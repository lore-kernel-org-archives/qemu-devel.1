Received: from eggs.gnu.org ([2001:4830:134:3::10]:55658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaX-00029P-0S
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaR-00060X-DH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaR-0005zO-4T
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 170EB13AB3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D1B8419219
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:14 +0100
Message-Id: <20171220185924.32756-4-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/13] qapi: Eliminate
 QAPISchemaParser.__init__()'s local fname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002141341.24616-4-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index dc92bca620..6c8001e96d 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -261,8 +261,7 @@ class QAPISchemaParser(object):
=20
     def __init__(self, fp, previously_included=3D[], incl_info=3DNone):
         abs_fname =3D os.path.abspath(fp.name)
-        fname =3D fp.name
-        self.fname =3D fname
+        self.fname =3D fp.name
         previously_included.append(abs_fname)
         self.incl_info =3D incl_info
         self.src =3D fp.read()
@@ -277,7 +276,7 @@ class QAPISchemaParser(object):
         self.accept()
=20
         while self.tok is not None:
-            info =3D {'file': fname, 'line': self.line,
+            info =3D {'file': self.fname, 'line': self.line,
                     'parent': self.incl_info}
             if self.tok =3D=3D '#':
                 self.reject_expr_doc()
--=20
2.13.6
