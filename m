Received: from eggs.gnu.org ([2001:4830:134:3::10]:37113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1fnUzu-0005mD-Pj
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gedwards@ddn.com>) id 1fnUzt-0001Zr-TE
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:58 -0400
Received: from legacy.ddn.com ([64.47.133.206]:16753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gedwards@ddn.com>) id 1fnUzt-0001Y6-MO
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:23:57 -0400
From: Greg Edwards <gedwards@ddn.com>
Date: Wed, 8 Aug 2018 13:52:35 -0600
Message-ID: <20180808195235.5843-4-gedwards@ddn.com>
In-Reply-To: <20180808195235.5843-1-gedwards@ddn.com>
References: <20180808195235.5843-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] vhost-scsi: expose 't10_pi' property for
 VIRTIO_SCSI_F_T10_PI
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

Allow toggling on/off the VIRTIO_SCSI_F_T10_PI feature bit for both
vhost-scsi and vhost-user-scsi devices.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 hw/scsi/vhost-scsi.c      | 3 +++
 hw/scsi/vhost-user-scsi.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 9c1bea8ff327..becf55008553 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -238,6 +238,9 @@ static Property vhost_scsi_properties[] = {
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
+    DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
+                                                 VIRTIO_SCSI_F_T10_PI,
+                                                 false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 26491daaa0bf..2e1ba4a87bb1 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -152,6 +152,9 @@ static Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_BIT64("param_change", VHostSCSICommon, host_features,
                                                        VIRTIO_SCSI_F_CHANGE,
                                                        true),
+    DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
+                                                 VIRTIO_SCSI_F_T10_PI,
+                                                 false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.17.1
