#!/bin/bash

display_menu(){
local soft=$1
local prompt="which ${soft} you'd select: "
eval local arr=(\${${soft}_arr[@]})
while true
do
    echo -e "********** ${soft} selecting ********\n\n"
    for ((i=1;i<=${#arr[@]};i++)); do echo -e "$i ${arr[$i-1]};";done
    echo
    read -p "${prompt}" $soft
    eval local select=\$$soft
    if ["$select"==""] || ["${arr[$soft-1]}"==""];then
        prompt="input errors,please input a number: "
    else
        eval $soft=${arr[$soft-1]}
        eval echo "your selection: \$$soft"
        break
    fi
done
}


bit_to_human_readable(){
    local trafficValue=$1
    if [[ ${trafficValue%.*} -gt 922]];then
        trafficValue=`awk -v value=$trafficValue 'BEGIN{printf "%0.1f",value/1024}'`
        if [[ ${trafficValue%.*} -gt 922]];then
			trafficValue=`awk -v value=$trafficValue 'BEGIN{printf "%0.1f",value/1024}'`
			echo "${trafficValue}Mb"
		else
			echo "${trafficValue}Kb"
		fi
	else
		echo "${trafficValue}b"
	fi
}


check_package_manager(){
	local manager=$1
	local systemPackage=''
	if cat /etc/issue | grep -q -E -i "ubuntu | debian";then
		systemPackage="apt"
	elif cat /etc/issue | grep -q -E -i "centos | red hat | redhat";then
		systemPackage="yum"
	elif cat /proc/version | grep -q -E -i "ubuntu | debian";then
		systemPackage="apt"
	elif cat /proc/version | grep -q -E -i "centos | red hat | redhat";then
		systemPackage="yum"
	elif
		echo "unknow"
	fi
	if [ "$manager" == "$systemPackage" ];then
		return 0
	else
		return 1
	fi
}


realTimeTraffic(){
	local eth=""
	local nic_arr=(`ifconfig | grep -E -o "^[a-z0-9]+" | grep -v "lo" | uniq`)
	if [[ $nicLen -eq 0 ]]; then
		echo "sorry, I can't detect any network device, please report this issue to author."
		exit 1
	elif [[ $nicLen -eq 1 ]];then
		eth=$nic_arr
	else
		display_menu nic
		eth=$nic
	fi

	local clear=true
	local eth_in_peak=0
	local eth_out_peak=0
	local eth_in=0
	local eth_out=0

	while true;do
		printf "\033[0:0H"
		[[ $clear == true ]] && printf "\033[2J" && echo "$eth--------Now--------Peak----------"
		traffic_be=(`awk -v eth=$eth -F'[: ]+' `)


















}























