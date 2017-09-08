Received: from eggs.gnu.org ([2001:4830:134:3::10]:42124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1J-0008Sr-4R
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1E-00057L-F1
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG1E-00056t-8b
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:12 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:55:00 +0800
Message-Id: <20170908095506.13594-33-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/38] buildsys: Move curese cflags/libs to per
 object
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
Message-Id: <20170907082918.7299-6-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure        | 6 ++++--
 ui/Makefile.objs | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index ddddfde599..df22b14259 100755
--- a/configure
+++ b/configure
@@ -3141,8 +3141,8 @@ EOF
       unset IFS
       if compile_prog "$curses_inc" "$curses_lib" ; then
         curses_found=3Dyes
-        QEMU_CFLAGS=3D"$curses_inc $QEMU_CFLAGS"
-        libs_softmmu=3D"$curses_lib $libs_softmmu"
+        curses_cflags=3D"$curses_inc $curses_cflags"
+        curses_libs=3D"$curses_lib $curses_libs"
         break
       fi
     done
@@ -5611,6 +5611,8 @@ if test "$cocoa" =3D "yes" ; then
 fi
 if test "$curses" =3D "yes" ; then
   echo "CONFIG_CURSES=3Dy" >> $config_host_mak
+  echo "CURSES_CFLAGS=3D$curses_cflags" >> $config_host_mak
+  echo "CURSES_LIBS=3D$curses_libs" >> $config_host_mak
 fi
 if test "$pipe2" =3D "yes" ; then
   echo "CONFIG_PIPE2=3Dy" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index a0b3c15a28..e3403b698b 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -57,3 +57,6 @@ gtk-egl.o-libs +=3D $(OPENGL_LIBS)
 shader.o-libs +=3D $(OPENGL_LIBS)
 console-gl.o-libs +=3D $(OPENGL_LIBS)
 egl-helpers.o-libs +=3D $(OPENGL_LIBS)
+
+curses.o-cflags :=3D $(CURSES_CFLAGS)
+curses.o-libs :=3D $(CURSES_LIBS)
--=20
2.13.5
