Received: from eggs.gnu.org ([2001:4830:134:3::10]:47783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dkTYP-0004IX-9y
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dkTYL-0004M7-6f
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:10:33 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:35523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dkTYK-0004KC-UJ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:10:29 -0400
Received: by mail-io0-x22a.google.com with SMTP id c18so4900047ioj.2
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 04:10:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z38PO+Dah3Xzw9o-ys_F-srd8xLv2htTMBZVoRRHHeTnQ@mail.gmail.com>
References: <CAOE=1Z16-G8kCpDcUfun3EAXNXsJHDiHkJNRFmgxqjOyS14v=g@mail.gmail.com>
	<CAOE=1Z0QmLvPEHUHH6yxF_KR1F++g5Fwph_kbXVR2UQ7O1aFqQ@mail.gmail.com>
	<CAOE=1Z38PO+Dah3Xzw9o-ys_F-srd8xLv2htTMBZVoRRHHeTnQ@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 23 Aug 2017 14:10:27 +0300
Message-ID: <CAKPgXcHd65h9EffNbGcZq5komHTSd8n4uLLncar4gh7gPpRtZw@mail.gmail.com>
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
To: Sam <batmanustc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org

Hi Sam,

>From the command line I assume that you are running CentOS-7-x86_64, did
you install the guest agent on the VM? Can you see that it is running?

What do you mean by blocked?

On Wed, Aug 23, 2017 at 5:34 AM, Sam <batmanustc@gmail.com> wrote:

> Hi all,
>
> I start VM using command like this:
>
> -chardev socket,path=/home/gangyewei-3/kvm/qga.sock,server,nowait,id=qga0
> > -device virtio-serial -device virtserialport,chardev=qga0,
> > name=org.qemu.guest_agent.0
>
>
> But When I use socat to send command (https://wiki.qemu.org/
> Features/GuestAgent), it blocked. Why and how to fix this? Thank you~
>
> whole command is :
>
> /usr/local/kvm/bin/qemu-system-x86_64 -smp 4 -m 4096 -enable-kvm
> > /home/gangyewei-3/kvm/centos6.6_2.img -cdrom
> /home/gangyewei-3/kvm/CentOS-7-x86_64-DVD-1503-01.iso
> > -daemonize -vnc 0.0.0.0:2520 -chardev socket,id=char-client-07-1,
> > path=/usr/local/var/run/openvswitch/client-07-1,server=on -netdev
> > type=vhost-user,id=client-07-1,chardev=char-client-07-1 -device
> > virtio-net-pci,mac=00:00:af:07:03:02,netdev=client-07-1 -object
> > memory-backend-file,id=mem,size=4096M,mem-path=/mnt/huge/,share=on -numa
> > node,memdev=mem -mem-prealloc -chardev socket,path=/home/gangyewei-3/
> > kvm/qga.sock,server,nowait,id=qga0 -device virtio-serial -device
> > virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 -incoming
> > tcp:0:4444
>
>
>
> 2017-08-22 18:00 GMT+08:00 Sam <batmanustc@gmail.com>:
>
> > whole command is :
> >
> > /usr/local/kvm/bin/qemu-system-x86_64 -smp 4 -m 4096 -enable-kvm
> >> /home/gangyewei-3/kvm/centos6.6_2.img -cdrom
> >> /home/gangyewei-3/kvm/CentOS-7-x86_64-DVD-1503-01.iso -daemonize -vnc
> >> 0.0.0.0:2520 -chardev socket,id=char-client-07-1,
> path=/usr/local/var/run/
> >> openvswitch/client-07-1,server=on -netdev type=vhost-user,id=client-07-
> 1,chardev=char-client-07-1
> >> -device virtio-net-pci,mac=00:00:af:07:03:02,netdev=client-07-1 -object
> >> memory-backend-file,id=mem,size=4096M,mem-path=/mnt/huge/,share=on
> -numa
> >> node,memdev=mem -mem-prealloc -chardev socket,path=/home/gangyewei-3/
> >> kvm/qga.sock,server,nowait,id=qga0 -device virtio-serial -device
> >> virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 -incoming
> >> tcp:0:4444
> >
> >
> > 2017-08-22 17:54 GMT+08:00 Sam <batmanustc@gmail.com>:
> >
> >> Hi all,
> >>
> >> I start VM using command like this:
> >>
> >> -chardev socket,path=/home/gangyewei-3/kvm/qga.sock,server,nowait,id=
> qga0
> >>> -device virtio-serial -device virtserialport,chardev=qga0,na
> >>> me=org.qemu.guest_agent.0
> >>
> >>
> >> But When I use socat to send command (https://wiki.qemu.org/Feature
> >> s/GuestAgent), it blocked. Why and how to fix this? Thank you~
> >>
> >
> >
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
