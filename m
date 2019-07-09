Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490A9C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFAD2080C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ipOfz+9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFAD2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmtz-0002gn-6U
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50067)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hkmnt-0004bb-IN
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hkmnp-0004OJ-Rg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:52:51 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hkmno-0004Jd-9V
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:52:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d2463ea0000>; Tue, 09 Jul 2019 02:52:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 09 Jul 2019 02:52:46 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 09 Jul 2019 02:52:46 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 09:52:46 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 9 Jul 2019 09:52:40 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Tue, 9 Jul 2019 15:19:15 +0530
Message-ID: <1562665760-26158-9-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1562665962; bh=8vUPg3KmhoNDzrGG08rPjtEGsYW1X/3yWpzwzoAlpYU=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=ipOfz+9+sePnvfBXM23A5xPOHNk40Y6dOPZYc+5fCzbjvkuEfTE7nRCHR6mUNr1jN
 2eUoh2cM1pK1/EF8uNN3IbIsEPPgjvdsMc2MHMuPDPzJj7lf0p39meHL6NHk4yvZod
 0x29plqcSjE4A/96wh3XMGzhRWG7ydTNRVZj13QbkSLTxdrpIIEZuhpqq0ImdPuhsf
 tY+yuPRIdtYHzko5W0PzKv/u3sIGLr+/VLtuYmUO/R1o3EQPqYthS/LGZBfnJyZnqw
 cXZWnaYJaZsAiu8GVjZ0/n7aJW8A2gpZVczLfpmH13yZ/3IfcDVvDjGwsyFKv6kjD3
 tatR+2s/riamA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: [Qemu-devel] [PATCH v7 08/13] vfio: Register SaveVMHandlers for
 VFIO device
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

Define flags to be used as delimeter in migration file stream.
Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
region from these functions at source during saving or pre-copy phase.
Set VFIO device state depending on VM's state. During live migration, VM is
running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
device. During save-restore, VM is paused, _SAVING state is set for VFIO device.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c  | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events |  2 ++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index e4a89a6f9bc7..0597a45fda2d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -23,6 +23,17 @@
 #include "pci.h"
 #include "trace.h"
 
+/*
+ * Flags used as delimiter:
+ * 0xffffffff => MSB 32-bit all 1s
+ * 0xef10     => emulated (virtual) function IO
+ * 0x0000     => 16-bits reserved for flags
+ */
+#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
+#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
+#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
+#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
+
 static void vfio_migration_region_exit(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -106,6 +117,74 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
     return 0;
 }
 
+/* ---------------------------------------------------------------------- */
+
+static int vfio_save_setup(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
+
+    if (migration->region.buffer.mmaps) {
+        qemu_mutex_lock_iothread();
+        ret = vfio_region_mmap(&migration->region.buffer);
+        qemu_mutex_unlock_iothread();
+        if (ret) {
+            error_report("%s: Failed to mmap VFIO migration region %d: %s",
+                         vbasedev->name, migration->region.index,
+                         strerror(-ret));
+            return ret;
+        }
+    }
+
+    if (vbasedev->vm_running) {
+        ret = vfio_migration_set_state(vbasedev,
+                         VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING);
+        if (ret) {
+            error_report("%s: Failed to set state RUNNING and SAVING",
+                         vbasedev->name);
+            return ret;
+        }
+    } else {
+        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
+        if (ret) {
+            error_report("%s: Failed to set state STOP and SAVING",
+                         vbasedev->name);
+            return ret;
+        }
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    trace_vfio_save_setup(vbasedev->name);
+    return 0;
+}
+
+static void vfio_save_cleanup(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (migration->region.buffer.mmaps) {
+        vfio_region_unmap(&migration->region.buffer);
+    }
+    trace_vfio_save_cleanup(vbasedev->name);
+}
+
+static SaveVMHandlers savevm_vfio_handlers = {
+    .save_setup = vfio_save_setup,
+    .save_cleanup = vfio_save_cleanup,
+};
+
+/* ---------------------------------------------------------------------- */
+
 static void vfio_vmstate_change(void *opaque, int running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
@@ -195,7 +274,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
     }
 
     qemu_mutex_init(&vbasedev->migration->lock);
-
+    register_savevm_live(vbasedev->dev, "vfio", -1, 1, &savevm_vfio_handlers,
+                         vbasedev);
     vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
                                                           vbasedev);
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 69503228f20e..4bb43f18f315 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -149,3 +149,5 @@ vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
 vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
 vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
 vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
+vfio_save_setup(char *name) " (%s)"
+vfio_save_cleanup(char *name) " (%s)"
-- 
2.7.0


