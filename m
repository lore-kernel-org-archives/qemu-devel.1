Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ABDC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024F321D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HOlI6UeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024F321D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzZD-0003qb-Vi
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyzB-0004Ns-BL
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:28:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyz0-0001Y4-S6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466878; x=1635002878;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5LshL2NkcHA1RDGV9snQE3sw9voWmOvgUlT4WW/q4e0=;
 b=HOlI6UeF90UAztDeBaJm/b+5NEFlGPJyllPKtPPIgyvxVM9UjRGU0Iia
 3fnyaTwBB0r6iKtnTWzdaDLvFk6bRPBy7e41WSop6Qscnof9AJkyTmuzP
 H+0670s3DLeuXK5RecOdD4pwAIv1TGE4blz4e2fbNqUl6cxRcVjXzPDNs
 1xI/5fZPzYM6APpeq0c76sRysJxXwWbsF70P2GEZV1d4+48r9wsxACOyl
 ZMDHsh3ZuxPHu2P5qiphnItFFq5c9q6LYHoQ8YcKWUbVJ/Q5mZAygmiaL
 Skew3l3ksEEGIo7/DLpQ0YoDry2xtxIe30CrbDSqBnbr40ztrQ2VDpNtu w==;
IronPort-SDR: 9GdCm0geRiWfAv7p+gTGpiPuFQSVtsnrp1++bP/FJKCLwgRvD3b9QpMx7mnZ5HpKFk4t+1f+rN
 z0auT74gd/EnK+U/44mjjj1PZsMTWeyUderp7Bwq1+zZR8mPSQo058/pP5Z+MXlgbH2iGkZCrm
 CrxmWTjkccBNbxTRSLYixnFS/J7bsNlwbqPnFu0UClg1smvUuxbMCudSAYOfI+5R+uPhx8kFvI
 YkYgPswivvgyK14zKtBeytBiYf+Q85BhrGH7tulp+9bh8x7dU3mJcmSJBplOfnkZW+SGdyALRw
 1O4=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652326"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:45 +0800
IronPort-SDR: UxWvT9DUC+oLSgQ0HQwN8Hk2yV48mQnsDKglEm0FLF7O8/i9RYxd5SI9DqGIdazq7JTcpXwgHg
 l3+CUtNH0Qc60B22v61EF/BPjX3n7dNmWU0SFTxA6OSctqoXXTzCC0qULR2oOvvER+GK2CPd9b
 Z8koTpWYBrnMoZIlu3o0X/UQHR0lHi7KJGMAB2yUVpVS/E2/g20uBTrW/A59buj2K8jmBgD4i0
 jGa+YoLBBS1VLlfzGIbukVzm7A/6mBR+udskPPO90qRDybJ/8KqCsdSVYLCoTxgeXirmMyydDH
 Huo1hCLA1WTNNjkRyFJzmFGq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:13:00 -0700
IronPort-SDR: zc6MpyBZw7AP1W4jEM4xryJatBXrK2SrJcenL4QGN5jVnf/DRIOojpyDrBFcUYhIZxE4nxmg72
 jRTxqG6QMZI8W3oUPPSRfb69b7Atw7RBbCQxBD9REoiDtMmHQC0hAky7KG6U9TzZmYy6VQ/L1K
 cJwbWsLISKUz+f5zxFQtHNdGr9YQo2/Vh1HJ3P1HxeMxxfiWmmDa9EUXlhbSvZLKU0FZUH5Ybo
 bHQ7j1qkKVrxYxYIULHq5+abLEU26WYPNJk7H5wzJJF9mbdXp3ySN6/rAQ80Xtsx6KjdVYN243
 82E=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 10/12] target/riscv: raise exception to HS-mode at
 get_physical_address
Date: Fri, 23 Oct 2020 08:16:17 -0700
Message-Id: <20201023151619.3175155-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Yifei Jiang <jiangyifei@huawei.com>, Yipeng Yin <yinyipeng1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yifei Jiang <jiangyifei@huawei.com>

VS-stage translation at get_physical_address needs to translate pte
address by G-stage translation. But the G-stage translation error
can not be distinguished from VS-stage translation error in
riscv_cpu_tlb_fill. On migration, destination needs to rebuild pte,
and this G-stage translation error must be handled by HS-mode. So
introduce TRANSLATE_STAGE2_FAIL so that riscv_cpu_tlb_fill could
distinguish and raise it to HS-mode.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201014101728.848-1-jiangyifei@huawei.com
[ Change by AF:
 - Clarify the fault_pte_addr shift
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 10 +++++++---
 target/riscv/cpu_helper.c | 36 +++++++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de275782e6..de4705bb57 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -82,9 +82,13 @@ enum {
 
 #define VEXT_VERSION_0_07_1 0x00000701
 
-#define TRANSLATE_PMP_FAIL 2
-#define TRANSLATE_FAIL 1
-#define TRANSLATE_SUCCESS 0
+enum {
+    TRANSLATE_SUCCESS,
+    TRANSLATE_FAIL,
+    TRANSLATE_PMP_FAIL,
+    TRANSLATE_G_STAGE_FAIL
+};
+
 #define MMU_USER_IDX 3
 
 #define MAX_RISCV_PMPS (16)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f363c1013c..4652082df1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -316,6 +316,9 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
  * @physical: This will be set to the calculated physical address
  * @prot: The returned protection attributes
  * @addr: The virtual address to be translated
+ * @fault_pte_addr: If not NULL, this will be set to fault pte address
+ *                  when a error occurs on pte address translation.
+ *                  This will already be shifted to match htval.
  * @access_type: The type of MMU access
  * @mmu_idx: Indicates current privilege level
  * @first_stage: Are we in first stage translation?
@@ -324,6 +327,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
  */
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *prot, target_ulong addr,
+                                target_ulong *fault_pte_addr,
                                 int access_type, int mmu_idx,
                                 bool first_stage, bool two_stage)
 {
@@ -447,11 +451,14 @@ restart:
 
             /* Do the second stage translation on the base PTE address. */
             int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
-                                                 base, MMU_DATA_LOAD,
+                                                 base, NULL, MMU_DATA_LOAD,
                                                  mmu_idx, false, true);
 
             if (vbase_ret != TRANSLATE_SUCCESS) {
-                return vbase_ret;
+                if (fault_pte_addr) {
+                    *fault_pte_addr = (base + idx * ptesize) >> 2;
+                }
+                return TRANSLATE_G_STAGE_FAIL;
             }
 
             pte_addr = vbase + idx * ptesize;
@@ -632,13 +639,13 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(env, &phys_addr, &prot, addr, 0, mmu_idx,
+    if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
                              true, riscv_cpu_virt_enabled(env))) {
         return -1;
     }
 
     if (riscv_cpu_virt_enabled(env)) {
-        if (get_physical_address(env, &phys_addr, &prot, phys_addr,
+        if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
                                  0, mmu_idx, false, true)) {
             return -1;
         }
@@ -727,19 +734,30 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (riscv_cpu_virt_enabled(env) ||
         (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH)) {
         /* Two stage lookup */
-        ret = get_physical_address(env, &pa, &prot, address, access_type,
+        ret = get_physical_address(env, &pa, &prot, address,
+                                   &env->guest_phys_fault_addr, access_type,
                                    mmu_idx, true, true);
 
+        /*
+         * A G-stage exception may be triggered during two state lookup.
+         * And the env->guest_phys_fault_addr has already been set in
+         * get_physical_address().
+         */
+        if (ret == TRANSLATE_G_STAGE_FAIL) {
+            first_stage_error = false;
+            access_type = MMU_DATA_LOAD;
+        }
+
         qemu_log_mask(CPU_LOG_MMU,
                       "%s 1st-stage address=%" VADDR_PRIx " ret %d physical "
                       TARGET_FMT_plx " prot %d\n",
                       __func__, address, ret, pa, prot);
 
-        if (ret != TRANSLATE_FAIL) {
+        if (ret == TRANSLATE_SUCCESS) {
             /* Second stage lookup */
             im_address = pa;
 
-            ret = get_physical_address(env, &pa, &prot2, im_address,
+            ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
                                        access_type, mmu_idx, false, true);
 
             qemu_log_mask(CPU_LOG_MMU,
@@ -768,8 +786,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     } else {
         /* Single stage lookup */
-        ret = get_physical_address(env, &pa, &prot, address, access_type,
-                                   mmu_idx, true, false);
+        ret = get_physical_address(env, &pa, &prot, address, NULL,
+                                   access_type, mmu_idx, true, false);
 
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " ret %d physical "
-- 
2.28.0


