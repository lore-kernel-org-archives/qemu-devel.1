Received: from eggs.gnu.org ([2001:4830:134:3::10]:42809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnULm-0003vC-0B
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnULk-0001by-Tt
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:05:42 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 13 Mar 2017 20:04:31 +0200
Message-Id: <20170313180432.7067-5-krzk@kernel.org>
In-Reply-To: <20170313180432.7067-1-krzk@kernel.org>
References: <20170313180432.7067-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v2 4/5] hw/timer/exynos4210_mct: Cleanup
 indentation and empty new lines
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

Statements under 'case' were in some places wrongly indented bringing
confusion and making the code less readable.  Remove also few unneeded
blank lines.  No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index cd290637f357..4dd3e441e2e6 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1015,9 +1015,9 @@ static uint64_t exynos4210_mct_read(void *opaque, hwaddr offset,
 
     case G_COMP_L(0): case G_COMP_L(1): case G_COMP_L(2): case G_COMP_L(3):
     case G_COMP_U(0): case G_COMP_U(1): case G_COMP_U(2): case G_COMP_U(3):
-    index = GET_G_COMP_IDX(offset);
-    shift = 8 * (offset & 0x4);
-    value = UINT32_MAX & (s->g_timer.reg.comp[index] >> shift);
+        index = GET_G_COMP_IDX(offset);
+        shift = 8 * (offset & 0x4);
+        value = UINT32_MAX & (s->g_timer.reg.comp[index] >> shift);
     break;
 
     case G_TCON:
@@ -1066,7 +1066,6 @@ static uint64_t exynos4210_mct_read(void *opaque, hwaddr offset,
         lt_i = GET_L_TIMER_IDX(offset);
 
         value = exynos4210_lfrc_get_count(&s->l_timer[lt_i]);
-
         break;
 
     case L0_TCON: case L1_TCON:
@@ -1152,23 +1151,23 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
 
     case G_COMP_L(0): case G_COMP_L(1): case G_COMP_L(2): case G_COMP_L(3):
     case G_COMP_U(0): case G_COMP_U(1): case G_COMP_U(2): case G_COMP_U(3):
-    index = GET_G_COMP_IDX(offset);
-    shift = 8 * (offset & 0x4);
-    s->g_timer.reg.comp[index] =
-            (s->g_timer.reg.comp[index] &
-            (((uint64_t)UINT32_MAX << 32) >> shift)) +
-            (value << shift);
+        index = GET_G_COMP_IDX(offset);
+        shift = 8 * (offset & 0x4);
+        s->g_timer.reg.comp[index] =
+                (s->g_timer.reg.comp[index] &
+                (((uint64_t)UINT32_MAX << 32) >> shift)) +
+                (value << shift);
 
-    DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
+        DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
 
-    if (offset & 0x4) {
-        s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
-    } else {
-        s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
-    }
+        if (offset & 0x4) {
+            s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
+        } else {
+            s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
+        }
 
-    exynos4210_gfrc_restart(s);
-    break;
+        exynos4210_gfrc_restart(s);
+        break;
 
     case G_TCON:
         old_val = s->g_timer.reg.tcon;
@@ -1206,7 +1205,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         break;
 
     case G_INT_ENB:
-
         /* Raise IRQ if transition from disabled to enabled and CSTAT pending */
         for (i = 0; i < MCT_GT_CMP_NUM; i++) {
             if ((value & G_INT_ENABLE(i)) > (s->g_timer.reg.tcon &
@@ -1287,7 +1285,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         break;
 
     case L0_TCNTB: case L1_TCNTB:
-
         lt_i = GET_L_TIMER_IDX(offset);
         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
 
@@ -1315,7 +1312,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         break;
 
     case L0_ICNTB: case L1_ICNTB:
-
         lt_i = GET_L_TIMER_IDX(offset);
         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
 
@@ -1352,13 +1348,12 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         if (icntb_max[lt_i] < value) {
             icntb_max[lt_i] = value;
         }
-DPRINTF("local timer[%d] ICNTB write %llx; max=%x, min=%x\n\n",
-        lt_i, value, icntb_max[lt_i], icntb_min[lt_i]);
+        DPRINTF("local timer[%d] ICNTB write %llx; max=%x, min=%x\n\n",
+                lt_i, value, icntb_max[lt_i], icntb_min[lt_i]);
 #endif
-break;
+        break;
 
     case L0_FRCNTB: case L1_FRCNTB:
-
         lt_i = GET_L_TIMER_IDX(offset);
         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
 
-- 
2.9.3
