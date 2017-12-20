Received: from eggs.gnu.org ([2001:4830:134:3::10]:55666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaX-00029d-2t
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaS-00062Q-Ra
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaS-00061F-KR
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B24B7C830
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 58794619AF
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:22 +0100
Message-Id: <20171220185924.32756-12-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/13] qapi2texi: De-duplicate code to add blank
 line before symbol
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
Message-Id: <20171002141341.24616-12-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 58add26c11..92e2af2cd6 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -206,8 +206,6 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
=20
     def visit_enum_type(self, name, info, values, prefix):
         doc =3D self.cur_doc
-        if self.out:
-            self.out +=3D '\n'
         self.out +=3D TYPE_FMT(type=3D'Enum',
                              name=3Ddoc.symbol,
                              body=3Dtexi_entity(doc, 'Values',
@@ -217,16 +215,12 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisito=
r):
         doc =3D self.cur_doc
         if base and base.is_implicit():
             base =3D None
-        if self.out:
-            self.out +=3D '\n'
         self.out +=3D TYPE_FMT(type=3D'Object',
                              name=3Ddoc.symbol,
                              body=3Dtexi_entity(doc, 'Members', base, va=
riants))
=20
     def visit_alternate_type(self, name, info, variants):
         doc =3D self.cur_doc
-        if self.out:
-            self.out +=3D '\n'
         self.out +=3D TYPE_FMT(type=3D'Alternate',
                              name=3Ddoc.symbol,
                              body=3Dtexi_entity(doc, 'Members'))
@@ -234,8 +228,6 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor)=
:
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed):
         doc =3D self.cur_doc
-        if self.out:
-            self.out +=3D '\n'
         if boxed:
             body =3D texi_body(doc)
             body +=3D ('\n@b{Arguments:} the members of @code{%s}\n'
@@ -249,13 +241,13 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisito=
r):
=20
     def visit_event(self, name, info, arg_type, boxed):
         doc =3D self.cur_doc
-        if self.out:
-            self.out +=3D '\n'
         self.out +=3D MSG_FMT(type=3D'Event',
                             name=3Ddoc.symbol,
                             body=3Dtexi_entity(doc, 'Arguments'))
=20
     def symbol(self, doc, entity):
+        if self.out:
+            self.out +=3D '\n'
         self.cur_doc =3D doc
         entity.visit(self)
         self.cur_doc =3D None
--=20
2.13.6
