Received: from eggs.gnu.org ([2001:4830:134:3::10]:53060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8q-00076q-1Z
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8n-0007ya-0I
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:51:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eye8m-0007yL-Rz
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:56 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Mar 2018 14:50:40 +0100
Message-Id: <20180321135041.15768-6-kraxel@redhat.com>
In-Reply-To: <20180321135041.15768-1-kraxel@redhat.com>
References: <20180321135041.15768-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] sdl2: drop dead code
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

Leftover from sdl1 -> sdl2 port.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-input.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index d46411c474..1378b63dd9 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -62,14 +62,6 @@ void sdl2_process_key(struct sdl2_console *scon,
 
     /* modifier state tracking */
     switch (ev->keysym.scancode) {
-#if 0
-    case SDL_SCANCODE_NUMLOCKCLEAR:
-    case SDL_SCANCODE_CAPSLOCK:
-        /* SDL does not send the key up event, so we generate it */
-        qemu_input_event_send_key_qcode(con, qcode, true);
-        qemu_input_event_send_key_qcode(con, qcode, false);
-        return;
-#endif
     case SDL_SCANCODE_LCTRL:
     case SDL_SCANCODE_LSHIFT:
     case SDL_SCANCODE_LALT:
-- 
2.9.3
