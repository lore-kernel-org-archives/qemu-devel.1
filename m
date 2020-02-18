Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0EEC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C9022527
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7TyzcVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C9022527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j44oc-00089Z-QD
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j44nr-0007Tk-E6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j44np-0003ZT-GD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:28:51 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j44np-0003Yy-81
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:28:49 -0500
Received: by mail-pf1-x442.google.com with SMTP id p14so10827777pfn.4
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HQHh6qrFUuo2T2mOb46doVh8eCV8qOfeXP4yG8YM+KE=;
 b=l7TyzcVtNETOsX7sWWVg80s6TeyD1XGTzSrNNHCDRUXEciLrXIDc224hHu6/JoUAmE
 fIpUPVfDKJmPAQCyeicAwfLUvCwZcdNvbrIQueeKKzzj/wDjXILgqbAqWavCK1avXNpd
 ECAZg8OoXYNgJq3NPII+PAEHfkAgXH/Uj4YepR8VcSfHdZOuICEF3bKpFfbf3sk9ngNR
 Cd1Fw6r01/KYWNHjJzUJLkLsFSp9uOhABr6ZFB60Z+9wsM9kTkD8a+X2lE6aQnI+hKTJ
 s7PM/tPIYK2YI5eYtsaVCesxXhmAUb8B4Qk5YukvtbqMgzS5s9go76voC9C7T5RIh+I3
 Iq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HQHh6qrFUuo2T2mOb46doVh8eCV8qOfeXP4yG8YM+KE=;
 b=YdhozhifrSKmmDk8KkFibS0UIEHvkM5or23A5EphVjVTpdNJIbrCETduqiUxEphNDh
 8Ii2efCh8UECqh5HfJZnFUFweveKNz8wSS9BFk9aiHoeZWQMuXv0yWbzLkwWKQI5XQGC
 BZe5jVWJTy3OwrFhPql632huIiRUSYq8eoZ9/ytzTv2f302WtrUrkf1LtBfLK8mk2Phd
 G8ORP76eoxtQ4zK17fv7+FDnH2jNgJrTPxwOMLybPP6btNaWmbDBrsQwzuFVO6ZkRQiq
 0dTIF09wi8Hz1g/xuNGd/+4WN3uq3964JRAActrw0zw2o5fwvtMUR7B9iuTsHtCrDSM1
 495Q==
X-Gm-Message-State: APjAAAXpnHC8TAmizOyCgubFT6LR+oenjHKRKdquXPV+ed3+kRGhCchj
 JSlWZBfFr06KHf8hOK21IMpLQi/RZd4=
X-Google-Smtp-Source: APXvYqwlS7VLwfBMVg2AXJ6lEaKj4b7aHy+LaJyW5U3u1hZlA0w5JGfKqOdxhmsmaH0US5YQeGk/6A==
X-Received: by 2002:a63:921a:: with SMTP id o26mr23777918pgd.246.1582039727453; 
 Tue, 18 Feb 2020 07:28:47 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r6sm4662382pfh.91.2020.02.18.07.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 07:28:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] target/arm: Honor the HCR_EL2.{TVM,TRVM} bits
Date: Tue, 18 Feb 2020 07:28:44 -0800
Message-Id: <20200218152844.29351-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

These bits trap EL1 access to various virtual memory controls.

Buglink: https://bugs.launchpad.net/bugs/1855072
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Include TTBCR.
---
 target/arm/helper.c | 77 ++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 366dbcf460..69946a57f8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -529,6 +529,19 @@ static CPAccessResult access_tpm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/* Check for traps from EL1 due to HCR_EL2.TVM and HCR_EL2.TRVM.  */
+static CPAccessResult access_tvm_trvm(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) == 1) {
+        uint64_t trap = isread ? HCR_TRVM : HCR_TVM;
+        if (arm_hcr_el2_eff(env) & trap) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    return CP_ACCESS_OK;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -784,7 +797,8 @@ static const ARMCPRegInfo cp_reginfo[] = {
      */
     { .name = "CONTEXTIDR_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .secure = ARM_CP_SECSTATE_NS,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .secure = ARM_CP_SECSTATE_NS,
       .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[1]),
       .resetvalue = 0, .writefn = contextidr_write, .raw_writefn = raw_write, },
     { .name = "CONTEXTIDR_S", .state = ARM_CP_STATE_AA32,
@@ -876,9 +890,11 @@ static const ARMCPRegInfo not_v7_cp_reginfo[] = {
       .opc1 = CP_ANY, .opc2 = 3, .access = PL1_W, .writefn = tlbimvaa_write,
       .type = ARM_CP_NO_RAW },
     { .name = "PRRR", .cp = 15, .crn = 10, .crm = 2,
-      .opc1 = 0, .opc2 = 0, .access = PL1_RW, .type = ARM_CP_NOP },
+      .opc1 = 0, .opc2 = 0, .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .type = ARM_CP_NOP },
     { .name = "NMRR", .cp = 15, .crn = 10, .crm = 2,
-      .opc1 = 0, .opc2 = 1, .access = PL1_RW, .type = ARM_CP_NOP },
+      .opc1 = 0, .opc2 = 1, .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .type = ARM_CP_NOP },
     REGINFO_SENTINEL
 };
 
@@ -996,7 +1012,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     { .name = "DMB", .cp = 15, .crn = 7, .crm = 10, .opc1 = 0, .opc2 = 5,
       .access = PL0_W, .type = ARM_CP_NOP },
     { .name = "IFAR", .cp = 15, .crn = 6, .crm = 0, .opc1 = 0, .opc2 = 2,
-      .access = PL1_RW,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ifar_s),
                              offsetof(CPUARMState, cp15.ifar_ns) },
       .resetvalue = 0, },
@@ -2164,16 +2180,19 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
      */
     { .name = "AFSR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 1, .opc2 = 0,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "AFSR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 5, .crm = 1, .opc2 = 1,
-      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /* MAIR can just read-as-written because we don't implement caches
      * and so don't need to care about memory attributes.
      */
     { .name = "MAIR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 0,
-      .access = PL1_RW, .fieldoffset = offsetof(CPUARMState, cp15.mair_el[1]),
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .fieldoffset = offsetof(CPUARMState, cp15.mair_el[1]),
       .resetvalue = 0 },
     { .name = "MAIR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 10, .crm = 2, .opc2 = 0,
@@ -2187,12 +2206,14 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       * handled in the field definitions.
       */
     { .name = "MAIR0", .state = ARM_CP_STATE_AA32,
-      .cp = 15, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 0, .access = PL1_RW,
+      .cp = 15, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.mair0_s),
                              offsetof(CPUARMState, cp15.mair0_ns) },
       .resetfn = arm_cp_reset_ignore },
     { .name = "MAIR1", .state = ARM_CP_STATE_AA32,
-      .cp = 15, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 1, .access = PL1_RW,
+      .cp = 15, .opc1 = 0, .crn = 10, .crm = 2, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.mair1_s),
                              offsetof(CPUARMState, cp15.mair1_ns) },
       .resetfn = arm_cp_reset_ignore },
@@ -3842,20 +3863,21 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
     { .name = "DFSR", .cp = 15, .crn = 5, .crm = 0, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .type = ARM_CP_ALIAS,
+      .access = PL1_RW, .accessfn = access_tvm_trvm, .type = ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.dfsr_s),
                              offsetoflow32(CPUARMState, cp15.dfsr_ns) }, },
     { .name = "IFSR", .cp = 15, .crn = 5, .crm = 0, .opc1 = 0, .opc2 = 1,
-      .access = PL1_RW, .resetvalue = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm, .resetvalue = 0,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.ifsr_s),
                              offsetoflow32(CPUARMState, cp15.ifsr_ns) } },
     { .name = "DFAR", .cp = 15, .opc1 = 0, .crn = 6, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .resetvalue = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.dfar_s),
                              offsetof(CPUARMState, cp15.dfar_ns) } },
     { .name = "FAR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .crn = 6, .crm = 0, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .fieldoffset = offsetof(CPUARMState, cp15.far_el[1]),
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .fieldoffset = offsetof(CPUARMState, cp15.far_el[1]),
       .resetvalue = 0, },
     REGINFO_SENTINEL
 };
@@ -3863,25 +3885,29 @@ static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
 static const ARMCPRegInfo vmsa_cp_reginfo[] = {
     { .name = "ESR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .crn = 5, .crm = 2, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
       .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .writefn = vmsa_ttbr_write, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) } },
     { .name = "TTBR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .writefn = vmsa_ttbr_write, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
-      .access = PL1_RW, .writefn = vmsa_tcr_el12_write,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .writefn = vmsa_tcr_el12_write,
       .resetfn = vmsa_ttbcr_reset, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[1]) },
     { .name = "TTBCR", .cp = 15, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
-      .access = PL1_RW, .type = ARM_CP_ALIAS, .writefn = vmsa_ttbcr_write,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .type = ARM_CP_ALIAS, .writefn = vmsa_ttbcr_write,
       .raw_writefn = vmsa_ttbcr_raw_write,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.tcr_el[3]),
                              offsetoflow32(CPUARMState, cp15.tcr_el[1])} },
@@ -3893,7 +3919,8 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
  */
 static const ARMCPRegInfo ttbcr2_reginfo = {
     .name = "TTBCR2", .cp = 15, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 3,
-    .access = PL1_RW, .type = ARM_CP_ALIAS,
+    .access = PL1_RW, .accessfn = access_tvm_trvm,
+    .type = ARM_CP_ALIAS,
     .bank_fieldoffsets = { offsetofhigh32(CPUARMState, cp15.tcr_el[3]),
                            offsetofhigh32(CPUARMState, cp15.tcr_el[1]) },
 };
@@ -4113,12 +4140,12 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
     /* NOP AMAIR0/1 */
     { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .type = ARM_CP_CONST,
-      .resetvalue = 0 },
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /* AMAIR1 is mapped to AMAIR_EL1[63:32] */
     { .name = "AMAIR1", .cp = 15, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 1,
-      .access = PL1_RW, .type = ARM_CP_CONST,
-      .resetvalue = 0 },
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "PAR", .cp = 15, .crm = 7, .opc1 = 0,
       .access = PL1_RW, .type = ARM_CP_64BIT, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.par_s),
@@ -4844,7 +4871,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .type = ARM_CP_NOP, .access = PL1_W },
     /* MMU Domain access control / MPU write buffer control */
     { .name = "DACR", .cp = 15, .opc1 = 0, .crn = 3, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .resetvalue = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm, .resetvalue = 0,
       .writefn = dacr_write, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.dacr_s),
                              offsetoflow32(CPUARMState, cp15.dacr_ns) } },
@@ -7652,7 +7679,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         ARMCPRegInfo sctlr = {
             .name = "SCTLR", .state = ARM_CP_STATE_BOTH,
             .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
-            .access = PL1_RW,
+            .access = PL1_RW, .accessfn = access_tvm_trvm,
             .bank_fieldoffsets = { offsetof(CPUARMState, cp15.sctlr_s),
                                    offsetof(CPUARMState, cp15.sctlr_ns) },
             .writefn = sctlr_write, .resetvalue = cpu->reset_sctlr,
-- 
2.20.1


