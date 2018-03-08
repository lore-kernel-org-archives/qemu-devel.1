Received: from eggs.gnu.org ([2001:4830:134:3::10]:37971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqys-00015d-LO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqym-0008Mb-TH
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:32:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etqym-0008Ld-PV
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:32:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51547416974A
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 08:32:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 09:32:28 +0100
Message-Id: <20180308083231.20180-6-kraxel@redhat.com>
In-Reply-To: <20180308083231.20180-1-kraxel@redhat.com>
References: <20180308083231.20180-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] ui/opengl: Makefile cleanup
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

With gtk.mo bits moved away we don't need the ifeq any more.
Also add missing opengl libs for some objects.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180306090951.22932-4-kraxel@redhat.com
---
 ui/Makefile.objs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index b560ee12c3..cc784346cb 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -51,14 +51,14 @@ curses.mo-objs := curses.o
 curses.mo-cflags := $(CURSES_CFLAGS)
 curses.mo-libs := $(CURSES_LIBS)
 
-ifeq ($(CONFIG_OPENGL),y)
-common-obj-y += shader.o
-common-obj-y += console-gl.o
-common-obj-y += egl-helpers.o
-common-obj-y += egl-context.o
+common-obj-$(CONFIG_OPENGL) += shader.o
+common-obj-$(CONFIG_OPENGL) += console-gl.o
+common-obj-$(CONFIG_OPENGL) += egl-helpers.o
+common-obj-$(CONFIG_OPENGL) += egl-context.o
 common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
-endif
 
 shader.o-libs += $(OPENGL_LIBS)
 console-gl.o-libs += $(OPENGL_LIBS)
 egl-helpers.o-libs += $(OPENGL_LIBS)
+egl-context.o-libs += $(OPENGL_LIBS)
+egl-headless.o-libs += $(OPENGL_LIBS)
-- 
2.9.3
