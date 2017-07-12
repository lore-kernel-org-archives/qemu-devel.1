Received: from eggs.gnu.org ([2001:4830:134:3::10]:41334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3D-0005gP-2Q
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3C-0003Pn-Aa
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:42654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dVH3C-0003Lp-2B
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:30 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 12 Jul 2017 20:40:15 +0800
Message-Id: <1499863221-16206-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v12 2/8] virtio-balloon: coding format cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com
Cc: virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

Clean up the comment format.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/virtio/virtio_balloon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7f38ae6..f0b3a0b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -132,8 +132,10 @@ static void set_page_pfns(struct virtio_balloon *vb,
 {
 	unsigned int i;
 
-	/* Set balloon pfns pointing at this page.
-	 * Note that the first pfn points at start of the page. */
+	/*
+	 * Set balloon pfns pointing at this page.
+	 * Note that the first pfn points at start of the page.
+	 */
 	for (i = 0; i < VIRTIO_BALLOON_PAGES_PER_PAGE; i++)
 		pfns[i] = cpu_to_virtio32(vb->vdev,
 					  page_to_balloon_pfn(page) + i);
-- 
2.7.4
