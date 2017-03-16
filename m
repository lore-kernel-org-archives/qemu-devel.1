Received: from eggs.gnu.org ([2001:4830:134:3::10]:54947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtY-0006B6-De
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-00079J-4o
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtR-000778-Nk
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D0EE64450
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E71D17D23
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:48 +0100
Message-Id: <1489645685-4750-33-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 32/49] tests/qapi-schema: Improve doc /
 expression mismatch coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

New tests doc-before-include.json and doc-before-pragma.json show we
fail to reject a misplaced expression comment.

New test doc-no-symbol.json shows a bad error message.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1489582656-31133-31-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include                    | 3 +++
 tests/qapi-schema/doc-before-include.err  | 0
 tests/qapi-schema/doc-before-include.exit | 1 +
 tests/qapi-schema/doc-before-include.json | 8 ++++++++
 tests/qapi-schema/doc-before-include.out  | 4 ++++
 tests/qapi-schema/doc-before-pragma.err   | 0
 tests/qapi-schema/doc-before-pragma.exit  | 1 +
 tests/qapi-schema/doc-before-pragma.json  | 8 ++++++++
 tests/qapi-schema/doc-before-pragma.out   | 4 ++++
 tests/qapi-schema/doc-no-symbol.err       | 1 +
 tests/qapi-schema/doc-no-symbol.exit      | 1 +
 tests/qapi-schema/doc-no-symbol.json      | 7 +++++++
 tests/qapi-schema/doc-no-symbol.out       | 0
 13 files changed, 38 insertions(+)
 create mode 100644 tests/qapi-schema/doc-before-include.err
 create mode 100644 tests/qapi-schema/doc-before-include.exit
 create mode 100644 tests/qapi-schema/doc-before-include.json
 create mode 100644 tests/qapi-schema/doc-before-include.out
 create mode 100644 tests/qapi-schema/doc-before-pragma.err
 create mode 100644 tests/qapi-schema/doc-before-pragma.exit
 create mode 100644 tests/qapi-schema/doc-before-pragma.json
 create mode 100644 tests/qapi-schema/doc-before-pragma.out
 create mode 100644 tests/qapi-schema/doc-no-symbol.err
 create mode 100644 tests/qapi-schema/doc-no-symbol.exit
 create mode 100644 tests/qapi-schema/doc-no-symbol.json
 create mode 100644 tests/qapi-schema/doc-no-symbol.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 00b02fd..505f918 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -369,6 +369,8 @@ qapi-schema += command-int.json
 qapi-schema += comments.json
 qapi-schema += doc-bad-args.json
 qapi-schema += doc-bad-symbol.json
+qapi-schema += doc-before-include.json
+qapi-schema += doc-before-pragma.json
 qapi-schema += doc-duplicated-arg.json
 qapi-schema += doc-duplicated-return.json
 qapi-schema += doc-duplicated-since.json
@@ -385,6 +387,7 @@ qapi-schema += doc-missing.json
 qapi-schema += doc-missing-colon.json
 qapi-schema += doc-missing-expr.json
 qapi-schema += doc-missing-space.json
+qapi-schema += doc-no-symbol.json
 qapi-schema += double-data.json
 qapi-schema += double-type.json
 qapi-schema += duplicate-key.json
diff --git a/tests/qapi-schema/doc-before-include.err b/tests/qapi-schema/doc-before-include.err
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/doc-before-include.exit b/tests/qapi-schema/doc-before-include.exit
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/tests/qapi-schema/doc-before-include.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/doc-before-include.json b/tests/qapi-schema/doc-before-include.json
new file mode 100644
index 0000000..ec1fbf2
--- /dev/null
+++ b/tests/qapi-schema/doc-before-include.json
@@ -0,0 +1,8 @@
+# Doc comment separated from defining expression by non-defining expression
+# BUG: not rejected
+
+##
+# @foo:
+##
+{ 'include': 'empty.json' }
+{ 'struct': 'foo', 'data': {} }
diff --git a/tests/qapi-schema/doc-before-include.out b/tests/qapi-schema/doc-before-include.out
new file mode 100644
index 0000000..236a849
--- /dev/null
+++ b/tests/qapi-schema/doc-before-include.out
@@ -0,0 +1,4 @@
+enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloat', 'qbool']
+    prefix QTYPE
+object foo
+object q_empty
diff --git a/tests/qapi-schema/doc-before-pragma.err b/tests/qapi-schema/doc-before-pragma.err
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/doc-before-pragma.exit b/tests/qapi-schema/doc-before-pragma.exit
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/tests/qapi-schema/doc-before-pragma.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/doc-before-pragma.json b/tests/qapi-schema/doc-before-pragma.json
new file mode 100644
index 0000000..fb2ec8e
--- /dev/null
+++ b/tests/qapi-schema/doc-before-pragma.json
@@ -0,0 +1,8 @@
+# Doc comment separated from defining expression by non-defining expression
+# BUG: not rejected
+
+##
+# @foo:
+##
+{ 'pragma': {} }
+{ 'struct': 'foo', 'data': {} }
diff --git a/tests/qapi-schema/doc-before-pragma.out b/tests/qapi-schema/doc-before-pragma.out
new file mode 100644
index 0000000..236a849
--- /dev/null
+++ b/tests/qapi-schema/doc-before-pragma.out
@@ -0,0 +1,4 @@
+enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloat', 'qbool']
+    prefix QTYPE
+object foo
+object q_empty
diff --git a/tests/qapi-schema/doc-no-symbol.err b/tests/qapi-schema/doc-no-symbol.err
new file mode 100644
index 0000000..727966c
--- /dev/null
+++ b/tests/qapi-schema/doc-no-symbol.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-no-symbol.json:4: Definition of 'foo' follows documentation for 'None'
diff --git a/tests/qapi-schema/doc-no-symbol.exit b/tests/qapi-schema/doc-no-symbol.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/doc-no-symbol.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-no-symbol.json b/tests/qapi-schema/doc-no-symbol.json
new file mode 100644
index 0000000..ee86ca1
--- /dev/null
+++ b/tests/qapi-schema/doc-no-symbol.json
@@ -0,0 +1,7 @@
+# Documentation for expression lacks symbol
+# BUG: Error message claims it has symbol 'None'
+
+##
+# foo:
+##
+{ 'command': 'foo', 'data': {'a': 'int'} }
diff --git a/tests/qapi-schema/doc-no-symbol.out b/tests/qapi-schema/doc-no-symbol.out
new file mode 100644
index 0000000..e69de29
-- 
2.7.4
