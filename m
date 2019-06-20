Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C06EC48BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEB62083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LyUsCduP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEB62083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyu2-0001fH-ET
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38088)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyKd-0006FL-F2
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyKa-0006FE-8N
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:31 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hdyKZ-0006DY-U4
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0b9b170000>; Thu, 20 Jun 2019 07:41:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Jun 2019 07:41:25 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 07:41:25 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:41:24 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:41:25 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 14:41:18 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Thu, 20 Jun 2019 20:07:41 +0530
Message-ID: <1561041461-22326-14-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561041687; bh=1S/KxQ69YuW1Nvqhm0/2EWNCTQLOARisCkaV+xZdDpg=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=LyUsCduPrLIevNwCWZHM9TO9p32gf7IwKza1iyy35H/vBGZVnSVk4+ePtwmHOVF9O
 UAA2v0rac2DH/Zc7ua1tOJgiqT8voZFSokIwwwHvy65feGKY4C9LUMB7e6o8P9HmD4
 EjWcgjfeLlZRV2RepIL+J/iwvSqJvXo+uCkviRb8RcD5QBrNS2hk2HqnZR+azWdpOw
 6SaF1y22bIf0yK2ehY+5UePPviNsltuJtW5MrEGOmL4YrqUUeKWWfNlaAugorh7BR8
 kH7yTYoUUnpmsBhHF2+re/7G2m4Hb8cq1tpnk3s1zzQUYK23uIrRklHK6ASji4eGoQ
 7kF5BFetqWL6Q==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
Subject: [Qemu-devel] [PATCH v4 13/13] vfio: Add trace events in migration
 code path
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

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c  | 26 ++++++++++++++++++++++++++
 hw/vfio/trace-events | 18 ++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 68775b5dec11..70c03f1a969f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -21,6 +21,7 @@
 #include "exec/ramlist.h"
 #include "exec/ram_addr.h"
 #include "pci.h"
+#include "trace.h"
 
 /*
  * Flags used as delimiter:
@@ -104,6 +105,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
     }
 
     vbasedev->device_state = state;
+    trace_vfio_migration_set_state(vbasedev->name, state);
     return 0;
 }
 
@@ -173,6 +175,8 @@ static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
         qemu_put_be64(f, data_size);
     }
 
+    trace_vfio_save_buffer(vbasedev->name, data_offset, data_size,
+                           migration->pending_bytes);
     ret = qemu_file_get_error(f);
 
     return data_size;
@@ -195,6 +199,7 @@ static int vfio_update_pending(VFIODevice *vbasedev)
     }
 
     migration->pending_bytes = pending_bytes;
+    trace_vfio_update_pending(vbasedev->name, pending_bytes);
     return 0;
 }
 
@@ -209,6 +214,8 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
     }
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
 
+    trace_vfio_save_device_config_state(vbasedev->name);
+
     return qemu_file_get_error(f);
 }
 
@@ -225,6 +232,7 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
         return -EINVAL;
     }
 
+    trace_vfio_load_device_config_state(vbasedev->name);
     return qemu_file_get_error(f);
 }
 
@@ -343,6 +351,9 @@ void vfio_get_dirty_page_list(VFIODevice *vbasedev,
         }
     } while (count < pfn_count);
 
+    trace_vfio_get_dirty_page_list(vbasedev->name, start_pfn, pfn_count,
+                                   page_size);
+
 dpl_unlock:
     qemu_mutex_unlock(&migration->lock);
 }
@@ -390,6 +401,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
+    trace_vfio_save_setup(vbasedev->name);
     return 0;
 }
 
@@ -401,6 +413,7 @@ static void vfio_save_cleanup(void *opaque)
     if (migration->region.buffer.mmaps) {
         vfio_region_unmap(&migration->region.buffer);
     }
+    trace_vfio_cleanup(vbasedev->name);
 }
 
 static void vfio_save_pending(QEMUFile *f, void *opaque,
@@ -424,6 +437,7 @@ static void vfio_save_pending(QEMUFile *f, void *opaque,
         *res_postcopy_only += migration->pending_bytes;
     }
     *res_compatible += 0;
+    trace_vfio_save_pending(vbasedev->name);
 }
 
 static int vfio_save_iterate(QEMUFile *f, void *opaque)
@@ -451,6 +465,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
         return ret;
     }
 
+    trace_vfio_save_iterate(vbasedev->name);
     return ret;
 }
 
@@ -504,6 +519,8 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
         error_report("Failed to set state STOPPED");
         return ret;
     }
+
+    trace_vfio_save_complete_precopy(vbasedev->name);
     return ret;
 }
 
@@ -544,6 +561,9 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 
     data = qemu_get_be64(f);
     while (data != VFIO_MIG_FLAG_END_OF_STATE) {
+
+        trace_vfio_load_state(vbasedev->name, data);
+
         switch (data) {
         case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
         {
@@ -627,6 +647,8 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
                     return -EINVAL;
                 }
             }
+            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
+                                              data_size);
             break;
         }
         }
@@ -668,6 +690,7 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
     }
 
     vbasedev->vm_running = running;
+    trace_vfio_vmstate_change(vbasedev->name, running);
 }
 
 static void vfio_migration_state_notifier(Notifier *notifier, void *data)
@@ -676,6 +699,8 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
     int ret;
 
+    trace_vfio_migration_state_notifier(vbasedev->name, s->state);
+
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
         if (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING) {
@@ -758,6 +783,7 @@ int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
             return ret;
         }
     } else {
+        trace_vfio_migration_probe(vbasedev->name, info->index);
         return vfio_migration_init(vbasedev, info);
     }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 8cdc27946cb8..b1f19ae7a806 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -143,3 +143,21 @@ vfio_display_edid_link_up(void) ""
 vfio_display_edid_link_down(void) ""
 vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
 vfio_display_edid_write_error(void) ""
+
+# migration.c
+vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
+vfio_save_buffer(char *name, uint64_t data_offset, uint64_t data_size, uint64_t pending) " (%s), Offset 0x%"PRIx64" size 0x%"PRIx64" pending 0x%"PRIx64
+vfio_update_pending(char *name, uint64_t pending) " (%s), pending 0x%"PRIx64
+vfio_save_device_config_state(char *name) " (%s)"
+vfio_load_device_config_state(char *name) " (%s)"
+vfio_get_dirty_page_list(char *name, uint64_t start, uint64_t pfn_count, uint64_t page_size) " (%s) start 0x%"PRIx64" pfn_count 0x%"PRIx64 " page size 0x%"PRIx64
+vfio_save_setup(char *name) " (%s)"
+vfio_cleanup(char *name) " (%s)"
+vfio_save_pending(char *name) " (%s)"
+vfio_save_iterate(char *name) " (%s)"
+vfio_save_complete_precopy(char *name) " (%s)"
+vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
+vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s), Offset 0x%"PRIx64" size 0x%"PRIx64
+vfio_vmstate_change(char *name, int running) " (%s) running %d"
+vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
+vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
-- 
2.7.0


