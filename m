Received: from eggs.gnu.org ([2001:4830:134:3::10]:43402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWb-0002u1-8C
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWa-0004tx-F5
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:53 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWa-0004sK-84
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:52 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWZ-0001Lo-4R
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:51 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:15 +0000
Message-Id: <20180302110640.28004-15-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/39] include/hw/or-irq.h: Add missing include
 guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The or-irq.h header file is missing the customary guard against
multiple inclusion, which means compilation fails if it gets
included twice. Fix the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-11-peter.maydell@linaro.org
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
2.16.2
