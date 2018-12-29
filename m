Received: from eggs.gnu.org ([208.118.235.92]:36341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gdBYH-0001cl-RD
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gdBIp-0001GG-T8
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 04:53:09 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gdBIp-0001D7-Kf
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 04:53:07 -0500
Received: by mail-lf1-x143.google.com with SMTP id b20so15858955lfa.12
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 01:53:07 -0800 (PST)
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
	<CAHmQWvDua+3fXT7wA2j7wDRbOi5VJWfMa_+YYt6Xjv9XZF1Skg@mail.gmail.com>
	<CAKv+Gu_hMyn0g0hV9z1nZY+neGKg_7Rjm_cS-u33HkGQra_6ng@mail.gmail.com>
	<CAHmQWvBJgyFY9Xme9k3qPA+QOXOX8KTZt+Qp0bt29cGRsEjWKQ@mail.gmail.com>
In-Reply-To: <CAHmQWvBJgyFY9Xme9k3qPA+QOXOX8KTZt+Qp0bt29cGRsEjWKQ@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Sat, 29 Dec 2018 17:52:54 +0800
Message-ID: <CAHmQWvC-4VwnjjHR=4+cds6awTUrbgWwjdYh0Y-+i9-ALtX_Og@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: kraxel@redhat.com, Leif Lindholm <leif.lindholm@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

well, checked it again, creating an generic xhci may take much efforts
and it is far beyond than my main task of creating an arm server
platform, so I'll create a generic system ehci, it satisfies our
requirements very well, will send it out separately.

On Wed, 21 Nov 2018 at 16:35, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> Well, considering all the comments/suggestions I received, I'd like to
> try to create a generic sysbus xhci.
> This would take some time for me, so my plan is to send out a new v5
> iteration of this sbsa-ref patch with updates according to Peter's
> comments, but without any xhci feature this time, and later I'll
> create the sysbus xhci with another patch set, including adding this
> new xhci to the sbsa-ref platform.
> Advantage of doing so: this won't make the sbsa-ref patch too
> complicated to review, and the xhci work won't block the process of
> sbsa-ref work.
>
> On Tue, 20 Nov 2018 at 17:40, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 20 Nov 2018 at 09:49, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> > >
> > > On Tue, 20 Nov 2018 at 16:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > >
> > > >   Hi,
> > > >
> > > > > > But I assume you specifically want things that do a lot of DMA, so I
> > > > > > couldn't get away with asking for keeping it to the SBSA UART(s)? :)
> > > > >
> > > > > Ideally, it would be something that supports platform MSIs as well,
> > > > > but that is unlikely to be a priority for anyone (and i would be very
> > > > > surprised if any of QEMU's sysbus host controllers implement that at
> > > > > the moment)
> > > > >
> > > > > I can live with just sysbus AHCI, though, if EHCI/XHCI are too cumbersome.
> > > >
> > > > Generic sysbus ehci should not be difficuilt, 10 lines patch or so.
> > > >
> > > > Gives you only usb2 though.  usb1 devices are handled either via ohci
> > > > companion controller (should be doable), or via integrated usb2 hub
> > > > (more common on recent hardware, but qemu usb-hub is usb1 only).
> > > >
> > > > Generic sysbus xhci would be more work.  But you'll get usb 1+2+3
> > > > support.  And wiring up platform MSIs should be possible too.
> > > >
> > > In kernel, these drivers are enabled by default:
> > > CONFIG_USB_XHCI_PLATFORM=y
> > > CONFIG_USB_EHCI_HCD_PLATFORM=y
> > > CONFIG_USB_OHCI_HCD_PLATFORM=y
> > >
> > > If we do generic EHCI or XHCI in qemu, can the driver in kernel work
> > > with it? (I guess yes?)
> > > My thought is if the available kernel driver will work without any
> > > change, then we can create it in qemu.
> > >
> >
> > Yes that should work. Our MacchiatoBin DSDT has the following for its
> > XHCI controllers:
> >
> > Device (XHC0)
> > {
> >     Name (_HID, "PNP0D10")      // _HID: Hardware ID
> >     Name (_UID, 0x00)           // _UID: Unique ID
> >     Name (_CCA, 0x01)           // _CCA: Cache Coherency Attribute
> >
> >     Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> >     {
> >         Memory32Fixed (ReadWrite,
> >             0xF2500000,         // Address Base (MMIO)
> >             0x00004000,         // Address Length
> >             )
> >         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
> >         {
> >           CP_GIC_SPI_CP0_USB_H0
> >         }
> >     })
> > }
> >
> > and this gets picked up by the kernel without problems.
> >
> > Wiring up platform MSIs would involve modifying the IORT as well,
> > which is one of the reasons I'd prefer to make these fixed devices: we
> > cannot rely on qemu_fw_cfg to generate it for us, and adding a lot of
> > new code to generate this on the fly is simply not worth the effort.
