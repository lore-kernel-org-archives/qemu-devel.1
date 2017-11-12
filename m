Received: from eggs.gnu.org ([2001:4830:134:3::10]:39925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxr-0001et-IB
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxq-0008FR-Pk
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:43 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDxxq-0008FC-JY
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:42 -0500
Received: by mail-wm0-x243.google.com with SMTP id z3so1299758wme.3
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 11:30:42 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 20:30:30 +0100
Message-Id: <20171112193032.9724-7-makovick@gmail.com>
In-Reply-To: <20171112193032.9724-1-makovick@gmail.com>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 6/8] sdl2: Fix dead keyboard after fullsceen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>
Cc: Jindrich Makovicka <makovick@gmail.com>

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 ui/sdl2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 51721d764e..cdc599be48 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -418,6 +418,7 @@ static void handle_keyup(SDL_Event *ev)
             sdl2_reset_keys(scon);
             return;
         }
+        sdl2_reset_keys(scon);
         gui_keysym = 0;
     }
     if (!gui_keysym) {
-- 
2.15.0
