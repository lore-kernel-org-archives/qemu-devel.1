Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E409EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F54420637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgVUJ5Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F54420637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9thX-0000ht-Ne
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPE-0003dd-5a
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPC-0002U6-5e
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:28 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPB-0002Ru-UR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:26 -0500
Received: by mail-wr1-x42b.google.com with SMTP id r17so7795398wrj.7
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rP0WTsFvBqMrZqUjV7tU4PPtYecIkdy5YUBe1HCruKI=;
 b=rgVUJ5DxxuaRHAnASjf77IPubjzZGvm2Ls9J4Fx8gziHTkaZAcA//Gwp0TTblMI66l
 2MlFADZhfA9GSbxgAdmCZSbO8Sctth63Odk36dVATsygdPIxhEGSVuMNzJYMwWHSQIEi
 X1fqo1j/ol8ys8av+D3DBrUF1DCz2Q2GYeU4eR0eHHAyPA24eC+DnUpmggF1DkZnn2zJ
 NT2jtNxwPlP/y0f3qYnBrjC+faCMEQmeiucXJ/tPnQ8Gj89ZFAME6p2zoBGxKC2Bq2FZ
 XtgMNyxguOUa6Y8h49Bw8NuH+nD6SdQjKd/tQyXaKZ1tOakjZ7dALgijo41PDnQ1ZiR+
 vJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rP0WTsFvBqMrZqUjV7tU4PPtYecIkdy5YUBe1HCruKI=;
 b=fUDtSotG15jOvRfZ1rKQIYZ9r/p8NFnRoKvLysCB0D3tPdkb+NRD3T/V+IQzZ7KvCW
 lRChglm2ChywJivcXRi2MYqjCAt/EXTc2/Xulnq9ZX2P96Jahjz9iEeWqz4OaO+FT/NI
 D8VuW7XyflclhlztKej+jmOFv0E/H4CtkSpOiMuDCQNJwd/Qkpwt8LNhE1XW88FRKaEk
 aTrCpi/o00JypylqYtwrzOdYTqSw96CnJagFma4rgyK8xx/O4TZ2GLOnetebh6KEIR+/
 BLyPMtb43fdyE6LfOmYQ2RTjSVI1xIi9iZHxUzwNnbagBXwcT89xDodqXiDDE2odkyvr
 QY5A==
X-Gm-Message-State: ANhLgQ2kNUGjKJeyxrATsiHYweqtp8CH/MDPLBH+E4ng4dyRD6mIAfp2
 XfwVsxi0sqErqGsa/3k2DKSZhdo6zM+dMQ==
X-Google-Smtp-Source: ADFU+vsPK8WX0oQiTuzncGsJU8WHr14ZIVoxbXgjoOdX7QmIG+XzcmkFaiYqsJAV51DZrOeP2goNHQ==
X-Received: by 2002:adf:9071:: with SMTP id
 h104mr11175743wrh.359.1583425884211; 
 Thu, 05 Mar 2020 08:31:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/37] target/arm: Honor the HCR_EL2.{TVM,TRVM} bits
Date: Thu,  5 Mar 2020 16:30:43 +0000
Message-Id: <20200305163100.22912-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

From: Richard Henderson <richard.henderson@linaro.org>

These bits trap EL1 access to various virtual memory controls.

Buglink: https://bugs.launchpad.net/bugs/1855072
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200229012811.24129-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 82 ++++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4ddb9443fbc..c78429bca2a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -530,6 +530,19 @@ static CPAccessResult access_tpm(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -785,12 +798,14 @@ static const ARMCPRegInfo cp_reginfo[] = {
      */
     { .name = "CONTEXTIDR_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .secure = ARM_CP_SECSTATE_NS,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .secure = ARM_CP_SECSTATE_NS,
       .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[1]),
       .resetvalue = 0, .writefn = contextidr_write, .raw_writefn = raw_write, },
     { .name = "CONTEXTIDR_S", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .secure = ARM_CP_SECSTATE_S,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .secure = ARM_CP_SECSTATE_S,
       .fieldoffset = offsetof(CPUARMState, cp15.contextidr_s),
       .resetvalue = 0, .writefn = contextidr_write, .raw_writefn = raw_write, },
     REGINFO_SENTINEL
@@ -803,7 +818,7 @@ static const ARMCPRegInfo not_v8_cp_reginfo[] = {
     /* MMU Domain access control / MPU write buffer control */
     { .name = "DACR",
       .cp = 15, .opc1 = CP_ANY, .crn = 3, .crm = CP_ANY, .opc2 = CP_ANY,
-      .access = PL1_RW, .resetvalue = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm, .resetvalue = 0,
       .writefn = dacr_write, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.dacr_s),
                              offsetoflow32(CPUARMState, cp15.dacr_ns) } },
@@ -996,7 +1011,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     { .name = "DMB", .cp = 15, .crn = 7, .crm = 10, .opc1 = 0, .opc2 = 5,
       .access = PL0_W, .type = ARM_CP_NOP },
     { .name = "IFAR", .cp = 15, .crn = 6, .crm = 0, .opc1 = 0, .opc2 = 2,
-      .access = PL1_RW,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ifar_s),
                              offsetof(CPUARMState, cp15.ifar_ns) },
       .resetvalue = 0, },
@@ -2208,16 +2223,19 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
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
@@ -2231,12 +2249,14 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
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
@@ -3886,20 +3906,21 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
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
@@ -3907,25 +3928,29 @@ static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
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
@@ -3937,7 +3962,8 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
  */
 static const ARMCPRegInfo ttbcr2_reginfo = {
     .name = "TTBCR2", .cp = 15, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 3,
-    .access = PL1_RW, .type = ARM_CP_ALIAS,
+    .access = PL1_RW, .accessfn = access_tvm_trvm,
+    .type = ARM_CP_ALIAS,
     .bank_fieldoffsets = { offsetofhigh32(CPUARMState, cp15.tcr_el[3]),
                            offsetofhigh32(CPUARMState, cp15.tcr_el[1]) },
 };
@@ -4157,23 +4183,25 @@ static const ARMCPRegInfo lpae_cp_reginfo[] = {
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
                              offsetof(CPUARMState, cp15.par_ns)} },
     { .name = "TTBR0", .cp = 15, .crm = 2, .opc1 = 0,
-      .access = PL1_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
                              offsetof(CPUARMState, cp15.ttbr0_ns) },
       .writefn = vmsa_ttbr_write, },
     { .name = "TTBR1", .cp = 15, .crm = 2, .opc1 = 1,
-      .access = PL1_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
                              offsetof(CPUARMState, cp15.ttbr1_ns) },
       .writefn = vmsa_ttbr_write, },
@@ -4888,7 +4916,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .type = ARM_CP_NOP, .access = PL1_W },
     /* MMU Domain access control / MPU write buffer control */
     { .name = "DACR", .cp = 15, .opc1 = 0, .crn = 3, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .resetvalue = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm, .resetvalue = 0,
       .writefn = dacr_write, .raw_writefn = raw_write,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.dacr_s),
                              offsetoflow32(CPUARMState, cp15.dacr_ns) } },
@@ -7765,7 +7793,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


