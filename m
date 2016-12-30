Received: from eggs.gnu.org ([2001:4830:134:3::10]:49220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMzeJ-0001BV-UL
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 11:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMzeG-0002W7-AV
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 11:03:19 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:41 +0300
Message-ID: <20161230143142.18214-18-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 17/18] qapi: allow blockdev-add for pcache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, eblake@redhat.com, armbru@redhat.com

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 qapi/block-core.json | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6b42216960..00a6e15db3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1719,6 +1719,7 @@
 # @nfs: Since 2.8
 # @replication: Since 2.8
 # @ssh: Since 2.8
+# @pcache: since 2.9
 #
 # Since: 2.0
 ##
@@ -1726,8 +1727,8 @@
   'data': [ 'archipelago', 'blkdebug', 'blkverify', 'bochs', 'cloop',
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'luks', 'nbd', 'nfs', 'null-aio',
-            'null-co', 'parallels', 'qcow', 'qcow2', 'qed', 'quorum', 'raw',
-            'replication', 'ssh', 'vdi', 'vhdx', 'vmdk', 'vpc',
+            'null-co', 'parallels', 'pcache', 'qcow', 'qcow2', 'qed', 'quorum',
+            'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk', 'vpc',
             'vvfat' ] }
 
 ##
@@ -1808,6 +1809,30 @@
   'base': 'BlockdevOptionsGenericFormat',
   'data': { '*key-secret': 'str' } }
 
+##
+# @BlockdevOptionsPCache
+#
+# Driver specific block device options for pcache.
+#
+# @image:                Reference to a block device image for caching.
+#
+# @pcache-stats-size:    #optional Total volume of requests for statistics.
+#
+# @pcache-max-aio-size:  #optional Maximum size of read request which is handled
+#                        by pcache.
+#
+# @pcache-full-size:     #optional Total cache size.
+#
+# @pcache-readahead-size #optional Prefetch cache readahead size.
+#
+# Since: 2.9
+##
+{ 'struct': 'BlockdevOptionsPCache',
+  'data': { 'image': 'BlockdevRef',
+            '*pcache-stats-size': 'int',
+            '*pcache-max-aio-size': 'int',
+            '*pcache-full-size': 'int',
+            '*pcache-readahead-size': 'int' } }
 
 ##
 # @BlockdevOptionsGenericCOWFormat:
@@ -2402,6 +2427,7 @@
       'null-aio':   'BlockdevOptionsNull',
       'null-co':    'BlockdevOptionsNull',
       'parallels':  'BlockdevOptionsGenericFormat',
+      'pcache':     'BlockdevOptionsPCache',
       'qcow2':      'BlockdevOptionsQcow2',
       'qcow':       'BlockdevOptionsGenericCOWFormat',
       'qed':        'BlockdevOptionsGenericCOWFormat',
-- 
2.11.0
