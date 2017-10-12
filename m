Received: from eggs.gnu.org ([2001:4830:134:3::10]:44186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxU-0003KH-2L
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxO-0004ZI-Ex
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxO-0004Xg-8S
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxM-0000cW-PZ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:26 +0100
Message-Id: <1507824216-29058-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/13] target/arm: Add M profile secure MMU
 index values to get_a32_user_mem_index()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add the M profile secure MMU index values to the switch in
get_a32_user_mem_index() so that LDRT/STRT work correctly
rather than asserting at translate time.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1507556919-24992-2-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fdc46cc..61fd0ef 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -165,6 +165,10 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_MPriv:
     case ARMMMUIdx_MNegPri:
         return arm_to_core_mmu_idx(ARMMMUIdx_MUser);
+    case ARMMMUIdx_MSUser:
+    case ARMMMUIdx_MSPriv:
+    case ARMMMUIdx_MSNegPri:
+        return arm_to_core_mmu_idx(ARMMMUIdx_MSUser);
     case ARMMMUIdx_S2NS:
     default:
         g_assert_not_reached();
-- 
2.7.4
