Received: from eggs.gnu.org ([2001:4830:134:3::10]:60034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0o-0001Zl-Bp
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0n-0004S6-1W
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:34 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 23 Jun 2017 15:46:57 +0300
Message-Id: <20170623124700.1389-6-el13635@mail.ntua.gr>
In-Reply-To: <20170623124700.1389-1-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v3 5/8] block: add BlockDevOptionsThrottle
 to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is needed to configure throttle filter driver nodes with QAPI.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 qapi/block-core.json | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f85c2235c7..1d4afafe8c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2119,7 +2119,7 @@
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
             'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
-            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -2984,6 +2984,7 @@
       'replication':'BlockdevOptionsReplication',
       'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
+      'throttle':   'BlockdevOptionsThrottle',
       'vdi':        'BlockdevOptionsGenericFormat',
       'vhdx':       'BlockdevOptionsGenericFormat',
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
@@ -3723,3 +3724,19 @@
   'data' : { 'parent': 'str',
              '*child': 'str',
              '*node': 'str' } }
+
+##
+# @BlockdevOptionsThrottle:
+#
+# Driver specific block device options for Throttle
+#
+# @throttling-group: the name of the throttling group to use
+#
+# @options:        BlockIOThrottle options
+# Since: 2.9
+##
+{ 'struct': 'BlockdevOptionsThrottle',
+  'data': { 'throttling-group': 'str',
+            'file' : 'BlockdevRef',
+            '*options' : 'BlockIOThrottle'
+             } }
-- 
2.11.0
