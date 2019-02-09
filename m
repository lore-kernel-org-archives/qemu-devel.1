Received: from eggs.gnu.org ([209.51.188.92]:42335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJn-0004SH-Nb
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJl-0004Qq-CN
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:51 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat,  9 Feb 2019 07:39:18 +0100
Message-Id: <1549694366-1284-18-git-send-email-thuth@redhat.com>
In-Reply-To: <1549694366-1284-1-git-send-email-thuth@redhat.com>
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 17/25] hw/arm: Express dependencies of the
 raspi machines with Kconfig
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

Most of the code is directly controlled by the CONFIG_RASPI switch,
so not much to add here additionally.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 4 +---
 hw/arm/Kconfig                  | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index b530a06..6605786 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -27,15 +27,13 @@ CONFIG_COLLIE=y
 CONFIG_ASPEED_SOC=y
 CONFIG_NETDUINO2=y
 CONFIG_MPS2=y
+CONFIG_RASPI=y
 
 CONFIG_VGA=y
 CONFIG_SSI_M25P80=y
 CONFIG_IMX_FEC=y
 
-CONFIG_FRAMEBUFFER=y
-
 CONFIG_DIGIC=y
-CONFIG_RASPI=y
 CONFIG_NRF51_SOC=y
 
 CONFIG_FSL_IMX6=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5765fe9..6b1522f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -270,6 +270,10 @@ config ALLWINNER_A10
 
 config RASPI
     bool
+    select FRAMEBUFFER
+    select PL011 # UART
+    select SDHCI
+    select PCI          # TODO: Currently required for SDHCI, remove this later
 
 config STM32F205_SOC
     bool
-- 
1.8.3.1
