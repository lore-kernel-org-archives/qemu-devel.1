Received: from eggs.gnu.org ([209.51.188.92]:36286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.kanavin@gmail.com>) id 1gjNFM-0001hy-CR
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.kanavin@gmail.com>) id 1gjNFK-0002FT-BZ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:51:08 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.kanavin@gmail.com>)
	id 1gjNFI-000298-8D
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:51:04 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so2586249wrs.10
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 03:51:00 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 15 Jan 2019 12:50:47 +0100
Message-Id: <20190115115047.39326-1-alex.kanavin@gmail.com>
Subject: [Qemu-devel] [PATCH] egl-helpers.h: add a missing X11 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>

Otherwise these errors occur, when qemu is built in the Yocto project:
| In file included from /home/alexander/development/poky/build-virgl-gtk-64/tmp/work/x86_64-nativesdk-pokysdk-linux/nativesdk-qemu/3.1.0-r0/qemu-3.1.0/include/ui/egl-context.h:5,
|                  from /home/alexander/development/poky/build-virgl-gtk-64/tmp/work/x86_64-nativesdk-pokysdk-linux/nativesdk-qemu/3.1.0-r0/qemu-3.1.0/ui/egl-context.c:3:
| /home/alexander/development/poky/build-virgl-gtk-64/tmp/work/x86_64-nativesdk-pokysdk-linux/nativesdk-qemu/3.1.0-r0/qemu-3.1.0/include/ui/egl-helpers.h:46:55: error: unknown type name 'Window'; did you mean 'minor'?
|  EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
|                                                        ^~~~~~
|                                                        minor

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
---
 include/ui/egl-helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 9db7293bdb..2c32d77e7a 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -4,6 +4,7 @@
 #include <epoxy/gl.h>
 #include <epoxy/egl.h>
 #include <gbm.h>
+#include <X11/Xlib.h>
 
 extern EGLDisplay *qemu_egl_display;
 extern EGLConfig qemu_egl_config;
-- 
2.17.1
