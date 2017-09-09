Received: from eggs.gnu.org ([2001:4830:134:3::10]:33975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbm-0006XO-AH
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbl-0006e2-HH
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYbl-0006dc-Bh
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:09 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:46:04 +0800
Message-Id: <20170909054613.19148-29-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 28/37] buildsys: Move gtk/vte cflags/libs to
 per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170907082918.7299-2-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure        | 3 +--
 ui/Makefile.objs | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 25c6ad6b20..8dca32900a 100755
--- a/configure
+++ b/configure
@@ -2427,7 +2427,6 @@ if test "$gtk" !=3D "no"; then
             gtk_cflags=3D"$gtk_cflags $x11_cflags"
             gtk_libs=3D"$gtk_libs $x11_libs"
         fi
-        libs_softmmu=3D"$gtk_libs $libs_softmmu"
         gtk=3D"yes"
     elif test "$gtk" =3D "yes"; then
         feature_not_found "gtk" "Install gtk3-devel"
@@ -2677,7 +2676,6 @@ if test "$vte" !=3D "no"; then
         vte_cflags=3D$($pkg_config --cflags $vtepackage)
         vte_libs=3D$($pkg_config --libs $vtepackage)
         vteversion=3D$($pkg_config --modversion $vtepackage)
-        libs_softmmu=3D"$vte_libs $libs_softmmu"
         vte=3D"yes"
     elif test "$vte" =3D "yes"; then
         if test "$gtkabi" =3D "3.0"; then
@@ -5738,6 +5736,7 @@ fi
 if test "$vte" =3D "yes" ; then
   echo "CONFIG_VTE=3Dy" >> $config_host_mak
   echo "VTE_CFLAGS=3D$vte_cflags" >> $config_host_mak
+  echo "VTE_LIBS=3D$vte_libs" >> $config_host_mak
 fi
 if test "$virglrenderer" =3D "yes" ; then
   echo "CONFIG_VIRGL=3Dy" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 3369451285..146a8ce062 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -45,6 +45,10 @@ gtk.o-cflags :=3D $(GTK_CFLAGS) $(VTE_CFLAGS)
 gtk-egl.o-cflags :=3D $(GTK_CFLAGS) $(VTE_CFLAGS)
 gtk-gl-area.o-cflags :=3D $(GTK_CFLAGS) $(VTE_CFLAGS)
=20
+gtk.o-libs :=3D $(GTK_LIBS) $(VTE_LIBS)
+gtk-egl.o-libs :=3D $(GTK_LIBS) $(VTE_LIBS)
+gtk-gl-area.o-libs :=3D $(GTK_LIBS) $(VTE_LIBS)
+
 gtk-egl.o-libs +=3D $(OPENGL_LIBS)
 shader.o-libs +=3D $(OPENGL_LIBS)
 console-gl.o-libs +=3D $(OPENGL_LIBS)
--=20
2.13.5
