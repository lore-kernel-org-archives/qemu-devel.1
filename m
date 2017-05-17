Received: from eggs.gnu.org ([2001:4830:134:3::10]:51333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAu5d-0001Ls-1V
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAu5Y-0003Uj-1O
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dAu5X-0003TU-SD
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A952880C0A
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 08:13:42 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 17 May 2017 10:13:32 +0200
Message-Id: <20170517081332.25811-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ui: egl-headless requires dmabuf support
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

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index aac6ae8bef..3369451285 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -33,7 +33,7 @@ common-obj-y += shader.o
 common-obj-y += console-gl.o
 common-obj-y += egl-helpers.o
 common-obj-y += egl-context.o
-common-obj-y += egl-headless.o
+common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
 ifeq ($(CONFIG_GTK_GL),y)
 common-obj-$(CONFIG_GTK) += gtk-gl-area.o
 else
-- 
2.9.3
