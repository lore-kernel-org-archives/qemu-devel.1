Received: from eggs.gnu.org ([2001:4830:134:3::10]:51553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWc-0004kM-JR
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWb-0007u2-T2
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:58 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWb-0007rv-MN
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:57 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWa-0007hW-NB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:56 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:18 +0000
Message-Id: <1513188761-20784-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/43] target/arm: Add missing M profile case to
 regime_is_user()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When we added the ARMMMUIdx_MSUser MMU index we forgot to
add it to the case statement in regime_is_user(), so we
weren't treating it as unprivileged when doing MPU lookups.
Correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1512153879-5291-4-git-send-email-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f21c142..c4c8d5a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8016,6 +8016,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1SE0:
     case ARMMMUIdx_S1NSE0:
     case ARMMMUIdx_MUser:
+    case ARMMMUIdx_MSUser:
         return true;
     default:
         return false;
-- 
2.7.4
