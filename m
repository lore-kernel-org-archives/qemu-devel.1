Received: from eggs.gnu.org ([2001:4830:134:3::10]:37795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQnZJ-0000kT-Sl
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQnZJ-0001TR-6d
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eQnZJ-0001Sm-0s
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 311F1356C5
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 05:02:24 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Sun, 17 Dec 2017 22:02:23 -0700
Message-ID: <20171218050223.13478.39223.stgit@gimli.home>
In-Reply-To: <20171218040852.13478.19208.stgit@gimli.home>
References: <20171218040852.13478.19208.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC/RFT PATCH 1/5] vfio/pci: Fixup VFIOMSIXInfo
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com

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
