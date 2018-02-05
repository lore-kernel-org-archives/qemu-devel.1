Received: from eggs.gnu.org ([2001:4830:134:3::10]:35485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxF-0001OF-LV
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxC-00041U-Kb
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eilxC-00040y-Di
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 944E02820D
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 18:57:21 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 05 Feb 2018 11:57:17 -0700
Message-ID: <20180205185717.14391.71934.stgit@gimli.home>
In-Reply-To: <20180205185416.14391.5739.stgit@gimli.home>
References: <20180205185416.14391.5739.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 04/11] vfio/pci: Fixup VFIOMSIXInfo comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The fields were removed in the referenced commit, but the comment
still mentions them.

Fixes: 2fb9636ebf24 ("vfio-pci: Remove unused fields from VFIOMSIXInfo")
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
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
