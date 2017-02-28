Received: from eggs.gnu.org ([2001:4830:134:3::10]:47848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikRY-0004tT-8P
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikRX-0001pP-Gu
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:16:04 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 28 Feb 2017 11:15:52 -0500
Message-Id: <20170228161553.28142-5-jcody@redhat.com>
In-Reply-To: <20170228161553.28142-1-jcody@redhat.com>
References: <20170228161553.28142-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] block/rbd: add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cf24c04..803edc3 100644
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
@@ -2119,7 +2120,7 @@
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
-            'quorum', 'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk',
+            'quorum', 'raw', 'rbd', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk',
             'vpc', 'vvfat' ] }
 
 ##
@@ -2666,6 +2667,34 @@
             '*timeout': 'int' } }
 
 ##
+# @BlockdevOptionsRbd:
+#
+# @pool:               Ceph pool name.
+#
+# @image:              Image name in the Ceph pool.
+#
+# @conf:               #optional path to Ceph configuration file.  Values
+#                      in the configuration file will be overridden by
+#                      options specified via QAPI.
+#
+# @snapshot:           #optional Ceph snapshot name.
+#
+# @user:               #optional Ceph id name.
+#
+# @password-secret:    #optional The ID of a QCryptoSecret object providing
+#                      the password for the login.
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
@@ -2863,7 +2892,7 @@
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
