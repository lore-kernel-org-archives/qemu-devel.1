Received: from eggs.gnu.org ([209.51.188.92]:42215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJ9-0003ld-H6
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMJ8-0003h0-Qz
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:40:11 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Sat,  9 Feb 2019 07:39:17 +0100
Message-Id: <1549694366-1284-17-git-send-email-thuth@redhat.com>
In-Reply-To: <1549694366-1284-1-git-send-email-thuth@redhat.com>
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 16/25] hw/arm: Express dependencies of the MPS2
 boards with Kconfig
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

Add Kconfig dependencies for the mps2-an* machines.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 19 +------------------
 hw/arm/Kconfig                  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 28bb37f..b530a06 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -26,6 +26,7 @@ CONFIG_Z2=y
 CONFIG_COLLIE=y
 CONFIG_ASPEED_SOC=y
 CONFIG_NETDUINO2=y
+CONFIG_MPS2=y
 
 CONFIG_VGA=y
 CONFIG_SSI_M25P80=y
@@ -34,27 +35,9 @@ CONFIG_IMX_FEC=y
 CONFIG_FRAMEBUFFER=y
 
 CONFIG_DIGIC=y
-CONFIG_MPS2=y
 CONFIG_RASPI=y
 CONFIG_NRF51_SOC=y
 
-CONFIG_CMSDK_APB_TIMER=y
-CONFIG_CMSDK_APB_DUALTIMER=y
-CONFIG_CMSDK_APB_UART=y
-CONFIG_CMSDK_APB_WATCHDOG=y
-
-CONFIG_MPS2_FPGAIO=y
-CONFIG_MPS2_SCC=y
-
-CONFIG_TZ_MPC=y
-CONFIG_TZ_MSC=y
-CONFIG_TZ_PPC=y
-CONFIG_ARMSSE=y
-CONFIG_IOTKIT_SECCTL=y
-CONFIG_IOTKIT_SYSCTL=y
-CONFIG_IOTKIT_SYSINFO=y
-CONFIG_ARMSSE_CPUID=y
-
 CONFIG_FSL_IMX6=y
 CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3621d44..5765fe9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -315,6 +315,23 @@ config ASPEED_SOC
 
 config MPS2
     bool
+    select ARMSSE
+    select ARMSSE_CPUID
+    select CMSDK_APB_TIMER
+    select CMSDK_APB_DUALTIMER
+    select CMSDK_APB_UART
+    select CMSDK_APB_WATCHDOG
+    select IOTKIT_SECCTL
+    select IOTKIT_SYSCTL
+    select IOTKIT_SYSINFO
+    select LAN9118
+    select MPS2_FPGAIO
+    select MPS2_SCC
+    select PL022    # Serial port
+    select PL080    # DMA controller
+    select TZ_MPC
+    select TZ_MSC
+    select TZ_PPC
 
 config IOTKIT
     bool
-- 
1.8.3.1
