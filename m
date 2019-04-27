Received: from eggs.gnu.org ([209.51.188.92]:44243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKObJ-0007Mq-Mg
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKObH-0003K1-P0
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:46:49 -0400
References: <20190427141459.19728-1-philmd@redhat.com>
	<20190427141459.19728-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bb31dd2a-8cd6-0dfe-a71f-4c47ec3d9687@redhat.com>
Date: Sat, 27 Apr 2019 16:46:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190427141459.19728-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/dma: Do not build the xlnx_dpdma
 device for the MicroBlaze machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 27/04/2019 16.14, Philippe Mathieu-Daud=C3=A9 wrote:
> The xlnx_dpdma device is only used by the ZynqMP AArch64 machine
> (not the MicroBlaze PMU). Remove it from the ZynqMP generic objects.
> (Note, this entry was duplicated for the AArch64).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/dma/Makefile.objs | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
> index 79affecc390..a5b1276f52a 100644
> --- a/hw/dma/Makefile.objs
> +++ b/hw/dma/Makefile.objs
> @@ -8,7 +8,6 @@ common-obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axidma.o
>  common-obj-$(CONFIG_ZYNQ_DEVCFG) +=3D xlnx-zynq-devcfg.o
>  common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_dma.o
>  common-obj-$(CONFIG_STP2000) +=3D sparc32_dma.o
> -obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx_dpdma.o
>  obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx_dpdma.o
>  common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zdma.o
> =20
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
