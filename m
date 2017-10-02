Received: from eggs.gnu.org ([2001:4830:134:3::10]:44102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tk-00070B-Dx
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tj-0003eH-BY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Tj-0003dq-5e
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 562925275A
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:41 +0200
Message-Id: <20171002141341.24616-12-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] qapi2texi: De-duplicate code to add
 blank line before symbol
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 58add26c11..92e2af2cd6 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -206,8 +206,6 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
 
     def visit_enum_type(self, name, info, values, prefix):
         doc = self.cur_doc
-        if self.out:
-            self.out += '\n'
         self.out += TYPE_FMT(type='Enum',
                              name=doc.symbol,
                              body=texi_entity(doc, 'Values',
@@ -217,16 +215,12 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
         doc = self.cur_doc
         if base and base.is_implicit():
             base = None
-        if self.out:
-            self.out += '\n'
         self.out += TYPE_FMT(type='Object',
                              name=doc.symbol,
                              body=texi_entity(doc, 'Members', base, variants))
 
     def visit_alternate_type(self, name, info, variants):
         doc = self.cur_doc
-        if self.out:
-            self.out += '\n'
         self.out += TYPE_FMT(type='Alternate',
                              name=doc.symbol,
                              body=texi_entity(doc, 'Members'))
@@ -234,8 +228,6 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed):
         doc = self.cur_doc
-        if self.out:
-            self.out += '\n'
         if boxed:
             body = texi_body(doc)
             body += ('\n@b{Arguments:} the members of @code{%s}\n'
@@ -249,13 +241,13 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
 
     def visit_event(self, name, info, arg_type, boxed):
         doc = self.cur_doc
-        if self.out:
-            self.out += '\n'
         self.out += MSG_FMT(type='Event',
                             name=doc.symbol,
                             body=texi_entity(doc, 'Arguments'))
 
     def symbol(self, doc, entity):
+        if self.out:
+            self.out += '\n'
         self.cur_doc = doc
         entity.visit(self)
         self.cur_doc = None
-- 
2.13.6
