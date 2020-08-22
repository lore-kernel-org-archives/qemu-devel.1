Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53050C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7D92072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FptaG5Ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7D92072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MYa-0006Lw-8I
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MRN-0002G0-E8
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MRL-0000D0-9g
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075503; x=1629611503;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YmSIJh6vlvG3yq8+l6R6dA4Np/mPZmUlDtmcWGm/swM=;
 b=FptaG5FfeYg6kZy3urfSspcBa3lbwhbHEjUpOyTCl3hiPmdzedVZ9p+8
 ChI1l5awPYj8XZlIPbea2z6HVGKWezgKtn/6qR3vxynepT5lQ+1agELRE
 s04f5zAexKXLh6GXOPzZapicWztVnujSssWrbsCL/BmdTl6x35o7d1lAp
 HJ44AuJxAu9KcLWqb837S+5TSTRq13hCGtEwl7VRjKIQHPZjFTSQuefae
 RmBtA1dSxB4Psqx98irh5xr3RKbMTD4/pxWmzsjV89rHfbf3lfhOlZZ30
 u3pa2YhnJgF0y8U5ML2fMKvVZaKz7iLwTpT6BKE7PtofHUmOqZCrcWC/X A==;
IronPort-SDR: +TE5sVSaO0yNy774yIifZTX/KAnnjFAf+ub2tzCYlBMpLi6WzZqdXkwKRZ6vPj7VmYMoXs5KFp
 h0lvZrAbe5PdbUt1+2GnPsgM28iFjrVhESrmO08cU6bir1CrJ5Q9Ed16zXI5qyAORm1y7X1tv9
 mBhN7KO69WAxeimH/vNmzzkB6O3NwHTX0RfCkn3IWaSNMh1M0lTh86UFiZ441CKbLULAuAV5YB
 B733oDERDoaii89bOwFWDs/S57v4cHEMjmywjPD+cts72GlGOKwXEL+6Oq7YK4Z/6vu+7W6aUR
 6R8=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571970"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:21 +0800
IronPort-SDR: WGwq5BbDWCVkaWgl8a13MFpn4aQ5xoVnH7wDTOQ4fBKqlpNR7v40v5AQBPledl7f/4iz8VClCB
 HLpFnY9JilGA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:38:14 -0700
IronPort-SDR: LcMV737BALoDIVNE0HqqbhBI9zxO3xmt6au8usz8Y4IzgJaWmxANPKSgaZ9KY95iw78LzXbt8A
 vPOVEgyu+y5A==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 17/20] target/riscv: Change the TLB page size depends on PMP
 entries.
Date: Fri, 21 Aug 2020 22:40:58 -0700
Message-Id: <20200822054101.1202175-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:43:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com,
 Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zong Li <zong.li@sifive.com>

The minimum granularity of PMP is 4 bytes, it is small than 4KB page
size, therefore, the pmp checking would be ignored if its range doesn't
start from the alignment of one page. This patch detects the pmp entries
and sets the small page size to TLB if there is a PMP entry which cover
the page size.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <6b0bf48662ef26ab4c15381a08e78a74ebd7ca79.1595924470.git.zong.li@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.h        |  2 ++
 target/riscv/cpu_helper.c | 10 ++++++--
 target/riscv/pmp.c        | 52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 8e19793132..6a8f072871 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -60,5 +60,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
     target_ulong size, pmp_priv_t priv, target_ulong mode);
+bool pmp_is_range_in_tlb(CPURISCVState *env, hwaddr tlb_sa,
+                         target_ulong *tlb_size);
 
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2f337e418c..fd1d373b6f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -693,6 +693,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
+    target_ulong tlb_size = 0;
 
     env->guest_phys_fault_addr = 0;
 
@@ -784,8 +785,13 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     if (ret == TRANSLATE_SUCCESS) {
-        tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
-                     prot, mmu_idx, TARGET_PAGE_SIZE);
+        if (pmp_is_range_in_tlb(env, pa & TARGET_PAGE_MASK, &tlb_size)) {
+            tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
+                         prot, mmu_idx, tlb_size);
+        } else {
+            tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
+                         prot, mmu_idx, TARGET_PAGE_SIZE);
+        }
         return true;
     } else if (probe) {
         return false;
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index b14feeb7da..c394e867f8 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -383,3 +383,55 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 
     return val;
 }
+
+/*
+ * Calculate the TLB size if the start address or the end address of
+ * PMP entry is presented in thie TLB page.
+ */
+static target_ulong pmp_get_tlb_size(CPURISCVState *env, int pmp_index,
+                                     target_ulong tlb_sa, target_ulong tlb_ea)
+{
+    target_ulong pmp_sa = env->pmp_state.addr[pmp_index].sa;
+    target_ulong pmp_ea = env->pmp_state.addr[pmp_index].ea;
+
+    if (pmp_sa >= tlb_sa && pmp_ea <= tlb_ea) {
+        return pmp_ea - pmp_sa + 1;
+    }
+
+    if (pmp_sa >= tlb_sa && pmp_sa <= tlb_ea && pmp_ea >= tlb_ea) {
+        return tlb_ea - pmp_sa + 1;
+    }
+
+    if (pmp_ea <= tlb_ea && pmp_ea >= tlb_sa && pmp_sa <= tlb_sa) {
+        return pmp_ea - tlb_sa + 1;
+    }
+
+    return 0;
+}
+
+/*
+ * Check is there a PMP entry which range covers this page. If so,
+ * try to find the minimum granularity for the TLB size.
+ */
+bool pmp_is_range_in_tlb(CPURISCVState *env, hwaddr tlb_sa,
+                         target_ulong *tlb_size)
+{
+    int i;
+    target_ulong val;
+    target_ulong tlb_ea = (tlb_sa + TARGET_PAGE_SIZE - 1);
+
+    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+        val = pmp_get_tlb_size(env, i, tlb_sa, tlb_ea);
+        if (val) {
+            if (*tlb_size == 0 || *tlb_size > val) {
+                *tlb_size = val;
+            }
+        }
+    }
+
+    if (*tlb_size != 0) {
+        return true;
+    }
+
+    return false;
+}
-- 
2.28.0


