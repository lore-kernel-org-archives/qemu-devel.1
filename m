Received: from eggs.gnu.org ([2001:4830:134:3::10]:57531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cj8xi-00055d-2e
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cj8xh-00070Z-8l
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:26:54 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed,  1 Mar 2017 20:26:18 +0200
Message-Id: <20170301182618.22395-6-krzk@kernel.org>
In-Reply-To: <20170301182618.22395-1-krzk@kernel.org>
References: <20170301182618.22395-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 5/5] hw/timer/exynos4210_mct: Remove unused
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhao@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>

Remove defines not used anywhere.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/timer/exynos4210_mct.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 4dd3e441e2e6..6069116942a4 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -172,13 +172,10 @@ enum LocalTimerRegCntIndexes {
     L_REG_CNT_AMOUNT
 };
 
-#define MCT_NIRQ                6
 #define MCT_SFR_SIZE            0x444
 
 #define MCT_GT_CMP_NUM          4
 
-#define MCT_GT_MAX_VAL          UINT64_MAX
-
 #define MCT_GT_COUNTER_STEP     0x100000000ULL
 #define MCT_LT_COUNTER_STEP     0x100000000ULL
 #define MCT_LT_CNT_LOW_LIMIT    0x100
-- 
2.9.3
