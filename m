Received: from eggs.gnu.org ([2001:4830:134:3::10]:60925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXpW-0006qi-97
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXpS-0004zN-E8
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:52:38 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:05 +0300
Message-Id: <3f2ce724f1f10065169e2c79a68e0d7d7fa2a21c.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 01/22] qemu-doc: Move the qemu-ga description
 into a separate chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

The qemu-ga description is currently a subsection of the Disk Images
chapter - which does not make much sense since the qemu-ga is not
directly related to disk images. So let's move this information
into a separate chapter instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-doc.texi | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index de0cc30790..3f4ed0aa9a 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -34,6 +34,7 @@
 * Introduction::
 * QEMU PC System emulator::
 * QEMU System emulator for non PC targets::
+* QEMU Guest Agent::
 * QEMU User space emulator::
 * Implementation notes::
 * License::
@@ -396,7 +397,6 @@ snapshots.
 * vm_snapshots::              VM snapshots
 * qemu_img_invocation::       qemu-img Invocation
 * qemu_nbd_invocation::       qemu-nbd Invocation
-* qemu_ga_invocation::        qemu-ga Invocation
 * disk_images_formats::       Disk image file formats
 * host_drives::               Using host drives
 * disk_images_fat_images::    Virtual FAT disk images
@@ -490,11 +490,6 @@ state is not saved or restored properly (in particular USB).
 
 @include qemu-nbd.texi
 
-@node qemu_ga_invocation
-@subsection @code{qemu-ga} Invocation
-
-@include qemu-ga.texi
-
 @node disk_images_formats
 @subsection Disk image file formats
 
@@ -2685,6 +2680,12 @@ Note that this allows guest direct access to the host filesystem,
 so should only be used with trusted guest OS.
 
 @end table
+
+@node QEMU Guest Agent
+@chapter QEMU Guest Agent invocation
+
+@include qemu-ga.texi
+
 @node QEMU User space emulator
 @chapter QEMU User space emulator
 
-- 
2.11.0
