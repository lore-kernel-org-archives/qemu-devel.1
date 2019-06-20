Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4963C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941E920675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Pji7itl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941E920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48976 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyh4-0007rs-QR
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyKA-0005zd-3x
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyK8-0005hA-Lr
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hdyK5-0005bs-OC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:59 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0b9ad70000>; Thu, 20 Jun 2019 07:40:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 20 Jun 2019 07:40:24 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 07:40:24 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:40:23 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 14:40:17 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Thu, 20 Jun 2019 20:07:32 +0530
Message-ID: <1561041461-22326-5-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561041623; bh=A8LxyFw0N3pgqPM1TG7/DMPRsfTFzYb8JI28vCOEjWk=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=Pji7itl/N1RPi9Vcs5C8LP1afeymQaCPZ4X68x22EL4IYb+WSD07yN4AcBG6gGxYw
 gXXqtOKz68HZzA7CLARYNmE+0t1tuyqrNolu1yNhTFdPGW4DtjgZ3EmfgjncBINxHu
 oYv1FXDZEz9/lv+MB26EU3xm0AIOK9plJ3lPK/en3pzYuYBnaoSBMpTalzex1I2Sb1
 1mlWcKaPg0K1+ao/w9/WcOIPKZUe+5J9jFDmWaDhn7X0dC47lFArWD5e5yXCcUyVj1
 vmi4SflTq7pKSovYmiTVg/zdRPOGpZkVGw7zwLndpTTVt9eevVXJqDs4JgUeyU68Ap
 aIGbqiPa+o3tQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: [Qemu-devel] [PATCH v4 04/13] vfio: Add migration region
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

- Migration functions are implemented for VFIO_DEVICE_TYPE_PCI device in this
  patch series.
- VFIO device supports migration or not is decided based of migration region
  query. If migration region query is successful then migration is supported
  else migration is blocked.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/Makefile.objs         |   2 +-
 hw/vfio/migration.c           | 137 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  14 +++++
 3 files changed, 152 insertions(+), 1 deletion(-)
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
index 000000000000..ba58d9253d26
--- /dev/null
+++ b/hw/vfio/migration.c
@@ -0,0 +1,137 @@
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
+    /* Migration support added for PCI device only */
+    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        obj = vfio_pci_get_object(vbasedev);
+    }
+
+    if (!obj) {
+        return ret;
+    }
+
+    ret = vfio_region_setup(obj, vbasedev, &migration->region.buffer,
+                            migration->region.index, "migration");
+    if (ret) {
+        error_report("Failed to setup VFIO migration region %d: %s",
+                      migration->region.index, strerror(-ret));
+        goto err;
+    }
+
+    if (!migration->region.buffer.size) {
+        ret = -EINVAL;
+        error_report("Invalid region size of VFIO migration region %d: %s",
+                     migration->region.index, strerror(-ret));
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
+        error_report("Failed to initialise migration region");
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
+    int ret;
+
+    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
+                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
+    if (ret) {
+        Error *local_err = NULL;
+
+        error_setg(&vbasedev->migration_blocker,
+                   "VFIO device doesn't support migration");
+        ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_free(vbasedev->migration_blocker);
+            return ret;
+        }
+    } else {
+        return vfio_migration_init(vbasedev, info);
+    }
+
+    return 0;
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
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ef078cf60ef9..1374a03470d8 100644
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
@@ -118,6 +127,8 @@ typedef struct VFIODevice {
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
+    VFIOMigration *migration;
+    Error *migration_blocker;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -206,4 +217,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
+int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
+void vfio_migration_finalize(VFIODevice *vbasedev);
+
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.7.0


