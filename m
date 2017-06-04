Received: from eggs.gnu.org ([2001:4830:134:3::10]:35103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXzC-00071W-Qn
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXz9-0003vs-M4
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 12:02:38 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:08 +0300
Message-Id: <7a0bbd55e5a1844996896fea5c006e3263c345e2.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 04/22] docs/qdev-device-use.txt: update section
 Default Devices
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

Resynchronize the table of default device suppressions with vl.c's
default_list[].

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/qdev-device-use.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 95a0c3ae55..1f297b5e9c 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -399,12 +399,13 @@ type.
 some DEVNAMEs:
 
     default device      suppressing DEVNAMEs
-    CD-ROM              ide-cd, ide-drive, scsi-cd
-    isa-fdc's driveA    isa-fdc
+    CD-ROM              ide-cd, ide-drive, ide-hd, scsi-cd, scsi-hd
+    isa-fdc's driveA    floppy, isa-fdc
     parallel            isa-parallel
     serial              isa-serial
-    VGA                 VGA, cirrus-vga, vmware-svga
-    virtioconsole       virtio-serial-pci, virtio-serial-s390, virtio-serial
+    VGA                 VGA, cirrus-vga, isa-vga, isa-cirrus-vga,
+                        vmware-svga, qxl-vga, virtio-vga
+    virtioconsole       virtio-serial-pci, virtio-serial
 
 The default NIC is connected to a default part created along with it.
 It is *not* suppressed by configuring a NIC with -device (you may call
-- 
2.11.0
