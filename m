Received: from eggs.gnu.org ([2001:4830:134:3::10]:58839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxS-00087s-Ql
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxR-0000wK-9P
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:26 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:49746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1e6jxR-0000w0-3f
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:25 -0400
Received: by mail-wm0-x244.google.com with SMTP id b189so11897876wmd.4
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:08:25 -0700 (PDT)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Mon, 23 Oct 2017 23:08:03 +0200
Message-Id: <20171023210803.20998-8-makovick@gmail.com>
In-Reply-To: <20171023210803.20998-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 7/7] sdl2: Do not leave grab when fullscreen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jindrich Makovicka <makovick@gmail.com>

---
 ui/sdl2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3823f0a834..811c21da27 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -451,8 +451,9 @@ static void handle_mousemotion(SDL_Event *ev)
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
2.15.0.rc0
