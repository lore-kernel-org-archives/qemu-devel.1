Received: from eggs.gnu.org ([2001:4830:134:3::10]:53071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cJ2O1-0005Tl-IN
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cJ2O0-0006Y9-Nh
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:10:09 -0500
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:33752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cJ2O0-0006WD-KL
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:10:08 -0500
Received: by mail-qt0-x231.google.com with SMTP id p16so152360954qta.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 10:10:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161219105859.GB17374@stefanha-x1.localdomain>
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
	<CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
	<CA+scX6n+xcY7qi=XbBcno=OQOfUfJf77ZGfS2s5FbhUCEHQp3A@mail.gmail.com>
	<20161215080634.GF26169@stefanha-x1.localdomain>
	<CA+scX6=Lk8Ea=vkFt_3c5v+n8gbr+uAb7hZ8vM1svzBZWwX7nQ@mail.gmail.com>
	<20161216094850.GA4129@stefanha-x1.localdomain>
	<CA+scX6k2u5E0E6M07S_WOd0633=x1OnLi9jvXVrED+YB3bzaWA@mail.gmail.com>
	<CA+scX6kS1CB8RcFgG-ErgEf7qS2YakNmo0hiEJfmpPfmEReG+w@mail.gmail.com>
	<20161219105859.GB17374@stefanha-x1.localdomain>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Mon, 19 Dec 2016 13:10:05 -0500
Message-ID: <CA+scX6nk746G7qPdyJ_ik3uF3UnymUVXSbkG_oP0gFzCwP4uPw@mail.gmail.com>
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

Got it. Thank you very much.

Best,
Weiwei Jia

On Mon, Dec 19, 2016 at 5:58 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Dec 16, 2016 at 04:42:54PM -0500, Weiwei Jia wrote:
>> Has x-data-plane been used (or accepted) widely in systems. I have
>> this concern since if it hasn't been widely accepted, it may
>> have/cause some problems we don't know. Do you know some hidden
>> problems which may caused by QEMU x-data-plane feature in systems?
>
> By now virtio-blk dataplane has been tested a fair amount.  virtio-scsi
> dataplane is more recent.
>
> I'm not aware of known issues with virtio-blk dataplane in modern QEMU
> but you seem to be using an older QEMU.  Originally dataplane had a lot
> of limitations (no live migration, no image file formats, no block
> jobs) so be sure to check that your QEMU supports these things with
> dataplane if you need the features.
>
> Stefan
