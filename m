Received: from eggs.gnu.org ([2001:4830:134:3::10]:50910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIS-0005en-Iq
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIN-0003cf-UN
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5TIN-0003cH-Pk
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:03 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Apr 2018 11:40:55 +0200
Message-Id: <20180409094100.27650-2-kraxel@redhat.com>
In-Reply-To: <20180409094100.27650-1-kraxel@redhat.com>
References: <20180409094100.27650-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] sdl2: Remove unused epoxy include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Elie Tournier <tournier.elie@gmail.com>, Elie Tournier <elie.tournier@collabora.com>

From: Elie Tournier <tournier.elie@gmail.com>

Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
Message-id: 20180404093040.26009-1-tournier.elie@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
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
2.9.3
