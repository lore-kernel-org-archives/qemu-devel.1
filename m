Received: from eggs.gnu.org ([2001:4830:134:3::10]:39247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d0pkk-0008CH-OQ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d0pkj-0001qJ-Ml
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:34:38 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1d0pkj-0001qA-HO
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:34:37 -0400
Received: by mail-qt0-x241.google.com with SMTP id c45so3182371qtb.0
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 06:34:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81o245N_zoSUtJ0SVupZyRE9cnfr15hmu+ReMuDj9iyQ@mail.gmail.com>
References: <CAJy91CZpAiZ6adPmbAESrYqDgtK37CEgw4SAk97jCNduADy6Tw@mail.gmail.com>
	<CAFEAcA-V3BNcrhhnap+Hn8spfZPd0=Dv2v0P5myGwqU2e5t0Eg@mail.gmail.com>
	<CAJy91Ca2FTvBzd2OqQZyEJBtCAxxosdcAFP1RMgGCQe2PJXEJA@mail.gmail.com>
	<CAFEAcA-f1P4OW+DwLRn1AZQCzoiWNX_8Rhq0oduppMOSLWo9Ww@mail.gmail.com>
	<CAJy91CY=s2H0VYYuDUrs=HYTEKjKZHpU1MXrhStxGxxWg=hfEg@mail.gmail.com>
	<CAFEAcA9mfnUF-ZtU+kGpSj2LqVxPi=0GLB4Jk9zLnhhfq_Su4A@mail.gmail.com>
	<CAJy91CaB3kA0vNRGs52S=OweSfSXnkO71AHOa2XpUYNJTnZHDQ@mail.gmail.com>
	<CAFEAcA81o245N_zoSUtJ0SVupZyRE9cnfr15hmu+ReMuDj9iyQ@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Wed, 19 Apr 2017 15:34:36 +0200
Message-ID: <CAJy91Cbo+CQbRMmS-1b32Hf=kgWb22N3htmiuyORW7y-of7Raw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Hight Processor time of Socket communciation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 April 2017 at 12:09, Peter Maydell <peter.maydell@linaro.org> wrote:

> On 19 April 2017 at 11:04, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> > Okay. Thank you for pointing this out.
> > I would like to make a new serial device based on pl011,
> > but containing a buffer for guest-to-host data transfer.
>
> As I've said, the PL011 is inherently byte at a time.
> If you want better than that, I recommend you use virtio-serial,
> because it already exists for this purpose.
>
> thanks
> -- PMM
>

Hi Peter,

But from the source code, I found the main characteristic of virtio-serial
is that,
virtio-serial can create multiple serial ports and each port has a pair of
control virt-queues and
a pair of guest input/output virt-queues.
Its "have_data" callback function enables multi-byte data transfer from
guest.
And it is not in a tranditional device emulation format.
I mean that no exact IO region is emulated for it.
Without Linux kernel driver, I don't know how to manipulate it.
For the time being, I enable the guest app to send data to
the pl011's data register directly via a pointer, as you see that in the
code above.

This is why I am thinking if adding a transmit buffer in pl011 for guest
writing
is a feasible alternative.

Any suggestion is welcome.
Regards,
Huan
