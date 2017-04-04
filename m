Received: from eggs.gnu.org ([2001:4830:134:3::10]:54133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcY-00026j-KZ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcT-0002DI-WF
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvLcT-0002C6-QI
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  4 Apr 2017 12:23:11 +0200
Message-Id: <20170404102315.24923-7-kraxel@redhat.com>
In-Reply-To: <20170404102315.24923-1-kraxel@redhat.com>
References: <20170404102315.24923-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] cg3: fix up size parameter for
 memory_region_get_dirty()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The code was incorrectly calculating the end address rather than the size of
the required region.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/cg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index e05ca92..6e19da0 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -115,7 +115,7 @@ static void cg3_update_display(void *opaque)
         int update = s->full_update;
 
         page = y * width;
-        update |= memory_region_get_dirty(&s->vram_mem, page, page + width,
+        update |= memory_region_get_dirty(&s->vram_mem, page, width - 1,
                                           DIRTY_MEMORY_VGA);
         if (update) {
             if (y_start < 0) {
-- 
2.9.3
