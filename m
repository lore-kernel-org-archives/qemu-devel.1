Received: from eggs.gnu.org ([2001:4830:134:3::10]:52917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnt7H-0000Vw-MW
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 17:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnt7G-0006ur-LT
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 17:04:39 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 1 Sep 2017 14:00:40 -0700
Message-ID: <26b702658b5bf9984edaecb22b1190be0a9d7052.1504293917.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1504293917.git.alistair.francis@xilinx.com>
References: <cover.1504293917.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 3/6] aarch64-softmmu.mak: Use an ARM
 specific config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, qemu-arm@nongnu.org

In preperation for having an ARM and MicroBlaze ZynqMP machine let's
split out the current ARM specific config options.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 default-configs/aarch64-softmmu.mak | 1 +
 hw/arm/Makefile.objs                | 2 +-
 hw/display/Makefile.objs            | 2 +-
 hw/dma/Makefile.objs                | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 24494832cf..9ddccf855e 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -7,3 +7,4 @@ CONFIG_AUX=y
 CONFIG_DDC=y
 CONFIG_DPCD=y
 CONFIG_XLNX_ZYNQMP=y
+CONFIG_XLNX_ZYNQMP_ARM=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index a2e56ecaae..95daa67836 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -13,7 +13,7 @@ obj-y += omap1.o omap2.o strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp.o xlnx-ep108.o
+obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-ep108.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 551c050a6a..d3a4cb396e 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -40,4 +40,4 @@ virtio-gpu.o-libs += $(VIRGL_LIBS)
 virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
 virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
 obj-$(CONFIG_DPCD) += dpcd.o
-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dp.o
+obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index 087c8e6855..be98d5d3d8 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -9,7 +9,7 @@ common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
 common-obj-$(CONFIG_STP2000) += sparc32_dma.o
 common-obj-$(CONFIG_SUN4M) += sun4m_iommu.o
-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dpdma.o
+obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
 
 obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
-- 
2.11.0
