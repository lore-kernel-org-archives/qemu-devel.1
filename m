Received: from eggs.gnu.org ([2001:4830:134:3::10]:33122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK4QB-0007Dj-Lp
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK4Q9-0000aq-4B
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:41:43 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 16:41:18 +0000
Message-Id: <20181106164118.16184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1] target/arm: Remove antique TODO comment
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

Remove a TODO comment about implementing the vectored interrupt
controller. We have had an implementation of that for a decade;
it's in hw/intc/pl190.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ec56becc394..851ea9aa977 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8378,7 +8378,6 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
         return;
     }
 
-    /* TODO: Vectored interrupt controller.  */
     switch (cs->exception_index) {
     case EXCP_UDEF:
         new_mode = ARM_CPU_MODE_UND;
-- 
2.19.1
