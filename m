Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9C2C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7935920673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZRqoPgDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7935920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyXh-0008Aq-JZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37791)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyJl-0005oP-DO
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyJk-0005J9-0m
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hdyJj-0005I3-OL
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0b9ade0001>; Thu, 20 Jun 2019 07:40:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Jun 2019 07:40:31 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 07:40:31 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:40:30 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:40:30 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 14:40:24 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Thu, 20 Jun 2019 20:07:33 +0530
Message-ID: <1561041461-22326-6-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561041630; bh=5AbXL8+lzah5/nkUztRbkxhK9HCmKouonbFzeonusws=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=ZRqoPgDuK0UAG/MXfOHYysJ4IRK6JpC/kfn2fRvjQ1uSlJ9+fHFAi+MUNWHbxac1R
 95Zn5ZUHJR3ajVswaA9uzQ7eBeAzXkNN2nD5fWPh4ka860ZNg4SRvvZ5XFLAHRjtYc
 jzSQnS16b1lgVbMnmeGTJ8MrJlPjLZWj9UsejAHuD5iLDKoV6834jZHTiEkpZPAFGT
 ZMz5bzbrrGhjlvqclnnR0IDTR6LhFipJjDhe1XeH17QIUBgoAzXK1jTUAWKlfN41AQ
 QHYKg3S2gWGpOO7VNvaLoGZdibEAxLmkcXxn6DlB4ipoAMLxQz3b0lfVDsPXA0z0id
 hkbmuyolS+EkA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: [Qemu-devel] [PATCH v4 05/13] vfio: Add VM state change handler to
 know state of VM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Zhengxiao.zx@Alibaba-inc.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yan.y.zhao@intel.com,
 eskultet@redhat.com, ziye.yang@intel.com, qemu-devel@nongnu.org,
 cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com,
 zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 yulei.zhang@intel.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VM state change handler gets called on change in VM's state. This is used to set
VFIO device state to _RUNNING.
VM state change handler, migration state change handler and log_sync listener
are called asynchronously, which sometimes lead to data corruption in migration
region. Initialised mutex that is used to serialize operations on migration data
region during saving state.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c           | 45 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  4 ++++
 2 files changed, 49 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index ba58d9253d26..15af218c23d1 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -77,6 +77,41 @@ err:
     return ret;
 }
 
+static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region.buffer;
+    int ret = 0;
+
+    ret = pwrite(vbasedev->fd, &state, sizeof(state),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              device_state));
+    if (ret < 0) {
+        error_report("Failed to set migration state %d %s",
+                     ret, strerror(errno));
+        return ret;
+    }
+
+    vbasedev->device_state = state;
+    return 0;
+}
+
+static void vfio_vmstate_change(void *opaque, int running, RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+
+    if ((vbasedev->vm_running != running) && running) {
+        int ret;
+
+        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
+        if (ret) {
+            error_report("Failed to set state RUNNING");
+        }
+    }
+
+    vbasedev->vm_running = running;
+}
+
 static int vfio_migration_init(VFIODevice *vbasedev,
                                struct vfio_region_info *info)
 {
@@ -91,6 +126,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
         return ret;
     }
 
+    qemu_mutex_init(&vbasedev->migration->lock);
+
+    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
+                                                          vbasedev);
+
     return 0;
 }
 
@@ -127,11 +167,16 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
         return;
     }
 
+    if (vbasedev->vm_state) {
+        qemu_del_vm_change_state_handler(vbasedev->vm_state);
+    }
+
     if (vbasedev->migration_blocker) {
         migrate_del_blocker(vbasedev->migration_blocker);
         error_free(vbasedev->migration_blocker);
     }
 
+    qemu_mutex_destroy(&vbasedev->migration->lock);
     vfio_migration_region_exit(vbasedev);
     g_free(vbasedev->migration);
 }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1374a03470d8..f2392e97fa57 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -29,6 +29,7 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
+#include "sysemu/sysemu.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -129,6 +130,9 @@ typedef struct VFIODevice {
     unsigned int flags;
     VFIOMigration *migration;
     Error *migration_blocker;
+    uint32_t device_state;
+    VMChangeStateEntry *vm_state;
+    int vm_running;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
2.7.0


