Received: from eggs.gnu.org ([2001:4830:134:3::10]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8g-0006z9-MM
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8a-0007sW-VA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eye8a-0007rz-QR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:50:44 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Mar 2018 14:50:39 +0100
Message-Id: <20180321135041.15768-5-kraxel@redhat.com>
In-Reply-To: <20180321135041.15768-1-kraxel@redhat.com>
References: <20180321135041.15768-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] sdl2: drop QEMU_KEY_BACKSPACE special case
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

Not needed, kbd_put_qcode_console() will handle that for us.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-input.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 62c2b58ef0..d46411c474 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -97,9 +97,6 @@ void sdl2_process_key(struct sdl2_console *scon,
             case SDL_SCANCODE_RETURN:
                 kbd_put_keysym_console(con, '\n');
                 break;
-            case SDL_SCANCODE_BACKSPACE:
-                kbd_put_keysym_console(con, QEMU_KEY_BACKSPACE);
-                break;
             default:
                 kbd_put_qcode_console(con, qcode, ctrl);
                 break;
-- 
2.9.3
