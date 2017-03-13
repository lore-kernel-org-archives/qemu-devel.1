Received: from eggs.gnu.org ([2001:4830:134:3::10]:42740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnULj-0003t2-L3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnULi-0001Y8-PT
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:05:39 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 13 Mar 2017 20:04:32 +0200
Message-Id: <20170313180432.7067-6-krzk@kernel.org>
In-Reply-To: <20170313180432.7067-1-krzk@kernel.org>
References: <20170313180432.7067-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v2 5/5] hw/timer/exynos4210_mct: Remove unused
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Remove defines not used anywhere.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
