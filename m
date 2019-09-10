Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05356C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CC52067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTgkrQt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CC52067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7d05-0006Vk-Rn
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1i7ct4-0008Qx-7d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1i7ct2-0002aB-NK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1i7ct2-0002ZQ-H0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id t16so18858107wra.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/WkGeJeyqUUlCOczegoffHH2fd/jiOdQ19K334OwQps=;
 b=jTgkrQt59w/pre1I46EQAUjxt8DCKTxmaxlpcf9syvSBT7ompVeqAOzKH0CL6/6YL/
 +5SZnkv0jxVYkEZf5z8vUXGR4Go+4f1h/LYWmnquSM8HLaGL7QClyAmgzbD0w+ODkcUV
 lej1x1+cOCrfqvT7VxAIw/q9E5BgylwNZkckZSvxTPUUkCLxqmROL+eFBTMmAWsTllnm
 wEbfljjujfsNug58Mchqlwf5aGpCSzxe68D80lN658zR7NJG7w9fKu6kfNF9Ck2Pq7fJ
 sEVOhLB292LEldEs+we1forGceN66iAbKkm5I84kDrtPLtXcwjA526is51RM4moyfhcm
 3xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/WkGeJeyqUUlCOczegoffHH2fd/jiOdQ19K334OwQps=;
 b=Zg/FDfbmV4UPlZyKPfsmD7lYHKp/1EaIOzpnzuOFln6Ey3GRs1Zy8uy3BX/ahgRKe2
 lz63kyqxvWNwsB1Jb+m6ta+svvBSITCZw7AdxGH6buyT+NWVTpToN5qPiATuzwd0EmK5
 1xzL57w8kaslimlGKbBe5F5jxonX24W/qwGzhaLL/Ci3YMTtSTI6jPegGhxNFwhNjdvI
 /WzcE951qv0lSt9KPNZHJw1S0HRPQ99QGxiyBWzXhnPG2L01tF9bp69xBF+X3bQ0ZP+f
 b3s4hN3VoHJwzl4EgX59inbnvIlLU10nfCHedNmb2n3tW2FgSqqAsZVihTSa5V0OAXc6
 RNng==
X-Gm-Message-State: APjAAAWX/tc1KVpspLPv3dE5oL/CeDu44isY75BylSLAwMnTyJnI6/Pg
 Wa84XaNsICCaUd41WEz76rBJoOZDkCo=
X-Google-Smtp-Source: APXvYqx2OPSNgpET+wL+51IIk442Ef5L4Pb4tyGh6ETgD0zBrAEjyRSybWCowI1vjcXyTBglPJzS7w==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr24800537wru.145.1568109395309; 
 Tue, 10 Sep 2019 02:56:35 -0700 (PDT)
Received: from moi-XPS-13-9350.arm.com
 (host86-144-13-57.range86-144.btcentralplus.com. [86.144.13.57])
 by smtp.gmail.com with ESMTPSA id e30sm32403540wra.48.2019.09.10.02.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:56:34 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 11:56:10 +0200
Message-Id: <20190910095610.4546-5-beata.michalska@linaro.org>
In-Reply-To: <20190910095610.4546-1-beata.michalska@linaro.org>
References: <20190910095610.4546-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 4/4] target/arm: Add support for DC CVAP & DC
 CVADP ins
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
Cc: peter.maydell@linaro.org, Beata Michalska <beata.michalska@linaro.org>,
 quintela@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
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
 linux-user/elfload.c       | 18 +++++++++++++++++-
 target/arm/cpu.h           | 13 ++++++++++++-
 target/arm/cpu64.c         |  1 +
 target/arm/helper.c        | 24 ++++++++++++++++++++++++
 target/arm/helper.h        |  1 +
 target/arm/op_helper.c     | 36 ++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  5 +++++
 7 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3365e192eb..1ec00308d5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -609,7 +609,12 @@ enum {
     ARM_HWCAP_A64_PACG          = 1UL << 31,
 };
 
+enum {
+    ARM_HWCAP2_A64_DCPODP   = 1 << 0,
+};
+
 #define ELF_HWCAP get_elf_hwcap()
+#define ELF_HWCAP2 get_elf_hwcap2()
 
 static uint32_t get_elf_hwcap(void)
 {
@@ -644,12 +649,23 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
     GET_FEATURE_ID(aa64_sb, ARM_HWCAP_A64_SB);
     GET_FEATURE_ID(aa64_condm_4, ARM_HWCAP_A64_FLAGM);
+    GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
 
-#undef GET_FEATURE_ID
 
     return hwcaps;
 }
 
+static uint32_t get_elf_hwcap2(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    uint32_t hwcaps = 0;
+
+    GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
+    return hwcaps;
+}
+
+#undef GET_FEATURE_ID
+
 #endif /* not TARGET_AARCH64 */
 #endif /* TARGET_ARM */
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 297ad5e47a..1713d76590 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2229,7 +2229,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
 #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
 #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
-#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
+#define ARM_CP_DC_CVAP           (ARM_CP_SPECIAL | 0x0600)
+#define ARM_LAST_SPECIAL         ARM_CP_DC_CVAP
 #define ARM_CP_FPU               0x1000
 #define ARM_CP_SVE               0x2000
 #define ARM_CP_NO_GDB            0x4000
@@ -3572,6 +3573,16 @@ static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) != 0;
 }
 
+static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
+}
+
+static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
+{
+    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >> 1) != 0;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d7f5bf610a..20094f980d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -331,6 +331,7 @@ static void aarch64_max_initfn(Object *obj)
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, APA, 1); /* PAuth, architected only */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 507026c915..99ae01b7e7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3843,6 +3843,22 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult aa64_cacheop_persist_access(CPUARMState *env,
+                                                  const ARMCPRegInfo *ri,
+                                                  bool isread)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    /*
+     * Access is UNDEF if lacking implementation for either DC CVAP or DC CVADP
+     * DC CVAP ->  CRm: 0xc
+     * DC CVADP -> CRm: 0xd
+     */
+    return (ri->crm == 0xc && !cpu_isar_feature(aa64_dcpop, cpu)) ||
+           (ri->crm == 0xd && !cpu_isar_feature(aa64_dcpodp, cpu))
+           ? CP_ACCESS_TRAP_UNCATEGORIZED
+           : aa64_cacheop_access(env, ri, isread);
+}
+
 /* See: D4.7.2 TLB maintenance requirements and the TLB maintenance instructions
  * Page D4-1736 (DDI0487A.b)
  */
@@ -4251,6 +4267,14 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
       .accessfn = aa64_cacheop_access },
+    { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
+      .access = PL0_W, .type = ARM_CP_DC_CVAP,
+      .accessfn = aa64_cacheop_persist_access },
+    { .name = "DC_CVADP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 1,
+      .access = PL0_W, .type = ARM_CP_DC_CVAP,
+      .accessfn = aa64_cacheop_persist_access },
     { .name = "DC_CSW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
       .access = PL1_W, .type = ARM_CP_NOP },
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1fb2cb5a77..a850364944 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -561,6 +561,7 @@ DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(dc_zva, void, env, i64)
+DEF_HELPER_2(dc_cvap, void, env, i64)
 
 DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 0fd4bd0238..75ebf6afa4 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -987,3 +987,39 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
     memset(g2h(vaddr), 0, blocklen);
 #endif
 }
+
+void HELPER(dc_cvap)(CPUARMState *env, uint64_t vaddr_in)
+{
+#ifndef CONFIG_USER_ONLY
+    ARMCPU *cpu = env_archcpu(env);
+    /* CTR_EL0 System register -> DminLine, bits [19:16] */
+    uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
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
+        /*
+         * RCU critical section + ref counting,
+         * so that MR won't disappear behind the scene
+         */
+        rcu_read_lock();
+        mr = memory_region_from_host(haddr, &offset);
+        if (mr) {
+            memory_region_ref(mr);
+        }
+        rcu_read_unlock();
+
+        if (mr) {
+            memory_region_do_writeback(mr, offset, dline_size);
+            memory_region_unref(mr);
+        }
+    }
+#endif
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2d6cd09634..21ea3631d6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1746,6 +1746,11 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         tcg_rt = cpu_reg(s, rt);
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
+    case ARM_CP_DC_CVAP:
+        /* DC CVAP / DC CVADP */
+        tcg_rt = cpu_reg(s, rt);
+        gen_helper_dc_cvap(cpu_env, tcg_rt);
+        return;
     default:
         break;
     }
-- 
2.17.1


