Received: from eggs.gnu.org ([2001:4830:134:3::10]:42495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmkY-0001Dl-Bo
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chmkW-0005we-MJ
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 19:31:42 -0500
Message-Id: <db1b69270ca4d2335e6fb2455ee56552373757fc.1488068248.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 25 Feb 2017 22:47:26 +0100
Subject: [Qemu-devel] [PATCH v2 12/14] sm501: Implement reading 2D engine
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Clients normally only write to these registers, nothing is known to
ever read them but they are documented as read/write so allow clients
to also read the values.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index af5e4db..32223f6 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1149,9 +1149,66 @@ static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
     SM501_DPRINTF("sm501 2d engine regs : read addr=%x\n", (int)addr);
 
     switch (addr) {
+    case SM501_2D_SOURCE:
+        ret = s->twoD_source;
+        break;
+    case SM501_2D_DESTINATION:
+        ret = s->twoD_destination;
+        break;
+    case SM501_2D_DIMENSION:
+        ret = s->twoD_dimension;
+        break;
+    case SM501_2D_CONTROL:
+        ret = s->twoD_control;
+        break;
+    case SM501_2D_PITCH:
+        ret = s->twoD_pitch;
+        break;
+    case SM501_2D_FOREGROUND:
+        ret = s->twoD_foreground;
+        break;
+    case SM501_2D_BACKGROUND:
+        ret = s->twoD_background;
+        break;
+    case SM501_2D_STRETCH:
+        ret = s->twoD_stretch;
+        break;
+    case SM501_2D_COLOR_COMPARE:
+        ret = s->twoD_color_compare;
+        break;
+    case SM501_2D_COLOR_COMPARE_MASK:
+        ret = s->twoD_color_compare_mask;
+        break;
+    case SM501_2D_MASK:
+        ret = s->twoD_mask;
+        break;
+    case SM501_2D_CLIP_TL:
+        ret = s->twoD_clip_tl;
+        break;
+    case SM501_2D_CLIP_BR:
+        ret = s->twoD_clip_br;
+        break;
+    case SM501_2D_MONO_PATTERN_LOW:
+        ret = s->twoD_mono_pattern_low;
+        break;
+    case SM501_2D_MONO_PATTERN_HIGH:
+        ret = s->twoD_mono_pattern_high;
+        break;
+    case SM501_2D_WINDOW_WIDTH:
+        ret = s->twoD_window_width;
+        break;
     case SM501_2D_SOURCE_BASE:
         ret = s->twoD_source_base;
         break;
+    case SM501_2D_DESTINATION_BASE:
+        ret = s->twoD_destination_base;
+        break;
+    case SM501_2D_ALPHA:
+        ret = s->twoD_alpha;
+        break;
+    case SM501_2D_WRAP:
+        ret = s->twoD_wrap;
+        break;
     case SM501_2D_STATUS:
         ret = 0; /* Should return interrupt status */
         break;
-- 
2.7.4
