Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16910C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F2D206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avq5xsVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F2D206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igohU-0003fE-Ny
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFz-00087V-Dx
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFy-0000EL-4d
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:43 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFx-0000C6-T0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:42 -0500
Received: by mail-wm1-x341.google.com with SMTP id b19so6250900wmj.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Bswh7/qVNoTMhX0s3zAgFkoXBHOrNaofcX0A6vxQIhI=;
 b=avq5xsVze4WGr53rNg2Mf0yzs/1RYk6MPUmTe3hz9UgkWmA9wk5EsulS6QIg3TPNon
 SnTLFZGpY5m7CiCDPNdCMadkhf4DDX0AweSCAz5aiznXlU7WQ78SbDT7ZqCTVHPl5zrX
 +6cf7yBjKqRSkPnfmJx81rFuQAIrkLo119DTZARVQqGfGeWMcmZissnRW6uqKDegSbi+
 +RoolCx7tDUMKGuBYzO1PwtnjmNYVoi2V6UX7hB//M4j0Wpa/3OFdL17sIQCOKp7IQEr
 lPj0r5pDp+KjfJktSYUcJ2qBJGxbQdUP0fLpg4LpMgX7ZfLGb3defa+O1r0YvFFCeNnQ
 Satg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bswh7/qVNoTMhX0s3zAgFkoXBHOrNaofcX0A6vxQIhI=;
 b=guEfuC6mjmLKk/wVhSfpjxQ99XKlqLCIiUFDWUgXE3hXimy9HiJjPzRnXbmqZJohoy
 o3bBlaiPNi1CNFWTeexmq4NHV0N0qTPimiuhOPamf1Jyo1QNdi5Z7O+WkfWdAtjfvBnO
 +ZrCGY83k6ZtqCM2a4J0GR7sk+BVfUW3t4wqiFva9UkFqbaGHk3WoFL3AG18QzPZjxXN
 4OEpPawQJ2/ERIRTbD7Cn/0+4dUnuycd3WTk8YUy26D5F3pf+iOMTZTYxwDBAvi3mipd
 7ysId0YTW1m2WqAYJsoiG0Cwa2LOfQzGBB99wuD7NQkZ95jE6fwXVkoLoll+/yaRtYp4
 f88A==
X-Gm-Message-State: APjAAAU/IP+2FJ4/ErERfF+If+1+lMcpVdzwmCg0hHEb6i5bqXg0yJHC
 499vZ8d5wNalfWc3x3jOBLPakGDecCW3xA==
X-Google-Smtp-Source: APXvYqzWjIsUusln2NmH7FZq5s2UdnF4O4Bn6HJ7J+WBaz0emR9D6KscC7JOF+0qPpzW6zew+chpDA==
X-Received: by 2002:a1c:f60f:: with SMTP id w15mr28848560wmc.132.1576494578237; 
 Mon, 16 Dec 2019 03:09:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/34] target/arm: Add support for DC CVAP & DC CVADP ins
Date: Mon, 16 Dec 2019 11:08:59 +0000
Message-Id: <20191216110904.30815-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Beata Michalska <beata.michalska@linaro.org>

ARMv8.2 introduced support for Data Cache Clean instructions
to PoP (point-of-persistence) - DC CVAP and PoDP (point-of-deep-persistence)
- DV CVADP. Both specify conceptual points in a memory system where all writes
that are to reach them are considered persistent.
The support provided considers both to be actually the same so there is no
distinction between the two. If none is available (there is no backing store
for given memory) both will result in Data Cache Clean up to the point of
coherency. Otherwise sync for the specified range shall be performed.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191121000843.24844-5-beata.michalska@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     | 10 ++++++++
 linux-user/elfload.c |  2 ++
 target/arm/cpu64.c   |  1 +
 target/arm/helper.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cebb3511a51..4106e4ae590 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3618,6 +3618,16 @@ static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
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
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6693e57609..07b16cc0f47 100644
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
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a39d6fcea34..61fd0ade29a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -646,6 +646,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a4f7b61b4e1..3a93844a3bc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5974,6 +5974,52 @@ static const ARMCPRegInfo rndr_reginfo[] = {
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
@@ -7046,6 +7092,16 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
2.20.1


