Received: from eggs.gnu.org ([2001:4830:134:3::10]:58559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d55wI-0001rT-GU
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d55wG-0003iM-HO
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:40:10 -0400
Received: from chuckie.co.uk ([82.165.15.123]:56768
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d55wG-0003gh-Ai
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:40:08 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon,  1 May 2017 08:39:35 +0100
Message-Id: <1493624375-12707-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1493624375-12707-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1493624375-12707-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/2] cg3: add explicit ram_addr_t cast to
 scanline page variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com

Coverity warns that multiplying two 32-bit values gives a 32-bit result which
is assigned to a 64-bit variable. Add an explicit ram_addr_t cast to silence
the warning.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/cg3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 03d9197..7ef8a96 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -113,7 +113,7 @@ static void cg3_update_display(void *opaque)
     for (y = 0; y < height; y++) {
         int update = s->full_update;
 
-        page = y * width;
+        page = (ram_addr_t)y * width;
         update |= memory_region_get_dirty(&s->vram_mem, page, width,
                                           DIRTY_MEMORY_VGA);
         if (update) {
-- 
1.7.10.4
