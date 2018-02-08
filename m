Received: from eggs.gnu.org ([2001:4830:134:3::10]:57586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejrnm-0002qj-Oo
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejrnl-0000m5-Oy
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:24:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Feb 2018 20:23:02 +0100
Message-Id: <20180208192328.16550-2-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-1-kwolf@redhat.com>
References: <20180208192328.16550-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 01/27] block/qapi: Introduce
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
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This creates a BlockdevCreateOptions union type that will contain all of
the options for image creation. We'll start out with an empty struct
type BlockdevCreateDummy for all drivers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8225308904..b59b1430bb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3338,6 +3338,67 @@
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
 
 ##
+# @BlockdevCreateNotSupported:
+#
+# This is used for all drivers that don't support creating images.
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateNotSupported', 'data': {}}
+
+##
+# @BlockdevCreateOptions:
+#
+# Options for creating an image format on a given node.
+#
+# @driver           block driver to create the image format
+#
+# Since: 2.12
+##
+{ 'union': 'BlockdevCreateOptions',
+  'base': {
+      'driver':         'BlockdevDriver' },
+  'discriminator': 'driver',
+  'data': {
+      'blkdebug':       'BlockdevCreateNotSupported',
+      'blkverify':      'BlockdevCreateNotSupported',
+      'bochs':          'BlockdevCreateNotSupported',
+      'cloop':          'BlockdevCreateNotSupported',
+      'dmg':            'BlockdevCreateNotSupported',
+      'file':           'BlockdevCreateNotSupported',
+      'ftp':            'BlockdevCreateNotSupported',
+      'ftps':           'BlockdevCreateNotSupported',
+      'gluster':        'BlockdevCreateNotSupported',
+      'host_cdrom':     'BlockdevCreateNotSupported',
+      'host_device':    'BlockdevCreateNotSupported',
+      'http':           'BlockdevCreateNotSupported',
+      'https':          'BlockdevCreateNotSupported',
+      'iscsi':          'BlockdevCreateNotSupported',
+      'luks':           'BlockdevCreateNotSupported',
+      'nbd':            'BlockdevCreateNotSupported',
+      'nfs':            'BlockdevCreateNotSupported',
+      'null-aio':       'BlockdevCreateNotSupported',
+      'null-co':        'BlockdevCreateNotSupported',
+      'parallels':      'BlockdevCreateNotSupported',
+      'qcow2':          'BlockdevCreateNotSupported',
+      'qcow':           'BlockdevCreateNotSupported',
+      'qed':            'BlockdevCreateNotSupported',
+      'quorum':         'BlockdevCreateNotSupported',
+      'raw':            'BlockdevCreateNotSupported',
+      'rbd':            'BlockdevCreateNotSupported',
+      'replication':    'BlockdevCreateNotSupported',
+      'sheepdog':       'BlockdevCreateNotSupported',
+      'ssh':            'BlockdevCreateNotSupported',
+      'throttle':       'BlockdevCreateNotSupported',
+      'vdi':            'BlockdevCreateNotSupported',
+      'vhdx':           'BlockdevCreateNotSupported',
+      'vmdk':           'BlockdevCreateNotSupported',
+      'vpc':            'BlockdevCreateNotSupported',
+      'vvfat':          'BlockdevCreateNotSupported',
+      'vxhs':           'BlockdevCreateNotSupported'
+  } }
+
+##
 # @blockdev-open-tray:
 #
 # Opens a block device's tray. If there is a block driver state tree inserted as
-- 
2.13.6
