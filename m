Received: from eggs.gnu.org ([2001:4830:134:3::10]:35149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gP1j2-0008Dj-B6
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gP1j1-0002fD-EF
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:49:40 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gP1j1-0002eV-5o
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:49:39 -0500
Received: by mail-lj1-x241.google.com with SMTP id t9-v6so918535ljh.6
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 00:49:38 -0800 (PST)
MIME-Version: 1.0
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<1539939312-19713-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-vF5orNpfGFe2sGWh=TxWL054PmCM-Yu4faJne+4CkbA@mail.gmail.com>
	<CAHmQWvD1ocAfZo=9aJYeuVDWrBk=AF_D-AgHriYb3-7=n+rR6A@mail.gmail.com>
	<20181116122705.msdb5hydmhtyzzxy@sirius.home.kraxel.org>
	<CAKv+Gu8QXaRioVPNze_+mJg4aqjJmwn4O-1jdRcYwrkieXrBwQ@mail.gmail.com>
	<20181119124423.qj3sjhhdyetrbju5@bivouac.eciton.net>
	<CAKv+Gu_-U8BHthhen-GBkium9qJMdd-pe_PB9TPdUaP=koeajQ@mail.gmail.com>
	<20181119164421.me2j4fwzo43aghaa@bivouac.eciton.net>
	<CAKv+Gu9VjERXDdb=ZkvzVocL4Fd3_2e+F=H0nqEJVs4UEkYmhw@mail.gmail.com>
	<20181120081613.bezcjotqhmqflvvb@sirius.home.kraxel.org>
In-Reply-To: <20181120081613.bezcjotqhmqflvvb@sirius.home.kraxel.org>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Tue, 20 Nov 2018 16:49:26 +0800
Message-ID: <CAHmQWvDua+3fXT7wA2j7wDRbOi5VJWfMa_+YYt6Xjv9XZF1Skg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] hw/arm: Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, 20 Nov 2018 at 16:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > But I assume you specifically want things that do a lot of DMA, so I
> > > couldn't get away with asking for keeping it to the SBSA UART(s)? :)
> >
> > Ideally, it would be something that supports platform MSIs as well,
> > but that is unlikely to be a priority for anyone (and i would be very
> > surprised if any of QEMU's sysbus host controllers implement that at
> > the moment)
> >
> > I can live with just sysbus AHCI, though, if EHCI/XHCI are too cumbersome.
>
> Generic sysbus ehci should not be difficuilt, 10 lines patch or so.
>
> Gives you only usb2 though.  usb1 devices are handled either via ohci
> companion controller (should be doable), or via integrated usb2 hub
> (more common on recent hardware, but qemu usb-hub is usb1 only).
>
> Generic sysbus xhci would be more work.  But you'll get usb 1+2+3
> support.  And wiring up platform MSIs should be possible too.
>
In kernel, these drivers are enabled by default:
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OHCI_HCD_PLATFORM=y

If we do generic EHCI or XHCI in qemu, can the driver in kernel work
with it? (I guess yes?)
My thought is if the available kernel driver will work without any
change, then we can create it in qemu.

> cheers,
>   Gerd
>
