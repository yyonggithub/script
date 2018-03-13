#!/bin/sh

#echo 欢迎使用本脚本
ping 127.0.0.1 -c 2 > /dev/null
echo 本脚本只适用于merlin 7.X改版固件，其他固件请勿运行本脚本
ping 127.0.0.1 -c 2 > /dev/null
echo 本提示保留5秒，如果您不是merlin改版固件请立刻按下Ctrl+C中止本脚本
ping 127.0.0.1 -c 10 > /dev/null
echo 本脚本适用于上海电信需要AB面认证的IPTV，其他地区请按实际情况修改脚本
ping 127.0.0.1 -c 2 > /dev/null
echo 使用前请确认光猫已经设置桥接
ping 127.0.0.1 -c 2 > /dev/null


#空行
echo


#脚本提示
echo 正在增加IPTV开机自启动脚本
#移动到脚本目录
cd /jffs/scripts删除之前的脚本
#
echo 正在删除旧文件
rm -rf nat-start*
#下载自启动脚本
echo 正在下载新文件
# wget -q --no-check-certificate https://raw.githubusercontent.com/ArronYin/4K-IPTV/master/nat-start


#!/bin/sh
dbus fire onnatstart
ifconfig eth0:1 192.168.1.200 netmask 255.255.255.0
iptables -t nat -I POSTROUTING -o eth0 -d 192.168.1.0/24 -j MASQUERADE
ip addr add 192.168.99.1/24 dev eth0
iptables -I INPUT 4 -i eth0 -m state --state NEW -j ACCEPT
iptables -I FORWARD 3 -i eth0 -o ppp0 -j ACCEPT
sleep 5
sh /koolshare/ss/nat-start.sh start_all

#设置权限
chmod -R 0755 nat-start
#完成提示
echo 成功

#延迟运行
ping 127.0.0.1 -c 2 > /dev/null
#空行
echo

#脚本提示
echo 正添加IPTV运行脚本
#移动到脚本目录
cd /jffs/configs/dnsmasq.d
#删除旧dnsmasq配置文件
echo 正在删除旧文件
rm -rf iptv.conf*
#下载开机运行脚本
echo 正在下载新文件
# wget -q --no-check-certificate https://raw.githubusercontent.com/ArronYin/4K-IPTV/master/iptv.conf

interface=eth0
dhcp-range=interface:eth0,192.168.99.2,192.168.99.10,255.255.255.0,86400s
dhcp-option=interface:eth0,3,192.168.99.1
dhcp-option=interface:eth0,252,"\n"
dhcp-option=interface:eth0,15
dhcp-option=interface:eth0,28
dhcp-option=interface:eth0,60,00:00:01:00:02:03:43:50:45:03:0e:45:38:20:47:50:4f:4e:20:52:4f:55:54:45:52:04:03:31:2E:30
dhcp-option-force=interface:eth0,125,00:00:00:00:1a:02:06:48:47:57:2d:43:54:0a:02:20:00:0b:02:00:55:0d:02:00:2e

#设置权限
chmod -R 0644 iptv.conf
#完成提示
echo 成功

#延迟运行
ping 127.0.0.1 -c 2 > /dev/null
#空行
echo

#返回默认目录
cd

#提示成功
ping 127.0.0.1 -c 2 > /dev/null
echo 脚本运行完成，如果光猫已经设置完毕，您可以把IPTV接在光猫lan口

#延迟运行
ping 127.0.0.1 -c 2 > /dev/null
#空行
echo

#运行提示
echo 正在重启路由器，请待路由器重启成功后，重新启动IPTV
#延迟运行
ping 127.0.0.1 -c 2 > /dev/null
#重启路由器
reboot > /dev/null
