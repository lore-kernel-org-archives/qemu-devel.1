Received: from eggs.gnu.org ([2001:4830:134:3::10]:58557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d55wI-0001rR-GC
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d55wE-0003g3-KH
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:40:10 -0400
Received: from chuckie.co.uk ([82.165.15.123]:56762
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d55wE-0003ff-D9
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:40:06 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon,  1 May 2017 08:39:34 +0100
Message-Id: <1493624375-12707-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1493624375-12707-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1493624375-12707-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/2] tcx: fix cut/paste error in
 update_palette_entries()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com

Commit ee72bed0 "tcx: remove primitives for non-32-bit surfaces" accidentally
left a trailing break in update_palette_entries() causing the palette update
routine to exit after just one iteration. Remove it.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/tcx.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 5a1115c..0e66dcd 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -145,7 +145,6 @@ static void update_palette_entries(TCXState *s, int start, int end)
         } else {
             s->palette[i] = rgb_to_pixel32(s->r[i], s->g[i], s->b[i]);
         }
-        break;
     }
     tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
 }
-- 
1.7.10.4
