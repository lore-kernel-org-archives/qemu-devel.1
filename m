Received: from eggs.gnu.org ([2001:4830:134:3::10]:50845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIP-0005d6-34
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIM-0003bw-RA
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5TIM-0003bc-Mn
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CB748011462
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 09:41:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Apr 2018 11:41:00 +0200
Message-Id: <20180409094100.27650-7-kraxel@redhat.com>
In-Reply-To: <20180409094100.27650-1-kraxel@redhat.com>
References: <20180409094100.27650-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] sdl2: drop dead code
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

Leftover from sdl1 -> sdl2 port.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180321135041.15768-6-kraxel@redhat.com
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
