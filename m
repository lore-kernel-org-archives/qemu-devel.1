Received: from eggs.gnu.org ([2001:4830:134:3::10]:36896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1fnUzR-0005Ub-0a
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1fnUzM-00017R-3T
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:29 -0400
Received: from legacy.ddn.com ([64.47.133.206]:14373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gedwards@ddn.com>) id 1fnUzL-00016L-SS
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:24 -0400
From: Greg Edwards <gedwards@ddn.com>
Date: Wed, 8 Aug 2018 13:52:32 -0600
Message-ID: <20180808195235.5843-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] expose VIRTIO_SCSI_F_T10_PI for vhost-scsi
 and vhost-user-scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, "Nicholas A. Bellinger" <nab@linux-iscsi.org>, Felipe Franciosi <felipe@nutanix.com>, Greg Edwards <gedwards@ddn.com>

Unify the get_features functions for vhost-scsi and vhost-user-scsi, including
their use of host_features, and expose a new 't10_pi' property to enable
negotiation of the VIRTIO_SCSI_F_T10_PI feature bit with the backend.

Greg Edwards (3):
  vhost-user-scsi: move host_features into VHostSCSICommon
  vhost-scsi: unify vhost-scsi get_features implementations
  vhost-scsi: expose 't10_pi' property for VIRTIO_SCSI_F_T10_PI

 hw/scsi/vhost-scsi-common.c           |  3 +++
 hw/scsi/vhost-scsi.c                  |  3 +++
 hw/scsi/vhost-user-scsi.c             | 28 ++++++++++-----------------
 include/hw/virtio/vhost-scsi-common.h |  1 +
 include/hw/virtio/vhost-user-scsi.h   |  1 -
 5 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.17.1
