Received: from eggs.gnu.org ([2001:4830:134:3::10]:37396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1gOiui-0000yW-Vv
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1gOiui-00036v-78
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:44:28 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
	id 1gOiuh-00036F-O9
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:44:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so22741558wrt.7
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 04:44:27 -0800 (PST)
Date: Mon, 19 Nov 2018 12:44:23 +0000
From: Leif Lindholm <leif.lindholm@linaro.org>
Message-ID: <20181119124423.qj3sjhhdyetrbju5@bivouac.eciton.net>
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<1539939312-19713-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-vF5orNpfGFe2sGWh=TxWL054PmCM-Yu4faJne+4CkbA@mail.gmail.com>
	<CAHmQWvD1ocAfZo=9aJYeuVDWrBk=AF_D-AgHriYb3-7=n+rR6A@mail.gmail.com>
	<20181116122705.msdb5hydmhtyzzxy@sirius.home.kraxel.org>
	<CAKv+Gu8QXaRioVPNze_+mJg4aqjJmwn4O-1jdRcYwrkieXrBwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8QXaRioVPNze_+mJg4aqjJmwn4O-1jdRcYwrkieXrBwQ@mail.gmail.com>
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Fri, Nov 16, 2018 at 02:04:07PM -0800, Ard Biesheuvel wrote:
> > > > What is this using the exynos4210 USB device for? That
> > > > is definitely not correct for a generic board.
> > > >
> > > Checked the code:
> > > #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
> > > #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
> > > #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
> > > #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
> > > #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> > >
> > > The first one seems only a parent type, not a general instance, cannot
> > > be used directly.
> > > The other four are specific instances using the first as parent type,
> > > one of them can be chosen to use.
> > > That is my understanding, any comments, or do we need to implement one
> > > which seems generic?
> >
> > I think what we *really* want is sysbus-xhci-generic.
> >
> > That'll be a bit more work though as xhci core and xhci pci needs to be
> > splitted, simliar to how it was done for ehci in commit
> > 5010d4dc618b6b8e7c21129c487c06f6493f71fc (and related patches).
> >
> > Or just plug qemu-xhci into a pcie slot.  Not sure which would be closer
> > to physical hardware.
> 
> We don't need XHCI especially, EHCI is perfectly fine as well.
> 
> This is mostly about ensuring that the emulated hardware spans the
> space of what we encounter on real hardware, and non-PCIE SATA and USB
> controllers is something we see often.
> 
> So I could live with MMIO SATA and PCI USB as well, but I'd prefer it
> if we could have both MMIO.

I would actually strongly prefer non-MMIO.

What "we see" is generally a result of embedded companies "value
adding" in the usual way when moving from embedded to servers.

I want the SBSA target to be an idealised machine, not an educational
vehicle for showing how companies have got it wrong.

Where in doubt, anything software discoverable should win over
non-discoverable.

/
    Leif
