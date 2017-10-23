Received: from eggs.gnu.org ([2001:4830:134:3::10]:58838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxS-00087r-Qi
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxQ-0000w3-HQ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:26 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:50763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1e6jxQ-0000vd-A4
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:24 -0400
Received: by mail-wr0-x244.google.com with SMTP id p96so4843658wrb.7
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:08:24 -0700 (PDT)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Mon, 23 Oct 2017 23:08:02 +0200
Message-Id: <20171023210803.20998-7-makovick@gmail.com>
In-Reply-To: <20171023210803.20998-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 6/7] sdl2: Fix dead keyboard after fullsceen
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
 ui/sdl2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 092eab37dc..3823f0a834 100644
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
2.15.0.rc0
