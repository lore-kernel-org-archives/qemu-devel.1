Received: from eggs.gnu.org ([2001:4830:134:3::10]:39665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQx-0002jm-23
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQw-0001Wl-BH
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQw-0001Vb-4e
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQv-00034D-40
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:08 +0100
Message-Id: <20180426104715.21702-13-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/19] target/arm: Fix bitmask for PMCCFILTR
 writes
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

It was shifted to the left one bit too few.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1523997485-1905-10-git-send-email-alindsay@codeaurora.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 81e88f255b..85c289f3b9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1119,7 +1119,7 @@ static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
     pmccntr_sync(env);
-    env->cp15.pmccfiltr_el0 = value & 0x7E000000;
+    env->cp15.pmccfiltr_el0 = value & 0xfc000000;
     pmccntr_sync(env);
 }
 
-- 
2.17.0
