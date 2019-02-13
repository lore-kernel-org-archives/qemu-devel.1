Received: from eggs.gnu.org ([209.51.188.92]:51852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtqG3-00021O-6d
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtq4r-0005rB-8t
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:39:34 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 09:38:05 +0100
Message-Id: <1550047098-1210-13-git-send-email-thuth@redhat.com>
In-Reply-To: <1550047098-1210-1-git-send-email-thuth@redhat.com>
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/25] hw/arm: Express dependencies of the
 aspeed boards with Kconfig
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

Dependencies have been determined by looking at hw/arm/aspeed.c

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak |  7 +------
 hw/arm/Kconfig                  | 10 ++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 9851068..b2e31b3 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -22,15 +22,12 @@ CONFIG_SPITZ=y
 CONFIG_TOSA=y
 CONFIG_Z2=y
 CONFIG_COLLIE=y
+CONFIG_ASPEED_SOC=y
 
 CONFIG_VGA=y
-CONFIG_TMP421=y
-CONFIG_PCA9552=y
 CONFIG_SSI_M25P80=y
 CONFIG_ALLWINNER_EMAC=y
 CONFIG_IMX_FEC=y
-CONFIG_FTGMAC100=y
-CONFIG_DS1338=y
 CONFIG_PLATFORM_BUS=y
 CONFIG_VIRTIO_MMIO=y
 
@@ -90,8 +87,6 @@ CONFIG_I82801B11=y
 CONFIG_ACPI=y
 CONFIG_ARM_VIRT=y
 CONFIG_SMBIOS=y
-CONFIG_ASPEED_SOC=y
-CONFIG_SMBUS_EEPROM=y
 CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
 CONFIG_FW_CFG_DMA=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 39cbda9..a4fe2c8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -267,6 +267,16 @@ config FSL_IMX6
 
 config ASPEED_SOC
     bool
+    select DS1338
+    select FTGMAC100
+    select I2C
+    select PCA9552
+    select SERIAL
+    select SMBUS_EEPROM
+    select SSI
+    select SSI_M25P80
+    select TMP105
+    select TMP421
 
 config MPS2
     bool
-- 
1.8.3.1
