Received: from eggs.gnu.org ([2001:4830:134:3::10]:53203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqIw-0006H6-CX
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqIv-00033y-R0
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:44:54 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Dec 2017 18:44:35 +0000
Message-Id: <1512153879-5291-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/7] target/arm: Add missing M profile case to
 regime_is_user()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

When we added the ARMMMUIdx_MSUser MMU index we forgot to
add it to the case statement in regime_is_user(), so we
weren't treating it as unprivileged when doing MPU lookups.
Correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
