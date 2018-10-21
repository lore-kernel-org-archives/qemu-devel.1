Received: from eggs.gnu.org ([2001:4830:134:3::10]:60371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gEJQw-0001hz-Cg
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gEJLk-0001T3-3G
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:25:21 -0400
Date: Sun, 21 Oct 2018 21:24:57 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181021192457.GG4229@toto>
References: <20181017213932.19973-1-edgar.iglesias@gmail.com>
	<20181017213932.19973-4-edgar.iglesias@gmail.com>
	<CAFEAcA9Dd3=52zReFVMgitYFeQsRA=guYsVMxy=0zHsLJ_+z_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Dd3=52zReFVMgitYFeQsRA=guYsVMxy=0zHsLJ_+z_g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/4] hw/arm: versal: Add a model of
 Xilinx Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On Fri, Oct 19, 2018 at 03:18:24PM +0100, Peter Maydell wrote:
> On 17 October 2018 at 22:39, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Add a model of Xilinx Versal SoC.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  default-configs/aarch64-softmmu.mak |   1 +
> >  hw/arm/Makefile.objs                |   1 +
> >  hw/arm/xlnx-versal.c                | 324 ++++++++++++++++++++++++++++
> >  include/hw/arm/xlnx-versal.h        | 122 +++++++++++
> >  4 files changed, 448 insertions(+)
> >  create mode 100644 hw/arm/xlnx-versal.c
> >  create mode 100644 include/hw/arm/xlnx-versal.h
> 
> > +    if (!kvm_irqchip_in_kernel()) {
> > +        qdev_prop_set_bit(gicdev, "has-security-extensions", true);
> > +    }
> 
> Do you really support KVM for this board/SoC ?
>


I haven't tried yet, so probably not, but KVM is something we'd like to support further down the road...
If you prefer, we can remove this kvm specific check for now though.

Cheers,
Edgar
