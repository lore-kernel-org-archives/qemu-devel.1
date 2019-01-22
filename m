Received: from eggs.gnu.org ([209.51.188.92]:59106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsVw-0006AI-M1
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsM0-0003OS-Rb
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glsM0-0003MP-Lz
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66A9C50452
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:28:19 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 Jan 2019 10:28:08 +0100
Message-Id: <20190122092814.14919-3-kraxel@redhat.com>
In-Reply-To: <20190122092814.14919-1-kraxel@redhat.com>
References: <20190122092814.14919-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v3 2/8] sdl2: remove sdl2_reset_keys()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

No users left, dead code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/sdl2.h |  1 -
 ui/sdl2-input.c   | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index f43eecdbd6..fffbbfaee4 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -41,7 +41,6 @@ void sdl2_window_destroy(struct sdl2_console *scon);
 void sdl2_window_resize(struct sdl2_console *scon);
 void sdl2_poll_events(struct sdl2_console *scon);
 
-void sdl2_reset_keys(struct sdl2_console *scon);
 void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev);
 
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 1378b63dd9..208266c6a5 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -32,22 +32,6 @@
 
 static uint8_t modifiers_state[SDL_NUM_SCANCODES];
 
-void sdl2_reset_keys(struct sdl2_console *scon)
-{
-    QemuConsole *con = scon ? scon->dcl.con : NULL;
-    int i;
-
-    for (i = 0 ;
-         i < SDL_NUM_SCANCODES && i < qemu_input_map_usb_to_qcode_len ;
-         i++) {
-        if (modifiers_state[i]) {
-            int qcode = qemu_input_map_usb_to_qcode[i];
-            qemu_input_event_send_key_qcode(con, qcode, false);
-            modifiers_state[i] = 0;
-        }
-    }
-}
-
 void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev)
 {
-- 
2.9.3
