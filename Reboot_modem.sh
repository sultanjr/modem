#!/bin/sh

#untuk ujicoba bikin saja dulu file baru 
#misal lokasinya di /root namafie test.sh
#pastekan scriptnya
#jalankan di putty dengan ketik : sh /root/test.sh

while true
do

	ipx="$(ifconfig | grep -i 'P-t')"
	echo $ipx
	if [ ${#ipx} == 0 ]; then
		echo "NOip..."
		sleep 30
	else
		ipy="$(ping -c5 8.8.8.8 -s 1 | grep -i '100% packet loss')"
		if [ ${#ipy} == 0 ]; then
			echo "chk 01 aman !!!" 
		else
			echo "reload modem !!!"
			#catatan lte adalah device modem-saya
			ifup lte
			sleep 10

					ipy="$(ping -c10 8.8.8.8 -s 1 | grep -i '100% packet loss')"
					if [ ${#ipy} == 0 ]; then
						echo "chk 02 aman !!!" 
					else
						echo "reboot router dalam 10s"
						sleep 10
						reboot
					fi

			fi
	fi
	echo "sleep 1m"
	sleep 1m
done