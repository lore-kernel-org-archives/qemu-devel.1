Received: from eggs.gnu.org ([2001:4830:134:3::10]:54811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZLdV-00047T-QE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZLdU-0003OD-3R
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eZLdT-0003Lx-OZ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:03 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 10 Jan 2018 12:01:55 -0700
Message-ID: <20180110190155.5389.69659.stgit@gimli.home>
In-Reply-To: <20180110190049.5389.12984.stgit@gimli.home>
References: <20180110190049.5389.12984.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/5] vfio/pci: Fixup VFIOMSIXInfo comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, aik@ozlabs.ru

The fields were removed in the referenced commit, but the comment
still mentions them.

Fixes: 2fb9636ebf24 ("vfio-pci: Remove unused fields from VFIOMSIXInfo")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a8fb3b34222c..3d753222ca4c 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -86,7 +86,7 @@ enum {
     VFIO_INT_MSIX = 3,
 };
 
-/* Cache of MSI-X setup plus extra mmap and memory region for split BAR map */
+/* Cache of MSI-X setup */
 typedef struct VFIOMSIXInfo {
     uint8_t table_bar;
     uint8_t pba_bar;
