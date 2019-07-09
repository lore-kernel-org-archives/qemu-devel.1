Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F1C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8902073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WtNqC6XF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8902073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkhS7-0003zc-6T
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 00:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34851)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hkhQM-0002Mq-Ky
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hkhQH-0003Ds-DD
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:08:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3827)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hkhQG-0003Bc-Lt
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:08:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d2413200014>; Mon, 08 Jul 2019 21:08:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 08 Jul 2019 21:07:56 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 08 Jul 2019 21:07:56 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 02:03:00 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 02:03:00 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 9 Jul 2019 02:02:54 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Tue, 9 Jul 2019 07:29:12 +0530
Message-ID: <1562637554-22439-12-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1562637554-22439-1-git-send-email-kwankhede@nvidia.com>
References: <1562637554-22439-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1562645290; bh=Q4DfoZruZ2aQNgjIuEPK+UWoRZJews7k8P3jDbq3Gyg=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=WtNqC6XFcR0Syn34Kzo3swHdDEeyQivMo/j+BbOJiYyJ/ACmYmAWpQBrHDvxDkCKc
 XVG/C8EBpRzu23suPzbvzd4qJWP/nB7naXuYvEfT5sLuzngW0PAXQist9RCZpDDkY+
 mirOvSouAbE+KwVucUKF2sTcQu4BTNZ7VM0eotDSNPqzGpxoJYJ6C1rqjEz5bVHNk0
 qSQ1Wc/2kncFA4WcU46NrlfLtgIhaGOwsphKc/yMpZ7Tbxu6NT+SLJmg/BgLkvpENA
 gc6JnzSFDaw3gsBln9+fxeHA+RE0RPvaz791AEgzAkBLn+YVYe6s+I8Obq75PD7e/u
 YrTPlRgANCLcw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.64
Subject: [Qemu-devel] [PATCH v6 11/13] vfio: Add function to get dirty page
 list
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

Dirty page tracking (.log_sync) is part of RAM copying state, where
vendor driver provides the bitmap of pages which are dirtied by vendor
driver through migration region and as part of RAM copy, those pages
gets copied to file stream.

To get dirty page bitmap:
- write start address, page_size and pfn count.
- read count of pfns copied.
    - Vendor driver should return 0 if driver doesn't have any page to
      report dirty in given range.
    - Vendor driver should return -1 to mark all pages dirty for given range.
- read data_offset, where vendor driver has written bitmap.
- read bitmap from the region or mmaped part of the region.
- Iterate above steps till page bitmap for all requested pfns are copied.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c           | 123 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |   4 +-
 include/hw/vfio/vfio-common.h |   2 +
 3 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 5fb4c5329ede..ca1a8c0f5f1f 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -269,6 +269,129 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
     return qemu_file_get_error(f);
 }
 
+void vfio_get_dirty_page_list(VFIODevice *vbasedev,
+                              uint64_t start_pfn,
+                              uint64_t pfn_count,
+                              uint64_t page_size)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region.buffer;
+    uint64_t count = 0;
+    int64_t copied_pfns = 0;
+    int64_t total_pfns = pfn_count;
+    int ret;
+
+    qemu_mutex_lock(&migration->lock);
+
+    while (total_pfns > 0) {
+        uint64_t bitmap_size, data_offset = 0;
+        uint64_t start = start_pfn + count;
+        void *buf = NULL;
+        bool buffer_mmaped = false;
+
+        ret = pwrite(vbasedev->fd, &start, sizeof(start),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              start_pfn));
+        if (ret < 0) {
+            error_report("%s: Failed to set dirty pages start address %d %s",
+                         vbasedev->name, ret, strerror(errno));
+            goto dpl_unlock;
+        }
+
+        ret = pwrite(vbasedev->fd, &page_size, sizeof(page_size),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              page_size));
+        if (ret < 0) {
+            error_report("%s: Failed to set dirty page size %d %s",
+                         vbasedev->name, ret, strerror(errno));
+            goto dpl_unlock;
+        }
+
+        ret = pwrite(vbasedev->fd, &total_pfns, sizeof(total_pfns),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              total_pfns));
+        if (ret < 0) {
+            error_report("%s: Failed to set dirty page total pfns %d %s",
+                         vbasedev->name, ret, strerror(errno));
+            goto dpl_unlock;
+        }
+
+        /* Read copied dirty pfns */
+        ret = pread(vbasedev->fd, &copied_pfns, sizeof(copied_pfns),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             copied_pfns));
+        if (ret < 0) {
+            error_report("%s: Failed to get dirty pages bitmap count %d %s",
+                         vbasedev->name, ret, strerror(errno));
+            goto dpl_unlock;
+        }
+
+        if (copied_pfns == VFIO_DEVICE_DIRTY_PFNS_NONE) {
+            /*
+             * copied_pfns could be 0 if driver doesn't have any page to
+             * report dirty in given range
+             */
+            break;
+        } else if (copied_pfns == VFIO_DEVICE_DIRTY_PFNS_ALL) {
+            /* Mark all pages dirty for this range */
+            cpu_physical_memory_set_dirty_range(start_pfn * page_size,
+                                                pfn_count * page_size,
+                                                DIRTY_MEMORY_MIGRATION);
+            break;
+        }
+
+        bitmap_size = (BITS_TO_LONGS(copied_pfns) + 1) * sizeof(unsigned long);
+
+        ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             data_offset));
+        if (ret != sizeof(data_offset)) {
+            error_report("%s: Failed to get migration buffer data offset %d",
+                         vbasedev->name, ret);
+            goto dpl_unlock;
+        }
+
+        if (region->mmaps) {
+            buf = find_data_region(region, data_offset, bitmap_size);
+        }
+
+        buffer_mmaped = (buf != NULL) ? true : false;
+
+        if (!buffer_mmaped) {
+            buf = g_try_malloc0(bitmap_size);
+            if (!buf) {
+                error_report("%s: Error allocating buffer ", __func__);
+                goto dpl_unlock;
+            }
+
+            ret = pread(vbasedev->fd, buf, bitmap_size,
+                        region->fd_offset + data_offset);
+            if (ret != bitmap_size) {
+                error_report("%s: Failed to get dirty pages bitmap %d",
+                             vbasedev->name, ret);
+                g_free(buf);
+                goto dpl_unlock;
+            }
+        }
+
+        cpu_physical_memory_set_dirty_lebitmap((unsigned long *)buf,
+                                               (start_pfn + count) * page_size,
+                                                copied_pfns);
+        count      += copied_pfns;
+        total_pfns -= copied_pfns;
+
+        if (!buffer_mmaped) {
+            g_free(buf);
+        }
+    }
+
+    trace_vfio_get_dirty_page_list(vbasedev->name, start_pfn, pfn_count,
+                                   page_size);
+
+dpl_unlock:
+    qemu_mutex_unlock(&migration->lock);
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_setup(QEMUFile *f, void *opaque)
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index a375efe490f9..6fdd12530c87 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -159,5 +159,5 @@ vfio_save_iterate(char *name, int data_size) " (%s) data_size %d"
 vfio_save_complete_precopy(char *name) " (%s)"
 vfio_load_device_config_state(char *name) " (%s)"
 vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
-vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s), Offset 0x%"PRIx64" size 0x%"PRIx64
-
+vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s), Offset 0x%"PRIx64" size 0x%"PRIx6
+vfio_get_dirty_page_list(char *name, uint64_t start, uint64_t pfn_count, uint64_t page_size) " (%s) start 0x%"PRIx64" pfn_count 0x%"PRIx64 " page size 0x%"PRIx64
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a022484d2636..dc1b83a0b4ef 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -222,5 +222,7 @@ int vfio_spapr_remove_window(VFIOContainer *container,
 
 int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_finalize(VFIODevice *vbasedev);
+void vfio_get_dirty_page_list(VFIODevice *vbasedev, uint64_t start_pfn,
+                               uint64_t pfn_count, uint64_t page_size);
 
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.7.0


