Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E91C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F8B20675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gX4/ipn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F8B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdykU-00032i-MK
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyKI-000635-59
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyKF-0005p4-OT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hdyKF-0005ng-G6
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0b9b010000>; Thu, 20 Jun 2019 07:41:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Jun 2019 07:41:05 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 07:41:05 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:41:05 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 14:40:58 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Thu, 20 Jun 2019 20:07:38 +0530
Message-ID: <1561041461-22326-11-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561041665; bh=zwCotcuQgQ/QY2vqSK3NjO/F2occ1fuAnSjeBVHdgh0=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=gX4/ipn+7skEaxCM2cfAoHylULu5+SmwkI8AM1dWf+yozVhi85VM1FR5RdMJ20JM9
 h4eLr+8Sxg3K1c3WjuIp7kF1XsKSkZkp2IoxWiU8AEmr/YRFNkuz9rohr8JExu/vWJ
 65T0E1rnFLqk/57Eb4rfsxEni2V6535QD5kP7EoPUpNTRVcwEfMGStCr7aX82ZFjxG
 xBeww31nSE7dYgx2EnAByLltUXOta8lxLDFz6gl8Ey+z5N8fDvcQuUMXSAvolVcLDd
 2z+NeWqtf8Gwr3ITMTgq0Z6hvvrdL17BYXbGkvjxh5x63dlkfTEvZL5YsQWvQ9AJKL
 HTmkA/txpXOvQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
Subject: [Qemu-devel] [PATCH v4 10/13] vfio: Add function to get dirty page
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
- read bitmap from the region or mmaped part of the region. This copy is
  iterated till page bitmap for all requested pfns are copied.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c           | 119 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |   2 +
 2 files changed, 121 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index e4895f91761d..68775b5dec11 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -228,6 +228,125 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
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
+    int ret;
+
+    qemu_mutex_lock(&migration->lock);
+    ret = pwrite(vbasedev->fd, &start_pfn, sizeof(start_pfn),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              start_pfn));
+    if (ret < 0) {
+        error_report("Failed to set dirty pages start address %d %s",
+                ret, strerror(errno));
+        goto dpl_unlock;
+    }
+
+    ret = pwrite(vbasedev->fd, &page_size, sizeof(page_size),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              page_size));
+    if (ret < 0) {
+        error_report("Failed to set dirty page size %d %s",
+                ret, strerror(errno));
+        goto dpl_unlock;
+    }
+
+    ret = pwrite(vbasedev->fd, &pfn_count, sizeof(pfn_count),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              total_pfns));
+    if (ret < 0) {
+        error_report("Failed to set dirty page total pfns %d %s",
+                ret, strerror(errno));
+        goto dpl_unlock;
+    }
+
+    do {
+        uint64_t bitmap_size, data_offset = 0;
+        void *buf = NULL;
+        bool buffer_mmaped = false;
+
+        /* Read copied dirty pfns */
+        ret = pread(vbasedev->fd, &copied_pfns, sizeof(copied_pfns),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             copied_pfns));
+        if (ret < 0) {
+            error_report("Failed to get dirty pages bitmap count %d %s",
+                    ret, strerror(errno));
+            goto dpl_unlock;
+        }
+
+        if (copied_pfns == 0) {
+            /*
+             * copied_pfns could be 0 if driver doesn't have any page to
+             * report dirty in given range
+             */
+            break;
+        } else if (copied_pfns == -1) {
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
+            error_report("Failed to get migration buffer data offset %d",
+                         ret);
+            goto dpl_unlock;
+        }
+
+        if (region->mmaps) {
+            int i;
+            for (i = 0; i < region->nr_mmaps; i++) {
+                if ((region->mmaps[i].offset >= data_offset) &&
+                    (data_offset < region->mmaps[i].offset +
+                                   region->mmaps[i].size)) {
+                    buf = region->mmaps[i].mmap + (data_offset -
+                                                   region->mmaps[i].offset);
+                    buffer_mmaped = true;
+                    break;
+                }
+            }
+        }
+
+        if (!buffer_mmaped) {
+            buf = g_malloc0(bitmap_size);
+
+            ret = pread(vbasedev->fd, buf, bitmap_size,
+                        region->fd_offset + data_offset);
+            if (ret != bitmap_size) {
+                error_report("Failed to get dirty pages bitmap %d", ret);
+                g_free(buf);
+                goto dpl_unlock;
+            }
+        }
+
+        cpu_physical_memory_set_dirty_lebitmap((unsigned long *)buf,
+                                               (start_pfn + count) * page_size,
+                                                copied_pfns);
+        count +=  copied_pfns;
+
+        if (!buffer_mmaped) {
+            g_free(buf);
+        }
+    } while (count < pfn_count);
+
+dpl_unlock:
+    qemu_mutex_unlock(&migration->lock);
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_setup(QEMUFile *f, void *opaque)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1d26e6be8d48..423d6dbccace 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -224,5 +224,7 @@ int vfio_spapr_remove_window(VFIOContainer *container,
 
 int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_finalize(VFIODevice *vbasedev);
+void vfio_get_dirty_page_list(VFIODevice *vbasedev, uint64_t start_pfn,
+                               uint64_t pfn_count, uint64_t page_size);
 
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.7.0


