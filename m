Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29215C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58FF2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vniI6nEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58FF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvIZ-0004F8-SB
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvHD-0002sP-Ra
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvHC-0002wW-1O
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:15 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:40333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvHB-0002vF-U9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:48:13 -0400
Received: by mail-yb1-xb41.google.com with SMTP id s7so3114299ybq.7
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=xmUaFHpu+lWY1a4oEujNqO15G+zNUx5P27Y/+JXsJIk=;
 b=vniI6nEWgQGjaqruQnSOhtv+QJhIk7rTAXzmo6V1OntciiUW0gxZsmESnKehNBT4Ny
 IY8vXWWLo5qOij5g5q2swrXog1J4keo4/iDZp1YPvDun+vqtxST3FLy39Syo/hnvtmGQ
 OTErbE8nL4//MOU5+n/niwKRQq1fmlOsnDNR2/5cI1ZAHQtEa5XEKgPqfI72cZA4My9A
 zaDFr0MeuPClIdThBCQuYR+wJTF8lCvpE4LY+0BoSBMye0rkaPPyKipGXeIlERuNaEz/
 99nmbP16Lw4rZa1aUkvRW0/SdUZc0AbSuqCmyZ/ryo37IGSCfxZjOntyjCaxoL5N5372
 R5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=xmUaFHpu+lWY1a4oEujNqO15G+zNUx5P27Y/+JXsJIk=;
 b=lWzDcpEDQ98D/bn8M8uSstkZqrkaodSOEbPT8J953i18RuMHG8F+TUvrxX/s0M4eMe
 VD1OMPdt/oJjZrAt8fGAXAGr8HlNyCWvSLccl3kLn4TahiJ6qpKAtKmsFcjw8NrrtRWK
 RXXJ2MGWEdfTEkoQJEI8z3ETL14RU3xM7L3P4MIMYGZpqAIIDse3QGrNiPmYv14Uxf0n
 LXH9UKhvKT/Q2vKBQUuvePsATd1qYeQklWEi7zZ7ifRiXj47dsxZzewE37u/QOaDGxn7
 seCd2vRbwv8mI71HZw/8cp7vz1vhcTJmj+mVcskfnuFwaGRiDTGIZ85pCYu5F82X95rT
 YnPg==
X-Gm-Message-State: APjAAAWdxsF+T5DKPjyQaXmmRd2DhsuGCGpBLWTr5vPv/QcvCjdxYbc3
 fwExONCTtOOfsMCIRkKGnhtKEKRykt4=
X-Google-Smtp-Source: APXvYqyWjVZf0B23dPtrpvMWCPFUzL4Ju9DQQ2QYpTxQkTkbRdYc5TNHycWzxkHzhYkmecz3xzLvRw==
X-Received: by 2002:a25:ed7:: with SMTP id 206mr9778464ybo.162.1570801692248; 
 Fri, 11 Oct 2019 06:48:12 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:48:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/22] target/arm: Implement ARMv8.5-MemTag, system mode
Date: Fri, 11 Oct 2019 09:47:22 -0400
Message-Id: <20191011134744.2477-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an update of the v4 patch from March.

I believe I've fixed the address space issues that Peter noticed.
If the board model does not supply tag memory, then I downgrade
the cpu support to "instructions only" (id_aa64pfr1.mte == 1),
which does not allow tag memory access to be enabled in the cpu.

I did not update the arm_hcr_el2_eff comment re ARMv8.4, because
I have not done a complete audit of all of the v8.5 bits.

The hacky kernel testing patch has needed some updates since March.
The following applies to v5.4-rc2.


r~


Richard Henderson (22):
  target/arm: Add MTE_ACTIVE to tb_flags
  target/arm: Add regime_has_2_ranges
  target/arm: Add MTE system registers
  target/arm: Add helper_mte_check{1,2,3}
  target/arm: Suppress tag check for sp+offset
  target/arm: Implement the IRG instruction
  target/arm: Implement ADDG, SUBG instructions
  target/arm: Implement the GMI instruction
  target/arm: Implement the SUBP instruction
  target/arm: Define arm_cpu_do_unaligned_access for CONFIG_USER_ONLY
  target/arm: Implement LDG, STG, ST2G instructions
  target/arm: Implement the STGP instruction
  target/arm: Implement the LDGM and STGM instructions
  target/arm: Implement the access tag cache flushes
  target/arm: Clean address for DC ZVA
  target/arm: Implement data cache set allocation tags
  target/arm: Set PSTATE.TCO on exception entry
  target/arm: Enable MTE
  target/arm: Cache the Tagged bit for a page in MemTxAttrs
  target/arm: Create tagged ram when MTE is enabled
  target/arm: Add mmu indexes for tag memory
  target/arm: Add allocation tag storage for system mode

 target/arm/cpu-param.h     |   2 +-
 target/arm/cpu.h           |  37 ++-
 target/arm/helper-a64.h    |  17 ++
 target/arm/internals.h     |  45 +++
 target/arm/translate.h     |   2 +
 hw/arm/virt.c              |  54 ++++
 target/arm/cpu.c           |  63 +++-
 target/arm/cpu64.c         |   1 +
 target/arm/helper.c        | 277 ++++++++++++++---
 target/arm/mte_helper.c    | 601 +++++++++++++++++++++++++++++++++++++
 target/arm/tlb_helper.c    |   3 +-
 target/arm/translate-a64.c | 342 ++++++++++++++++++---
 target/arm/Makefile.objs   |   1 +
 13 files changed, 1345 insertions(+), 100 deletions(-)
 create mode 100644 target/arm/mte_helper.c

--- kernel patch

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index f19fe4b9acc4..ee6b7f387a9a 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -52,7 +52,8 @@
 #define ARM64_HAS_IRQ_PRIO_MASKING		42
 #define ARM64_HAS_DCPODP			43
 #define ARM64_WORKAROUND_1463225		44
+#define ARM64_HAS_MTE				45
 
-#define ARM64_NCAPS				45
+#define ARM64_NCAPS				46
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index ddf9d762ac62..5825130bd8eb 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -12,6 +12,7 @@
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
+#define HCR_ATA		(UL(1) << 56)
 #define HCR_FWB		(UL(1) << 46)
 #define HCR_API		(UL(1) << 41)
 #define HCR_APK		(UL(1) << 40)
@@ -78,8 +79,8 @@
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
 			 HCR_FMO | HCR_IMO)
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
-#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
-#define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
+#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
+#define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H | HCR_ATA)
 
 /* TCR_EL2 Registers bits */
 #define TCR_EL2_RES1		((1 << 31) | (1 << 23))
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 972d196c7714..2a65831f6e0f 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -482,6 +482,7 @@
 
 /* Common SCTLR_ELx flags. */
 #define SCTLR_ELx_DSSBS	(BIT(44))
+#define SCTLR_ELx_ATA	(BIT(43))
 #define SCTLR_ELx_ENIA	(BIT(31))
 #define SCTLR_ELx_ENIB	(BIT(30))
 #define SCTLR_ELx_ENDA	(BIT(27))
@@ -510,6 +511,7 @@
 #endif
 
 /* SCTLR_EL1 specific flags. */
+#define SCTLR_EL1_ATA0		(BIT(42))
 #define SCTLR_EL1_UCI		(BIT(26))
 #define SCTLR_EL1_E0E		(BIT(24))
 #define SCTLR_EL1_SPAN		(BIT(23))
@@ -598,6 +600,7 @@
 #define ID_AA64PFR0_EL0_32BIT_64BIT	0x2
 
 /* id_aa64pfr1 */
+#define ID_AA64PFR1_MTE_SHIFT		8
 #define ID_AA64PFR1_SSBS_SHIFT		4
 
 #define ID_AA64PFR1_SSBS_PSTATE_NI	0
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index cabebf1a7976..6a122ed7f76b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -171,6 +171,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MTE_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
 	ARM64_FTR_END,
 };
@@ -1261,6 +1262,11 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 }
 #endif
 
+static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
+{
+	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ATA | SCTLR_EL1_ATA0);
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1561,6 +1567,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 1,
 	},
 #endif
+	{
+		.desc = "Memory Tagging",
+		.capability = ARM64_HAS_MTE,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR1_EL1,
+		.field_pos = ID_AA64PFR1_MTE_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 2,
+		.cpu_enable = cpu_enable_mte,
+	},
 	{},
 };
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index a1e0592d1fbc..32cfa35195ae 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -424,14 +424,14 @@ ENTRY(__cpu_setup)
 	 *   DEVICE_nGnRE	001	00000100
 	 *   DEVICE_GRE		010	00001100
 	 *   NORMAL_NC		011	01000100
-	 *   NORMAL		100	11111111
+	 *   NORMAL		100	11110000 (Tag)
 	 *   NORMAL_WT		101	10111011
 	 */
 	ldr	x5, =MAIR(0x00, MT_DEVICE_nGnRnE) | \
 		     MAIR(0x04, MT_DEVICE_nGnRE) | \
 		     MAIR(0x0c, MT_DEVICE_GRE) | \
 		     MAIR(0x44, MT_NORMAL_NC) | \
-		     MAIR(0xff, MT_NORMAL) | \
+		     MAIR(0xf0, MT_NORMAL) | \
 		     MAIR(0xbb, MT_NORMAL_WT)
 	msr	mair_el1, x5
 	/*

--- mte smoke test

/*
 * Memory tagging, basic pass cases.
 */

#include <stdio.h>
#include <assert.h>
#include <sys/mman.h>

asm(".arch armv8.5-a+memtag");

int data[16 / sizeof(int)] __attribute__((aligned(16)));

int main(int ac, char **av)
{
    int *p0 = data;
    int *p1, *p2;
    long c;

    if (mlock(data, sizeof(data)) < 0) {
        perror("mlock");
        return 1;
    }

    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
    assert(p1 != p0);
    asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
    assert(c == 0);

    asm("stg %0, [%0]" : : "r"(p1));
    asm("ldg %0, [%1]" : "=r"(p2) : "r"(p0), "0"(p0));
    assert(p1 == p2);

    return 0;
}


