Received: from eggs.gnu.org ([2001:4830:134:3::10]:43660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQe-0001Yv-N4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQb-0004Hk-1O
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:49:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Oct 2017 14:48:31 +0100
Message-Id: <1507556919-24992-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/9] target/arm: Add M profile secure MMU index
 values to get_a32_user_mem_index()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

Add the M profile secure MMU index values to the switch in
get_a32_user_mem_index() so that LDRT/STRT work correctly
rather than asserting at translate time.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ab1a12a..e1b83b7 100644
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
