Received: from eggs.gnu.org ([209.51.188.92]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKOZi-0005dm-NC
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKOYS-0000wF-9N
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:43:53 -0400
References: <20190427141459.19728-1-philmd@redhat.com>
	<20190427141459.19728-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9c902821-137a-1727-0353-033773e9b895@redhat.com>
Date: Sat, 27 Apr 2019 16:43:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190427141459.19728-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 27/04/2019 16.14, Philippe Mathieu-Daud=C3=A9 wrote:
> The Xilinx I/O Module Interrupt Controller is only used by the
> MicroBlaze PMU, not by the AArch64 machine.
> Move it from the generic ZynqMP object list to the PMU specific.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/intc/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
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
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
