Received: from eggs.gnu.org ([2001:4830:134:3::10]:57195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuG-0004sh-7O
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuF-00005L-Bm
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:52:56 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:16 +0100
Message-Id: <20180111195225.4226-2-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 01/10] block/qapi: Introduce
 BlockdevCreateOptions
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

This creates a BlockdevCreateOptions union type that will contain all of
the options for image creation. We'll start out with an empty struct
type BlockdevCreateDummy for all drivers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e94a6881b2..1749376c61 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3320,6 +3320,70 @@
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
 
 ##
+# @BlockdevCreateDummy:
+#
+# FIXME To be removed. Only there to make the QAPI generator happy while we're
+# adding driver by driver. Leaving out union branches is not allowed.
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateDummy', 'data': {}}
+
+##
+# @BlockdevCreateOptions:
+#
+# Options for creating an image format on a given node.
+#
+# @driver           block driver to create the image format
+# @node             node to create the image format on
+#
+# Since: 2.12
+##
+{ 'union': 'BlockdevCreateOptions',
+  'base': {
+      'driver':         'BlockdevDriver',
+      'node':           'BlockdevRef' },
+  'discriminator': 'driver',
+  'data': {
+      'blkdebug':       'BlockdevCreateDummy',
+      'blkverify':      'BlockdevCreateDummy',
+      'bochs':          'BlockdevCreateDummy',
+      'cloop':          'BlockdevCreateDummy',
+      'dmg':            'BlockdevCreateDummy',
+      'file':           'BlockdevCreateDummy',
+      'ftp':            'BlockdevCreateDummy',
+      'ftps':           'BlockdevCreateDummy',
+      'gluster':        'BlockdevCreateDummy',
+      'host_cdrom':     'BlockdevCreateDummy',
+      'host_device':    'BlockdevCreateDummy',
+      'http':           'BlockdevCreateDummy',
+      'https':          'BlockdevCreateDummy',
+      'iscsi':          'BlockdevCreateDummy',
+      'luks':           'BlockdevCreateDummy',
+      'nbd':            'BlockdevCreateDummy',
+      'nfs':            'BlockdevCreateDummy',
+      'null-aio':       'BlockdevCreateDummy',
+      'null-co':        'BlockdevCreateDummy',
+      'parallels':      'BlockdevCreateDummy',
+      'qcow2':          'BlockdevCreateDummy',
+      'qcow':           'BlockdevCreateDummy',
+      'qed':            'BlockdevCreateDummy',
+      'quorum':         'BlockdevCreateDummy',
+      'raw':            'BlockdevCreateDummy',
+      'rbd':            'BlockdevCreateDummy',
+      'replication':    'BlockdevCreateDummy',
+      'sheepdog':       'BlockdevCreateDummy',
+      'ssh':            'BlockdevCreateDummy',
+      'throttle':       'BlockdevCreateDummy',
+      'vdi':            'BlockdevCreateDummy',
+      'vhdx':           'BlockdevCreateDummy',
+      'vmdk':           'BlockdevCreateDummy',
+      'vpc':            'BlockdevCreateDummy',
+      'vvfat':          'BlockdevCreateDummy',
+      'vxhs':           'BlockdevCreateDummy'
+  } }
+
+##
 # @blockdev-open-tray:
 #
 # Opens a block device's tray. If there is a block driver state tree inserted as
-- 
2.13.6
