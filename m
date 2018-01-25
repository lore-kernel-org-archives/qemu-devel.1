Received: from eggs.gnu.org ([2001:4830:134:3::10]:59427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNh-0006zQ-Eq
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNg-0007vc-Lq
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eeaNg-0007uK-Fq
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:24 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 25 Jan 2018 13:46:48 +0800
Message-Id: <20180125054648.18747-15-famz@redhat.com>
In-Reply-To: <20180125054648.18747-1-famz@redhat.com>
References: <20180125054648.18747-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 14/14] qapi: Add NVMe driver options to the
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
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180110091846.10699-10-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180116060901.17413-10-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qapi/block-core.json | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4e84cf29db..a21bc69388 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2248,6 +2248,7 @@
 #
 # @vxhs: Since 2.10
 # @throttle: Since 2.11
+# @nvme: Since 2.12
 #
 # Since: 2.9
 ##
@@ -2255,7 +2256,7 @@
   'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
-            'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
+            'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2', 'qed',
             'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
             'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
 
@@ -2296,6 +2297,19 @@
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
@@ -3201,6 +3215,7 @@
       'nfs':        'BlockdevOptionsNfs',
       'null-aio':   'BlockdevOptionsNull',
       'null-co':    'BlockdevOptionsNull',
+      'nvme':       'BlockdevOptionsNVMe',
       'parallels':  'BlockdevOptionsGenericFormat',
       'qcow2':      'BlockdevOptionsQcow2',
       'qcow':       'BlockdevOptionsQcow',
-- 
2.14.3
