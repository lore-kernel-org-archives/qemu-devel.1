Received: from eggs.gnu.org ([2001:4830:134:3::10]:41393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etFig-0005us-HP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etFib-0007i4-LS
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:45:42 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:57920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1etFia-0007hP-T6
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:45:37 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue,  6 Mar 2018 18:45:04 +0200
Message-Id: <20180306164504.9138-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] iotests: Update output of 051 and 186 after
 commit 1454509726719e0933c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/051.pc.out | 20 --------------------
 tests/qemu-iotests/186.out    | 22 +++-------------------
 2 files changed, 3 insertions(+), 39 deletions(-)

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
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index c8377fe146..d83bba1a88 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -444,31 +444,15 @@ ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
 
 Testing: -drive if=scsi,driver=null-co
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=scsi,driver=null-co: warning: bus=0,unit=0 is deprecated with this machine type
-info block
-scsi0-hd0 (NODE_NAME): null-co:// (null-co)
-    Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
-    Cache mode:       writeback
-(qemu) quit
+(qemu) QEMU_PROG: -drive if=scsi,driver=null-co: machine type does not support if=scsi,bus=0,unit=0
 
 Testing: -drive if=scsi,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
-info block
-scsi0-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
-    Removable device: not locked, tray closed
-(qemu) quit
+(qemu) QEMU_PROG: -drive if=scsi,media=cdrom: machine type does not support if=scsi,bus=0,unit=0
 
 Testing: -drive if=scsi,driver=null-co,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=scsi,driver=null-co,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
-info block
-scsi0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
-    Attached to:      /machine/unattached/device[27]/scsi.0/legacy[0]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-(qemu) quit
+(qemu) QEMU_PROG: -drive if=scsi,driver=null-co,media=cdrom: machine type does not support if=scsi,bus=0,unit=0
 
 Testing: -drive if=virtio,driver=null-co
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.11.0
