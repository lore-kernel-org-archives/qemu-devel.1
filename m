Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454B1C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDDD206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4GtESMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDDD206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHF1-0001lA-VM
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH5E-00028r-Bl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:12 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH5B-0000rH-8f
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:12 -0400
Received: by mail-pg1-x543.google.com with SMTP id 5so4807520pgl.4
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GIYwSbqP2/Q+h6E6JYicJ9jGdOa2Pz7gLWfst3DCrHU=;
 b=p4GtESMYMWerGZwL2UAxtVOLl1xs2bYFU1froYHQUsRZ0zqEhN3g3r6inTHahEfis1
 ehY2Bv3VefoVoaATXSwRI/pq4K/+aZyqdY3C2d8b+yE3l2o/VE7zq65YlIOZRar9056r
 yW1lqGL8hLeDN3hAd6epEdrsEi4eQzdRkWJbKAMGVX7YbCto4P2jcWEfFAY4wXA8UESd
 vhB0DWJsM2EFi+xJ2RWMNi43SNW6Gycct6fLZOrbpKE3SXDgbzQU+XLItv3nVYHp2Ugr
 em3k9UResaqGX3+U1qHyuHskbagSx+T7gS+BE/rQa0MfG++spb8HeA0Z1Zlt2FHzPB73
 pUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GIYwSbqP2/Q+h6E6JYicJ9jGdOa2Pz7gLWfst3DCrHU=;
 b=TWMhxjEuTTX2jYxZqpGi6r/af2QzM7MoFTGV3b2LrPFQ/jXFP1QMv9kJ3SYwCGffu2
 Z3/h6SGeYv4jBoPSExASJ8Yav2SzyCzKMkU7ygYXUdpKdz3vcZ/3UyIYzSFsVjc5VLgW
 +sglxBWR7wYZxbl8EAp7tyoSEBEVU+RvsFXEvMpX5ewo4F5Q5MHQR4D7tSdpwIHzQcT5
 EtmlMa3EuKWM7X+On9ZT0SfRzYEJUs0eEN63RSNa2ioPcM+ldpdqSGM0K+YUR0gU3wU4
 Dc2TnIXn68NbspsO4xlX16UxCQl9CQvWyUm+MJesw+WsVWgsoK/VoKswaEgjoBvR2Qhh
 GYRA==
X-Gm-Message-State: AOAM530P3J/erHWdVxGWZ8Gmw6bEowUXmqO3FH4VtIuyIag+e+0bNi0r
 N3arT4AESVFIdopZMq1eVlpGqeBo4OXJdQ==
X-Google-Smtp-Source: ABdhPJyFDmRysfD4Lf6OBRZkJJb1txyerFF5nv8vGkI9ZBknGlrdYriofspjrNuqQaAx2D1Vp543WA==
X-Received: by 2002:a63:4c:: with SMTP id 73mr8526187pga.286.1599246547136;
 Fri, 04 Sep 2020 12:09:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:09:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/19] target/microblaze: Move mmu parameters to
 MicroBlazeCPUConfig
Date: Fri,  4 Sep 2020 12:08:39 -0700
Message-Id: <20200904190842.2282109-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The final 4 fields in MicroBlazeMMU are configuration constants.
Move them into MicroBlazeCPUConfig where they belong.

Remove the leading "c_" from the member names, as that presumably
implied "config", and that should not be explicit in the location.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h    |  5 +++++
 target/microblaze/mmu.h    |  7 +------
 target/microblaze/cpu.c    |  9 +++++----
 target/microblaze/helper.c |  4 ++--
 target/microblaze/mmu.c    | 30 +++++++++++++++++-------------
 5 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index ef96f2fe02..b54f99da61 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -295,6 +295,8 @@ struct CPUMBState {
 typedef struct {
     char *version;
 
+    uint64_t addr_mask;
+
     uint32_t base_vectors;
     uint32_t pvr_user2;
     uint32_t pvr_regs[13];
@@ -304,6 +306,9 @@ typedef struct {
     uint8_t use_hw_mul;
     uint8_t pvr_user1;
     uint8_t pvr;
+    uint8_t mmu;
+    uint8_t mmu_tlb_access;
+    uint8_t mmu_zones;
 
     bool stackprot;
     bool use_barrel;
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index c1feb811b9..7d0fbb8341 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -70,11 +70,6 @@ typedef struct {
     uint8_t tids[TLB_ENTRIES];
     /* Control flops.  */
     uint32_t regs[3];
-
-    int c_mmu;
-    int c_mmu_tlb_access;
-    int c_mmu_zones;
-    uint64_t c_addr_mask; /* Mask to apply to physical addresses.  */
 } MicroBlazeMMU;
 
 typedef struct {
@@ -88,7 +83,7 @@ typedef struct {
     } err;
 } MicroBlazeMMULookup;
 
-unsigned int mmu_translate(MicroBlazeMMU *mmu, MicroBlazeMMULookup *lu,
+unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
                            target_ulong vaddr, int rw, int mmu_idx);
 uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
 void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index b9bb7f0cc7..fde646a7ad 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -135,10 +135,6 @@ static void mb_cpu_reset(DeviceState *dev)
 #else
     mb_cpu_write_msr(env, 0);
     mmu_init(&env->mmu);
-    env->mmu.c_mmu = 3;
-    env->mmu.c_mmu_tlb_access = 3;
-    env->mmu.c_mmu_zones = 16;
-    env->mmu.c_addr_mask = MAKE_64BIT_MASK(0, cpu->cfg.addr_size);
 #endif
 }
 
@@ -232,6 +228,11 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     cpu->cfg.pvr_regs[11] = ((cpu->cfg.use_mmu ? PVR11_USE_MMU : 0) |
                              16 << 17);
 
+    cpu->cfg.mmu = 3;
+    cpu->cfg.mmu_tlb_access = 3;
+    cpu->cfg.mmu_zones = 16;
+    cpu->cfg.addr_mask = MAKE_64BIT_MASK(0, cpu->cfg.addr_size);
+
     mcc->parent_realize(dev, errp);
 }
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index c9f236c897..3d6ce1b31b 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -64,7 +64,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         return true;
     }
 
-    hit = mmu_translate(&env->mmu, &lu, address, access_type, mmu_idx);
+    hit = mmu_translate(cpu, &lu, address, access_type, mmu_idx);
     if (likely(hit)) {
         uint32_t vaddr = address & TARGET_PAGE_MASK;
         uint32_t paddr = lu.paddr + vaddr - lu.vaddr;
@@ -240,7 +240,7 @@ hwaddr mb_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     unsigned int hit;
 
     if (mmu_idx != MMU_NOMMU_IDX) {
-        hit = mmu_translate(&env->mmu, &lu, addr, 0, 0);
+        hit = mmu_translate(cpu, &lu, addr, 0, 0);
         if (hit) {
             vaddr = addr & TARGET_PAGE_MASK;
             paddr = lu.paddr + vaddr - lu.vaddr;
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 0546cfd0bc..1dbbb271c4 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -73,9 +73,10 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
 }
 
 /* rw - 0 = read, 1 = write, 2 = fetch.  */
-unsigned int mmu_translate(MicroBlazeMMU *mmu, MicroBlazeMMULookup *lu,
+unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
                            target_ulong vaddr, int rw, int mmu_idx)
 {
+    MicroBlazeMMU *mmu = &cpu->env.mmu;
     unsigned int i, hit = 0;
     unsigned int tlb_ex = 0, tlb_wr = 0, tlb_zsel;
     uint64_t tlb_tag, tlb_rpn, mask;
@@ -114,13 +115,13 @@ unsigned int mmu_translate(MicroBlazeMMU *mmu, MicroBlazeMMULookup *lu,
             t0 = mmu->regs[MMU_R_ZPR] >> (30 - (tlb_zsel * 2));
             t0 &= 0x3;
 
-            if (tlb_zsel > mmu->c_mmu_zones) {
+            if (tlb_zsel > cpu->cfg.mmu_zones) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "tlb zone select out of range! %d\n", tlb_zsel);
                 t0 = 1; /* Ignore.  */
             }
 
-            if (mmu->c_mmu == 1) {
+            if (cpu->cfg.mmu == 1) {
                 t0 = 1; /* Zones are disabled.  */
             }
 
@@ -157,7 +158,7 @@ unsigned int mmu_translate(MicroBlazeMMU *mmu, MicroBlazeMMULookup *lu,
             tlb_rpn = d & TLB_RPN_MASK;
 
             lu->vaddr = tlb_tag;
-            lu->paddr = tlb_rpn & mmu->c_addr_mask;
+            lu->paddr = tlb_rpn & cpu->cfg.addr_mask;
             lu->size = tlb_size;
             lu->err = ERR_HIT;
             lu->idx = i;
@@ -175,10 +176,11 @@ done:
 /* Writes/reads to the MMU's special regs end up here.  */
 uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
 {
+    MicroBlazeCPU *cpu = env_archcpu(env);
     unsigned int i;
     uint32_t r = 0;
 
-    if (env->mmu.c_mmu < 2 || !env->mmu.c_mmu_tlb_access) {
+    if (cpu->cfg.mmu < 2 || !cpu->cfg.mmu_tlb_access) {
         qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
         return 0;
     }
@@ -191,7 +193,7 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
         /* Reads to HI/LO trig reads from the mmu rams.  */
         case MMU_R_TLBLO:
         case MMU_R_TLBHI:
-            if (!(env->mmu.c_mmu_tlb_access & 1)) {
+            if (!(cpu->cfg.mmu_tlb_access & 1)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "Invalid access to MMU reg %d\n", rn);
                 return 0;
@@ -204,7 +206,7 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
             break;
         case MMU_R_PID:
         case MMU_R_ZPR:
-            if (!(env->mmu.c_mmu_tlb_access & 1)) {
+            if (!(cpu->cfg.mmu_tlb_access & 1)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "Invalid access to MMU reg %d\n", rn);
                 return 0;
@@ -227,12 +229,14 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
 
 void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
 {
+    MicroBlazeCPU *cpu = env_archcpu(env);
     uint64_t tmp64;
     unsigned int i;
+
     qemu_log_mask(CPU_LOG_MMU,
                   "%s rn=%d=%x old=%x\n", __func__, rn, v, env->mmu.regs[rn]);
 
-    if (env->mmu.c_mmu < 2 || !env->mmu.c_mmu_tlb_access) {
+    if (cpu->cfg.mmu < 2 || !cpu->cfg.mmu_tlb_access) {
         qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
         return;
     }
@@ -258,7 +262,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
             env->mmu.rams[rn & 1][i] = deposit64(tmp64, ext * 32, 32, v);
             break;
         case MMU_R_ZPR:
-            if (env->mmu.c_mmu_tlb_access <= 1) {
+            if (cpu->cfg.mmu_tlb_access <= 1) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "Invalid access to MMU reg %d\n", rn);
                 return;
@@ -272,7 +276,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
             env->mmu.regs[rn] = v;
             break;
         case MMU_R_PID:
-            if (env->mmu.c_mmu_tlb_access <= 1) {
+            if (cpu->cfg.mmu_tlb_access <= 1) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "Invalid access to MMU reg %d\n", rn);
                 return;
@@ -292,14 +296,14 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
             MicroBlazeMMULookup lu;
             int hit;
 
-            if (env->mmu.c_mmu_tlb_access <= 1) {
+            if (cpu->cfg.mmu_tlb_access <= 1) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "Invalid access to MMU reg %d\n", rn);
                 return;
             }
 
-            hit = mmu_translate(&env->mmu, &lu,
-                                v & TLB_EPN_MASK, 0, cpu_mmu_index(env, false));
+            hit = mmu_translate(cpu, &lu, v & TLB_EPN_MASK,
+                                0, cpu_mmu_index(env, false));
             if (hit) {
                 env->mmu.regs[MMU_R_TLBX] = lu.idx;
             } else {
-- 
2.25.1


