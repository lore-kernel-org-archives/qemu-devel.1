Received: from eggs.gnu.org ([209.51.188.92]:36908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIt-0001lU-U6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSIr-0007j2-Lw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:47041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSIn-0005r5-Qx
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:27:11 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:24:04 +0800
Message-Id: <20190118112410.3010-38-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v3 37/43] ptimer: express dependencies with
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/Kconfig       | 2 ++
 hw/net/Kconfig   | 2 ++
 hw/timer/Kconfig | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/hw/Kconfig b/hw/Kconfig
index 906143a816..0d836b527e 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -62,6 +62,8 @@ source xtensa/Kconfig
 # Symbols used by multiple targets
 config XILINX
     bool
+    select PTIMER # for hw/timer/xilinx_timer.c
 
 config XILINX_AXI
     bool
+    select PTIMER # for hw/dma/xilinx_axidma.c
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 07eda72d78..b54577e00b 100644
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
