Received: from eggs.gnu.org ([2001:4830:134:3::10]:35308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ebPlt-0005c4-De
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ebPls-0000Bt-7w
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:17 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:43146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1ebPls-0000Ag-19
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:16 -0500
Received: by mail-lf0-x242.google.com with SMTP id o89so12944323lfg.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:51:15 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 16 Jan 2018 12:51:02 +0100
Message-Id: <1516103467-7983-4-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
References: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 3/8] aarch64-softmmu.mak: Use an ARM specific
 config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: Alistair Francis <alistair.francis@xilinx.com>

In preperation for having an ARM and MicroBlaze ZynqMP machine let's
split out the current ARM specific config options.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 default-configs/aarch64-softmmu.mak | 1 +
 hw/arm/Makefile.objs                | 2 +-
 hw/display/Makefile.objs            | 2 +-
 hw/dma/Makefile.objs                | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 2449483..9ddccf8 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -7,3 +7,4 @@ CONFIG_AUX=y
 CONFIG_DDC=y
 CONFIG_DPCD=y
 CONFIG_XLNX_ZYNQMP=y
+CONFIG_XLNX_ZYNQMP_ARM=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 2794e08..1c896ba 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -13,7 +13,7 @@ obj-y += omap1.o omap2.o strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp.o xlnx-zcu102.o
+obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 551c050..d3a4cb3 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -40,4 +40,4 @@ virtio-gpu.o-libs += $(VIRGL_LIBS)
 virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
 virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
 obj-$(CONFIG_DPCD) += dpcd.o
-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dp.o
+obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index 0b3a009..5adf385 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -8,7 +8,7 @@ common-obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
 common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
 common-obj-$(CONFIG_STP2000) += sparc32_dma.o
-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dpdma.o
+obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
 
 obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
-- 
2.7.4
