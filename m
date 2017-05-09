Received: from eggs.gnu.org ([2001:4830:134:3::10]:36231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d81e0-0001Ca-8l
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d81dw-0001WZ-Bl
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:41:24 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 11:41:16 +0200
Message-Id: <1494322876-28843-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1494322876-28843-1-git-send-email-armbru@redhat.com>
References: <1494322876-28843-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] docs/qdev-device-use.txt: update section
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
Cc: qemu-trivial@nongnu.org, "thuth@redhat.comthuth"@redhat.com

Resynchronize the table of default device suppressions with vl.c's
default_list[].

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/qdev-device-use.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index caf779b..f9f9eaa 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -401,12 +401,13 @@ type.
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
2.7.4
