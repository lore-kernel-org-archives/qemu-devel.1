Received: from eggs.gnu.org ([2001:4830:134:3::10]:41663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKY7-0002OY-37
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKY6-0000il-B3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:15 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKY6-0000iS-37
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:14 -0400
Received: by mail-lf0-x244.google.com with SMTP id f28so17186841lfi.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:55:13 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:48 +0200
Message-Id: <1499162088-1562-18-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 17/17] xilinx-dp: Add support for the yuy2
 video format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for the yuy2 video format.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Acked-by: Sai Pavan Boddu <saipava@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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
