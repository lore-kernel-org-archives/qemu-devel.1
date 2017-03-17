Received: from eggs.gnu.org ([2001:4830:134:3::10]:57584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1colA8-0006BP-PQ
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1colA4-00072o-R6
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1colA4-00072i-LV
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:14:52 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 17 Mar 2017 14:14:45 +0800
Message-Id: <20170317061447.16243-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v3 0/2] virtio-scsi: Fix assertion
 failure on dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>

v3: Don't forget the virtio_scsi_release in virtio_scsi_handle_event_vq. [Ed Swierk]
v2: Use virtio_scsi_acquire/release. [Paolo]

Fam Zheng (2):
  virtio-scsi: Make virtio_scsi_acquire/release public
  virtio-scsi: Fix acquire/release in dataplane handlers

 hw/scsi/virtio-scsi-dataplane.c | 20 ++++++++++++++++----
 hw/scsi/virtio-scsi.c           | 41 ++++++++++++++---------------------------
 include/hw/virtio/virtio-scsi.h | 14 ++++++++++++++
 3 files changed, 44 insertions(+), 31 deletions(-)

-- 
2.9.3
