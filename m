Received: from eggs.gnu.org ([2001:4830:134:3::10]:37744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgR-0008BC-Ia
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgP-0000zj-RY
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgP-0000zb-LS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:33 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:38 +0800
Message-Id: <20170922074659.30097-16-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/36] buildsys: Move sdl cflags/libs to per
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
Message-Id: <20170907082918.7299-3-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 audio/Makefile.objs | 1 +
 configure           | 2 +-
 ui/Makefile.objs    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index 481d1aa30e..c20695668f 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -11,3 +11,4 @@ common-obj-$(CONFIG_AUDIO_WIN_INT) +=3D audio_win_int.o
 common-obj-y +=3D wavcapture.o
=20
 sdlaudio.o-cflags :=3D $(SDL_CFLAGS)
+sdlaudio.o-libs :=3D $(SDL_LIBS)
diff --git a/configure b/configure
index 956ab367dc..3675ae816e 100755
--- a/configure
+++ b/configure
@@ -2788,7 +2788,6 @@ EOF
     sdl_cflags=3D"$sdl_cflags $x11_cflags"
     sdl_libs=3D"$sdl_libs $x11_libs"
   fi
-  libs_softmmu=3D"$sdl_libs $libs_softmmu"
 fi
=20
 ##########################################
@@ -5557,6 +5556,7 @@ if test "$sdl" =3D "yes" ; then
   echo "CONFIG_SDL=3Dy" >> $config_host_mak
   echo "CONFIG_SDLABI=3D$sdlabi" >> $config_host_mak
   echo "SDL_CFLAGS=3D$sdl_cflags" >> $config_host_mak
+  echo "SDL_LIBS=3D$sdl_libs" >> $config_host_mak
 fi
 if test "$cocoa" =3D "yes" ; then
   echo "CONFIG_COCOA=3Dy" >> $config_host_mak
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 3369451285..ec8533d6d9 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -27,6 +27,7 @@ sdl.mo-objs +=3D sdl2-gl.o
 endif
 endif
 sdl.mo-cflags :=3D $(SDL_CFLAGS)
+sdl.mo-libs :=3D $(SDL_LIBS)
=20
 ifeq ($(CONFIG_OPENGL),y)
 common-obj-y +=3D shader.o
--=20
2.13.5
