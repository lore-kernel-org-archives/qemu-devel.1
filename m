Received: from eggs.gnu.org ([2001:4830:134:3::10]:33284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTi-0005O7-5W
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTd-0006kP-HL
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTd-0006fN-9Q
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTO-00012Q-Nq
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:06:53 +0100
Message-Id: <1497362826-21125-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/17] hw/timer/exynos4210_mct: Remove unused
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Remove defines not used anywhere.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index ea5f99d..e4ef4cf 100644
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
2.7.4
