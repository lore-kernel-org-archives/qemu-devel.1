Received: from eggs.gnu.org ([2001:4830:134:3::10]:58584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHSZ-0005Xy-Nq
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHSX-0005w0-5m
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faHSW-0005vQ-VM
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:18:53 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 11:18:47 +0200
Message-Id: <20180703091847.7057-2-kraxel@redhat.com>
In-Reply-To: <20180703091847.7057-1-kraxel@redhat.com>
References: <20180703091847.7057-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] ui: do not build-depend or link with libdrm,
 it is not needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>

From: Michael Tokarev <mjt@tls.msk.ru>

Opengl support brings up libdrm. But actually nothing uses this library
or includes any of its headers. Just remove checking for it from configur=
e.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180630165448.30795-1-mjt@msgid.tls.msk.ru
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 65548df1fc..951ff022dd 100755
--- a/configure
+++ b/configure
@@ -3865,7 +3865,7 @@ libs_softmmu=3D"$libs_softmmu $fdt_libs"
 # opengl probe (for sdl2, gtk, milkymist-tmu2)
=20
 if test "$opengl" !=3D "no" ; then
-  opengl_pkgs=3D"epoxy libdrm gbm"
+  opengl_pkgs=3D"epoxy gbm"
   if $pkg_config $opengl_pkgs; then
     opengl_cflags=3D"$($pkg_config --cflags $opengl_pkgs)"
     opengl_libs=3D"$($pkg_config --libs $opengl_pkgs)"
--=20
2.9.3
