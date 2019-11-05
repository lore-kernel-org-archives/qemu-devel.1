Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C9DC5DF61
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5503214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAYHjiPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5503214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS8Zx-0003oW-VK
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 18:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8SP-0005tR-LN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8SO-0004lp-6r
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:53 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iS8SO-0004lW-13
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:52 -0500
Received: by mail-wr1-x443.google.com with SMTP id q13so23570831wrs.12
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8lNKiTvXzplhNbh/GcJVZyL/fynA0fCPHUNuHIruE/g=;
 b=qAYHjiPaen2PldMQMuyzz31BaZEpScWhl3dgB5BGybuKI7BOpksA4pcEHY1ywJyg6L
 NqCVBxb3H9Q1Dkxjfjx6pZa3xOK6oCyiA8e00qdtiA7Uy1knGa0PbVsdfS+g7CdAvjW7
 b/g61P+spe/jiqJRAZhLC4cscWJGn2z5TUFjDeywoLzNyqIAG8MWDVGcElV4u9m6dFGo
 Ul85U6nRz+/OEbJOQ4A+8b3kBg+9/NXSHZUc5ck92vLbSp4UgUok0ve7mEGQlV1FTV/a
 w3pxRhRCdhYLDsguJEpR8csZlFEDWspMCLYokUVHE0nhobMvgAJLk3atnZSuyzsgkni+
 9Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8lNKiTvXzplhNbh/GcJVZyL/fynA0fCPHUNuHIruE/g=;
 b=rguESLH+PLDxQuEncsxkjtKgPq3d+3PHEXp2gAtMTK0ttinrwQuH6uLwlcOb6W16+X
 gC0cNoz8W7PYu4NRoJwOBipkc7pU0mLrRLq1iG8b9Z2lDGAL7C4PMQGrLDeR1HyZT/yT
 rT1+fD5A7eCvLzEL2ou3E8eIkZbvQ6jv1edbFC7Wq+GKIxaWq8AAqOevQoc+J1bOoX2w
 zaFRusaLNEYnh6xNprWpYu6f1c2aypxuYsMgOEAqJjjRbEpuHM7YL7eeq036E0eJZ8pi
 +700CliHJXwMgmsd9GLOWNWj/8D5BBiVvzoWNR0x1ap646y5eastDrW0PCDZzFmxf4N7
 Utnw==
X-Gm-Message-State: APjAAAWMEMjQnusUb1n0nAkZzwUFefUMg9R+QAsiejKXnSVouQaaVcWq
 iW/pzfnwogk0ULANWWMSPjahN6dY6TTrzQ==
X-Google-Smtp-Source: APXvYqwt9r6dQ0PzrUZBPgiZSJtTuB7gsK8Ja4/pTzruE816FfKjnKiaAL2FHWDCKJeUmE6481yUwg==
X-Received: by 2002:adf:9044:: with SMTP id h62mr31518193wrh.91.1572997310898; 
 Tue, 05 Nov 2019 15:41:50 -0800 (PST)
Received: from moi-limbo-9350.home
 (host86-144-13-94.range86-144.btcentralplus.com. [86.144.13.94])
 by smtp.gmail.com with ESMTPSA id q25sm27295010wra.3.2019.11.05.15.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 15:41:50 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] target/arm: Add support for DC CVAP & DC CVADP ins
Date: Tue,  5 Nov 2019 23:41:00 +0000
Message-Id: <20191105234100.22052-5-beata.michalska@linaro.org>
In-Reply-To: <20191105234100.22052-1-beata.michalska@linaro.org>
References: <20191105234100.22052-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, richard.henderson@linaro.org,
 dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ARMv8.2 introduced support for Data Cache Clean instructions
to PoP (point-of-persistence) - DC CVAP and PoDP (point-of-deep-persistence)
- DV CVADP. Both specify conceptual points in a memory system where all writes
that are to reach them are considered persistent.
The support provided considers both to be actually the same so there is no
distinction between the two. If none is available (there is no backing store
for given memory) both will result in Data Cache Clean up to the point of
coherency. Otherwise sync for the specified range shall be performed.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 linux-user/elfload.c |  2 ++
 target/arm/cpu.h     | 10 ++++++++++
 target/arm/cpu64.c   |  1 +
 target/arm/helper.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6693e5..07b16cc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -656,6 +656,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
     GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
+    GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
 
     return hwcaps;
 }
@@ -665,6 +666,7 @@ static uint32_t get_elf_hwcap2(void)
     ARMCPU *cpu = ARM_CPU(thread_cpu);
     uint32_t hwcaps = 0;
 
+    GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
     GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e1a66a2..0dc22c6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3617,6 +3617,16 @@ static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) != 0;
 }
 
+static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
+}
+
+static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >= 2;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 68baf04..e6a033e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -661,6 +661,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index be67e2c..00c72e4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5924,6 +5924,52 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
     REGINFO_SENTINEL
 };
+
+#ifndef CONFIG_USER_ONLY
+static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
+                          uint64_t value)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    /* CTR_EL0 System register -> DminLine, bits [19:16] */
+    uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
+    uint64_t vaddr_in = (uint64_t) value;
+    uint64_t vaddr = vaddr_in & ~(dline_size - 1);
+    void *haddr;
+    int mem_idx = cpu_mmu_index(env, false);
+
+    /* This won't be crossing page boundaries */
+    haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
+    if (haddr) {
+
+        ram_addr_t offset;
+        MemoryRegion *mr;
+
+        /* RCU lock is already being held */
+        mr = memory_region_from_host(haddr, &offset);
+
+        if (mr) {
+            memory_region_do_writeback(mr, offset, dline_size);
+        }
+    }
+}
+
+static const ARMCPRegInfo dcpop_reg[] = {
+    { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
+      .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .accessfn = aa64_cacheop_access, .writefn = dccvap_writefn },
+    REGINFO_SENTINEL
+};
+
+static const ARMCPRegInfo dcpodp_reg[] = {
+    { .name = "DC_CVADP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 1,
+      .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .accessfn = aa64_cacheop_access, .writefn = dccvap_writefn },
+    REGINFO_SENTINEL
+};
+#endif /*CONFIG_USER_ONLY*/
+
 #endif
 
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6884,6 +6930,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rndr, cpu)) {
         define_arm_cp_regs(cpu, rndr_reginfo);
     }
+#ifndef CONFIG_USER_ONLY
+    /* Data Cache clean instructions up to PoP */
+    if (cpu_isar_feature(aa64_dcpop, cpu)) {
+        define_one_arm_cp_reg(cpu, dcpop_reg);
+
+        if (cpu_isar_feature(aa64_dcpodp, cpu)) {
+            define_one_arm_cp_reg(cpu, dcpodp_reg);
+        }
+    }
+#endif /*CONFIG_USER_ONLY*/
 #endif
 
     /*
-- 
2.7.4


