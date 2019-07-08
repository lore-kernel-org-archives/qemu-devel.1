Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06384C606CD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB736217D6
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="As0ebpah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB736217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkZHd-0004JG-3v
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 15:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hkZCF-00050V-TA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hkZCC-0002zT-4C
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:21:07 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hkZCB-0002oX-BF
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:21:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d2397940000>; Mon, 08 Jul 2019 12:20:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 08 Jul 2019 12:20:47 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 08 Jul 2019 12:20:47 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jul
 2019 19:20:47 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 8 Jul 2019 19:20:41 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Tue, 9 Jul 2019 00:47:25 +0530
Message-ID: <1562613452-24969-7-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1562613452-24969-1-git-send-email-kwankhede@nvidia.com>
References: <1562613452-24969-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1562613652; bh=CzIjuh45DV8zioWi2bRTMYHoiTulp8p5NKtpMhF1Pz8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=As0ebpahHZlh7XzbLNPzWT43U7ghR4CVDo/YiMP2MLP1LZO2DXFfwWBDW5HVZmQYM
 Vujuj5wtx5f3bRm5yXVZQhDj5HV4yyB+JW85gWa1Q4F5qx1p6pk9sKlHYph5LFcLs9
 8St7v7YQM+YaJ8HTZoj7brBBJu7MjL48l7+tniSJ5Cuoioe/JVfQ8r/tyN8x+H68+E
 /aTp2x78VVpXd4cGj2S38xAN4UhqvnJ6dUX38+SQ81SZfGttwmHzjZUxJwYVY0QJwj
 wSY/R3rlBOvftWZ1/MkJ0Js212NlDFgpJms8an1NM3Dp0yPvSj0Lf6YTbtpeX4s7PA
 y0tMAheg9PNyA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
Subject: [Qemu-devel] [PATCH v5 06/13] vfio: Add VM state change handler to
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
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
 hw/vfio/migration.c           | 64 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |  2 ++
 include/hw/vfio/vfio-common.h |  4 +++
 3 files changed, 70 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index a2cfbd5af2e1..c01f08b659d0 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -78,6 +78,60 @@ err:
     return ret;
 }
 
+static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region.buffer;
+    uint32_t device_state;
+    int ret = 0;
+
+    device_state = (state & VFIO_DEVICE_STATE_MASK) |
+                   (vbasedev->device_state & ~VFIO_DEVICE_STATE_MASK);
+
+    if ((device_state & VFIO_DEVICE_STATE_MASK) == VFIO_DEVICE_STATE_INVALID) {
+        return -EINVAL;
+    }
+
+    ret = pwrite(vbasedev->fd, &device_state, sizeof(device_state),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              device_state));
+    if (ret < 0) {
+        error_report("%s: Failed to set device state %d %s",
+                     vbasedev->name, ret, strerror(errno));
+        return ret;
+    }
+
+    vbasedev->device_state = device_state;
+    trace_vfio_migration_set_state(vbasedev->name, device_state);
+    return 0;
+}
+
+static void vfio_vmstate_change(void *opaque, int running, RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+
+    if ((vbasedev->vm_running != running)) {
+        int ret;
+        uint32_t dev_state;
+
+        if (running) {
+            dev_state = VFIO_DEVICE_STATE_RUNNING;
+        } else {
+            dev_state = (vbasedev->device_state & VFIO_DEVICE_STATE_MASK) &
+                     ~VFIO_DEVICE_STATE_RUNNING;
+        }
+
+        ret = vfio_migration_set_state(vbasedev, dev_state);
+        if (ret) {
+            error_report("%s: Failed to set device state 0x%x",
+                         vbasedev->name, dev_state);
+        }
+        vbasedev->vm_running = running;
+        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
+                                  dev_state);
+    }
+}
+
 static int vfio_migration_init(VFIODevice *vbasedev,
                                struct vfio_region_info *info)
 {
@@ -93,6 +147,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
         return ret;
     }
 
+    qemu_mutex_init(&vbasedev->migration->lock);
+
+    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
+                                                          vbasedev);
+
     return 0;
 }
 
@@ -135,11 +194,16 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
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
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 191a726a1312..3d15bacd031a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -146,3 +146,5 @@ vfio_display_edid_write_error(void) ""
 
 # migration.c
 vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
+vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
+vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 152da3f8d6f3..f6c70db3a9c1 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -29,6 +29,7 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
+#include "sysemu/sysemu.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -124,6 +125,9 @@ typedef struct VFIODevice {
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


