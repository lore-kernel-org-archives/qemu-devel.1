Received: from eggs.gnu.org ([2001:4830:134:3::10]:50704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVy7o-0002ie-6b
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVy7l-0002b1-Io
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:14:52 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:25 +0300
Message-Id: <4518d7929ee8a86e7e383c2087a8eba3386b4138.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 21/31] vfio: remove a duplicated word in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Cao jin <caoj.fnst@cn.fujitsu.com>

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7dbe0e..882d3a9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1881,8 +1881,8 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
      * 0 is reserved for this since absence of capabilities is indicated by
      * 0 for the ID, version, AND next pointer.  However, pcie_add_capability()
      * uses ID 0 as reserved for list management and will incorrectly match and
-     * assert if we attempt to pre-load the head of the chain with with this
-     * ID.  Use ID 0xFFFF temporarily since it is also seems to be reserved in
+     * assert if we attempt to pre-load the head of the chain with this ID.
+     * Use ID 0xFFFF temporarily since it is also seems to be reserved in
      * part for identifying absence of capabilities in a root complex register
      * block.  If the ID still exists after adding capabilities, switch back to
      * zero.  We'll mark this entire first dword as emulated for this purpose.
-- 
2.1.4
