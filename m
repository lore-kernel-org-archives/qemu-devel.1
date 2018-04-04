Received: from eggs.gnu.org ([2001:4830:134:3::10]:37110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f3er0-0000gy-Am
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f3eqx-0004PZ-4c
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:37:18 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1f3eqw-0004P5-Ud
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:37:15 -0400
Received: by mail-wm0-x242.google.com with SMTP id r82so40991141wme.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 02:37:14 -0700 (PDT)
From: Elie Tournier <tournier.elie@gmail.com>
Date: Wed,  4 Apr 2018 10:30:40 +0100
Message-Id: <20180404093040.26009-1-tournier.elie@gmail.com>
Subject: [Qemu-devel] [PATCH] sdl2: Remove unused epoxy include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Elie Tournier <tournier.elie@gmail.com>

Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
---
Can someone push this patch for me please.
I don't have commit access.

 ui/sdl2-gl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 5e1073a084..c3683e6b65 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -32,8 +32,6 @@
 #include "ui/sdl2.h"
 #include "sysemu/sysemu.h"
 
-#include <epoxy/gl.h>
-
 static void sdl2_set_scanout_mode(struct sdl2_console *scon, bool scanout)
 {
     if (scon->scanout_mode == scanout) {
-- 
2.16.3
