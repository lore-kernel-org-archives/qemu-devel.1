Received: from eggs.gnu.org ([2001:4830:134:3::10]:37912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVxk4-00022N-Bu
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVxk0-0007UB-8v
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:27:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVxk0-0007TF-4W
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:27:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180621083551.775-1-armbru@redhat.com>
Date: Thu, 21 Jun 2018 13:27:02 +0200
In-Reply-To: <20180621083551.775-1-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 21 Jun 2018 10:35:51 +0200")
Message-ID: <871sd0nzw9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix some pycodestyle-3 complaints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

Forgot tests/qapi-schema/test-qapi.py, as usual.  To be squashed in:

diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 4512a41504..abbc9c7830 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -33,8 +33,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         if base:
             print('    base %s' % base.name)
         for m in members:
-            print('    member %s: %s optional=%s' % \
-                  (m.name, m.type.name, m.optional))
+            print('    member %s: %s optional=%s'
+                  % (m.name, m.type.name, m.optional))
         self._print_variants(variants)
 
     def visit_alternate_type(self, name, info, variants):
@@ -43,10 +43,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
 
     def visit_command(self, name, info, arg_type, ret_type, gen,
                       success_response, boxed, allow_oob, allow_preconfig):
-        print('command %s %s -> %s' % \
-              (name, arg_type and arg_type.name, ret_type and ret_type.name))
-        print('   gen=%s success_response=%s boxed=%s oob=%s preconfig=%s' % \
-              (gen, success_response, boxed, allow_oob, allow_preconfig))
+        print('command %s %s -> %s'
+              % (name, arg_type and arg_type.name,
+                 ret_type and ret_type.name))
+        print('   gen=%s success_response=%s boxed=%s oob=%s preconfig=%s'
+              % (gen, success_response, boxed, allow_oob, allow_preconfig))
 
     def visit_event(self, name, info, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
-- 
2.17.1
