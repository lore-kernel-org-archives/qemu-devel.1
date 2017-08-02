Received: from eggs.gnu.org ([2001:4830:134:3::10]:49404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwl5-0003Ud-Eo
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwl4-0004ec-L8
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:31 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  2 Aug 2017 17:44:00 +0100
Message-Id: <1501692241-23310-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 14/15] armv7m_nvic.h: Move from include/hw/arm
 to include/hw/intc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The armv7m_nvic.h header file was accidentally placed in
include/hw/arm; move it to include/hw/intc to match where
its corresponding .c file lives.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c                  | 2 +-
 include/hw/arm/armv7m.h                | 2 +-
 include/hw/{arm => intc}/armv7m_nvic.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/{arm => intc}/armv7m_nvic.h (100%)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 343bc16..5a18025 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -17,7 +17,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/arm/arm.h"
-#include "hw/arm/armv7m_nvic.h"
+#include "hw/intc/armv7m_nvic.h"
 #include "target/arm/cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index a9b3f2a..10eb058 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -11,7 +11,7 @@
 #define HW_ARM_ARMV7M_H
 
 #include "hw/sysbus.h"
-#include "hw/arm/armv7m_nvic.h"
+#include "hw/intc/armv7m_nvic.h"
 
 #define TYPE_BITBAND "ARM,bitband-memory"
 #define BITBAND(obj) OBJECT_CHECK(BitBandState, (obj), TYPE_BITBAND)
diff --git a/include/hw/arm/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
similarity index 100%
rename from include/hw/arm/armv7m_nvic.h
rename to include/hw/intc/armv7m_nvic.h
-- 
2.7.4
