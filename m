Received: from eggs.gnu.org ([2001:4830:134:3::10]:41523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cql7X-0008Jv-PD
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cql7R-0000ZQ-TF
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:36:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cql7R-0000YD-MR
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0571C04BD42
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 18:36:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 785D7852A7
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 18:36:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 19:36:13 +0100
Message-Id: <1490207781-18965-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1490207781-18965-1-git-send-email-armbru@redhat.com>
References: <1490207781-18965-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 for-2.9 09/17] tests/qapi-schema: Make
 test-qapi.py print docs again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

test-qapi.py used to print the internal representation of doc comments
(commit 3313b61).  This went away when we dropped the doc comments in
positive tests (commit 87c16dc).  Bring it back, because I'm going to
add real positive doc comment tests.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490015515-25851-5-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qapi-schema/test-qapi.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index ef74e2c..c7724d3 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -55,3 +55,14 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
=20
 schema =3D QAPISchema(sys.argv[1])
 schema.visit(QAPISchemaTestVisitor())
+
+for doc in schema.docs:
+    if doc.symbol:
+        print 'doc symbol=3D%s' % doc.symbol
+    else:
+        print 'doc freeform'
+    print '    body=3D\n%s' % doc.body
+    for arg, section in doc.args.iteritems():
+        print '    arg=3D%s\n%s' % (arg, section)
+    for section in doc.sections:
+        print '    section=3D%s\n%s' % (section.name, section)
--=20
2.7.4
