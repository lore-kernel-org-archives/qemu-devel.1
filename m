Received: from eggs.gnu.org ([2001:4830:134:3::10]:41449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrIb-0001Dv-0X
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etrIX-0008F7-9s
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:53:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56798 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etrIX-0008Eo-5n
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:53:13 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 09:53:00 +0100
Message-Id: <20180308085301.8875-2-kraxel@redhat.com>
In-Reply-To: <20180308085301.8875-1-kraxel@redhat.com>
References: <20180308085301.8875-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] modules: use gmodule-export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>

As we want qemu symbols be exported to modules we should use the
gmodule-export-2.0 pkg-config instead of gmodule-2.0.

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 6f3921c02a..eb612532aa 100755
--- a/configure
+++ b/configure
@@ -3352,7 +3352,7 @@ else
 fi
 glib_modules=3Dgthread-2.0
 if test "$modules" =3D yes; then
-    glib_modules=3D"$glib_modules gmodule-2.0"
+    glib_modules=3D"$glib_modules gmodule-export-2.0"
 fi
=20
 # This workaround is required due to a bug in pkg-config file for glib a=
s it
--=20
2.9.3
