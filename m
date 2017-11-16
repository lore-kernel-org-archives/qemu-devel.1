Received: from eggs.gnu.org ([2001:4830:134:3::10]:33852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpa-0001lb-8f
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpY-0000DA-6f
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eFIpY-0000Ca-0T
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:40 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Nov 2017 12:59:21 +0100
Message-Id: <20171116115926.16627-7-pbonzini@redhat.com>
In-Reply-To: <20171116115926.16627-1-pbonzini@redhat.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/11] vhost-user-scsi: add missing
 virtqueue_size param
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>

From: Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>

Commit 5c0919d0 [1] introduced virtqueue_size parameter
for common virtio-scsi path, without updaing the vhost-user-scsi
code. vhost-user-scsi devices right now report size 0 for each vq.

This patch introduces virtqueue_size param to vhost-user-scsi,
that can now be set by the user. However, the most importantly, it
now has a default value of 128 (same as QEMU's virtio-scsi).

[1] 5c0919d0 ("virtio-scsi: Add virtqueue_size parameter
allowing virtqueue size to be set.")

Change-Id: I70e87eab702ebf1196c028dbf17d54fdc0c89a14
Signed-off-by: Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>
Message-Id: <1510676916-76409-1-git-send-email-dariuszx.stojaczyk@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/vhost-user-scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 500fa6a067..f7561e23fa 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -135,6 +135,8 @@ static Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
+    DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
+                       128),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
-- 
2.14.3
