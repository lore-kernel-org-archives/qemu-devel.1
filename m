Received: from eggs.gnu.org ([2001:4830:134:3::10]:47838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT9or-0002L8-PN
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT9op-0007j6-Ub
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:07:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cT9op-0007j2-Op
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:07:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 076E27EBA9
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:07:40 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue, 17 Jan 2017 00:07:29 +0800
Message-Id: <20170116160730.4696-2-famz@redhat.com>
In-Reply-To: <20170116160730.4696-1-famz@redhat.com>
References: <20170116160730.4696-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] manual update linux header for virtio scsi
 fc_host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

XXX: bring these changes in by syncing once it's added to linux.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/standard-headers/linux/virtio_scsi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/standard-headers/linux/virtio_scsi.h b/include/standard-headers/linux/virtio_scsi.h
index ab66166..b37c395 100644
--- a/include/standard-headers/linux/virtio_scsi.h
+++ b/include/standard-headers/linux/virtio_scsi.h
@@ -113,6 +113,11 @@ struct virtio_scsi_config {
 	uint16_t max_channel;
 	uint16_t max_target;
 	uint32_t max_lun;
+	uint8_t  primary_wwpn[8];
+	uint8_t  primary_wwnn[8];
+	uint8_t  secondary_wwpn[8];
+	uint8_t  secondary_wwnn[8];
+	uint8_t  primary_active;
 } QEMU_PACKED;
 
 /* Feature Bits */
@@ -120,6 +125,7 @@ struct virtio_scsi_config {
 #define VIRTIO_SCSI_F_HOTPLUG                  1
 #define VIRTIO_SCSI_F_CHANGE                   2
 #define VIRTIO_SCSI_F_T10_PI                   3
+#define VIRTIO_SCSI_F_FC_HOST                  4
 
 /* Response codes */
 #define VIRTIO_SCSI_S_OK                       0
-- 
2.9.3
