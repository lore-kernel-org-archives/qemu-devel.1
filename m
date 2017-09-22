Received: from eggs.gnu.org ([2001:4830:134:3::10]:37819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgX-0008G5-NS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgW-00012a-SP
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgW-00012C-NF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:42 +0800
Message-Id: <20170922074659.30097-20-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/36] buildsys: Move usb redir cflags/libs to
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
Message-Id: <20170907082918.7299-10-famz@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure            | 4 ++--
 hw/usb/Makefile.objs | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index a6204651d5..d8455d42e1 100755
--- a/configure
+++ b/configure
@@ -4235,8 +4235,6 @@ if test "$usb_redir" !=3D "no" ; then
         usb_redir=3D"yes"
         usb_redir_cflags=3D$($pkg_config --cflags libusbredirparser-0.5)
         usb_redir_libs=3D$($pkg_config --libs libusbredirparser-0.5)
-        QEMU_CFLAGS=3D"$QEMU_CFLAGS $usb_redir_cflags"
-        libs_softmmu=3D"$libs_softmmu $usb_redir_libs"
     else
         if test "$usb_redir" =3D "yes"; then
             feature_not_found "usb-redir" "Install usbredir devel"
@@ -5793,6 +5791,8 @@ fi
=20
 if test "$usb_redir" =3D "yes" ; then
   echo "CONFIG_USB_REDIR=3Dy" >> $config_host_mak
+  echo "USB_REDIR_CFLAGS=3D$usb_redir_cflags" >> $config_host_mak
+  echo "USB_REDIR_LIBS=3D$usb_redir_libs" >> $config_host_mak
 fi
=20
 if test "$opengl" =3D "yes" ; then
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 05afbd36fa..9255234c63 100644
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
 ifeq ($(CONFIG_LIBUSB)$(CONFIG_USB),yy)
--=20
2.13.5
