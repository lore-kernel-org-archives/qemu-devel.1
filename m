Received: from eggs.gnu.org ([2001:4830:134:3::10]:34417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0F-0002ng-R6
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0C-00055C-25
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dOM0B-000547-S8
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAA1142BD8
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 10:39:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 12:39:42 +0200
Message-Id: <20170623103945.7014-5-kraxel@redhat.com>
In-Reply-To: <20170623103945.7014-1-kraxel@redhat.com>
References: <20170623103945.7014-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] sdl2: add assert to make coverity happy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

There is a loop a few lines up counting consoles and setting
sdl2_num_outputs accordingly, so con ptr can't be NULL there.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170621122234.12751-1-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index f76ee1081f..53dd447fd2 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -804,6 +804,7 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
     sdl2_console = g_new0(struct sdl2_console, sdl2_num_outputs);
     for (i = 0; i < sdl2_num_outputs; i++) {
         QemuConsole *con = qemu_console_lookup_by_index(i);
+        assert(con != NULL);
         if (!qemu_console_is_graphic(con)) {
             sdl2_console[i].hidden = true;
         }
-- 
2.9.3
