Received: from eggs.gnu.org ([2001:4830:134:3::10]:58793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxP-000854-LO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxO-0000vI-S7
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:23 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:47147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1e6jxO-0000uw-Lx
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:22 -0400
Received: by mail-wr0-x242.google.com with SMTP id y39so18739087wrd.4
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:08:22 -0700 (PDT)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Mon, 23 Oct 2017 23:08:00 +0200
Message-Id: <20171023210803.20998-5-makovick@gmail.com>
In-Reply-To: <20171023210803.20998-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 4/7] sdl2: Only accept the hotkeys on the main
 window
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
 ui/sdl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 685e4fabec..fa54353430 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -349,7 +349,7 @@ static void handle_keydown(SDL_Event *ev)
     }
     gui_key_modifier_pressed = mod_state;
 
-    if (gui_key_modifier_pressed) {
+    if (gui_key_modifier_pressed && !ev->key.repeat && qemu_console_is_graphic(scon->dcl.con)) {
         switch (ev->key.keysym.scancode) {
         case SDL_SCANCODE_2:
         case SDL_SCANCODE_3:
-- 
2.15.0.rc0
