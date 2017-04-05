Received: from eggs.gnu.org ([2001:4830:134:3::10]:57215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ5-0002Hz-0x
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ2-0005U4-8Q
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:00 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42817
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgQ2-0005TV-12
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:35:58 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:17 +0100
Message-Id: <1491381329-3995-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 02/14] cg3: fix up size parameter for
 memory_region_get_dirty()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org

The code was incorrectly calculating the end address rather than the size of
the required region.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/cg3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 7d43694..b42f60e 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -114,7 +114,7 @@ static void cg3_update_display(void *opaque)
         int update = s->full_update;
 
         page = y * width;
-        update |= memory_region_get_dirty(&s->vram_mem, page, page + width,
+        update |= memory_region_get_dirty(&s->vram_mem, page, width,
                                           DIRTY_MEMORY_VGA);
         if (update) {
             if (y_start < 0) {
-- 
1.7.10.4
