Received: from eggs.gnu.org ([2001:4830:134:3::10]:42297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1U-0000D1-Jq
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG1P-0005Gu-TX
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG1P-0005GN-OA
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:23 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:55:05 +0800
Message-Id: <20170908095506.13594-38-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/38] buildsys: Move brlapi libs to per object
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

baum.o already receives the sdl cflags in its per object variable, do
the same for brlapi libs to avoid cluttering libs_softmmu.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170907084700.952-1-famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 chardev/Makefile.objs | 1 +
 configure             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 52a8127606..d68e1347f9 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -20,5 +20,6 @@ chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
 common-obj-y +=3D msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) +=3D baum.o
 baum.o-cflags :=3D $(SDL_CFLAGS)
+baum.o-libs :=3D $(BRLAPI_LIBS)
=20
 common-obj-$(CONFIG_SPICE) +=3D spice.o
diff --git a/configure b/configure
index 64a931d1e2..e354497eaa 100755
--- a/configure
+++ b/configure
@@ -3098,7 +3098,6 @@ int main( void ) { return brlapi__openConnection (N=
ULL, NULL, NULL); }
 EOF
   if compile_prog "" "$brlapi_libs" ; then
     brlapi=3Dyes
-    libs_softmmu=3D"$brlapi_libs $libs_softmmu"
   else
     if test "$brlapi" =3D "yes" ; then
       feature_not_found "brlapi" "Install brlapi devel"
@@ -5689,6 +5688,7 @@ if test "$curl" =3D "yes" ; then
 fi
 if test "$brlapi" =3D "yes" ; then
   echo "CONFIG_BRLAPI=3Dy" >> $config_host_mak
+  echo "BRLAPI_LIBS=3D$brlapi_libs" >> $config_host_mak
 fi
 if test "$bluez" =3D "yes" ; then
   echo "CONFIG_BLUEZ=3Dy" >> $config_host_mak
--=20
2.13.5
