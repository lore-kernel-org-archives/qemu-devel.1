Received: from eggs.gnu.org ([2001:4830:134:3::10]:46581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Am-0005Sa-7u
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Aj-0002Iz-AC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3Aj-0002IL-4W
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18DF2C04B310
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:57:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 09:56:52 +0200
Message-Id: <20170614075653.26420-5-kraxel@redhat.com>
In-Reply-To: <20170614075653.26420-1-kraxel@redhat.com>
References: <20170614075653.26420-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] sdl: prefer sdl2 over sdl1
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

In case the configure script finds both SDL 1.2 and SDL 2.x installed
it still prefers SDL 1.2.  Prefer SDL 2.x instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20170606105339.3613-3-kraxel@redhat.com
---
 configure | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index bfba156a41..db0798d51d 100755
--- a/configure
+++ b/configure
@@ -2598,12 +2598,12 @@ fi
 # sdl-config even without cross prefix, and favour pkg-config over sdl-c=
onfig.
=20
 if test "$sdlabi" =3D ""; then
-    if $pkg_config --exists "sdl"; then
-        sdlabi=3D1.2
-    elif $pkg_config --exists "sdl2"; then
+    if $pkg_config --exists "sdl2"; then
         sdlabi=3D2.0
+    elif $pkg_config --exists "sdl"; then
+        sdlabi=3D1.2
     else
-        sdlabi=3D1.2
+        sdlabi=3D2.0
     fi
 fi
=20
@@ -2630,7 +2630,7 @@ elif has ${sdl_config}; then
   sdlversion=3D$($sdlconfig --version)
 else
   if test "$sdl" =3D "yes" ; then
-    feature_not_found "sdl" "Install SDL devel"
+    feature_not_found "sdl" "Install SDL2-devel"
   fi
   sdl=3Dno
 fi
--=20
2.9.3
