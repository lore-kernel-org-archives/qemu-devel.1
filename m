Received: from eggs.gnu.org ([2001:4830:134:3::10]:35423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo5j9-0005pz-D7
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo5j8-000882-Ly
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:04:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo5j8-000879-I9
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:04:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6636C402314E
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:04:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 12:04:33 +0100
Message-Id: <20180220110433.20353-4-kraxel@redhat.com>
In-Reply-To: <20180220110433.20353-1-kraxel@redhat.com>
References: <20180220110433.20353-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] egl-helpers: add alpha channel to texture
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
