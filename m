Received: from eggs.gnu.org ([2001:4830:134:3::10]:36859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBdaU-0001IC-3g
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBdaR-0001lA-Vp
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dBdaR-0001kn-Pa
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:48:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FECB8047A
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:48:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 19 May 2017 10:48:30 +0200
Message-Id: <20170519084830.2674-2-kraxel@redhat.com>
In-Reply-To: <20170519084830.2674-1-kraxel@redhat.com>
References: <20170519084830.2674-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] ui: egl-headless requires dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170517122744.3541-1-kraxel@redhat.com
---
 vl.c             | 4 ++--
 ui/Makefile.objs | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 1512df6e9e..ca4a5d679c 100644
--- a/vl.c
+++ b/vl.c
@@ -2129,7 +2129,7 @@ static DisplayType select_display(const char *p)
             exit(1);
         }
     } else if (strstart(p, "egl-headless", &opts)) {
-#ifdef CONFIG_OPENGL
+#ifdef CONFIG_OPENGL_DMABUF
         request_opengl =3D 1;
         display_opengl =3D 1;
         display =3D DT_EGL;
@@ -4668,7 +4668,7 @@ int main(int argc, char **argv, char **envp)
         qemu_spice_display_init();
     }
=20
-#ifdef CONFIG_OPENGL
+#ifdef CONFIG_OPENGL_DMABUF
     if (display_type =3D=3D DT_EGL) {
         egl_headless_init();
     }
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index aac6ae8bef..3369451285 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -33,7 +33,7 @@ common-obj-y +=3D shader.o
 common-obj-y +=3D console-gl.o
 common-obj-y +=3D egl-helpers.o
 common-obj-y +=3D egl-context.o
-common-obj-y +=3D egl-headless.o
+common-obj-$(CONFIG_OPENGL_DMABUF) +=3D egl-headless.o
 ifeq ($(CONFIG_GTK_GL),y)
 common-obj-$(CONFIG_GTK) +=3D gtk-gl-area.o
 else
--=20
2.9.3
