Received: from eggs.gnu.org ([2001:4830:134:3::10]:41984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHtYW-0006Qo-IW
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHtYV-0004fU-F9
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:32:16 -0500
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:36199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cHtYV-0004f1-B3
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:32:15 -0500
Received: by mail-qt0-x230.google.com with SMTP id w33so88135232qtc.3
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:32:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161216094850.GA4129@stefanha-x1.localdomain>
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
	<CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
	<CA+scX6n+xcY7qi=XbBcno=OQOfUfJf77ZGfS2s5FbhUCEHQp3A@mail.gmail.com>
	<20161215080634.GF26169@stefanha-x1.localdomain>
	<CA+scX6=Lk8Ea=vkFt_3c5v+n8gbr+uAb7hZ8vM1svzBZWwX7nQ@mail.gmail.com>
	<20161216094850.GA4129@stefanha-x1.localdomain>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Fri, 16 Dec 2016 09:32:14 -0500
Message-ID: <CA+scX6k2u5E0E6M07S_WOd0633=x1OnLi9jvXVrED+YB3bzaWA@mail.gmail.com>
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

On Fri, Dec 16, 2016 at 4:48 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Thu, Dec 15, 2016 at 11:04:23AM -0500, Weiwei Jia wrote:
>> On Thu, Dec 15, 2016 at 3:06 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> > On Thu, Dec 15, 2016 at 12:17:09AM -0500, Weiwei Jia wrote:
>> >> BTW, do we have an example to show users how to config following
>> >> virtio-blk dataplane commands into XML configuration file?
>> >>
>> >> qemu -object iothread,id=iothread0 \
>> >>       -drive if=none,id=drive0,file=test.img,format=raw,cache=none \
>> >>       -device virtio-blk-pci,iothread=iothread0,drive=drive0
>> >
>> > https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation
>> >
>> > See also <cputune><iothreadpin> and <driver iothread=>.
>>
>> It seems that the libvirt XML configuration in above link [1] is
>> different from the configuration which you said in your blog [2]. Your
>> blog just said how to use x-data-plane for virtio-blk but libvirt XML
>> configuration doesn't say anything about x-data-plane. Does it in
>> default support by latest QEMU version. If I want to test virtio-blk
>> or virtio-scsi data-plane to make timeslice more stable, what version
>> of QEMU/KVM should I use? Would you please give me some suggestions?
>> Thank you.
>>
>> [1] https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation
>> [2] http://blog.vmsplice.net/2013/03/new-in-qemu-14-high-performance-virtio.html
>
> I will update the blog post (from 2013) with the modern libvirt XML
> syntax.
>
> Please use the
> https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation
> documentation (unless you are using a really old QEMU and libvirt!).

I have tried the old libvirt XML way in your blog with QEMU v2.2.0 and
Libvirt v1.2.2. It seems that everything works well for me. I will try
the modern libvirt XML syntax with latest QEMU and libvirt.

Thank you,
Weiwei Jia
