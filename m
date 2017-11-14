Received: from eggs.gnu.org ([2001:4830:134:3::10]:41679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dariuszx.stojaczyk@intel.com>) id 1eEajB-0000gh-QQ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dariuszx.stojaczyk@intel.com>) id 1eEaj7-0005Bi-4m
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:54:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:65400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dariuszx.stojaczyk@intel.com>)
	id 1eEaj6-00054l-TV
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:54:05 -0500
From: Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>
Date: Tue, 14 Nov 2017 17:28:36 +0100
Message-Id: <1510676916-76409-1-git-send-email-dariuszx.stojaczyk@intel.com>
Subject: [Qemu-devel] [PATCH] vhost-user-scsi: add missing virtqueue_size
 param
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>

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
---
 hw/scsi/vhost-user-scsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 500fa6a..f7561e2 100644
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
2.7.4
