Received: from eggs.gnu.org ([2001:4830:134:3::10]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Am-0005SU-6Q
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Aj-0002Im-4g
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3Ai-0002II-Ui
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1A8681243
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:56:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 09:56:51 +0200
Message-Id: <20170614075653.26420-4-kraxel@redhat.com>
In-Reply-To: <20170614075653.26420-1-kraxel@redhat.com>
References: <20170614075653.26420-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] gtk: prefer gtk3 over gtk2
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

In case the configure script finds both gtk2 and gtk3 installed it
still prefers gtk2 over gtk3.  Prefer gtk3 instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20170606105339.3613-2-kraxel@redhat.com
---
 configure | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index b147191ae6..bfba156a41 100755
--- a/configure
+++ b/configure
@@ -2301,14 +2301,14 @@ fi
 # GTK probe
=20
 if test "$gtkabi" =3D ""; then
-    # The GTK ABI was not specified explicitly, so try whether 2.0 is av=
ailable.
-    # Use 3.0 as a fallback if that is available.
-    if $pkg_config --exists "gtk+-2.0 >=3D 2.18.0"; then
-        gtkabi=3D2.0
-    elif $pkg_config --exists "gtk+-3.0 >=3D 3.0.0"; then
+    # The GTK ABI was not specified explicitly, so try whether 3.0 is av=
ailable.
+    # Use 2.0 as a fallback if that is available.
+    if $pkg_config --exists "gtk+-3.0 >=3D 3.0.0"; then
         gtkabi=3D3.0
+    elif $pkg_config --exists "gtk+-2.0 >=3D 2.18.0"; then
+        gtkabi=3D2.0
     else
-        gtkabi=3D2.0
+        gtkabi=3D3.0
     fi
 fi
=20
@@ -2331,7 +2331,7 @@ if test "$gtk" !=3D "no"; then
         libs_softmmu=3D"$gtk_libs $libs_softmmu"
         gtk=3D"yes"
     elif test "$gtk" =3D "yes"; then
-        feature_not_found "gtk" "Install gtk2 or gtk3 devel"
+        feature_not_found "gtk" "Install gtk3-devel"
     else
         gtk=3D"no"
     fi
--=20
2.9.3
