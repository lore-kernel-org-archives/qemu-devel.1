Received: from eggs.gnu.org ([2001:4830:134:3::10]:57475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cj8xf-00050s-Av
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cj8xe-0006yw-JT
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 13:26:51 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed,  1 Mar 2017 20:26:17 +0200
Message-Id: <20170301182618.22395-5-krzk@kernel.org>
In-Reply-To: <20170301182618.22395-1-krzk@kernel.org>
References: <20170301182618.22395-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 4/5] hw/timer/exynos4210_mct: Fix checkpatch
 style errors
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

Fix checkpatch errors:
1. ERROR: spaces required around that '+' (ctx:VxV)
2. ERROR: spaces required around that '&' (ctx:VxV)

No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/timer/exynos4210_mct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 76634fb1b4fd..4dd3e441e2e6 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -936,7 +936,7 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
 {
     uint32_t freq = s->freq;
     s->freq = 24000000 /
-            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg)+1) *
+            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg) + 1) *
                     MCT_CFG_GET_DIVIDER(s->reg_mct_cfg));
 
     if (freq != s->freq) {
@@ -1160,7 +1160,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
 
         DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
 
-        if (offset&0x4) {
+        if (offset & 0x4) {
             s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
         } else {
             s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
-- 
2.9.3
