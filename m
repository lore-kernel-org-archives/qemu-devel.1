Received: from eggs.gnu.org ([2001:4830:134:3::10]:53905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eoCGY-0008Cq-Tu
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eoCGX-0001hz-Ci
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:03:46 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 18:03:16 +0000
Message-Id: <20180220180325.29818-11-peter.maydell@linaro.org>
In-Reply-To: <20180220180325.29818-1-peter.maydell@linaro.org>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 10/19] include/hw/or-irq.h: Add missing include
 guard
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

The or-irq.h header file is missing the customary guard against
multiple inclusion, which means compilation fails if it gets
included twice. Fix the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/or-irq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
index fd900fcf19..3f6fc1b58a 100644
--- a/include/hw/or-irq.h
+++ b/include/hw/or-irq.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+#ifndef HW_OR_IRQ_H
+#define HW_OR_IRQ_H
+
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
@@ -41,3 +44,5 @@ struct OrIRQState {
     bool levels[MAX_OR_LINES];
     uint16_t num_lines;
 };
+
+#endif
-- 
2.16.1
