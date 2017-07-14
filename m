Received: from eggs.gnu.org ([2001:4830:134:3::10]:35012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxAf-0002oM-H4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxAe-0002dF-9j
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:01 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 14 Jul 2017 12:45:20 +0300
Message-Id: <20170714094521.4909-7-el13635@mail.ntua.gr>
In-Reply-To: <20170714094521.4909-1-el13635@mail.ntua.gr>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 6/7] block: add BlockDevOptionsThrottle to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

This is needed to configure throttle filter driver nodes with QAPI.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 qapi/block-core.json | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1084158b6a..9aaad97c54 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2210,6 +2210,7 @@
 # Drivers that are supported in block device operations.
 #
 # @vxhs: Since 2.10
+# @throttle: Since 2.10
 #
 # Since: 2.9
 ##
@@ -2219,7 +2220,7 @@
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
             'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
-            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -3084,6 +3085,21 @@
             '*tls-creds': 'str' } }
 
 ##
+# @BlockdevOptionsThrottle:
+#
+# Driver specific block device options for the throttle driver
+#
+# @throttling-group: the name of the throttling group to use
+# @file:             reference to or definition of the data source block device
+# @limits:           ThrottleLimits options
+# Since: 2.10
+##
+{ 'struct': 'BlockdevOptionsThrottle',
+  'data': { '*throttling-group': 'str',
+            'file' : 'BlockdevRef',
+            '*limits' : 'ThrottleLimits'
+             } }
+##
 # @BlockdevOptions:
 #
 # Options for creating a block device.  Many options are available for all
@@ -3144,6 +3160,7 @@
       'replication':'BlockdevOptionsReplication',
       'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
+      'throttle':   'BlockdevOptionsThrottle',
       'vdi':        'BlockdevOptionsGenericFormat',
       'vhdx':       'BlockdevOptionsGenericFormat',
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
@@ -3883,3 +3900,4 @@
   'data' : { 'parent': 'str',
              '*child': 'str',
              '*node': 'str' } }
+
-- 
2.11.0
