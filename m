Received: from eggs.gnu.org ([2001:4830:134:3::10]:54739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnlWB-0001x2-6p
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnlWA-0007q2-5Y
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dnlW9-0007pf-Vx
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E94538047F
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:57:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  1 Sep 2017 14:57:42 +0200
Message-Id: <20170901125742.4249-6-kraxel@redhat.com>
In-Reply-To: <20170901125742.4249-1-kraxel@redhat.com>
References: <20170901125742.4249-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] vga/migration: Update memory map in
 post_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

After migration the chain4 alias mapping added by 80763888 (in 2011)
might be missing, since there's no call to vga_update_memory_access
in the post_load after the registers are updated.  Add it back.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170804113329.13609-1-dgilbert@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 6fc8c8708a..ed24ef7076 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2050,6 +2050,7 @@ static int vga_common_post_load(void *opaque, int version_id)
     /* force refresh */
     s->graphic_mode = -1;
     vbe_update_vgaregs(s);
+    vga_update_memory_access(s);
     return 0;
 }
 
-- 
2.9.3
