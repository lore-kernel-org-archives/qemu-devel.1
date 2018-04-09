Received: from eggs.gnu.org ([2001:4830:134:3::10]:50851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIP-0005d9-4L
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIM-0003bi-M4
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5TIM-0003bK-HJ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B20B401CC41
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 09:41:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Apr 2018 11:40:59 +0200
Message-Id: <20180409094100.27650-6-kraxel@redhat.com>
In-Reply-To: <20180409094100.27650-1-kraxel@redhat.com>
References: <20180409094100.27650-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] sdl2: drop QEMU_KEY_BACKSPACE special case
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

Not needed, kbd_put_qcode_console() will handle that for us.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180321135041.15768-5-kraxel@redhat.com
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
