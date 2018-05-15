Received: from eggs.gnu.org ([2001:4830:134:3::10]:48523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6u-0004Dt-7x
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6q-0001Ta-5I
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:08 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 11:18:52 +0200
Message-Id: <20180515091901.27774-2-kraxel@redhat.com>
In-Reply-To: <20180515091901.27774-1-kraxel@redhat.com>
References: <20180515091901.27774-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] sdl2: move opts assignment into loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

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
