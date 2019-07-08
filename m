Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6EC606C7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449CE217D6
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PdfKiDbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449CE217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkZI2-0005AR-Io
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 15:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35135)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hkZCK-00058W-I3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hkZCI-00033g-LC
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:21:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hkZCI-0002kf-8Z
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:21:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d23978e0000>; Mon, 08 Jul 2019 12:20:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 08 Jul 2019 12:20:41 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 08 Jul 2019 12:20:41 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jul
 2019 19:20:41 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jul
 2019 19:20:40 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 8 Jul 2019 19:20:33 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Tue, 9 Jul 2019 00:47:24 +0530
Message-ID: <1562613452-24969-6-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1562613452-24969-1-git-send-email-kwankhede@nvidia.com>
References: <1562613452-24969-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1562613646; bh=GAcrL9sBGC5c9BmokU8vkZghd0B7Dg122zj5OUDX0Dg=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=PdfKiDbDkcOjA/mZ8lTkNz2n8GTPcoABlykezpVfK4yRakwlW0JcLHrMk/MLkn3Pt
 DZEBQDjAZnwowxQVpY8DPAxdXbp9RPIJeZ41wnShq9mpJhlKWcxuA7Ut9pyv3mqXGS
 KyTtVopkHgmwu8lBkzrm/PNeRn6G+m/hfispnEdAfkhT0F6wiVRKhdQ20tBeonYCGd
 S8CiZljWc1zCCy/dF0lQ6dmUf3vTPlQGEUCsP8GzET7j5iQwDhNRynSZPVB3fBnJuk
 ND9mwOjircxBoZtGOAYsiH20fSFBNftcQNVMEZYe9zwQO5Dl8kCBHna0BdeJG9E/91
 cts20yE/HgQeg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
Subject: [Qemu-devel] [PATCH v5 05/13] vfio: Add migration region
 initialization and finalize function
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

- Migration functions are implemented for VFIO_DEVICE_TYPE_PCI device in this
  patch series.
- VFIO device supports migration or not is decided based of migration region
  query. If migration region query is successful and migration region
  initialization is successful then migration is supported else migration is
  blocked.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/Makefile.objs         |   2 +-
 hw/vfio/migration.c           | 145 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |   3 +
 include/hw/vfio/vfio-common.h |  14 ++++
 4 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 hw/vfio/migration.c

diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index abad8b818c9b..36033d1437c5 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += common.o spapr.o
+obj-y += common.o spapr.o migration.o
 obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
 obj-$(CONFIG_VFIO_CCW) += ccw.o
 obj-$(CONFIG_VFIO_PLATFORM) += platform.o
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
new file mode 100644
index 000000000000..a2cfbd5af2e1
--- /dev/null
+++ b/hw/vfio/migration.c
@@ -0,0 +1,145 @@
+/*
+ * Migration support for VFIO devices
+ *
+ * Copyright NVIDIA, Inc. 2019
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+
+#include "hw/vfio/vfio-common.h"
+#include "cpu.h"
+#include "migration/migration.h"
+#include "migration/qemu-file.h"
+#include "migration/register.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
+#include "qapi/error.h"
+#include "exec/ramlist.h"
+#include "exec/ram_addr.h"
+#include "pci.h"
+#include "trace.h"
+
+static void vfio_migration_region_exit(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (!migration) {
+        return;
+    }
+
+    if (migration->region.buffer.size) {
+        vfio_region_exit(&migration->region.buffer);
+        vfio_region_finalize(&migration->region.buffer);
+    }
+}
+
+static int vfio_migration_region_init(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    Object *obj = NULL;
+    int ret = -EINVAL;
+
+    if (!migration) {
+        return ret;
+    }
+
+    if (!vbasedev->ops || !vbasedev->ops->vfio_get_object) {
+        return ret;
+    }
+
+    obj = vbasedev->ops->vfio_get_object(vbasedev);
+    if (!obj) {
+        return ret;
+    }
+
+    ret = vfio_region_setup(obj, vbasedev, &migration->region.buffer,
+                            migration->region.index, "migration");
+    if (ret) {
+        error_report("%s: Failed to setup VFIO migration region %d: %s",
+                     vbasedev->name, migration->region.index, strerror(-ret));
+        goto err;
+    }
+
+    if (!migration->region.buffer.size) {
+        ret = -EINVAL;
+        error_report("%s: Invalid region size of VFIO migration region %d: %s",
+                     vbasedev->name, migration->region.index, strerror(-ret));
+        goto err;
+    }
+
+    return 0;
+
+err:
+    vfio_migration_region_exit(vbasedev);
+    return ret;
+}
+
+static int vfio_migration_init(VFIODevice *vbasedev,
+                               struct vfio_region_info *info)
+{
+    int ret;
+
+    vbasedev->migration = g_new0(VFIOMigration, 1);
+    vbasedev->migration->region.index = info->index;
+
+    ret = vfio_migration_region_init(vbasedev);
+    if (ret) {
+        error_report("%s: Failed to initialise migration region",
+                     vbasedev->name);
+        return ret;
+    }
+
+    return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
+int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_region_info *info;
+    Error *local_err = NULL;
+    int ret;
+
+    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
+                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
+    if (ret) {
+        goto add_blocker;
+    }
+
+    ret = vfio_migration_init(vbasedev, info);
+    if (ret) {
+        goto add_blocker;
+    }
+
+    trace_vfio_migration_probe(vbasedev->name, info->index);
+    return 0;
+
+add_blocker:
+    error_setg(&vbasedev->migration_blocker,
+               "VFIO device doesn't support migration");
+    ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_free(vbasedev->migration_blocker);
+    }
+    return ret;
+}
+
+void vfio_migration_finalize(VFIODevice *vbasedev)
+{
+    if (!vbasedev->migration) {
+        return;
+    }
+
+    if (vbasedev->migration_blocker) {
+        migrate_del_blocker(vbasedev->migration_blocker);
+        error_free(vbasedev->migration_blocker);
+    }
+
+    vfio_migration_region_exit(vbasedev);
+    g_free(vbasedev->migration);
+}
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 8cdc27946cb8..191a726a1312 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -143,3 +143,6 @@ vfio_display_edid_link_up(void) ""
 vfio_display_edid_link_down(void) ""
 vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
 vfio_display_edid_write_error(void) ""
+
+# migration.c
+vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ee72bd984a36..152da3f8d6f3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -57,6 +57,15 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
+typedef struct VFIOMigration {
+    struct {
+        VFIORegion buffer;
+        uint32_t index;
+    } region;
+    uint64_t pending_bytes;
+    QemuMutex lock;
+} VFIOMigration;
+
 typedef struct VFIOAddressSpace {
     AddressSpace *as;
     QLIST_HEAD(, VFIOContainer) containers;
@@ -113,6 +122,8 @@ typedef struct VFIODevice {
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
+    VFIOMigration *migration;
+    Error *migration_blocker;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -204,4 +215,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
+int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
+void vfio_migration_finalize(VFIODevice *vbasedev);
+
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.7.0


