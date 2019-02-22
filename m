Received: from eggs.gnu.org ([209.51.188.92]:60548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eQ-0006yE-BO
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eO-0001cF-OK
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx5eN-0001Sg-Bc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39FC63082A51
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:53:33 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 08:53:14 +0100
Message-Id: <20190222075326.9850-4-kraxel@redhat.com>
In-Reply-To: <20190222075326.9850-1-kraxel@redhat.com>
References: <20190222075326.9850-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] sdl2: drop
 qemu_input_event_send_key_qcode call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

qkbd_state_key_event() does that for us.

Fixes: 07333e1ca3 kbd-state: use state tracker for sdl2
Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 20190208072744.10687-1-kraxel@redhat.com
---
 ui/sdl2-input.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 664364a5e5be..fb345f45fb28 100644
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
