Received: from eggs.gnu.org ([2001:4830:134:3::10]:56838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDHA-0005XF-4R
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDH4-0004jm-Tw
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuDH4-0004iV-Mp
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7103E4023827
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 08:53:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Aug 2018 10:53:09 +0200
Message-Id: <20180827085320.9732-2-kraxel@redhat.com>
In-Reply-To: <20180827085320.9732-1-kraxel@redhat.com>
References: <20180827085320.9732-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] ui/sdl2: Remove the obsolete
 SDL_INIT_NOPARACHUTE flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

SDL_INIT_NOPARACHUTE is not used in SDL2 anymore, and the define is just
a dummy (see https://wiki.libsdl.org/MigrationGuide#Some_general_truths
for example). So we can remove it and get rid of the "flags" variable
nowadays.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1533721602-15763-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 76e59427cc..755a7134ff 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -761,7 +761,6 @@ static void sdl2_display_early_init(DisplayOptions *o)
 
 static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 {
-    int flags;
     uint8_t data = 0;
     char *filename;
     int i;
@@ -782,8 +781,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     setenv("SDL_VIDEODRIVER", "x11", 0);
 #endif
 
-    flags = SDL_INIT_VIDEO | SDL_INIT_NOPARACHUTE;
-    if (SDL_Init(flags)) {
+    if (SDL_Init(SDL_INIT_VIDEO)) {
         fprintf(stderr, "Could not initialize SDL(%s) - exiting\n",
                 SDL_GetError());
         exit(1);
-- 
2.9.3
