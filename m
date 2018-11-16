Received: from eggs.gnu.org ([2001:4830:134:3::10]:56603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNdDM-0002NN-BX
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNdDL-0007qa-OP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:27:12 -0500
Date: Fri, 16 Nov 2018 13:27:05 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181116122705.msdb5hydmhtyzzxy@sirius.home.kraxel.org>
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<1539939312-19713-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-vF5orNpfGFe2sGWh=TxWL054PmCM-Yu4faJne+4CkbA@mail.gmail.com>
	<CAHmQWvD1ocAfZo=9aJYeuVDWrBk=AF_D-AgHriYb3-7=n+rR6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmQWvD1ocAfZo=9aJYeuVDWrBk=AF_D-AgHriYb3-7=n+rR6A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] hw/arm: Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

  Hi,

> > What is this using the exynos4210 USB device for? That
> > is definitely not correct for a generic board.
> >
> Checked the code:
> #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
> #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
> #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
> #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
> #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> 
> The first one seems only a parent type, not a general instance, cannot
> be used directly.
> The other four are specific instances using the first as parent type,
> one of them can be chosen to use.
> That is my understanding, any comments, or do we need to implement one
> which seems generic?

I think what we *really* want is sysbus-xhci-generic.

That'll be a bit more work though as xhci core and xhci pci needs to be
splitted, simliar to how it was done for ehci in commit
5010d4dc618b6b8e7c21129c487c06f6493f71fc (and related patches).

Or just plug qemu-xhci into a pcie slot.  Not sure which would be closer
to physical hardware.

cheers,
  Gerd
