Received: from eggs.gnu.org ([2001:4830:134:3::10]:44333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SF-0006DA-Pr
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW5SA-00008W-PA
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:27 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cW5SA-00008M-JP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:04:22 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so36532132wmd.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:04:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Jan 2017 19:04:12 +0100
Message-Id: <20170124180420.12430-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/8] virtio: use MemoryRegionCache for
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

Compared to v1, I have improved error recovery (thanks to Stefan
for the great review!).  Patch 3 is pretty much rewritten,
making patch 4 also much easier to review hopefully.

Paolo


Paolo Bonzini (8):
  virtio: make virtio_should_notify static
  virtio: add virtio_*_phys_cached
  virtio: use address_space_map/unmap to access descriptors
  exec: make address_space_cache_destroy idempotent
  virtio: use MemoryRegionCache to access descriptors
  virtio: add MemoryListener to cache ring translations
  virtio: use VRingMemoryRegionCaches for descriptor ring
  virtio: use VRingMemoryRegionCaches for avail and used rings

 exec.c                            |   1 +
 hw/net/virtio-net.c               |  14 +-
 hw/virtio/virtio.c                | 321 ++++++++++++++++++++++++++++++--------
 include/exec/memory.h             |   2 +
 include/hw/virtio/virtio-access.h |  52 ++++++
 include/hw/virtio/virtio.h        |   2 +-
 6 files changed, 323 insertions(+), 69 deletions(-)

-- 
2.9.3
