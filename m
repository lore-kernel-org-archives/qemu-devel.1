Received: from eggs.gnu.org ([2001:4830:134:3::10]:56822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fieep-00061l-MU
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 07:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fieem-0003xv-NR
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 07:42:11 -0400
Date: Thu, 26 Jul 2018 13:41:58 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180726114158.am7kgc3jekxg55i5@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvCKkzim+-Z4Y69fWg6igZ7V6gaWhjKJZ0m0G0dhbwOFyw@mail.gmail.com>
	<20180725112621.imdzdkntpmh3n5og@kamzik.brq.redhat.com>
	<CAHmQWvCfHFSU7RGKG5t6=m7ZSWZjf3TeqOo3cX2KT-GSiN3mPw@mail.gmail.com>
	<20180726102855.x6ffdoqjpejpyae7@kamzik.brq.redhat.com>
	<CAKv+Gu-ffZRNmACH6YieNsg=AHxJxYoXHsBGf6C=nOvFfTu7Sg@mail.gmail.com>
	<20180726111109.w24jk6ehklimige7@kamzik.brq.redhat.com>
	<CAKv+Gu80KfwZft4t1HtOXPuijuPLV80K9iW+BsTgs7WcnosMXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu80KfwZft4t1HtOXPuijuPLV80K9iW+BsTgs7WcnosMXA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Thu, Jul 26, 2018 at 01:15:15PM +0200, Ard Biesheuvel wrote:
> That may be true. But we'll still end up with a UEFI build that has
> OVMF virtio bus drivers and device drivers included, blurring the line
> between emulation and virtualization.

The UEFI build can drop the virtio-mmio support, and all the virtio-mmio
device drivers. Those haven't been necessary since the virt machine got
a PCIe host bridge. You'd still need the virtio-pci device drivers, which
may or may not "taint" the reference code, depending on its requirements.

> > I don't disagree, but there's no point in making QEMU ACPI generation
> > code changes that will never be consumed. This patch adds tables for
> > the hard coded ?HCI controllers to ACPI. We don't need those changes for
> > the virt machine and, without fw-cfg, you can't use them on the reference
> > machine.
> >
> 
> Ah, indeed. I missed that bit.
> 
> We should not include any changes that modify the DT node or ACPI
> table generation for mach-virt.
>

The patch guards the generation. It'll only modify DT and ACPI for the
new machine type. But, while modifying the DT makes sense, as that
generated DT will get consumed, the ACPI tables have no way of being
consumed without fw-cfg. If the new machine type doesn't want fw-cfg,
then there's no need to touch any ACPI generation code at all in this
patch.

Thanks,
drew
