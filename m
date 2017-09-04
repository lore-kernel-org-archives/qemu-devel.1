Received: from eggs.gnu.org ([2001:4830:134:3::10]:52567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSQ-000511-Kq
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSB-0004ls-VV
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSB-0004l7-OY
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSA-0005VE-Ph
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:45 +0100
Message-Id: <1504527967-29248-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/36] armv7m_nvic.h: Move from include/hw/arm
 to include/hw/intc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The armv7m_nvic.h header file was accidentally placed in
include/hw/arm; move it to include/hw/intc to match where
its corresponding .c file lives.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-15-git-send-email-peter.maydell@linaro.org
---
 include/hw/arm/armv7m.h                | 2 +-
 include/hw/{arm => intc}/armv7m_nvic.h | 0
 hw/intc/armv7m_nvic.c                  | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/{arm => intc}/armv7m_nvic.h (100%)

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
-- 
2.7.4
