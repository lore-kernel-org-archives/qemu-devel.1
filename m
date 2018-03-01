Received: from eggs.gnu.org ([2001:4830:134:3::10]:40507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6p-0000qL-R7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6o-0007YL-VM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6o-0007Xf-QB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C8702D0FAE
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:43:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:27 -0600
Message-Id: <20180301194245.29854-13-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/30] qapi/common: Eliminate QAPISchema.exprs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180211093607.27351-13-armbru@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index bfa9bfec01d..60a47486065 100644
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

-    def _def_exprs(self):
-        for expr_elem in self.exprs:
+    def _def_exprs(self, exprs):
+        for expr_elem in exprs:
             expr =3D expr_elem['expr']
             info =3D expr_elem['info']
             doc =3D expr_elem.get('doc')
--=20
2.14.3
