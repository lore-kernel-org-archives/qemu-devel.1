Received: from eggs.gnu.org ([2001:4830:134:3::10]:36521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciQVf-0005DD-Ly
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciQVe-0003FU-S2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:58:59 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 27 Feb 2017 13:58:47 -0500
Message-Id: <3d09a265f288145ddd8a0159c72ce343d32c30ff.1488220970.git.jcody@redhat.com>
In-Reply-To: <cover.1488220970.git.jcody@redhat.com>
References: <cover.1488220970.git.jcody@redhat.com>
In-Reply-To: <cover.1488220970.git.jcody@redhat.com>
References: <cover.1488220970.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] block/rbd: add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 qapi/block-core.json | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5f82d35..5b311ff 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2111,6 +2111,7 @@
 # @replication: Since 2.8
 # @ssh: Since 2.8
 # @iscsi: Since 2.9
+# @rbd: Since 2.9
 #
 # Since: 2.0
 ##
@@ -2120,7 +2121,7 @@
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
             'quorum', 'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk',
-            'vpc', 'vvfat' ] }
+            'vpc', 'vvfat', 'rbd' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -2376,7 +2377,6 @@
             'path': 'str',
             '*user': 'str' } }
 
-
 ##
 # @BlkdebugEvent:
 #
@@ -2666,6 +2666,34 @@
             '*timeout': 'int' } }
 
 ##
+# @BlockdevOptionsRbd:
+#
+# @pool:               Ceph pool name.
+#
+# @image:              Image name in the Ceph pool.
+#
+# @conf:               # optional path to Ceph configuration file.  Values
+#                      in the configuration file will be overridden by
+#                      options specified via QAPI.
+#
+# @snapshot:           #optional Ceph snapshot name.
+#
+# @user:               #optional Ceph id name.
+#
+# @password-secret:    #optional The ID of a QCryptoSecret object providing
+#                       the password for the login.
+#
+# Since: 2.9
+##
+{ 'struct': 'BlockdevOptionsRbd',
+  'data': { 'pool': 'str',
+            'image': 'str',
+            '*conf': 'str',
+            '*snapshot': 'str',
+            '*user': 'str',
+            '*password-secret': 'str' } }
+
+##
 # @ReplicationMode:
 #
 # An enumeration of replication modes.
@@ -2863,7 +2891,7 @@
       'qed':        'BlockdevOptionsGenericCOWFormat',
       'quorum':     'BlockdevOptionsQuorum',
       'raw':        'BlockdevOptionsRaw',
-# TODO rbd: Wait for structured options
+      'rbd':        'BlockdevOptionsRbd',
       'replication':'BlockdevOptionsReplication',
 # TODO sheepdog: Wait for structured options
       'ssh':        'BlockdevOptionsSsh',
-- 
2.9.3
