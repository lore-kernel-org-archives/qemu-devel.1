Received: from eggs.gnu.org ([2001:4830:134:3::10]:49279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6R-0003dB-Qz
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6O-0002bJ-Kj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cpx6O-0002as-F4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 14:11:53 +0100
Message-Id: <1490015515-25851-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490015515-25851-1-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 4/6] tests/qapi-schema: Make
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

test-qapi.py used to print the internal representation of doc comments
(commit 3313b61).  This went away when we dropped the doc comments in
positive tests (commit 87c16dc).  Bring it back, because I'm going to
add real positive doc comment tests.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/test-qapi.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index ef74e2c..c7724d3 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -55,3 +55,14 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
 
 schema = QAPISchema(sys.argv[1])
 schema.visit(QAPISchemaTestVisitor())
+
+for doc in schema.docs:
+    if doc.symbol:
+        print 'doc symbol=%s' % doc.symbol
+    else:
+        print 'doc freeform'
+    print '    body=\n%s' % doc.body
+    for arg, section in doc.args.iteritems():
+        print '    arg=%s\n%s' % (arg, section)
+    for section in doc.sections:
+        print '    section=%s\n%s' % (section.name, section)
-- 
2.7.4
