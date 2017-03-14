Received: from eggs.gnu.org ([2001:4830:134:3::10]:45309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnoV1-0000ZL-MP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnoUy-0001Rx-Iv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cnoUy-0001Rk-Dz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:36:32 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A31DF76F1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 15:36:31 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 23:36:24 +0800
Message-Id: <20170314153626.16989-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] virtio-scsi: Fix assertion failure on
 dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

v2: Use virtio_scsi_acquire/release. [Paolo]

Fam Zheng (2):
  virtio-scsi: Make virtio_scsi_acquire/release public
  virtio-scsi: Fix acquire/release in dataplane handlers

 hw/scsi/virtio-scsi-dataplane.c | 20 ++++++++++++++++----
 hw/scsi/virtio-scsi.c           | 40 ++++++++++++++--------------------------
 include/hw/virtio/virtio-scsi.h | 14 ++++++++++++++
 3 files changed, 44 insertions(+), 30 deletions(-)

-- 
2.9.3
