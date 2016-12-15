Received: from eggs.gnu.org ([2001:4830:134:3::10]:53604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHYXB-0004bX-5Z
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHYX6-0008HN-Nk
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:05:29 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cHYX6-0008H2-In
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:05:24 -0500
Received: by mail-qk0-f193.google.com with SMTP id n21so866624qka.0
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 08:05:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161215080634.GF26169@stefanha-x1.localdomain>
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
	<CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
	<CA+scX6n+xcY7qi=XbBcno=OQOfUfJf77ZGfS2s5FbhUCEHQp3A@mail.gmail.com>
	<20161215080634.GF26169@stefanha-x1.localdomain>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Thu, 15 Dec 2016 11:04:23 -0500
Message-ID: <CA+scX6=Lk8Ea=vkFt_3c5v+n8gbr+uAb7hZ8vM1svzBZWwX7nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Lock contention in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Dec 15, 2016 at 3:06 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Dec 15, 2016 at 12:17:09AM -0500, Weiwei Jia wrote:
>> BTW, do we have an example to show users how to config following
>> virtio-blk dataplane commands into XML configuration file?
>>
>> qemu -object iothread,id=iothread0 \
>>       -drive if=none,id=drive0,file=test.img,format=raw,cache=none \
>>       -device virtio-blk-pci,iothread=iothread0,drive=drive0
>
> https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation
>
> See also <cputune><iothreadpin> and <driver iothread=>.

It seems that the libvirt XML configuration in above link [1] is
different from the configuration which you said in your blog [2]. Your
blog just said how to use x-data-plane for virtio-blk but libvirt XML
configuration doesn't say anything about x-data-plane. Does it in
default support by latest QEMU version. If I want to test virtio-blk
or virtio-scsi data-plane to make timeslice more stable, what version
of QEMU/KVM should I use? Would you please give me some suggestions?
Thank you.

[1] https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation
[2] http://blog.vmsplice.net/2013/03/new-in-qemu-14-high-performance-virtio.html

Cheers,
Weiwei Jia
