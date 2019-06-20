Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA3EC48BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B68F2084E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yqb4z967"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B68F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdybZ-00033e-8G
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37863)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyK1-0005xA-6v
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyJz-0005YR-R5
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13233)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hdyJz-0005VS-IR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0b9ae50000>; Thu, 20 Jun 2019 07:40:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Jun 2019 07:40:37 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 07:40:37 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:40:37 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:40:37 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 14:40:31 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Thu, 20 Jun 2019 20:07:34 +0530
Message-ID: <1561041461-22326-7-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561041637; bh=lBhaXThY2cPoc8ul1w3nQGKRFmg6IBN6bpYoTDrFtTE=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=Yqb4z967z8eaCKiK5yVu2pIZwmPoANmrsU0R3/ErqOosLfWdFewX510sgQpw0AF4R
 fz2NQK9z18FmWb3M+C1HUZJBtvm8nVP3UGrEbh8IwHRxKi7szt8D5s5akcp9+VnrX/
 EiC1/n8QIT1tMM9vBliwGkXjAAYFMUY7AvjVozjzDCnfrqUiH1J1+biJ5tFU2Mwq42
 cTISqzixXSaOpQvK5TLFRaEnrEsAUJlmy/5slrjVqJ6BYWfBnkNoxjEt/hHTbJ5X73
 6yqvjL2fTvZyNm0h5xzqHaQ0N95ijyuSeIt950P+zyKjVw18danBhl57NMJ4cdkBGP
 QOk3B8OipHIkw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: [Qemu-devel] [PATCH v4 06/13] vfio: Add migration state change
 notifier
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

Added migration state change notifier to get notification on migration state
change. These states are translated to VFIO device state and conveyed to vendor
driver.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c           | 49 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 15af218c23d1..7f9858e6c995 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -112,6 +112,48 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
     vbasedev->vm_running = running;
 }
 
+static void vfio_migration_state_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s = data;
+    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
+    int ret;
+
+    switch (s->state) {
+    case MIGRATION_STATUS_ACTIVE:
+        if (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING) {
+            if (vbasedev->vm_running) {
+                ret = vfio_migration_set_state(vbasedev,
+                          VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING);
+                if (ret) {
+                    error_report("Failed to set state RUNNING and SAVING");
+                }
+            } else {
+                ret = vfio_migration_set_state(vbasedev,
+                                               VFIO_DEVICE_STATE_SAVING);
+                if (ret) {
+                    error_report("Failed to set state STOP and SAVING");
+                }
+            }
+        } else {
+            ret = vfio_migration_set_state(vbasedev,
+                                           VFIO_DEVICE_STATE_RESUMING);
+            if (ret) {
+                error_report("Failed to set state RESUMING");
+            }
+        }
+        return;
+
+    case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_CANCELLED:
+    case MIGRATION_STATUS_FAILED:
+        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
+        if (ret) {
+            error_report("Failed to set state RUNNING");
+        }
+        return;
+    }
+}
+
 static int vfio_migration_init(VFIODevice *vbasedev,
                                struct vfio_region_info *info)
 {
@@ -131,6 +173,9 @@ static int vfio_migration_init(VFIODevice *vbasedev,
     vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
                                                           vbasedev);
 
+    vbasedev->migration_state.notify = vfio_migration_state_notifier;
+    add_migration_state_change_notifier(&vbasedev->migration_state);
+
     return 0;
 }
 
@@ -167,6 +212,10 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
         return;
     }
 
+    if (vbasedev->migration_state.notify) {
+        remove_migration_state_change_notifier(&vbasedev->migration_state);
+    }
+
     if (vbasedev->vm_state) {
         qemu_del_vm_change_state_handler(vbasedev->vm_state);
     }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f2392e97fa57..1d26e6be8d48 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -133,6 +133,7 @@ typedef struct VFIODevice {
     uint32_t device_state;
     VMChangeStateEntry *vm_state;
     int vm_running;
+    Notifier migration_state;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
2.7.0


