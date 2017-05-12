Received: from eggs.gnu.org ([2001:4830:134:3::10]:60849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996n-0002t3-5O
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996m-00054o-37
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d996l-00054K-Ss
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B46B38B11B
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 11:51:42 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 13:51:32 +0200
Message-Id: <20170512115135.17379-8-kraxel@redhat.com>
In-Reply-To: <20170512115135.17379-1-kraxel@redhat.com>
References: <20170512115135.17379-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] egl: explicitly ask for core context
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170505104101.30589-6-kraxel@redhat.com
---
 ui/egl-context.c | 7 ++++---
 ui/egl-helpers.c | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/ui/egl-context.c b/ui/egl-context.c
index 3a02b68d1a..2161969abe 100644
--- a/ui/egl-context.c
+++ b/ui/egl-context.c
@@ -7,9 +7,10 @@ QEMUGLContext qemu_egl_create_context(DisplayChangeListener *dcl,
 {
    EGLContext ctx;
    EGLint ctx_att[] = {
-      EGL_CONTEXT_CLIENT_VERSION, params->major_ver,
-      EGL_CONTEXT_MINOR_VERSION_KHR, params->minor_ver,
-      EGL_NONE
+       EGL_CONTEXT_OPENGL_PROFILE_MASK, EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT,
+       EGL_CONTEXT_CLIENT_VERSION, params->major_ver,
+       EGL_CONTEXT_MINOR_VERSION_KHR, params->minor_ver,
+       EGL_NONE
    };
 
    ctx = eglCreateContext(qemu_egl_display, qemu_egl_config,
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index b50225158b..4a4d3370ee 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -296,6 +296,7 @@ int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy)
 EGLContext qemu_egl_init_ctx(void)
 {
     static const EGLint ctx_att_gl[] = {
+        EGL_CONTEXT_OPENGL_PROFILE_MASK, EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT,
         EGL_NONE
     };
     EGLContext ectx;
-- 
2.9.3
