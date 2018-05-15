Received: from eggs.gnu.org ([2001:4830:134:3::10]:35504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIVF1-0003wc-1i
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIVEw-0000kI-2r
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:23:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fIVEv-0000j9-Tp
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:23:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B38B818B13B
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:23:20 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 10:23:19 +0200
Message-Id: <20180515082319.30723-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] sdl2: move opts assignment into loop
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

So the opts pointer is set for all sdl2_consoles.

Fixes: 844fd50dbbcfc9e401895274bf4fb8da8e8d3f64
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index da037248c2..a0f9b16bc1 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -804,7 +804,6 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         return;
     }
     sdl2_console = g_new0(struct sdl2_console, sdl2_num_outputs);
-    sdl2_console->opts = o;
     for (i = 0; i < sdl2_num_outputs; i++) {
         QemuConsole *con = qemu_console_lookup_by_index(i);
         assert(con != NULL);
@@ -812,6 +811,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
             sdl2_console[i].hidden = true;
         }
         sdl2_console[i].idx = i;
+        sdl2_console[i].opts = o;
 #ifdef CONFIG_OPENGL
         sdl2_console[i].opengl = display_opengl;
         sdl2_console[i].dcl.ops = display_opengl ? &dcl_gl_ops : &dcl_2d_ops;
-- 
2.9.3
