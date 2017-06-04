Received: from eggs.gnu.org ([2001:4830:134:3::10]:35099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXzC-00071R-Pw
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXz9-0003w1-Mg
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:02:38 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:07 +0300
Message-Id: <1c9f3b887baa785d0d9942ce960492b9101fb0b9.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 03/22] docs qemu-doc: Avoid ide-drive,
 it's deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Markus Armbruster <armbru@redhat.com>

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/bootindex.txt       | 2 +-
 docs/qdev-device-use.txt | 4 ++--
 qemu-options.hx          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/bootindex.txt b/docs/bootindex.txt
index b9a8ba122f..6937862ba0 100644
--- a/docs/bootindex.txt
+++ b/docs/bootindex.txt
@@ -13,7 +13,7 @@ Let's assume we have a QEMU machine with two NICs (virtio, e1000) and two
 disks (IDE, virtio):
 
 qemu -drive file=disk1.img,if=none,id=disk1
-     -device ide-drive,drive=disk1,bootindex=4
+     -device ide-hd,drive=disk1,bootindex=4
      -drive file=disk2.img,if=none,id=disk2
      -device virtio-blk-pci,drive=disk2,bootindex=3
      -netdev type=user,id=net0 -device virtio-net-pci,netdev=net0,bootindex=2
diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 4274fe9f25..95a0c3ae55 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -31,8 +31,8 @@ A QEMU block device (drive) has a host and a guest part.
 
 In the general case, the guest device is connected to a controller
 device.  For instance, the IDE controller provides two IDE buses, each
-of which can have up to two ide-drive devices, and each ide-drive
-device is a guest part, and is connected to a host part.
+of which can have up to two devices, and each device is a guest part,
+and is connected to a host part.
 
 Except we sometimes lump controller, bus(es) and drive device(s) all
 together into a single device.  For instance, the ISA floppy
diff --git a/qemu-options.hx b/qemu-options.hx
index a6c9b9e763..10995dc932 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -262,7 +262,7 @@ STEXI
 Set default value of @var{driver}'s property @var{prop} to @var{value}, e.g.:
 
 @example
-qemu-system-i386 -global ide-drive.physical_block_size=4096 -drive file=file,if=ide,index=0,media=disk
+qemu-system-i386 -global ide-hd.physical_block_size=4096 disk-image.img
 @end example
 
 In particular, you can use this to set driver properties for devices which are 
-- 
2.11.0
