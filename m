Received: from eggs.gnu.org ([209.51.188.92]:42492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJt-0004XW-7A
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJr-0004XQ-PT
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat,  9 Feb 2019 07:39:20 +0100
Message-Id: <1549694366-1284-20-git-send-email-thuth@redhat.com>
In-Reply-To: <1549694366-1284-1-git-send-email-thuth@redhat.com>
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 19/25] hw/arm: Express dependencies of
 sabrelite with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com
Cc: qemu-arm@nongnu.org, philmd@redhat.com

Add Kconfig dependencies for the Sabrelite / iMX6 machine.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 4 +---
 hw/arm/Kconfig                  | 7 +++++++
 hw/arm/Makefile.objs            | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 20fcbcb..f6193b1 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -29,6 +29,7 @@ CONFIG_NETDUINO2=y
 CONFIG_MPS2=y
 CONFIG_RASPI=y
 CONFIG_DIGIC=y
+CONFIG_SABRELITE=y
 
 CONFIG_VGA=y
 CONFIG_SSI_M25P80=y
@@ -36,13 +37,10 @@ CONFIG_IMX_FEC=y
 
 CONFIG_NRF51_SOC=y
 
-CONFIG_FSL_IMX6=y
 CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
 
-CONFIG_IMX_I2C=y
-
 CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 617a460..d98d39e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -184,6 +184,10 @@ config REALVIEW
     select DS1338 # I2C RTC+NVRAM
     select USB_OHCI
 
+config SABRELITE
+    bool
+    select FSL_IMX6
+
 config STELLARIS
     bool
     select ARM_V7M
@@ -304,6 +308,9 @@ config FSL_IMX31
 
 config FSL_IMX6
     bool
+    select A9MPCORE
+    select IMX
+    select IMX_I2C
 
 config ASPEED_SOC
     bool
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index f17187f..ee9f5c6 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -22,6 +22,7 @@ obj-$(CONFIG_COLLIE) += collie.o
 obj-$(CONFIG_VERSATILE) += versatilepb.o
 obj-$(CONFIG_VEXPRESS) += vexpress.o
 obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
+obj-$(CONFIG_SABRELITE) += sabrelite.o
 
 obj-$(CONFIG_ARM_V7M) += armv7m.o
 obj-$(CONFIG_EXYNOS4) += exynos4210.o
@@ -36,7 +37,7 @@ obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
 obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
-obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
+obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) += mps2.o
 obj-$(CONFIG_MPS2) += mps2-tz.o
-- 
1.8.3.1
