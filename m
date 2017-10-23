Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxM-000836-SX
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxM-0000uH-5H
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:20 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:47704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1e6jxL-0000u7-Uy
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:20 -0400
Received: by mail-wm0-x244.google.com with SMTP id t69so11975959wmt.2
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:08:19 -0700 (PDT)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Mon, 23 Oct 2017 23:07:57 +0200
Message-Id: <20171023210803.20998-2-makovick@gmail.com>
In-Reply-To: <20171023210803.20998-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 1/7] sdl2: Fix broken display updating after
 the window is hidden
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

With SDL 2.0.6, calling SDL_ShowWindow during SDL_WINDOWEVENT_HIDDEN
blocks all subsequent display updates.
---
 ui/sdl2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 53dd447fd2..7f51933234 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -576,11 +576,6 @@ static void handle_windowevent(SDL_Event *ev)
             SDL_HideWindow(scon->real_window);
         }
         break;
-    case SDL_WINDOWEVENT_HIDDEN:
-        if (!scon->hidden) {
-            SDL_ShowWindow(scon->real_window);
-        }
-        break;
     }
 }
 
-- 
2.15.0.rc0
