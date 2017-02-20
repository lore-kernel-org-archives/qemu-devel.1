Received: from eggs.gnu.org ([2001:4830:134:3::10]:38258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfo6R-0007ks-UM
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfo6O-00031h-1J
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:34:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cfo6N-0002zZ-SA
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:34:03 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D84797F36F
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 13:34:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Feb 2017 14:33:57 +0100
Message-Id: <1487597638-28323-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487597638-28323-1-git-send-email-armbru@redhat.com>
References: <1487597638-28323-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] qapi2texi: replace quotation by bold
 section name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
Message-Id: <20170217093416.27688-1-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 83ded95..c1071c6 100755
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
2.7.4
