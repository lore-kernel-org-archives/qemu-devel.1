Received: from eggs.gnu.org ([2001:4830:134:3::10]:34804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ceevv-0003uv-FN
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ceevr-0005Th-FY
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:34:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ceevr-0005Ta-9O
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:34:27 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Feb 2017 13:34:16 +0400
Message-Id: <20170217093416.27688-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qapi2texi: replace quotation by bold section
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

When we build qemu-qmp-ref.txt this causes texinfo to complain several
times:
"Negative repeat count does nothing at
/usr/share/texinfo/Texinfo/Convert/Line.pm line 124."

It also doesn't display correctly, because the "Notes" text disappears
entirely in the HTML version because it thinks there's no actual
quotation text.

The text file output formatting is also not good.

To solve those problems, remove usage of @quotation, and simply use bold
face for the section name.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 83ded95c2d..c1071c62c6 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -159,12 +159,10 @@ def texi_body(doc):
             func =3D texi_example
=20
         if name:
-            # FIXME the indentation produced by @quotation in .txt and
-            # .html output is confusing
-            body +=3D "\n@quotation %s\n%s\n@end quotation" % \
-                    (name, func(doc))
-        else:
-            body +=3D func(doc)
+            # prefer @b over @strong, so txt doesn't translate it to *Fo=
o:*
+            body +=3D "\n\n@b{%s:}\n" % name
+
+        body +=3D func(doc)
=20
     return body
=20
--=20
2.11.0.295.gd7dffce1c.dirty
