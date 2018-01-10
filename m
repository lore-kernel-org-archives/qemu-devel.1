Received: from eggs.gnu.org ([2001:4830:134:3::10]:49233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZCYK-000681-Ts
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZCYH-0000Wi-4d
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:20:08 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 10 Jan 2018 17:18:46 +0800
Message-Id: <20180110091846.10699-10-famz@redhat.com>
In-Reply-To: <20180110091846.10699-1-famz@redhat.com>
References: <20180110091846.10699-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 9/9] qapi: Add NVMe driver options to the
 schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qapi/block-core.json | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e94a6881b2..fd6c94454d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2237,7 +2237,7 @@
   'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
-            'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
+            'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2', 'qed',
             'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
             'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
 
@@ -2278,6 +2278,19 @@
 { 'struct': 'BlockdevOptionsNull',
   'data': { '*size': 'int', '*latency-ns': 'uint64' } }
 
+##
+# @BlockdevOptionsNVMe:
+#
+# Driver specific block device options for the NVMe backend.
+#
+# @device:    controller address of the NVMe device.
+# @namespace: namespace number of the device, starting from 1.
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevOptionsNVMe',
+  'data': { 'device': 'str', 'namespace': 'int' } }
+
 ##
 # @BlockdevOptionsVVFAT:
 #
@@ -3183,6 +3196,7 @@
       'nfs':        'BlockdevOptionsNfs',
       'null-aio':   'BlockdevOptionsNull',
       'null-co':    'BlockdevOptionsNull',
+      'nvme':       'BlockdevOptionsNVMe',
       'parallels':  'BlockdevOptionsGenericFormat',
       'qcow2':      'BlockdevOptionsQcow2',
       'qcow':       'BlockdevOptionsQcow',
-- 
2.14.3
