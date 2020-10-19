Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA875C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB9321741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB9321741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpVV-0002u5-2e
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQt-00060h-37; Tue, 20 Oct 2020 07:03:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38654 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQp-0006mv-Se; Tue, 20 Oct 2020 07:03:58 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A6CCB55C9628D24EB3C0;
 Tue, 20 Oct 2020 19:03:49 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:41 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 04/10] hw/intc/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:17 +0800
Message-ID: <20201019203023.658555-5-ganqixin@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201019203023.658555-1-ganqixin@huawei.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:03:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, f4bug@amsat.org,
 alistair.francis@wdc.com, Gan Qixin <ganqixin@huawei.com>,
 kuhn.chenqun@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using scripts/checkpatch.pl, it is found that many files in hw/intc/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/intc/apic.c           | 3 ++-
 hw/intc/arm_gic.c        | 5 +++--
 hw/intc/arm_gic_common.c | 3 ++-
 hw/intc/ioapic.c         | 3 ++-
 hw/intc/xics.c           | 3 ++-
 hw/intc/xics_kvm.c       | 3 ++-
 6 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index b6a05e5439..89c2558f78 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -426,7 +426,8 @@ static void apic_eoi(APICCommonState *s)
     if (isrv < 0)
         return;
     apic_reset_bit(s->isr, isrv);
-    if (!(s->spurious_vec & APIC_SV_DIRECTED_IO) && apic_get_bit(s->tmr, isrv)) {
+    if (!(s->spurious_vec & APIC_SV_DIRECTED_IO) &&
+        apic_get_bit(s->tmr, isrv)) {
         ioapic_eoi_broadcast(isrv);
     }
     apic_sync_vapic(s, SYNC_FROM_VAPIC | SYNC_TO_VAPIC);
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index c60dc6b5e6..7580ef25c1 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1976,8 +1976,9 @@ static MemTxResult gic_hyp_write(void *opaque, int cpu, hwaddr addr,
     return MEMTX_OK;
 }
 
-static MemTxResult gic_thiscpu_hyp_read(void *opaque, hwaddr addr, uint64_t *data,
-                                    unsigned size, MemTxAttrs attrs)
+static MemTxResult gic_thiscpu_hyp_read(void *opaque, hwaddr addr,
+                                        uint64_t *data, unsigned size,
+                                        MemTxAttrs attrs)
 {
     GICState *s = (GICState *)opaque;
 
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 7b44d5625b..337ef239be 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -87,7 +87,8 @@ static const VMStateDescription vmstate_gic_virt_state = {
         /* Virtual CPU interfaces */
         VMSTATE_UINT32_SUB_ARRAY(cpu_ctlr, GICState, GIC_NCPU, GIC_NCPU),
         VMSTATE_UINT16_SUB_ARRAY(priority_mask, GICState, GIC_NCPU, GIC_NCPU),
-        VMSTATE_UINT16_SUB_ARRAY(running_priority, GICState, GIC_NCPU, GIC_NCPU),
+        VMSTATE_UINT16_SUB_ARRAY(running_priority, GICState, GIC_NCPU,
+                                 GIC_NCPU),
         VMSTATE_UINT16_SUB_ARRAY(current_pending, GICState, GIC_NCPU, GIC_NCPU),
         VMSTATE_UINT8_SUB_ARRAY(bpr, GICState, GIC_NCPU, GIC_NCPU),
         VMSTATE_UINT8_SUB_ARRAY(abpr, GICState, GIC_NCPU, GIC_NCPU),
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index bca71b5934..68d5548fd9 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -237,7 +237,8 @@ void ioapic_eoi_broadcast(int vector)
             entry = s->ioredtbl[n];
 
             if ((entry & IOAPIC_VECTOR_MASK) != vector ||
-                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) != IOAPIC_TRIGGER_LEVEL) {
+                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=
+                IOAPIC_TRIGGER_LEVEL) {
                 continue;
             }
 
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 68f9d44feb..c1bee454b5 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -322,7 +322,8 @@ static void icp_realize(DeviceState *dev, Error **errp)
         break;
 
     default:
-        error_setg(errp, "XICS interrupt controller does not support this CPU bus model");
+        error_setg(errp, "XICS interrupt controller does not support this "
+                   "CPU bus model");
         return;
     }
 
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 68bb1914b9..a8a2327062 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -400,7 +400,8 @@ int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers,
     /* Create the KVM XICS device */
     rc = kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
     if (rc < 0) {
-        error_setg_errno(&local_err, -rc, "Error on KVM_CREATE_DEVICE for XICS");
+        error_setg_errno(&local_err, -rc,
+                         "Error on KVM_CREATE_DEVICE for XICS");
         goto fail;
     }
 
-- 
2.23.0


