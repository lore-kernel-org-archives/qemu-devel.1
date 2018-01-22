Received: from eggs.gnu.org ([2001:4830:134:3::10]:55183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ediRW-0007NE-Ks
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ediRV-0002h9-H5
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:11:46 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1516650109.git.alistair.francis@xilinx.com>
	<c7577f92c251176a04ba82a56fc088cd3609800f.1516650109.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9a6c3bdc-79bb-c119-61b2-fd4dd9fe8221@amsat.org>
Date: Mon, 22 Jan 2018 17:11:37 -0300
MIME-Version: 1.0
In-Reply-To: <c7577f92c251176a04ba82a56fc088cd3609800f.1516650109.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 4/9] aarch64-softmmu.mak: Use an ARM
 specific config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair23@gmail.com, qemu-arm@nongnu.org

On 01/22/2018 04:43 PM, Alistair Francis wrote:
> In preperation for having an ARM and MicroBlaze ZynqMP machine let's
> split out the current ARM specific config options.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>  default-configs/aarch64-softmmu.mak | 1 +
>  hw/arm/Makefile.objs                | 2 +-
>  hw/display/Makefile.objs            | 2 +-
>  hw/dma/Makefile.objs                | 1 +
>  4 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
> index 24494832cf..9ddccf855e 100644
> --- a/default-configs/aarch64-softmmu.mak
> +++ b/default-configs/aarch64-softmmu.mak
> @@ -7,3 +7,4 @@ CONFIG_AUX=y
>  CONFIG_DDC=y
>  CONFIG_DPCD=y
>  CONFIG_XLNX_ZYNQMP=y
> +CONFIG_XLNX_ZYNQMP_ARM=y
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 2794e086d6..1c896bafb4 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -13,7 +13,7 @@ obj-y += omap1.o omap2.o strongarm.o
>  obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
>  obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
>  obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
> -obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp.o xlnx-zcu102.o
> +obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
>  obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
>  obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>  obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 551c050a6a..d3a4cb396e 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -40,4 +40,4 @@ virtio-gpu.o-libs += $(VIRGL_LIBS)
>  virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
>  virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
>  obj-$(CONFIG_DPCD) += dpcd.o
> -obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dp.o
> +obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
> diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
> index 0b3a009b87..c2afecbf73 100644
> --- a/hw/dma/Makefile.objs
> +++ b/hw/dma/Makefile.objs
> @@ -9,6 +9,7 @@ common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
>  common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
>  common-obj-$(CONFIG_STP2000) += sparc32_dma.o
>  obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dpdma.o
> +obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
>  
>  obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
>  obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
> 
