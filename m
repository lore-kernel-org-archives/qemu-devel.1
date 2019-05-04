Received: from eggs.gnu.org ([209.51.188.92]:58970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hMmFO-0006Sv-CT
	for qemu-devel@nongnu.org; Sat, 04 May 2019 00:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hMmFN-000157-BJ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 00:26:02 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:40285)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hMmFM-00014G-VD
	for qemu-devel@nongnu.org; Sat, 04 May 2019 00:26:01 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id 0090333357
	for <qemu-devel@nongnu.org>; Sat,  4 May 2019 00:25:57 -0400 (EDT)
Mime-Version: 1.0
Message-Id: <97245929-a8b5-4b67-bfee-656db4438cd0@www.fastmail.com>
In-Reply-To: <CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
	<CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
	<CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
Date: Sat, 04 May 2019 00:25:56 -0400
From: Alistair <alistair@alistair23.me>
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, May 2, 2019, at 3:06 AM, Peter Maydell wrote:
> On Tue, 30 Apr 2019 at 21:29, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Tue, Apr 30, 2019 at 9:02 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > Can you explain the purpose of the reset code? None of the other
> > > v7m boards seem to need to do a manual qemu_register_reset().
> >
> > The reset code allows the machine to work with the -kernel option.
> > Without the reset override using -kernel results in the guest starting
> > at the wrong address. We can use the -device loader option without the
> > reset code though.
> 
> That sounds in line with how -kernel works on the other armv7m
> boards -- the expectation is that your image file includes a
> full vector table and the CPU will read the PC and SP from it
> when it resets. If you want "honour the entry point" you can
> use -device loader, as you say.
> 
> Ignoring the entry point for -kernel ELF files is certainly
> a bit confusing, but I think if we want to change this we should
> do it globally, rather than having one board which behaves
> differently to the rest. Changing it does have some awkwardness:

Hmm... That is a good point. It is confusing having something just for one board. I'll drop this part and we can re-evaluate later.

> * possibility of breaking previously working images

I have no way to test the other boards, so this might be difficult to change.

> * we can get the initial PC from the ELF entrypoint, but if
>  we do this what do we do about the initial SP value ?

Not sure about this one either. I'm guessing it changes between the different M cores.

Alistair

> 
> thanks
> -- PMM
> 
> 
