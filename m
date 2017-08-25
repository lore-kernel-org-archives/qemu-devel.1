Received: from eggs.gnu.org ([2001:4830:134:3::10]:58346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dlBWc-0004vy-8w
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dlBWa-0007uA-Tz
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:07:38 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dlBWa-0007u2-P7
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:07:36 -0400
Received: by mail-qt0-x243.google.com with SMTP id q53so1635815qtq.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 03:07:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ebe4b0f3-9b50-2fc8-6238-d40f32d6e0b3@redhat.com>
References: <CAOE=1Z0trKFwm__wTKHSTAUSt+r9SBjCwft3tA=i5vJaixuX8w@mail.gmail.com>
	<ebe4b0f3-9b50-2fc8-6238-d40f32d6e0b3@redhat.com>
From: Sam <batmanustc@gmail.com>
Date: Fri, 25 Aug 2017 18:07:35 +0800
Message-ID: <CAOE=1Z0nfxKwAXDUbMsiD6L+3f3M9RVdGL237GBr-c5K9L_yUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Why got no response of vnc?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

No firewall, as another vm could be connect by vnc, this is the start
command used by that vm, and the disk(*.img) is copied from other place.

$QEMU -smp 4 -m 4096 -enable-kvm $SCRIPT_PATH/$IMG -cdrom $CD -daemonize
-vnc 0.0.0.0:2520 \
 -chardev
socket,id=char-$IF,path=/usr/local/var/run/openvswitch/$IF,server=on \
 -netdev type=vhost-user,id=$IF,chardev=char-$IF \
 -device virtio-net-pci,mac=00:00:af:07:03:02,netdev=$IF \
 -object memory-backend-file,id=mem,size=4096M,mem-path=$MEM_PATH,share=on \
 -numa node,memdev=mem -mem-prealloc \
 -chardev socket,path=$SCRIPT_PATH/qga.sock,server,nowait,id=qga0 \
 -device virtio-serial \
 -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 \
 -incoming tcp:0:80818

2017-08-25 16:21 GMT+08:00 Thomas Huth <thuth@redhat.com>:

> On 25.08.2017 08:31, Sam wrote:
> > Hi all,
> >
> > I'm starting vm using:
> >
> > kvm]$ sudo /usr/local/bin/qemu-system-x86_64 -m 256 -hda test.qcow2
> -cdrom
> >> CentOS-7-x86_64-DVD-1503-01.iso -boot d
> >> VNC server running on '127.0.0.1:5900'
> >
> > then I start vnc client in another PC to connect 10.253.23.24:11800 and
> > 10.253.23.24:5900, I got time out, why?
>
> Do you have a firewall running on the host system? It might be blocking
> the VNC connection - in that case you could use port forwarding of ssh
> (the -L parameter for example), or try to reconfigure your firewall on
> the host.
>
>  Thomas
>
>
> PS: Don't forget to specify --enable-kvm in case you want to use
> hardware virtualization.
>
>
>
