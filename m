Received: from eggs.gnu.org ([2001:4830:134:3::10]:41910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIFy4-0006GL-DL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIFy0-0004Le-Ho
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:00:24 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Jun 2017 17:00:16 +0200
Message-Id: <20170606150016.17143-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: do not refer to years-old version
 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 8e5c4a951f..51046ef9d1 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -386,11 +386,9 @@ CPU registers by prefixing them with @emph{$}.
 @node disk_images
 @section Disk Images
 
-Since version 0.6.1, QEMU supports many disk image formats, including
-growable disk images (their size increase as non empty sectors are
-written), compressed and encrypted disk images. Version 0.8.3 added
-the new qcow2 disk image format which is essential to support VM
-snapshots.
+QEMU supports many disk image formats, including growable disk images
+(their size increase as non empty sectors are written), compressed and
+encrypted disk images.
 
 @menu
 * disk_images_quickstart::    Quick start for disk image creation
-- 
2.13.0
