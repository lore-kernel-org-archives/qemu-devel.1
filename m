Received: from eggs.gnu.org ([2001:4830:134:3::10]:39784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR0-0002lC-JJ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQz-0001Zm-CW
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQz-0001OF-2B
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQq-000314-1j
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:01 +0100
Message-Id: <20180426104715.21702-6-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/19] target/arm: Check PMCNTEN for whether
 PMCCNTR is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <alindsay@codeaurora.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1523997485-1905-2-git-send-email-alindsay@codeaurora.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0fa02c31e1..1526724d64 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -994,7 +994,7 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
 {
     /* This does not support checking PMCCFILTR_EL0 register */
 
-    if (!(env->cp15.c9_pmcr & PMCRE)) {
+    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
         return false;
     }
 
-- 
2.17.0
