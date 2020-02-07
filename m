Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CBFC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320AF21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjG7KeRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320AF21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04oV-0005aO-DC
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i5-0000vt-LR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i4-0003Je-G5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:21 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04i4-0003HZ-8p
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:20 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so2777853wmj.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JMPFk0I8G2lk98QhY9xW2fm5UIcVqoFjQ1BM8KPf/ic=;
 b=rjG7KeRoWjtvIsqJO1AHpjQBk2qcL+oiwqjEIS6S/lxr5oJm1Dvl2P1eTw00B2G4vK
 I1OYDU4BtofCUYGxO1N5nzrS7sSjOSSQnbfNkOsqGy0w0N4T25hNLagdRzhJAErbKYlJ
 zEtnhERRDk2c/SNjKKAM+LK4Qlob8IzXruO/Dpa5JSAoogVbmVVaRcbAvTzQ0q7LRmeX
 IoY0T+VhCcVC581C3bFzX62MJJGvEOWFDzjAM+WLvjIcGIs2guTEiQABX6OTj4oNZDST
 eY85Sw2own4qjPpUu1tpEFp+z5hWR3iJ0btJS05I3eJgSaY+DEMhAR2KnoZFNmG8/8pd
 u+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JMPFk0I8G2lk98QhY9xW2fm5UIcVqoFjQ1BM8KPf/ic=;
 b=k09tUufNCIFNETn4TaQyHZUDyL05QiFPR1ADBItBtTjoJA4xERL6jKTwggFFeojPFt
 IwP/5oEyuUexDdCGzOqDTnPf/qtsIKGxru70npSWSSl0DjIJCRHf06LRf6WXiXmzz+iL
 +VRQ/SUVIzlT/9ZkgWFbS9lnmd0ewGrNPpwES9eHg+D58ISbagAiuSU3Ni51udBQA3Vv
 NOSGQdN4wpJocNzcNf84FA41oSlHB0JiSUH3JTGpwKRmF9K7Bpas4XYiWW9thXEEAVN1
 kp9Vg/jSBRzQynUA/ivKZF0g6TC+U58jI871SjJ1zOm0rnrzKmmsB8sOboVRiqpZiwER
 2/2Q==
X-Gm-Message-State: APjAAAWhTxFcMtUGApWSb2J+lU4ctR7SW8IWRq2hHrr82uktw7DO6ue4
 SnQi43lYn3eNlKafYJN8qJpW5xOpnZA=
X-Google-Smtp-Source: APXvYqxFo5AkpVuIpqsqAb0MAOzvZfHisZqDe3zPbQVZLE9OmUWs14ZkVdVAU6LUfW2eF92lLLSkrw==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr4651088wmh.52.1581086059078; 
 Fri, 07 Feb 2020 06:34:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/48] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
Date: Fri,  7 Feb 2020 14:33:26 +0000
Message-Id: <20200207143343.30322-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

Since we only support a single ASID, flush the tlb when it changes.

Note that TCR_EL2, like TCR_EL1, has the A1 bit that chooses between
the two TTBR* registers for the location of the ASID.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-31-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index cfa6ce59dc8..f9be6b052f0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3763,7 +3763,7 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
     tcr->base_mask = 0xffffc000u;
 }
 
-static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+static void vmsa_tcr_el12_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3789,7 +3789,17 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    /* TODO: There are ASID fields in here with HCR_EL2.E2H */
+    /*
+     * If we are running with E2&0 regime, then an ASID is active.
+     * Flush if that might be changing.  Note we're not checking
+     * TCR_EL2.A1 to know if this is really the TTBRx_EL2 that
+     * holds the active ASID, only checking the field that might.
+     */
+    if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
+        (arm_hcr_el2_eff(env) & HCR_E2H)) {
+        tlb_flush_by_mmuidx(env_cpu(env),
+                            ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0);
+    }
     raw_write(env, ri, value);
 }
 
@@ -3849,7 +3859,7 @@ static const ARMCPRegInfo vmsa_cp_reginfo[] = {
                              offsetof(CPUARMState, cp15.ttbr1_ns) } },
     { .name = "TCR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
-      .access = PL1_RW, .writefn = vmsa_tcr_el1_write,
+      .access = PL1_RW, .writefn = vmsa_tcr_el12_write,
       .resetfn = vmsa_ttbcr_reset, .raw_writefn = raw_write,
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[1]) },
     { .name = "TTBCR", .cp = 15, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 2,
@@ -5175,10 +5185,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
-      .access = PL2_RW,
-      /* no .writefn needed as this can't cause an ASID change;
-       * no .raw_writefn or .resetfn needed as we never use mask/base_mask
-       */
+      .access = PL2_RW, .writefn = vmsa_tcr_el12_write,
+      /* no .raw_writefn or .resetfn needed as we never use mask/base_mask */
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
-- 
2.20.1


