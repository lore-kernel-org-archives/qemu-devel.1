Received: from eggs.gnu.org ([2001:4830:134:3::10]:37264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eQLXE-0007o6-NV
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 18:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eQLXA-0006Xv-G9
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 18:06:23 -0500
Message-Id: <4a19707d5b6554dda851b5da07e0276634b50900.1513465066.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1513465066.git.balaton@eik.bme.hu>
References: <cover.1513465066.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 16 Dec 2017 23:57:46 +0100
Subject: [Qemu-devel] [PATCH 1/2] sm501: Add panel hardware cursor registers
 also to read function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

These were forgotten when adding panel layer support.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 7f18224..b9b6111 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -956,6 +956,19 @@ static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
         ret = s->dc_panel_v_sync;
         break;
 
+    case SM501_DC_PANEL_HWC_ADDR:
+        ret = s->dc_panel_hwc_addr;
+        break;
+    case SM501_DC_PANEL_HWC_LOC:
+        ret = s->dc_panel_hwc_location;
+        break;
+    case SM501_DC_PANEL_HWC_COLOR_1_2:
+        ret = s->dc_panel_hwc_color_1_2;
+        break;
+    case SM501_DC_PANEL_HWC_COLOR_3:
+        ret = s->dc_panel_hwc_color_3;
+        break;
+
     case SM501_DC_VIDEO_CONTROL:
         ret = s->dc_video_control;
         break;
-- 
2.7.6
