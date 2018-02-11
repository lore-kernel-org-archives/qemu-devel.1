Received: from eggs.gnu.org ([2001:4830:134:3::10]:53966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3Z-00070M-6W
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3W-0006JZ-CH
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3W-0006HW-3V
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:50 +0100
Message-Id: <20180211093607.27351-13-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/29] qapi/common: Eliminate
 QAPISchema.exprs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3e92b38ade..d72c339ad5 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1461,13 +1461,13 @@ class QAPISchema(object):
     def __init__(self, fname):
         try:
             parser =3D QAPISchemaParser(open(fname, 'r'))
-            self.exprs =3D check_exprs(parser.exprs)
+            exprs =3D check_exprs(parser.exprs)
             self.docs =3D parser.docs
             self._entity_dict =3D {}
             self._predefining =3D True
             self._def_predefineds()
             self._predefining =3D False
-            self._def_exprs()
+            self._def_exprs(exprs)
             self.check()
         except QAPIError as err:
             print(err, file=3Dsys.stderr)
@@ -1652,8 +1652,8 @@ class QAPISchema(object):
                 name, info, doc, 'arg', self._make_members(data, info))
         self._def_entity(QAPISchemaEvent(name, info, doc, data, boxed))
=20
-    def _def_exprs(self):
-        for expr_elem in self.exprs:
+    def _def_exprs(self, exprs):
+        for expr_elem in exprs:
             expr =3D expr_elem['expr']
             info =3D expr_elem['info']
             doc =3D expr_elem.get('doc')
--=20
2.13.6
