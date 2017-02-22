Received: from eggs.gnu.org ([2001:4830:134:3::10]:46300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgZvC-0002zK-TJ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgZv7-00053h-U6
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:37:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cgZv7-00053W-Ob
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:37:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 22 Feb 2017 16:37:32 +0000
Message-Id: <20170222163734.13104-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] virtio: migration fixes for memory
 region cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Avoid early region cache initialization in virtio_load() with wrong ring
   addresses for VIRTIO-1 in Patch 2 [Cornelia]

Bug fixes for the recently added memory region cache in virtio.  This series
fixes live migration, see patches for details.

Stefan Hajnoczi (2):
  virtio: invalidate memory in vring_set_avail_event()
  virtio: add missing region cache init in virtio_load()

 hw/virtio/virtio.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.9.3
