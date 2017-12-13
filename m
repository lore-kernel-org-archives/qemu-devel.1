Received: from eggs.gnu.org ([2001:4830:134:3::10]:52056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePBXI-0005VE-5X
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePBXF-0008VT-2L
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ePBXE-0008Up-S1
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:36 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 13 Dec 2017 11:13:32 -0700
Message-ID: <20171213181326.10919.86475.stgit@gimli.home>
In-Reply-To: <20171213180541.10386.38737.stgit@gimli.home>
References: <20171213180541.10386.38737.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 4/4] vfio-pci: Remove unused fields from
 VFIOMSIXInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru

From: Alexey Kardashevskiy <aik@ozlabs.ru>

When support for multiple mappings per a region were added, this was
left behind, let's finish and remove unused bits.

Fixes: db0da029a185 ("vfio: Generalize region support")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 502a5755b944..a8fb3b34222c 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -93,8 +93,6 @@ typedef struct VFIOMSIXInfo {
     uint16_t entries;
     uint32_t table_offset;
     uint32_t pba_offset;
-    MemoryRegion mmap_mem;
-    void *mmap;
     unsigned long *pending;
 } VFIOMSIXInfo;
 
