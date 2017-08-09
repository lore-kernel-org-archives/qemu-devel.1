Received: from eggs.gnu.org ([2001:4830:134:3::10]:45730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfNvR-0003r2-2C
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfNvP-0005ty-JV
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 06:09:16 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed,  9 Aug 2017 13:07:33 +0300
Message-Id: <20170809100734.17540-7-el13635@mail.ntua.gr>
In-Reply-To: <20170809100734.17540-1-el13635@mail.ntua.gr>
References: <20170809100734.17540-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v4 6/7] block: add BlockDevOptionsThrottle to
 QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is needed to configure throttle filter driver nodes with QAPI.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 qapi/block-core.json | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0bdc69aa5f..12fd749a94 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2222,6 +2222,7 @@
 # Drivers that are supported in block device operations.
 #
 # @vxhs: Since 2.10
+# @throttle: Since 2.11
 #
 # Since: 2.9
 ##
@@ -2231,7 +2232,7 @@
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
             'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
-            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -3095,6 +3096,24 @@
             '*tls-creds': 'str' } }
 
 ##
+# @BlockdevOptionsThrottle:
+#
+# Driver specific block device options for the throttle driver
+#
+# @throttle-group:   the name of the throttle-group object to use. It will be
+#                    created if it doesn't already exist. If not specified, an
+#                    anonymous group will be created, which cannot be
+#                    referenced by other throttle nodes.
+# @file:             reference to or definition of the data source block device
+# @limits:           ThrottleLimits options
+# Since: 2.11
+##
+{ 'struct': 'BlockdevOptionsThrottle',
+  'data': { '*throttle-group': 'str',
+            'file' : 'BlockdevRef',
+            '*limits' : 'ThrottleLimits'
+             } }
+##
 # @BlockdevOptions:
 #
 # Options for creating a block device.  Many options are available for all
@@ -3155,6 +3174,7 @@
       'replication':'BlockdevOptionsReplication',
       'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
+      'throttle':   'BlockdevOptionsThrottle',
       'vdi':        'BlockdevOptionsGenericFormat',
       'vhdx':       'BlockdevOptionsGenericFormat',
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
-- 
2.11.0
