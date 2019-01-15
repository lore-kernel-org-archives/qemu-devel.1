Received: from eggs.gnu.org ([209.51.188.92]:37336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPYM-0002jb-E2
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gjPSn-0001eh-HP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:13:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:56326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gjPSn-0001A9-9b
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:13:09 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Tue, 15 Jan 2019 22:11:02 +0800
Message-Id: <20190115141108.934-32-yang.zhong@intel.com>
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
References: <20190115141108.934-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v2 31/37] ptimer: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/Kconfig       | 2 ++
 hw/net/Kconfig   | 2 ++
 hw/timer/Kconfig | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/hw/Kconfig b/hw/Kconfig
index 55743a958a..f9d88986a0 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -55,6 +55,8 @@ source riscv/Kconfig
 # Symbols used by multiple targets
 config XILINX
     bool
+    select PTIMER # for hw/timer/xilinx_timer.c
 
 config XILINX_AXI
     bool
+    select PTIMER # for hw/dma/xilinx_axidma.c
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 5a30fdcc17..a9aa60f9a7 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -45,6 +45,7 @@ config SMC91C111
 
 config LAN9118
     bool
+    select PTIMER
 
 config NE2000_ISA
     bool
@@ -96,6 +97,7 @@ config VIRTIO_NET
 
 config ETSEC
     bool
+    select PTIMER
 
 config ROCKER
     bool
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index e1a6e7469b..a021c742de 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -1,8 +1,10 @@
 config ARM_TIMER
     bool
+    select PTIMER
 
 config ARM_MPTIMER
     bool
+    select PTIMER
 
 config A9_GTIMER
     bool
@@ -36,12 +38,14 @@ config XLNX_ZYNQMP
 
 config ALTERA_TIMER
     bool
+    select PTIMER
 
 config MC146818RTC
     bool
 
 config ALLWINNER_A10_PIT
     bool
+    select PTIMER
 
 config STM32F2XX_TIMER
     bool
@@ -51,6 +55,8 @@ config SUN4V_RTC
 
 config CMSDK_APB_TIMER
     bool
+    select PTIMER
 
 config CMSDK_APB_DUALTIMER
     bool
+    select PTIMER
-- 
2.17.1
