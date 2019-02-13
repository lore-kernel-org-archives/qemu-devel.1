Received: from eggs.gnu.org ([209.51.188.92]:51852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtqFz-00021O-RZ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtq51-00062O-36
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:39:43 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 09:38:13 +0100
Message-Id: <1550047098-1210-21-git-send-email-thuth@redhat.com>
In-Reply-To: <1550047098-1210-1-git-send-email-thuth@redhat.com>
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/25] hw/arm: Express dependencies of the
 MSF2 machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, philmd@redhat.com

Add Kconfig dependencies for the emcraft-sf2 machine - we also
distinguis between the machine (CONFIG_EMCRAFT_SF2) and the SoC
(CONFIG_MSF2) now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 3 +--
 hw/arm/Kconfig                  | 8 ++++++++
 hw/arm/Makefile.objs            | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index f6193b1..5eceeba 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -30,9 +30,9 @@ CONFIG_MPS2=y
 CONFIG_RASPI=y
 CONFIG_DIGIC=y
 CONFIG_SABRELITE=y
+CONFIG_EMCRAFT_SF2=y
 
 CONFIG_VGA=y
-CONFIG_SSI_M25P80=y
 CONFIG_IMX_FEC=y
 
 CONFIG_NRF51_SOC=y
@@ -45,5 +45,4 @@ CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
-CONFIG_MSF2=y
 CONFIG_PCI_EXPRESS_DESIGNWARE=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 70fc73f..cebb410 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -358,9 +358,17 @@ config FSL_IMX6UL
 config NRF51_SOC
     bool
 
+config EMCRAFT_SF2
+    bool
+    select MSF2
+    select SSI_M25P80
+
 config MSF2
     bool
+    select ARM_V7M
     select PTIMER
+    select SERIAL
+    select SSI
 
 config ZAURUS
     bool
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index ee9f5c6..29dc7d9 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARM_VIRT) += virt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
+obj-$(CONFIG_EMCRAFT_SF2) += msf2-som.o
 obj-$(CONFIG_HIGHBANK) += highbank.o
 obj-$(CONFIG_INTEGRATOR) += integratorcp.o
 obj-$(CONFIG_MAINSTONE) += mainstone.o
@@ -41,7 +42,7 @@ obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) += mps2.o
 obj-$(CONFIG_MPS2) += mps2-tz.o
-obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
+obj-$(CONFIG_MSF2) += msf2-soc.o
 obj-$(CONFIG_ARMSSE) += armsse.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
 obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
-- 
1.8.3.1
