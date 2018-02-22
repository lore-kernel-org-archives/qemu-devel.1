Received: from eggs.gnu.org ([2001:4830:134:3::10]:50269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2E-0003J4-KS
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2B-0001zu-EY
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoo2B-0001yJ-62
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3440857F9
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:23:22 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 11:23:12 +0100
Message-Id: <20180222102317.25776-5-kraxel@redhat.com>
In-Reply-To: <20180222102317.25776-1-kraxel@redhat.com>
References: <20180222102317.25776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] egl-helpers: add alpha channel to texture
 format
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

Needed when rendering cursers which (unlike framebuffers)
actually are transparent.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180220110433.20353-4-kraxel@redhat.com
---
 ui/egl-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 5fa60ef4e8..16dc3ded36 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -83,7 +83,7 @@ void egl_fb_setup_new_tex(egl_fb *fb, int width, int height)
 
     glGenTextures(1, &texture);
     glBindTexture(GL_TEXTURE_2D, texture);
-    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height,
+    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height,
                  0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
 
     egl_fb_setup_for_tex(fb, width, height, texture, true);
-- 
2.9.3
