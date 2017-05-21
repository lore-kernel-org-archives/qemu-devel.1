Received: from eggs.gnu.org ([2001:4830:134:3::10]:53535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dCSo4-0002Hn-2s
	for qemu-devel@nongnu.org; Sun, 21 May 2017 11:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dCSo3-0007CN-86
	for qemu-devel@nongnu.org; Sun, 21 May 2017 11:30:08 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 21 May 2017 17:29:41 +0200
Message-Id: <20170521152949.15338-4-krzk@kernel.org>
In-Reply-To: <20170521152949.15338-1-krzk@kernel.org>
References: <20170521152949.15338-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v3 03/11] hw/timer/exynos4210_mct: Fix
 checkpatch style errors
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

Fix checkpatch errors:
1. ERROR: spaces required around that '+' (ctx:VxV)
2. ERROR: spaces required around that '&' (ctx:VxV)

No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index a2ec3920f82e..2404fb737ac4 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -937,7 +937,7 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
 {
     uint32_t freq = s->freq;
     s->freq = 24000000 /
-            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg)+1) *
+            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg) + 1) *
                     MCT_CFG_GET_DIVIDER(s->reg_mct_cfg));
 
     if (freq != s->freq) {
@@ -1162,7 +1162,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
 
     DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
 
-    if (offset&0x4) {
+    if (offset & 0x4) {
         s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
     } else {
         s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
-- 
2.9.3
