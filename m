Received: from eggs.gnu.org ([2001:4830:134:3::10]:53662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dCSoD-0002SG-Qb
	for qemu-devel@nongnu.org; Sun, 21 May 2017 11:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dCSoD-0007KP-4v
	for qemu-devel@nongnu.org; Sun, 21 May 2017 11:30:17 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 21 May 2017 17:29:43 +0200
Message-Id: <20170521152949.15338-6-krzk@kernel.org>
In-Reply-To: <20170521152949.15338-1-krzk@kernel.org>
References: <20170521152949.15338-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v3 05/11] hw/timer/exynos4210_mct: Remove
 unused defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Krzysztof Kozlowski <krzk@kernel.org>

Remove defines not used anywhere.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index ea5f99d9a41b..e4ef4cfd3625 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -173,13 +173,10 @@ enum LocalTimerRegCntIndexes {
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
