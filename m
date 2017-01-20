Received: from eggs.gnu.org ([2001:4830:134:3::10]:50499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcfU-0006my-Do
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcfP-0001GV-F3
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:08:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcfP-0001Fs-9G
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:07:59 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78B06C057FA4
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 17:07:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 18:07:50 +0100
Message-Id: <20170120170757.30308-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] virtio: use MemoryRegionCache for
 descriptors and rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com

Patch posted during 2.8 hard freeze.  Quick measurements give a 10%
performance improvement on various virtio-blk benchmarks, but the machine
I used seems to love my patches particularly today!

Paolo

Paolo Bonzini (7):
  virtio: make virtio_should_notify static
  virtio: add virtio_*_phys_cached
  virtio: use address_space_map/unmap to access descriptors
  virtio: use MemoryRegionCache to access descriptors
  virtio: add MemoryListener to cache ring translations
  virtio: use VRingMemoryRegionCaches for descriptor ring
  virtio: use VRingMemoryRegionCaches for avail and used rings

 hw/net/virtio-net.c               |  14 +-
 hw/virtio/virtio.c                | 322 ++++++++++++++++++++++++++++++--------
 include/hw/virtio/virtio-access.h |  52 ++++++
 include/hw/virtio/virtio.h        |   2 +-
 4 files changed, 322 insertions(+), 68 deletions(-)

-- 
2.9.3
