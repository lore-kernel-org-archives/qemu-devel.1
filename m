Received: from eggs.gnu.org ([2001:4830:134:3::10]:33466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkv-00012m-Cu
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkn-0006gS-Tq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:52 +0100
Message-Id: <20180309161933.8168-16-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/56] block/qapi: Introduce
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This creates a BlockdevCreateOptions union type that will contain all of
the options for image creation. We'll start out with an empty struct
type BlockdevCreateNotSupported for all drivers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 00475f08d4..bb2db662f7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3359,6 +3359,68 @@
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
+      'nvme':           'BlockdevCreateNotSupported',
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
