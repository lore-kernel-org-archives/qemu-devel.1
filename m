Received: from eggs.gnu.org ([2001:4830:134:3::10]:55440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuzTF-0000j4-SU
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuzTB-0005B9-Vd
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:21:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58130 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuzTB-00058e-ON
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8A1026341
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 12:21:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 29 Aug 2018 14:20:59 +0200
Message-Id: <20180829122101.29852-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-gpu: add iommu support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



Gerd Hoffmann (2):
  virtio-gpu: pass down VirtIOGPU pointer to a bunch of functions
  virtio-gpu: add iommu support

 include/hw/virtio/virtio-gpu.h |  6 +++--
 hw/display/virtio-gpu-3d.c     |  8 +++----
 hw/display/virtio-gpu.c        | 50 ++++++++++++++++++++++++------------------
 3 files changed, 37 insertions(+), 27 deletions(-)

-- 
2.9.3
