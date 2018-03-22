Received: from eggs.gnu.org ([2001:4830:134:3::10]:36868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyyBo-0000M7-R3
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eyyBk-00064Z-NR
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:15:24 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:33495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1eyyBk-00063Y-B8
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:15:20 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 22 Mar 2018 13:14:52 +0200
Message-Id: <c2c3db5708b41e12337ec2bb104b4c44a7356052.1521717086.git.berto@igalia.com>
In-Reply-To: <cover.1521717086.git.berto@igalia.com>
References: <cover.1521717086.git.berto@igalia.com>
In-Reply-To: <cover.1521717086.git.berto@igalia.com>
References: <cover.1521717086.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-2.12 v3 1/2] iotests: Update 051 and 186
 after commit 1454509726719e0933c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Thomas Huth <thuth@redhat.com>

SCSI controllers are no longer created automatically for
-drive if=scsi, so this patch updates the tests that relied
on that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/051.pc.out | 20 --------------------
 tests/qemu-iotests/186        |  4 ----
 tests/qemu-iotests/186.out    | 28 ----------------------------
 3 files changed, 52 deletions(-)

diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 830c11880a..b01f9a90d7 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -117,20 +117,10 @@ Testing: -drive if=ide,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 
-Testing: -drive if=scsi,media=cdrom
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
-quit
-
 Testing: -drive if=ide
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: Initialization of device ide-hd failed: Device needs media, but drive is empty
 
-Testing: -drive if=scsi
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=scsi: warning: bus=0,unit=0 is deprecated with this machine type
-QEMU_PROG: -drive if=scsi: Device needs media, but drive is empty
-
 Testing: -drive if=virtio
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
@@ -170,20 +160,10 @@ Testing: -drive file=TEST_DIR/t.qcow2,if=ide,media=cdrom,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
 
-Testing: -drive file=TEST_DIR/t.qcow2,if=scsi,media=cdrom,readonly=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=scsi,media=cdrom,readonly=on: warning: bus=0,unit=0 is deprecated with this machine type
-quit
-
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: Initialization of device ide-hd failed: Block node is read-only
 
-Testing: -drive file=TEST_DIR/t.qcow2,if=scsi,readonly=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=scsi,readonly=on: warning: bus=0,unit=0 is deprecated with this machine type
-quit
-
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 44cc01ed87..9687243d34 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -133,10 +133,6 @@ check_info_block -drive if=ide,driver=null-co
 check_info_block -drive if=ide,media=cdrom
 check_info_block -drive if=ide,driver=null-co,media=cdrom
 
-check_info_block -drive if=scsi,driver=null-co
-check_info_block -drive if=scsi,media=cdrom
-check_info_block -drive if=scsi,driver=null-co,media=cdrom
-
 check_info_block -drive if=virtio,driver=null-co
 
 check_info_block -drive if=pflash,driver=null-co,size=1M
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index c8377fe146..ec75c0fc60 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -442,34 +442,6 @@ ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
     Cache mode:       writeback
 (qemu) quit
 
-Testing: -drive if=scsi,driver=null-co
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=scsi,driver=null-co: warning: bus=0,unit=0 is deprecated with this machine type
-info block
-scsi0-hd0 (NODE_NAME): null-co:// (null-co)
-    Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
-    Cache mode:       writeback
-(qemu) quit
-
-Testing: -drive if=scsi,media=cdrom
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
-info block
-scsi0-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
-    Removable device: not locked, tray closed
-(qemu) quit
-
-Testing: -drive if=scsi,driver=null-co,media=cdrom
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=scsi,driver=null-co,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
-info block
-scsi0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
-    Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
-
 Testing: -drive if=virtio,driver=null-co
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
-- 
2.11.0
