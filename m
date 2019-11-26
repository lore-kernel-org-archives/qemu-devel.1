Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B412071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lG0M2nib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B412071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZbgR-0003St-69
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZbaF-0007HD-Bj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZbaD-0005nR-5o
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZbaC-0005mv-SQ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:49 -0500
Received: by mail-wm1-x341.google.com with SMTP id t26so3481555wmi.4
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 06:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1yHl23JxBbbJm19d4IXd4etGFcAifQ1EcDoDvSYqoKE=;
 b=lG0M2nibZy2dfayRX6mvmWsQsmsVBzX+6bgYBwL7YKJKopoOK7JlfUi8He6PymXoJG
 B86k9kb1RSGetsP4CH0gXJ3nda3o+I03eCp62GfUjuwfRV48KN/+Ulm/sDn1WOw5gQKE
 zsmgpyWqJkW4MnkgNL9kg1uSyVWgcGwD9M6RSH0ubmrirukyUw9OgjisUZUnTK2zRUwt
 auU6liXMRFv7h5CkotlSsGatLBOUVQzmrgkIFUMF5w49TG79pQPo0iIDqW9MRNYSrkkb
 TVoW8gRqF/KbaKYr760nmxY1Dey6m63MA9gP3kJd9bJSSSzgTh8M8nmnlBpDJOarnYOf
 EA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1yHl23JxBbbJm19d4IXd4etGFcAifQ1EcDoDvSYqoKE=;
 b=oG/Nej6KMwF8lgaw2RTClCfimZ1HYHQoN/l6kKKv5C1JttSpdedzkv0MdVJItKL0I6
 nk+aclpABixj0h1d9Qc3jXashUdiBogXq/CDTa6tOvLxquqgnpOTrO8OmbE+ATiDn8P5
 VtyDxLUZ+4mahkTmCSqj0YrgH2csV+vtsKhrQTN6Utio92ss969SrlQ2I4DTCxSxsH8S
 EQwU0Zsziqb5nd9ZJcFn1OEOo3i4CU+xQ/LzpeDh+/IVOsz79EJtz1PjIVmKsN95O+aW
 j0n3FX12Da/1SpsGr38wlpcCHO0Sb98829Dfw6dGpsvcjvDOwx3gGtt37N47VkASiPZN
 RBCw==
X-Gm-Message-State: APjAAAUBoyR2GdG47vCz5mYsfYomqVblnJA7i+SgzWucKl4aHil15Di1
 xyMgljfExAboL94Pry8IjP699EXYE8s=
X-Google-Smtp-Source: APXvYqyFCOhw/BXjJX7lOoWQ2GorCpR59OMVGyjyvY7A07aDCzUDCO5QlsC9Z/nPBUTFuPy7ShRFig==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr4146002wmh.159.1574777567147; 
 Tue, 26 Nov 2019 06:12:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i127sm3364581wma.35.2019.11.26.06.12.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 06:12:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] target/arm: Honor HCR_EL2.TID3 trapping requirements
Date: Tue, 26 Nov 2019 14:12:39 +0000
Message-Id: <20191126141239.8219-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126141239.8219-1-peter.maydell@linaro.org>
References: <20191126141239.8219-1-peter.maydell@linaro.org>
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

From: Marc Zyngier <maz@kernel.org>

HCR_EL2.TID3 mandates that access from EL1 to a long list of id
registers traps to EL2, and QEMU has so far ignored this requirement.

This breaks (among other things) KVM guests that have PtrAuth enabled,
while the hypervisor doesn't want to expose the feature to its guest.
To achieve this, KVM traps the ID registers (ID_AA64ISAR1_EL1 in this
case), and masks out the unsupported feature.

QEMU not honoring the trap request means that the guest observes
that the feature is present in the HW, starts using it, and dies
a horrible death when KVM injects an UNDEF, because the feature
*really* isn't supported.

Do the right thing by trapping to EL2 if HCR_EL2.TID3 is set.

Note that this change does not include trapping of the MVFR
registers from AArch32 (they are accessed via the VMRS
instruction and need to be handled in a different way).

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Will Deacon <will@kernel.org>
Message-id: 20191123115618.29230-1-maz@kernel.org
[PMM: added missing accessfn line for ID_AA4PFR2_EL1_RESERVED;
 changed names of access functions to include _tid3]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 027fffbff69..0bf8f53d4b8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5978,6 +5978,26 @@ static const ARMCPRegInfo predinv_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_aa32_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        return access_aa64_tid3(env, ri, isread);
+    }
+
+    return CP_ACCESS_OK;
+}
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -6001,6 +6021,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_PFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->id_pfr0 },
             /* ID_PFR1 is not a plain ARM_CP_CONST because we don't know
              * the value of the GIC field until after we define these regs.
@@ -6008,63 +6029,78 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_PFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_NO_RAW,
+              .accessfn = access_aa32_tid3,
               .readfn = id_pfr1_read,
               .writefn = arm_cp_write_ignore },
             { .name = "ID_DFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->id_dfr0 },
             { .name = "ID_AFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->id_afr0 },
             { .name = "ID_MMFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->id_mmfr0 },
             { .name = "ID_MMFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->id_mmfr1 },
             { .name = "ID_MMFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->id_mmfr2 },
             { .name = "ID_MMFR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->id_mmfr3 },
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->isar.id_isar0 },
             { .name = "ID_ISAR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->isar.id_isar1 },
             { .name = "ID_ISAR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->isar.id_isar2 },
             { .name = "ID_ISAR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->isar.id_isar3 },
             { .name = "ID_ISAR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->isar.id_isar4 },
             { .name = "ID_ISAR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->isar.id_isar5 },
             { .name = "ID_MMFR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->id_mmfr4 },
             { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa32_tid3,
               .resetvalue = cpu->isar.id_isar6 },
             REGINFO_SENTINEL
         };
@@ -6185,164 +6221,204 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_NO_RAW,
+              .accessfn = access_aa64_tid3,
               .readfn = id_aa64pfr0_read,
               .writefn = arm_cp_write_ignore },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64pfr1},
             { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64PFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ZFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               /* At present, only SVEver == 0 is defined anyway.  */
               .resetvalue = 0 },
             { .name = "ID_AA64PFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64PFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64PFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->id_aa64dfr0 },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->id_aa64dfr1 },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64DFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64AFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->id_aa64afr0 },
             { .name = "ID_AA64AFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->id_aa64afr1 },
             { .name = "ID_AA64AFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64AFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64isar0 },
             { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64isar1 },
             { .name = "ID_AA64ISAR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64mmfr0 },
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64mmfr1 },
             { .name = "ID_AA64MMFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "MVFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.mvfr0 },
             { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.mvfr1 },
             { .name = "MVFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.mvfr2 },
             { .name = "MVFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "MVFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "MVFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "MVFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "MVFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
+              .accessfn = access_aa64_tid3,
               .resetvalue = 0 },
             { .name = "PMCEID0", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 9, .crm = 12, .opc2 = 6,
-- 
2.20.1


