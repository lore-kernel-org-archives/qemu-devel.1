Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7654C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8025C208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8025C208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbCB-0001IS-Nu
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1kBbBL-0000FW-Ah
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:00:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4718 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1kBbBC-0000Ij-VO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:00:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9376652ABFFF29C696DA;
 Fri, 28 Aug 2020 18:00:05 +0800 (CST)
Received: from localhost (10.174.149.106) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 28 Aug 2020
 17:59:56 +0800
From: Wang Xin <wangxinxin.wang@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/2] memory: Allow a MemoryRegion to be marked no_vhost
Date: Fri, 28 Aug 2020 17:59:52 +0800
Message-ID: <20200828095953.2276-2-wangxinxin.wang@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200828095953.2276-1-wangxinxin.wang@huawei.com>
References: <20200828095953.2276-1-wangxinxin.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.149.106]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=wangxinxin.wang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 06:00:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Wang Xin <wangxinxin.wang@huawei.com>, jianjay.zhou@huawei.com,
 weidong.huang@huawei.com, dgilbert@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow a memory region to be marked as 'no_vhost' and
exclude that region from vhost's list build.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>
---
 hw/virtio/vhost.c     |  5 ++++-
 include/exec/memory.h | 21 +++++++++++++++++++++
 softmmu/memory.c      | 15 +++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e7a6..bd50532a30 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -415,7 +415,10 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
 {
     MemoryRegion *mr = section->mr;
 
-    if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
+    if (memory_region_is_ram(mr) &&
+        !memory_region_is_rom(mr) &&
+        !memory_region_is_no_vhost(mr)) {
+
         uint8_t dirty_mask = memory_region_get_dirty_log_mask(mr);
         uint8_t handled_dirty;
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0cfe987ab4..7258fd6996 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -380,6 +380,7 @@ struct MemoryRegion {
     bool global_locking;
     uint8_t dirty_log_mask;
     bool is_iommu;
+    bool no_vhost;
     RAMBlock *ram_block;
     Object *owner;
 
@@ -1205,6 +1206,26 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
     return mr->rom_device && mr->romd_mode;
 }
 
+/**
+ * memory_region_set_no_vhost: Make vhost ignore a memory region
+ *
+ * Makes vhost ignore a memory region, useful if it isn't real
+ * DMAble memory and is at inconvenient addresses
+ *
+ * @mr: the region being updated.
+ * @no_vhost: true to ignore
+ */
+void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost);
+
+/**
+ * memory_region_is_no_vhost: Test if memory region is marked no vhost
+ *
+ * Test if the no_vhost flag is set on the memory region
+ *
+ * @mr: the region being tested.
+ */
+bool memory_region_is_no_vhost(const MemoryRegion *mr);
+
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
  *
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 70b93104e8..5debe22978 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -2125,6 +2125,21 @@ void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
     }
 }
 
+void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost)
+{
+    if (mr->no_vhost != no_vhost) {
+        memory_region_transaction_begin();
+        mr->no_vhost = no_vhost;
+        memory_region_update_pending |= mr->enabled;
+        memory_region_transaction_commit();
+    }
+}
+
+bool memory_region_is_no_vhost(const MemoryRegion *mr)
+{
+    return mr->no_vhost;
+}
+
 void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
                                hwaddr size, unsigned client)
 {
-- 
2.26.0.windows.1



