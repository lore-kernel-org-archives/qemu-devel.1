Received: from eggs.gnu.org ([2001:4830:134:3::10]:52243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSA-0004oz-Tq
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS1-0004Zt-Jz
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS1-0004Yp-Dm
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS0-0005RQ-F3
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:00 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:37 +0100
Message-Id: <1504527967-29248-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/36] target/arm: Remove incorrect comment
 about MPU_CTRL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remove the comment that claims that some MPU_CTRL bits are stored
in sctlr_el[1]. This has never been true since MPU_CTRL was added
in commit 29c483a50607 -- the comment is a leftover from
Michael Davidsaver's original implementation, which I modified
not to use sctlr_el[1]; I forgot to delete the comment then.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-7-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5932ef1..2f2aa87 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -416,7 +416,7 @@ typedef struct CPUARMState {
         uint32_t dfsr; /* Debug Fault Status Register */
         uint32_t mmfar; /* MemManage Fault Address */
         uint32_t bfar; /* BusFault Address */
-        unsigned mpu_ctrl; /* MPU_CTRL (some bits kept in sctlr_el[1]) */
+        unsigned mpu_ctrl; /* MPU_CTRL */
         int exception;
     } v7m;
 
-- 
2.7.4
