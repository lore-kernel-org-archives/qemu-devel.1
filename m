Received: from eggs.gnu.org ([209.51.188.92]:53042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gs0Zm-0008Dx-Ao
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gs0Zl-0001ik-Fx
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:27:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gs0Zl-0001h0-66
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:27:53 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  8 Feb 2019 08:27:44 +0100
Message-Id: <20190208072744.10687-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] sdl2: drop qemu_input_event_send_key_qcode call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, balaton@eik.bme.hu

qkbd_state_key_event() does that for us.

Fixes: 07333e1ca3 kbd-state: use state tracker for sdl2
Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-input.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 664364a5e5..fb345f45fb 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -54,8 +54,5 @@ void sdl2_process_key(struct sdl2_console *scon,
                 break;
             }
         }
-    } else {
-        qemu_input_event_send_key_qcode(con, qcode,
-                                        ev->type == SDL_KEYDOWN);
     }
 }
-- 
2.9.3
