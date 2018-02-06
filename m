Received: from eggs.gnu.org ([2001:4830:134:3::10]:34862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej8Dw-0004iZ-GR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej8Ds-0004KQ-Qy
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:44:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ej8Ds-0004IA-Jv
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:44:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B03E549012
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 18:44:03 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 06 Feb 2018 11:44:03 -0700
Message-ID: <20180206184403.14644.95864.stgit@gimli.home>
In-Reply-To: <20180206184101.14644.84734.stgit@gimli.home>
References: <20180206184101.14644.84734.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 10/11] vfio/common: Remove redundant copy of
 local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

There is already @hostwin in vfio_listener_region_add() so there is no
point in having the other one.

Fixes: 2e4109de8e58 ("vfio/spapr: Create DMA window dynamically (SPAPR IOMMU v2)")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ec41f93b7479..ee9240daeb5d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -435,7 +435,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
     end = int128_get64(int128_sub(llend, int128_one()));
 
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        VFIOHostDMAWindow *hostwin;
         hwaddr pgsize = 0;
 
         /* For now intersections are not allowed, we may relax this later */
