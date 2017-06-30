Received: from eggs.gnu.org ([2001:4830:134:3::10]:54075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dQwOk-0007Lh-Sm
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dQwOh-0005dE-Lw
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:55:50 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 30 Jun 2017 15:55:44 +0200
Message-Id: <1498830944-26857-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/1] xilinx-dp: Add support for the yuy2
 video format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for the yuy2 video format.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Acked-by: Sai Pavan Boddu <saipava@xilinx.com>
---
 hw/display/xlnx_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index f7b7b80..a77d7db 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -624,6 +624,9 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
     case 0:
         s->v_plane.format = PIXMAN_x8b8g8r8;
         break;
+    case DP_NL_VID_Y0_CB_Y1_CR:
+        s->v_plane.format = PIXMAN_yuy2;
+        break;
     case DP_NL_VID_RGBA8880:
         s->v_plane.format = PIXMAN_x8b8g8r8;
         break;
-- 
2.7.4
