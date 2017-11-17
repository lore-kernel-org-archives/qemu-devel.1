Received: from eggs.gnu.org ([2001:4830:134:3::10]:42487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY4-0006eQ-BH
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY1-00063U-6d
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdY0-00060v-WA
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:06:57 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:06:52 +0100
Message-Id: <20171117100653.13015-5-kraxel@redhat.com>
In-Reply-To: <20171117100653.13015-1-kraxel@redhat.com>
References: <20171117100653.13015-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] sdl2: Do not leave grab when fullscreen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jindrich Makovicka <makovick@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Jindrich Makovicka <makovick@gmail.com>

Prevents displaying of a doubled mouse pointer when moving the pointer
to the screen edges when fullscreen.

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
Message-Id: <20171112193032.9724-8-makovick@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index cf05214f97..8360054094 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -471,8 +471,9 @@ static void handle_mousemotion(SDL_Event *ev)
         SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
         max_x = scr_w - 1;
         max_y = scr_h - 1;
-        if (gui_grab && (ev->motion.x == 0 || ev->motion.y == 0 ||
-                         ev->motion.x == max_x || ev->motion.y == max_y)) {
+        if (gui_grab && !gui_fullscreen
+            && (ev->motion.x == 0 || ev->motion.y == 0 ||
+                ev->motion.x == max_x || ev->motion.y == max_y)) {
             sdl_grab_end(scon);
         }
         if (!gui_grab &&
-- 
2.9.3
