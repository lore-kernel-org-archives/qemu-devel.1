Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2023C606CA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D0F217D6
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KHYsY8KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D0F217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkZDA-00065F-Ts
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 15:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1hkZBZ-0004Wq-3r
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1hkZBX-0002QS-Q7
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:20:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1hkZBX-0002NY-Gb
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:20:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d23976f0000>; Mon, 08 Jul 2019 12:20:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 08 Jul 2019 12:20:20 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 08 Jul 2019 12:20:20 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jul
 2019 19:20:20 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jul
 2019 19:20:19 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 8 Jul 2019 19:20:13 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Tue, 9 Jul 2019 00:47:21 +0530
Message-ID: <1562613452-24969-3-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1562613452-24969-1-git-send-email-kwankhede@nvidia.com>
References: <1562613452-24969-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1562613616; bh=nylc0cVMKEEnjbH8m1Te0YQIduVRuoNb4byY+ts2y18=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=KHYsY8KSfUKhr7ShmghgbIvdjsGbyJElhGfTXqby7ywytDT3KRqL3ntMuK42Ow0FN
 b/vQ0f+sngHhWRPL3p6QWY/FlO9jYg5Mxjgw1C9t50BqX/cIHggBlv+waY/XOFfdU4
 tevkXTnp5kIaG9C5sQu/xBhTxXZW4lz+0xaenWOsL8fF8QS+uEeAz/sqXMlxYWZZ64
 tqAytSbDkBFiGY2A4BKNRuuZL/JTrxVmzpJSDDxTt2PhIA57Um2MGQ7vPswaA/9PzH
 DNNKdJlUHhsVaksDVXIxazSmpBXSV5hi6Hb9vKrkbRmsLi5mSWhZ21b1rVinW2ICn2
 Ma8iVGxD2HaPQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: [Qemu-devel] [PATCH v5 02/13] vfio: Add function to unmap VFIO
 region
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

This function is used in follwing patch in this series.
Migration region is mmaped when migration starts and will be unmapped when
migration is complete.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/common.c              | 20 ++++++++++++++++++++
 hw/vfio/trace-events          |  1 +
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a859298fdad9..de74dae8d6a6 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -964,6 +964,26 @@ int vfio_region_mmap(VFIORegion *region)
     return 0;
 }
 
+void vfio_region_unmap(VFIORegion *region)
+{
+    int i;
+
+    if (!region->mem) {
+        return;
+    }
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        trace_vfio_region_unmap(memory_region_name(&region->mmaps[i].mem),
+                                region->mmaps[i].offset,
+                                region->mmaps[i].offset +
+                                region->mmaps[i].size - 1);
+        memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
+        munmap(region->mmaps[i].mmap, region->mmaps[i].size);
+        object_unparent(OBJECT(&region->mmaps[i].mem));
+        region->mmaps[i].mmap = NULL;
+    }
+}
+
 void vfio_region_exit(VFIORegion *region)
 {
     int i;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1ef55a33ffd..8cdc27946cb8 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -111,6 +111,7 @@ vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Reg
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
 vfio_region_finalize(const char *name, int index) "Device %s, region %d"
 vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
+vfio_region_unmap(const char *name, unsigned long offset, unsigned long end) "Region %s unmap [0x%lx - 0x%lx]"
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9107bd41c030..93493891ba40 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -171,6 +171,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
+void vfio_region_unmap(VFIORegion *region);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
-- 
2.7.0


