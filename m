Received: from eggs.gnu.org ([2001:4830:134:3::10]:58143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyXed-00073K-N7
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyXea-0005hs-Mr
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:55:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyXea-0005hW-Bn
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:55:20 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 21 Mar 2018 14:55:05 +0800
Message-Id: <20180321065506.21091-3-peterx@redhat.com>
In-Reply-To: <20180321065506.21091-1-peterx@redhat.com>
References: <20180321065506.21091-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] tests: add oob-test for qapi-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>

It simply tests the new OOB capability, and make sure the QAPISchema can
parse it correctly.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/Makefile.include          | 1 +
 tests/qapi-schema/oob-test.err  | 0
 tests/qapi-schema/oob-test.exit | 1 +
 tests/qapi-schema/oob-test.json | 2 ++
 tests/qapi-schema/oob-test.out  | 6 ++++++
 5 files changed, 10 insertions(+)
 create mode 100644 tests/qapi-schema/oob-test.err
 create mode 100644 tests/qapi-schema/oob-test.exit
 create mode 100644 tests/qapi-schema/oob-test.json
 create mode 100644 tests/qapi-schema/oob-test.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0b277036df..059523e2d1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -523,6 +523,7 @@ qapi-schema += missing-comma-object.json
 qapi-schema += missing-type.json
 qapi-schema += nested-struct-data.json
 qapi-schema += non-objects.json
+qapi-schema += oob-test.json
 qapi-schema += pragma-doc-required-crap.json
 qapi-schema += pragma-extra-junk.json
 qapi-schema += pragma-name-case-whitelist-crap.json
diff --git a/tests/qapi-schema/oob-test.err b/tests/qapi-schema/oob-test.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/oob-test.exit b/tests/qapi-schema/oob-test.exit
new file mode 100644
index 0000000000..573541ac97
--- /dev/null
+++ b/tests/qapi-schema/oob-test.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/oob-test.json b/tests/qapi-schema/oob-test.json
new file mode 100644
index 0000000000..096c34b2fb
--- /dev/null
+++ b/tests/qapi-schema/oob-test.json
@@ -0,0 +1,2 @@
+# Some Out-Of-Band specific tests
+{ 'command': 'an-oob-command', 'allow-oob': true }
diff --git a/tests/qapi-schema/oob-test.out b/tests/qapi-schema/oob-test.out
new file mode 100644
index 0000000000..ce5a130dcf
--- /dev/null
+++ b/tests/qapi-schema/oob-test.out
@@ -0,0 +1,6 @@
+object q_empty
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
+    prefix QTYPE
+module oob-test.json
+command an-oob-command None -> None
+   gen=True success_response=True boxed=False oob=True
-- 
2.14.3
