Received: from eggs.gnu.org ([209.51.188.92]:41846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLA6L-000527-7m
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLA6K-0006OM-C9
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:01 -0400
MIME-Version: 1.0
References: <20190427141459.19728-1-philmd@redhat.com>
	<20190427141459.19728-3-philmd@redhat.com>
In-Reply-To: <20190427141459.19728-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2019 10:29:28 -0700
Message-ID: <CAKmqyKMMTQtq2sxSH85oPzsK-vVX1jELaQALPhAEJ6EpTSD66g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/intc: Only build the
 xlnx-iomod-intc device for the MicroBlaze PMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Sat, Apr 27, 2019 at 7:17 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The Xilinx I/O Module Interrupt Controller is only used by the
> MicroBlaze PMU, not by the AArch64 machine.
> Move it from the generic ZynqMP object list to the PMU specific.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index df712c3e6c9..247e8016cb8 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -3,7 +3,7 @@ common-obj-$(CONFIG_I8259) +=3D i8259_common.o i8259.o
>  common-obj-$(CONFIG_PL190) +=3D pl190.o
>  common-obj-$(CONFIG_PUV3) +=3D puv3_intc.o
>  common-obj-$(CONFIG_XILINX) +=3D xilinx_intc.o
> -common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-pmu-iomod-intc.o
> +common-obj-$(CONFIG_XLNX_ZYNQMP_PMU) +=3D xlnx-pmu-iomod-intc.o
>  common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-ipi.o
>  common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_pic.o
>  common-obj-$(CONFIG_IMX) +=3D imx_avic.o imx_gpcv2.o
> --
> 2.20.1
>
>
