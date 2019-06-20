Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B4C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB0820675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bwVnklTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB0820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48988 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyht-0000Td-UX
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37894)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyK9-0005yv-DD
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hdyK7-0005fs-CW
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:46:01 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hdyK5-0005bt-I7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:45:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0b9af30000>; Thu, 20 Jun 2019 07:40:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Jun 2019 07:40:51 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 07:40:51 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 14:40:51 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 14:40:44 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Thu, 20 Jun 2019 20:07:36 +0530
Message-ID: <1561041461-22326-9-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561041651; bh=AYjCKCG6U7oS8eRuxBjCX/xkqGGrD9U9l/a9tXx+r8g=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=bwVnklTu0d7EkQ8qJUwAHNY0JL9mULgsOl+Hq6/iAkXw04X07Ki4XNPhL1HAbFoEk
 1LmcWThRVtA5se4QB2oZtqK2aSdbQIDk4SCv6PtXWFwuHUmDJB1FXCQQ6XL93yXhCR
 ux15CVt3F4gpUinTNsoQ8NOM3QsVXRK8YiWtPy4WhVJw4+MFBHg93SC40cFQfTitGx
 XKdYSqxAr/OfcCGV/xVcnNXYnBi07HX0DuuuG8GURhMfrLIM2aXodyGkHnQnP2EvfU
 Wd6vVeDvPNCyXT7rmfNEwfdjKk4vJYCYwd1O9TVuagEKmW8t9jgwWJfErGCRqhHkvc
 /ZB4r9p5v6gTw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: [Qemu-devel] [PATCH v4 08/13] vfio: Add save state functions to
 SaveVMHandlers
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

Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
functions. These functions handles pre-copy and stop-and-copy phase.

In _SAVING|_RUNNING device state or pre-copy phase:
- read pending_bytes
- read data_offset - indicates kernel driver to write data to staging
  buffer which is mmapped.
- read data_size - amount of data in bytes written by vendor driver in migration
  region.
- if data section is trapped, pread() number of bytes in data_size, from
  data_offset.
- if data section is mmaped, read mmaped buffer of size data_size.
- Write data packet to file stream as below:
{VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
VFIO_MIG_FLAG_END_OF_STATE }

In _SAVING device state or stop-and-copy phase
a. read config space of device and save to migration file stream. This
   doesn't need to be from vendor driver. Any other special config state
   from driver can be saved as data in following iteration.
b. read pending_bytes - indicates kernel driver to write data to staging
   buffer which is mmapped.
c. read data_size - amount of data in bytes written by vendor driver in
   migration region.
d. if data section is trapped, pread() from data_offset of size data_size.
e. if data section is mmaped, read mmaped buffer of size data_size.
f. Write data packet as below:
   {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
g. iterate through steps b to f until (pending_bytes > 0)
h. Write {VFIO_MIG_FLAG_END_OF_STATE}

.save_live_iterate runs outside the iothread lock in the migration case, which
could race with asynchronous call to get dirty page list causing data corruption
in mapped migration region. Mutex added here to serial migration buffer read
operation.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index fe0887c27664..0a2f30872316 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -107,6 +107,111 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
     return 0;
 }
 
+static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region.buffer;
+    uint64_t data_offset = 0, data_size = 0;
+    int ret;
+
+    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             data_offset));
+    if (ret != sizeof(data_offset)) {
+        error_report("Failed to get migration buffer data offset %d",
+                     ret);
+        return -EINVAL;
+    }
+
+    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             data_size));
+    if (ret != sizeof(data_size)) {
+        error_report("Failed to get migration buffer data size %d",
+                     ret);
+        return -EINVAL;
+    }
+
+    if (data_size > 0) {
+        void *buf = NULL;
+        bool buffer_mmaped = false;
+
+        if (region->mmaps) {
+            int i;
+
+            for (i = 0; i < region->nr_mmaps; i++) {
+                if ((data_offset >= region->mmaps[i].offset) &&
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
+            buf = g_malloc0(data_size);
+            ret = pread(vbasedev->fd, buf, data_size,
+                        region->fd_offset + data_offset);
+            if (ret != data_size) {
+                error_report("Failed to get migration data %d", ret);
+                g_free(buf);
+                return -EINVAL;
+            }
+        }
+
+        qemu_put_be64(f, data_size);
+        qemu_put_buffer(f, buf, data_size);
+
+        if (!buffer_mmaped) {
+            g_free(buf);
+        }
+        migration->pending_bytes -= data_size;
+    } else {
+        qemu_put_be64(f, data_size);
+    }
+
+    ret = qemu_file_get_error(f);
+
+    return data_size;
+}
+
+static int vfio_update_pending(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region.buffer;
+    uint64_t pending_bytes = 0;
+    int ret;
+
+    ret = pread(vbasedev->fd, &pending_bytes, sizeof(pending_bytes),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             pending_bytes));
+    if ((ret < 0) || (ret != sizeof(pending_bytes))) {
+        error_report("Failed to get pending bytes %d", ret);
+        migration->pending_bytes = 0;
+        return (ret < 0) ? ret : -EINVAL;
+    }
+
+    migration->pending_bytes = pending_bytes;
+    return 0;
+}
+
+static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
+
+    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        vfio_pci_save_config(vbasedev, f);
+    }
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    return qemu_file_get_error(f);
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_setup(QEMUFile *f, void *opaque)
@@ -163,9 +268,116 @@ static void vfio_save_cleanup(void *opaque)
     }
 }
 
+static void vfio_save_pending(QEMUFile *f, void *opaque,
+                              uint64_t threshold_size,
+                              uint64_t *res_precopy_only,
+                              uint64_t *res_compatible,
+                              uint64_t *res_postcopy_only)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    ret = vfio_update_pending(vbasedev);
+    if (ret) {
+        return;
+    }
+
+    if (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING) {
+        *res_precopy_only += migration->pending_bytes;
+    } else {
+        *res_postcopy_only += migration->pending_bytes;
+    }
+    *res_compatible += 0;
+}
+
+static int vfio_save_iterate(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
+
+    qemu_mutex_lock(&migration->lock);
+    ret = vfio_save_buffer(f, vbasedev);
+    qemu_mutex_unlock(&migration->lock);
+
+    if (ret < 0) {
+        error_report("vfio_save_buffer failed %s",
+                     strerror(errno));
+        return ret;
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    return ret;
+}
+
+static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
+    if (ret) {
+        error_report("Failed to set state STOP and SAVING");
+        return ret;
+    }
+
+    ret = vfio_save_device_config_state(f, opaque);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vfio_update_pending(vbasedev);
+    if (ret) {
+        return ret;
+    }
+
+    while (migration->pending_bytes > 0) {
+        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
+        ret = vfio_save_buffer(f, vbasedev);
+        if (ret < 0) {
+            error_report("Failed to save buffer");
+            return ret;
+        } else if (ret == 0) {
+            break;
+        }
+
+        ret = vfio_update_pending(vbasedev);
+        if (ret) {
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
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOPPED);
+    if (ret) {
+        error_report("Failed to set state STOPPED");
+        return ret;
+    }
+    return ret;
+}
+
 static SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
+    .save_live_pending = vfio_save_pending,
+    .save_live_iterate = vfio_save_iterate,
+    .save_live_complete_precopy = vfio_save_complete_precopy,
 };
 
 /* ---------------------------------------------------------------------- */
-- 
2.7.0


