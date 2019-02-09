Received: from eggs.gnu.org ([209.51.188.92]:42567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJu-0004Z2-Lu
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJt-0004aQ-44
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:58 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat,  9 Feb 2019 07:39:22 +0100
Message-Id: <1549694366-1284-22-git-send-email-thuth@redhat.com>
In-Reply-To: <1549694366-1284-1-git-send-email-thuth@redhat.com>
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 21/25] hw/arm: Express dependencies for
 remaining IMX boards with Kconfig
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

IMX25, IMX7 and IMX6UL were still missing the Kconfig dependencies.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak |  2 --
 hw/arm/Kconfig                  | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 729e4b8..e0d1a00 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -33,7 +33,6 @@ CONFIG_SABRELITE=y
 CONFIG_MSF2=y
 
 CONFIG_VGA=y
-CONFIG_IMX_FEC=y
 
 CONFIG_NRF51_SOC=y
 
@@ -45,4 +44,3 @@ CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
-CONFIG_PCI_EXPRESS_DESIGNWARE=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7823a16..c4b3cd2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -297,6 +297,10 @@ config XLNX_VERSAL
 
 config FSL_IMX25
     bool
+    select IMX
+    select IMX_FEC
+    select IMX_I2C
+    select DS1338
 
 config FSL_IMX31
     bool
@@ -311,6 +315,8 @@ config FSL_IMX6
     select A9MPCORE
     select IMX
     select IMX_I2C
+    select SDHCI
+    select PCI          # TODO: Currently required for SDHCI, remove this later
 
 config ASPEED_SOC
     bool
@@ -350,12 +356,26 @@ config IOTKIT
 
 config FSL_IMX7
     bool
+    imply PCI_DEVICES
+    select A15MPCORE
+    select PCI
+    select IMX
+    select IMX_FEC
+    select IMX_I2C
+    select PCI_EXPRESS_DESIGNWARE
+    select SDHCI
 
 config ARM_SMMUV3
     bool
 
 config FSL_IMX6UL
     bool
+    select A15MPCORE
+    select IMX
+    select IMX_FEC
+    select IMX_I2C
+    select SDHCI
+    select PCI          # TODO: Currently required for SDHCI, remove this later
 
 config NRF51_SOC
     bool
-- 
1.8.3.1
