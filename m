Received: from eggs.gnu.org ([2001:4830:134:3::10]:60915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ebadK-0004OY-Dj
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ebadJ-00028l-CL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:27:10 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 16 Jan 2018 15:22:29 -0800
Message-ID: <6603dc74caa9a754b1a331055130096efab79a92.1516144891.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1516144891.git.alistair.francis@xilinx.com>
References: <cover.1516144891.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 4/9] aarch64-softmmu.mak: Use an ARM
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
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---

 default-configs/aarch64-softmmu.mak | 1 +
 hw/arm/Makefile.objs                | 2 +-
 hw/display/Makefile.objs            | 2 +-
 hw/dma/Makefile.objs                | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-=
softmmu.mak
index 24494832cf..9ddccf855e 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -7,3 +7,4 @@ CONFIG_AUX=3Dy
 CONFIG_DDC=3Dy
 CONFIG_DPCD=3Dy
 CONFIG_XLNX_ZYNQMP=3Dy
+CONFIG_XLNX_ZYNQMP_ARM=3Dy
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 2794e086d6..1c896bafb4 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -13,7 +13,7 @@ obj-y +=3D omap1.o omap2.o strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
 obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp.o xlnx-zcu102.o
+obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu102.o
 obj-$(CONFIG_FSL_IMX25) +=3D fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) +=3D fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o sabrelite.o
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 551c050a6a..d3a4cb396e 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -40,4 +40,4 @@ virtio-gpu.o-libs +=3D $(VIRGL_LIBS)
 virtio-gpu-3d.o-cflags :=3D $(VIRGL_CFLAGS)
 virtio-gpu-3d.o-libs +=3D $(VIRGL_LIBS)
 obj-$(CONFIG_DPCD) +=3D dpcd.o
-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx_dp.o
+obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx_dp.o
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index 0b3a009b87..c2afecbf73 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -9,6 +9,7 @@ common-obj-$(CONFIG_ZYNQ_DEVCFG) +=3D xlnx-zynq-devcfg.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_dma.o
 common-obj-$(CONFIG_STP2000) +=3D sparc32_dma.o
 obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx_dpdma.o
+obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx_dpdma.o

 obj-$(CONFIG_OMAP) +=3D omap_dma.o soc_dma.o
 obj-$(CONFIG_PXA2XX) +=3D pxa2xx_dma.o
--
2.14.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
