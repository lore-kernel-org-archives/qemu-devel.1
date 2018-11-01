Received: from eggs.gnu.org ([2001:4830:134:3::10]:35391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8Iz-0007r6-DS
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8Iy-0006QR-00
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:26:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gI8Ix-0006N6-L7
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:26:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Nov 2018 12:24:23 +0400
Message-Id: <20181101082423.26424-8-marcandre.lureau@redhat.com>
In-Reply-To: <20181101082423.26424-1-marcandre.lureau@redhat.com>
References: <20181101082423.26424-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 7/7] editorconfig: set emacs mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Some time ago, I proposed to use an (eval) in .dir-locals.el to set
the mode for all json files and Makefile. Unfortunately, this isn't
safe, and emacs will prompt the user, which isn't very friendly.

Fortunately, editorconfig provides a special config key which does
allow to set the emacs mode. Add a few missing entries and set the
emacs mode.

Update top comment to provide a short summary about the file and the
IDE plugins while at it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 .editorconfig | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/.editorconfig b/.editorconfig
index b2022e391a..1582883393 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -1,4 +1,10 @@
-# http://editorconfig.org
+# EditorConfig is a file format and collection of text editor plugins
+# for maintaining consistent coding styles between different editors
+# and IDEs. Most popular editors support this either natively or via
+# plugin.
+#
+# Check https://editorconfig.org for details.
+
 root =3D true
=20
 [*]
@@ -6,10 +12,23 @@ end_of_line =3D lf
 insert_final_newline =3D true
 charset =3D utf-8
=20
+[*.mak]
+indent_style =3D tab
+indent_size =3D 8
+file_type_emacs =3D makefile
+
 [Makefile*]
 indent_style =3D tab
 indent_size =3D 8
+file_type_emacs =3D makefile
=20
 [*.{c,h}]
 indent_style =3D space
 indent_size =3D 4
+
+[*.{vert,frag}]
+file_type_emacs =3D glsl
+
+[*.json]
+indent_style =3D space
+file_type_emacs =3D python
--=20
2.19.1.708.g4ede3d42df
