Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F0AC606C7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3363520644
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="esqB5lAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3363520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkZKH-0007np-Gp
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 15:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35243)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hkZCR-0005Ox-EY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hkZCP-0003Ce-Hn
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:21:19 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hkZCP-0003BL-4Q
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:21:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d2397aa0000>; Mon, 08 Jul 2019 12:21:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 08 Jul 2019 12:21:15 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 08 Jul 2019 12:21:15 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jul
 2019 19:21:15 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 8 Jul 2019 19:21:08 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Tue, 9 Jul 2019 00:47:29 +0530
Message-ID: <1562613452-24969-11-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1562613452-24969-1-git-send-email-kwankhede@nvidia.com>
References: <1562613452-24969-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1562613674; bh=yBjqmN+GS5fGXlxqrXJTMWeR6Y126MP5vM4ePZTJeIc=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=esqB5lAUakhj/SnX5Kjb69pQrWiTI8e2+uis5FJPYkekcJLhZWXebg9JTOMPrSR1L
 1fkqWpqzRbcOr1aUGS/I1bt8TMY+4e87Wb3kPu8FmQhK3rgddd5GHVzfZAbtlkImb9
 iTciirSxcDV0jCg/5h2mKDHacEukBy/uwFXxgq8pcamqjY5Sq3tZbQRD4peLDPCcpP
 eh6qx8hULKaCVxvlrm04IpQw+x+3nbKh/dF+ZTu+RgSJgU3o0U+iIPNDLhuaQmjHqB
 KytcDfc6KnyjJR8ebQwpSRnjea/qX1sXrdB315nVuRX0T5WgSKGYbe7FvJYHWyWS2p
 XfuhVEWqmkf/w==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
Subject: [Qemu-devel] [PATCH v5 10/13] vfio: Add load state functions to
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

Flow during _RESUMING device state:
- If Vendor driver defines mappable region, mmap migration region.
- Load config state.
- For data packet, till VFIO_MIG_FLAG_END_OF_STATE is not reached
    - read data_size from packet, read buffer of data_size
    - read data_offset from where QEMU should write data.
        if region is mmaped, write data of data_size to mmaped region.
    - write data_size.
        In case of mmapped region, write to data_size indicates kernel
        driver that data is written in staging buffer.
    - if region is trapped, pwrite() data of data_size from data_offset.
- Repeat above until VFIO_MIG_FLAG_END_OF_STATE.
- Unmap migration region.

For user, data is opaque. User should write data in the same order as
received.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/migration.c  | 162 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |   4 ++
 2 files changed, 166 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 4e9b4cce230b..5fb4c5329ede 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -249,6 +249,26 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
     return qemu_file_get_error(f);
 }
 
+static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    uint64_t data;
+
+    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
+        vbasedev->ops->vfio_load_config(vbasedev, f);
+    }
+
+    data = qemu_get_be64(f);
+    if (data != VFIO_MIG_FLAG_END_OF_STATE) {
+        error_report("%s: Failed loading device config space, "
+                     "end flag incorrect 0x%"PRIx64, vbasedev->name, data);
+        return -EINVAL;
+    }
+
+    trace_vfio_load_device_config_state(vbasedev->name);
+    return qemu_file_get_error(f);
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_setup(QEMUFile *f, void *opaque)
@@ -421,12 +441,154 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     return ret;
 }
 
+static int vfio_load_setup(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret = 0;
+
+    if (migration->region.buffer.mmaps) {
+        ret = vfio_region_mmap(&migration->region.buffer);
+        if (ret) {
+            error_report("%s: Failed to mmap VFIO migration region %d: %s",
+                         vbasedev->name, migration->region.index,
+                         strerror(-ret));
+            return ret;
+        }
+    }
+
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING);
+    if (ret) {
+        error_report("%s: Failed to set state RESUMING", vbasedev->name);
+    }
+    return ret;
+}
+
+static int vfio_load_cleanup(void *opaque)
+{
+    vfio_save_cleanup(opaque);
+    return 0;
+}
+
+static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret = 0;
+    uint64_t data, data_size;
+
+    data = qemu_get_be64(f);
+    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
+
+        trace_vfio_load_state(vbasedev->name, data);
+
+        switch (data) {
+        case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
+        {
+            ret = vfio_load_device_config_state(f, opaque);
+            if (ret) {
+                return ret;
+            }
+            break;
+        }
+        case VFIO_MIG_FLAG_DEV_SETUP_STATE:
+        {
+            data = qemu_get_be64(f);
+            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
+                return ret;
+            } else {
+                error_report("%s: SETUP STATE: EOS not found 0x%"PRIx64,
+                             vbasedev->name, data);
+                return -EINVAL;
+            }
+            break;
+        }
+        case VFIO_MIG_FLAG_DEV_DATA_STATE:
+        {
+            VFIORegion *region = &migration->region.buffer;
+            void *buf = NULL;
+            bool buffer_mmaped = false;
+            uint64_t data_offset = 0;
+
+            data_size = qemu_get_be64(f);
+            if (data_size == 0) {
+                break;
+            }
+
+            ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
+                        region->fd_offset +
+                        offsetof(struct vfio_device_migration_info,
+                        data_offset));
+            if (ret != sizeof(data_offset)) {
+                error_report("%s:Failed to get migration buffer data offset %d",
+                             vbasedev->name, ret);
+                return -EINVAL;
+            }
+
+            if (region->mmaps) {
+                buf = find_data_region(region, data_offset, data_size);
+            }
+
+            buffer_mmaped = (buf != NULL) ? true : false;
+
+            if (!buffer_mmaped) {
+                buf = g_try_malloc0(data_size);
+                if (!buf) {
+                    error_report("%s: Error allocating buffer ", __func__);
+                    return -ENOMEM;
+                }
+            }
+
+            qemu_get_buffer(f, buf, data_size);
+
+            ret = pwrite(vbasedev->fd, &data_size, sizeof(data_size),
+                         region->fd_offset +
+                       offsetof(struct vfio_device_migration_info, data_size));
+            if (ret != sizeof(data_size)) {
+                error_report("%s: Failed to set migration buffer data size %d",
+                             vbasedev->name, ret);
+                if (!buffer_mmaped) {
+                    g_free(buf);
+                }
+                return -EINVAL;
+            }
+
+            if (!buffer_mmaped) {
+                ret = pwrite(vbasedev->fd, buf, data_size,
+                             region->fd_offset + data_offset);
+                g_free(buf);
+
+                if (ret != data_size) {
+                    error_report("%s: Failed to set migration buffer %d",
+                                 vbasedev->name, ret);
+                    return -EINVAL;
+                }
+            }
+            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
+                                              data_size);
+            break;
+        }
+        }
+
+        ret = qemu_file_get_error(f);
+        if (ret) {
+            return ret;
+        }
+        data = qemu_get_be64(f);
+    }
+
+    return ret;
+}
+
 static SaveVMHandlers savevm_vfio_handlers = {
     .save_setup = vfio_save_setup,
     .save_cleanup = vfio_save_cleanup,
     .save_live_pending = vfio_save_pending,
     .save_live_iterate = vfio_save_iterate,
     .save_live_complete_precopy = vfio_save_complete_precopy,
+    .load_setup = vfio_load_setup,
+    .load_cleanup = vfio_load_cleanup,
+    .load_state = vfio_load_state,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 4c16e787f5a1..e01c94e6ebd4 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -157,3 +157,7 @@ vfio_save_device_config_state(char *name) " (%s)"
 vfio_save_pending(char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s), precopy 0x%"PRIx64" postcopy 0x%x"PRIx64" compatible 0x%""PRIx64
 vfio_save_iterate(char *name, int data_size) " (%s) data_size %d"
 vfio_save_complete_precopy(char *name) " (%s)"
+vfio_load_device_config_state(char *name) " (%s)"
+vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
+vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s), Offset 0x%"PRIx64" size 0x%"PRIx64
+
-- 
2.7.0


