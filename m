Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dkLV1-0003KJ-Cz
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dkLV0-0002o4-01
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:34:31 -0400
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z0QmLvPEHUHH6yxF_KR1F++g5Fwph_kbXVR2UQ7O1aFqQ@mail.gmail.com>
References: <CAOE=1Z16-G8kCpDcUfun3EAXNXsJHDiHkJNRFmgxqjOyS14v=g@mail.gmail.com>
	<CAOE=1Z0QmLvPEHUHH6yxF_KR1F++g5Fwph_kbXVR2UQ7O1aFqQ@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Wed, 23 Aug 2017 10:34:28 +0800
Message-ID: <CAOE=1Z38PO+Dah3Xzw9o-ys_F-srd8xLv2htTMBZVoRRHHeTnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Why I got "timeout" while using qga socket to
 connect VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Hi all,

I start VM using command like this:

-chardev socket,path=/home/gangyewei-3/kvm/qga.sock,server,nowait,id=qga0
> -device virtio-serial -device virtserialport,chardev=qga0,
> name=org.qemu.guest_agent.0


But When I use socat to send command (https://wiki.qemu.org/
Features/GuestAgent), it blocked. Why and how to fix this? Thank you~

whole command is :

/usr/local/kvm/bin/qemu-system-x86_64 -smp 4 -m 4096 -enable-kvm
> /home/gangyewei-3/kvm/centos6.6_2.img -cdrom /home/gangyewei-3/kvm/CentOS-7-x86_64-DVD-1503-01.iso
> -daemonize -vnc 0.0.0.0:2520 -chardev socket,id=char-client-07-1,
> path=/usr/local/var/run/openvswitch/client-07-1,server=on -netdev
> type=vhost-user,id=client-07-1,chardev=char-client-07-1 -device
> virtio-net-pci,mac=00:00:af:07:03:02,netdev=client-07-1 -object
> memory-backend-file,id=mem,size=4096M,mem-path=/mnt/huge/,share=on -numa
> node,memdev=mem -mem-prealloc -chardev socket,path=/home/gangyewei-3/
> kvm/qga.sock,server,nowait,id=qga0 -device virtio-serial -device
> virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 -incoming
> tcp:0:4444



2017-08-22 18:00 GMT+08:00 Sam <batmanustc@gmail.com>:

> whole command is :
>
> /usr/local/kvm/bin/qemu-system-x86_64 -smp 4 -m 4096 -enable-kvm
>> /home/gangyewei-3/kvm/centos6.6_2.img -cdrom
>> /home/gangyewei-3/kvm/CentOS-7-x86_64-DVD-1503-01.iso -daemonize -vnc
>> 0.0.0.0:2520 -chardev socket,id=char-client-07-1,path=/usr/local/var/run/
>> openvswitch/client-07-1,server=on -netdev type=vhost-user,id=client-07-1,chardev=char-client-07-1
>> -device virtio-net-pci,mac=00:00:af:07:03:02,netdev=client-07-1 -object
>> memory-backend-file,id=mem,size=4096M,mem-path=/mnt/huge/,share=on -numa
>> node,memdev=mem -mem-prealloc -chardev socket,path=/home/gangyewei-3/
>> kvm/qga.sock,server,nowait,id=qga0 -device virtio-serial -device
>> virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 -incoming
>> tcp:0:4444
>
>
> 2017-08-22 17:54 GMT+08:00 Sam <batmanustc@gmail.com>:
>
>> Hi all,
>>
>> I start VM using command like this:
>>
>> -chardev socket,path=/home/gangyewei-3/kvm/qga.sock,server,nowait,id=qga0
>>> -device virtio-serial -device virtserialport,chardev=qga0,na
>>> me=org.qemu.guest_agent.0
>>
>>
>> But When I use socat to send command (https://wiki.qemu.org/Feature
>> s/GuestAgent), it blocked. Why and how to fix this? Thank you~
>>
>
>
