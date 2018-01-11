Received: from eggs.gnu.org ([2001:4830:134:3::10]:57241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuN-00050e-1V
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuM-0000Av-9W
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:03 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:17 +0100
Message-Id: <20180111195225.4226-3-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 02/10] block/qapi: Add qcow2 create options
 to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1749376c61..9341f6708d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3320,6 +3320,37 @@
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
 
 ##
+# @BlockdevQcow2CompatLevel:
+# @0_10:    The original QCOW2 format as introduced in qemu 0.10 (version 2)
+# @1_1:     The extended QCOW2 format as introduced in qemu 1.1 (version 3)
+#
+# Since: 2.10
+##
+{ 'enum': 'BlockdevQcow2CompatLevel',
+  'data': [ '0_10', '1_1' ] }
+
+
+##
+# @BlockdevCreateOptionsQcow2:
+#
+# Driver specific image creation options for qcow2.
+#
+# TODO Describe fields
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsQcow2',
+  'data': { 'size':             'size',
+            '*compat':          'BlockdevQcow2CompatLevel',
+            '*backing-file':    'str',
+            '*backing-fmt':     'BlockdevDriver',
+            '*encrypt':         'QCryptoBlockCreateOptions',
+            '*cluster-size':    'size',
+            '*preallocation':   'PreallocMode',
+            '*lazy-refcounts':  'bool',
+            '*refcount-bits':   'int' } }
+
+##
 # @BlockdevCreateDummy:
 #
 # FIXME To be removed. Only there to make the QAPI generator happy while we're
@@ -3365,7 +3396,7 @@
       'null-aio':       'BlockdevCreateDummy',
       'null-co':        'BlockdevCreateDummy',
       'parallels':      'BlockdevCreateDummy',
-      'qcow2':          'BlockdevCreateDummy',
+      'qcow2':          'BlockdevCreateOptionsQcow2',
       'qcow':           'BlockdevCreateDummy',
       'qed':            'BlockdevCreateDummy',
       'quorum':         'BlockdevCreateDummy',
-- 
2.13.6
