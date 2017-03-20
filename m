Received: from eggs.gnu.org ([2001:4830:134:3::10]:38448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cpo7p-000400-SR
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 23:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cpo7m-00063M-Pj
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 23:36:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cpo7m-000636-KR
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 23:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2387C04B328
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 03:36:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Mar 2017 11:36:37 +0800
Message-Id: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH fixup 0/2] Vhost device IOTLB fixup for vfio
 enablment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Hi:

This series is a fixup for vfio enablement series which breaks vhost
device IOTLB. The main reason is that vhost device IOTLB assumes the
iommu region were alwasy as->root. Fixing by using a memory listener
to register iommu notifiers.

Please review.

Jason Wang (2):
  intel_iommu: use the correct memory region for device IOTLB
    notification
  vhost: genearlize iommu memory region

 hw/i386/intel_iommu.c     |  2 +-
 hw/virtio/vhost.c         | 93 +++++++++++++++++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 10 +++++
 3 files changed, 84 insertions(+), 21 deletions(-)

-- 
2.7.4
