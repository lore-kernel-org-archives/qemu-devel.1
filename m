Received: from eggs.gnu.org ([2001:4830:134:3::10]:60781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFiJ-0004V6-UH
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFiJ-0001C1-Aj
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:27 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMFiJ-0008MG-3g
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:27 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhG-0005r5-9Y
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:08:22 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 17:08:02 +0000
Message-Id: <20181112170816.500-3-peter.maydell@linaro.org>
In-Reply-To: <20181112170816.500-1-peter.maydell@linaro.org>
References: <20181112170816.500-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/16] target/arm: Remove antique TODO comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remove a TODO comment about implementing the vectored interrupt
controller. We have had an implementation of that for a decade;
it's in hw/intc/pl190.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181106164118.16184-1-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
