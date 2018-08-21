Received: from eggs.gnu.org ([2001:4830:134:3::10]:33729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0002IQ-18
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4b-0006x2-Hx
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:17 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4a-0006uF-T3
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:05 -0400
Received: by mail-wm0-x235.google.com with SMTP id w24-v6so3507296wmc.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:28 +0200
Message-Id: <1534870966-9287-57-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 56/74] vhost-scsi: expose 't10_pi' property for
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
Cc: Greg Edwards <gedwards@ddn.com>

From: Greg Edwards <gedwards@ddn.com>

Allow toggling on/off the VIRTIO_SCSI_F_T10_PI feature bit for both
vhost-scsi and vhost-user-scsi devices.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
Message-Id: <20180808195235.5843-4-gedwards@ddn.com>
Reviewed-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/vhost-scsi.c      | 3 +++
 hw/scsi/vhost-user-scsi.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 9c1bea8..becf550 100644
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
index 26491da..2e1ba4a 100644
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
1.8.3.1
