Received: from eggs.gnu.org ([2001:4830:134:3::10]:55293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1doqYX-0001bJ-B2
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1doqYR-0000Up-Q2
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:32:45 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:38880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1doqYR-0000Ui-KV
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:32:39 -0400
Received: by mail-qt0-x230.google.com with SMTP id w42so1317550qtg.5
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 05:32:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z2E-OJKFGp1QWwTbBm0evbtLDubv7JVS5hC8dPqK_9M-Q@mail.gmail.com>
References: <CAOE=1Z3xuudQenX+Oe11fPDZfrC_d02S50HQ9mJ=RfnJ0B5DUg@mail.gmail.com>
	<20170904093623.GB7186@redhat.com>
	<CAOE=1Z2HFVhD8b1TXaQFd8sGvqoddOeJoSds1ZxwzKSw8im7ng@mail.gmail.com>
	<20170904101624.GE7186@redhat.com>
	<CAOE=1Z2E-OJKFGp1QWwTbBm0evbtLDubv7JVS5hC8dPqK_9M-Q@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Mon, 4 Sep 2017 20:32:38 +0800
Message-ID: <CAOE=1Z1=gc_BJPiCTfVj_-DCixDxzFE62W8szxtY6G9oXgNTiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to use monitor socket in python to connect VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

There are two docs:

https://wiki.qemu.org/index.php/Documentation/QMP

https://en.wikibooks.org/wiki/QEMU/Monitor

I don't know which one is right...?

2017-09-04 20:31 GMT+08:00 Sam <batmanustc@gmail.com>:

> Thank you, but I have to ask last question. My qemu is 2.6.0, and there is
> no -qmp option :
>
> [root@yf-mos-test-net09 ~]# ps aux | grep qemu
>> root      5714  0.0  0.0 1669388 77736 ?       Sl   Sep01   0:09
>> /usr/local/bin/qemu-system-x86_64_2.6.0 -enable-kvm -cpu
>> qemu64,+vmx,+ssse3,+sse4.1,+sse4.2,+x2apic,+aes,+avx,+vme,
>> +pat,+ss,+pclmulqdq,+xsave,level=13 -machine pc,accel=kvm -chardev
>> socket,id=hmqmondev,port=55919,host=127.0.0.1,nodelay,server,nowait -mon
>> chardev=hmqmondev,id=hmqmon,mode=readline -rtc
>> base=utc,clock=host,driftfix=none -usb -device usb-tablet -daemonize
>> -nodefaults -nodefconfig -no-kvm-pit-reinjection -global
>> kvm-pit.lost_tick_policy=discard -vga std -k en-us -smp 1 -name
>> mvs5-huanghuai -m 1024 -boot order=cdn -vnc :19,password -drive
>> file=/opt/cloud/workspace/disks/4a5148da-e34e-4c81-aada-
>> 12a247c0337e,if=none,id=drive_0,format=qcow2,cache=none,aio=native
>> -device virtio-blk-pci,id=dev_drive_0,drive=drive_0,bus=pci.0,addr=0x5
>> -drive file=/opt/cloud/workspace/disks/08eb3f72-07ba-44e9-8ee9-
>> 4ab662dbbd1f,if=none,id=drive_1,format=qcow2,cache=none,aio=native
>> -device virtio-blk-pci,id=dev_drive_1,drive=drive_1,bus=pci.0,addr=0x6
>> -device ide-cd,drive=ide0-cd0,bus=ide.1,unit=1 -drive
>> id=ide0-cd0,media=cdrom,if=none -chardev socket,id=char-n-f879ac2f,
>> path=/usr/local/var/run/openvswitch/n-f879ac2f,server -netdev
>> type=vhost-user,id=n-f879ac2f,chardev=char-n-f879ac2f,vhostforce=on
>> -device virtio-net-pci,netdev=n-f879ac2f,mac=00:22:f8:79:ac:
>> 2f,id=netdev-n-f879ac2f,addr=0xf -object memory-backend-file,id=mem,
>> size=1024M,mem-path=/dev/hugepages,share=on -numa node,memdev=mem
>> -mem-prealloc -pidfile /opt/cloud/workspace/servers/
>> 63ef2ec4-556f-47ea-93e0-23089bb59be5/pid -chardev socket,path=/opt/cloud/
>> workspace/servers/63ef2ec4-556f-47ea-93e0-23089bb59be5/qga.sock,server,nowait,id=qga0
>> -device virtio-serial -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
>> -incoming tcp:0:8081
>
>
>  After I use telnet like this `telnet localhost 55919`, then enter this
> cmd line:
>
> [root@yf-mos-test-net09 ~]# telnet localhost 55919
>> Trying ::1...
>> telnet: connect to address ::1: Connection refused
>> Trying 127.0.0.1...
>> Connected to localhost.
>> Escape character is '^]'.
>> QEMU 2.6.0 monitor - type 'help' for more information
>> (qemu) help
>> help
>> acl_add aclname match allow|deny [index] -- add a match rule to the
>> access control list
>> ...
>> xp /fmt addr -- physical memory dump starting at 'addr'
>> (qemu)
>> (qemu)
>
> (qemu) {"execute":"query-status"}
>> {"execute":"query-status"}
>> unknown command: '{"execute":"query-status"}'
>
>
>
> And I send QMP json format command,  it report error as above. So where is
> the monitor socket? Why I got error while using QMP command?
>
>
> 2017-09-04 18:16 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:
>
>> On Mon, Sep 04, 2017 at 06:11:44PM +0800, Sam wrote:
>> > Actually I use qga socket first(send json format command like
>> {'execute':
>> > 'chardev-add', 'arguments': {'id': id, 'type': type}, 'params': params}
>> by
>> > qga socket, which is
>> > /opt/cloud/workspace/servers/1925a92d-f003-4d77-871c-bce8f85
>> 229aa/qga.sock,
>> > using the same script as first mail), but it response me "netdev_add is
>> not
>> > valid command"(it's reasonable, as guest OS could not operate
>> 'netdev_add'
>> > command), so I thought qga could not do this work, then I change to
>> monitor.
>>
>> You're mixing up two different things.  'QGA' is the QEMU guest agent
>> which is a service than runs in the guest OS. 'QMP' is the QEMU monitor
>> socket which runs in the host OS. Both of these use the same JSON based
>> protocol, but take completely different commands.
>>
>> You need to use 'QMP' for 'netdev_add', not 'QGA'.
>>
>> Regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/
>> dberrange :|
>> |: https://libvirt.org         -o-
>> https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dber
>> range :|
>>
>
>
