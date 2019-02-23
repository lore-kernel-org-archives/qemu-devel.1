Received: from eggs.gnu.org ([209.51.188.92]:57672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS51-0005Hh-Ti
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gxS50-0002pt-0F
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 02:50:39 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat, 23 Feb 2019 08:49:17 +0100
Message-Id: <1550908162-22644-26-git-send-email-thuth@redhat.com>
In-Reply-To: <1550908162-22644-1-git-send-email-thuth@redhat.com>
References: <1550908162-22644-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 25/30] hw/arm: Express dependencies for
 remaining IMX boards with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

IMX25, IMX7 and IMX6UL were still missing the Kconfig dependencies.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak |  2 --
 hw/arm/Kconfig                  | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index a01e407..88e4e8e 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -34,7 +34,6 @@ CONFIG_SABRELITE=y
 CONFIG_EMCRAFT_SF2=y
 
 CONFIG_VGA=y
-CONFIG_IMX_FEC=y
 
 CONFIG_NRF51_SOC=y
 
@@ -46,4 +45,3 @@ CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
-CONFIG_PCI_EXPRESS_DESIGNWARE=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9495e7f..3eee2bd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -295,6 +295,10 @@ config XLNX_VERSAL
 
 config FSL_IMX25
     bool
+    select IMX
+    select IMX_FEC
+    select IMX_I2C
+    select DS1338
 
 config FSL_IMX31
     bool
@@ -309,6 +313,7 @@ config FSL_IMX6
     select A9MPCORE
     select IMX
     select IMX_I2C
+    select SDHCI
 
 config ASPEED_SOC
     bool
@@ -337,12 +342,25 @@ config IOTKIT
 
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
 
 config NRF51_SOC
     bool
-- 
1.8.3.1
