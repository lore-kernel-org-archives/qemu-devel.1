Received: from eggs.gnu.org ([2001:4830:134:3::10]:34228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYc1-0006mF-3v
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbz-0006rZ-Sy
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYbz-0006rA-N8
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:23 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:46:11 +0800
Message-Id: <20170909054613.19148-36-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 35/37] buildsys: Move usb redir cflags/libs
 to per object
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
Message-Id: <20170907082918.7299-10-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure            | 4 ++--
 hw/usb/Makefile.objs | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index b50d662cde..85ea2c25bb 100755
--- a/configure
+++ b/configure
@@ -4264,8 +4264,6 @@ if test "$usb_redir" !=3D "no" ; then
         usb_redir=3D"yes"
         usb_redir_cflags=3D$($pkg_config --cflags libusbredirparser-0.5)
         usb_redir_libs=3D$($pkg_config --libs libusbredirparser-0.5)
-        QEMU_CFLAGS=3D"$QEMU_CFLAGS $usb_redir_cflags"
-        libs_softmmu=3D"$libs_softmmu $usb_redir_libs"
     else
         if test "$usb_redir" =3D "yes"; then
             feature_not_found "usb-redir" "Install usbredir devel"
@@ -5828,6 +5826,8 @@ fi
=20
 if test "$usb_redir" =3D "yes" ; then
   echo "CONFIG_USB_REDIR=3Dy" >> $config_host_mak
+  echo "USB_REDIR_CFLAGS=3D$usb_redir_cflags" >> $config_host_mak
+  echo "USB_REDIR_LIBS=3D$usb_redir_libs" >> $config_host_mak
 fi
=20
 if test "$opengl" =3D "yes" ; then
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 9ce9eadb47..92eb199697 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -38,6 +38,8 @@ endif
=20
 # usb redirection
 common-obj-$(CONFIG_USB_REDIR) +=3D redirect.o quirks.o
+redirect.o-cflags =3D $(USB_REDIR_CFLAGS)
+redirect.o-libs =3D $(USB_REDIR_LIBS)
=20
 # usb pass-through
 common-obj-y +=3D $(patsubst %,host-%.o,$(HOST_USB))
--=20
2.13.5
