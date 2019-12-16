Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C19DC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C81206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cturLwvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C81206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igojd-000732-BM
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFo-0007uz-V5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFn-0008Pg-MT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:32 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFn-0008MD-FG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:31 -0500
Received: by mail-wm1-x341.google.com with SMTP id f4so4739423wmj.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+wbOydoHJcrGiS0BnuKATAZrpNqvBjK0CPC4VxKCSdY=;
 b=cturLwvJYPoQQz9PDf4pIkt7RerSgyLIHGdd24NUzAqzGIyH7mYLgf5lDOGzO9gjl1
 BS/7x1yatRopJz9Ux05T9Ho6eZcDvVUdeKsD+AbgGbAzOwRSmIX8v947d40Jv0RZToLQ
 5m5sfSK6V9iy8sUo6eTLVm8XRigpdbK9eSGiTAzI3EsMEGkgGruflgAwQMcaDwXj4Xlv
 0tsZn/xdSir8ltuYxBeSgINnw3qOIi7pBXvL77stVG3LJRdF8OLtm0ksqjgL1R+a+xlU
 Ep0yHobp55O4G6b0uQuWDkYg1de63Whlcgq1sGC/I19OqPPvhoPJg17b9khCsIe8ipYB
 6x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+wbOydoHJcrGiS0BnuKATAZrpNqvBjK0CPC4VxKCSdY=;
 b=KfxdfQUwSOZvCtEpftH8UOcHKvWC0aYf9jTGG/+l6ZRaaS7sL2Mck21xh8IA742utW
 qYntuteZHjaBqBxlmVOITblM30+NrVqCK+QdaP+FWAU+a3cT4J6Rzz2xtCVGh/K6fQya
 rRMLwhj9tNk2bLJ6pk7OZzBhQM7GrKH9D/anJFW9xykXFMVkgXVtnoVextz7szozc3s5
 aninatlS4T4MKXLcdBUT+sOFBl017BgkDaEltfu3yAa6jYtxSWdDW9hHWBYTfuxX0kOV
 3OcDoSB0lQdpycA2n4AbG48oT6vghSzWxTY+RsMuPWYV149v4IA3I702t6hX2MczNBjW
 pDNg==
X-Gm-Message-State: APjAAAUg7ILb2mGWhxFcQUfHHttQL+e6nPIR7IgcNzT0HpPIhltnxq4d
 BdG/Ju/1Kd/6UXdoLcbMgzZiEUzI8uQcPA==
X-Google-Smtp-Source: APXvYqzgIvVVpd9UbkN/jdHe5+SkbyLhq3BxhERjBa3xjghuRBLmrLtFE9Ex44WjfufkHajJ/UvpaQ==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr30585623wmj.90.1576494570181; 
 Mon, 16 Dec 2019 03:09:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/34] target/arm: Honor HCR_EL2.TID1 trapping requirements
Date: Mon, 16 Dec 2019 11:08:51 +0000
Message-Id: <20191216110904.30815-22-peter.maydell@linaro.org>
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

From: Marc Zyngier <maz@kernel.org>

HCR_EL2.TID1 mandates that access from EL1 to REVIDR_EL1, AIDR_EL1
(and their 32bit equivalents) as well as TCMTR, TLBTR are trapped
to EL2. QEMU ignores it, making it harder for a hypervisor to
virtualize the HW (though to be fair, no known hypervisor actually
cares).

Do the right thing by trapping to EL2 if HCR_EL2.TID1 is set.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191201122018.25808-3-maz@kernel.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1e546096b82..93ecab27c0c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1973,6 +1973,26 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return ret;
 }
 
+static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TID1)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_aa32_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        return access_aa64_tid1(env, ri, isread);
+    }
+
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo v7_cp_reginfo[] = {
     /* the old v6 WFI, UNPREDICTABLE in v7 but we choose to NOP */
     { .name = "NOP", .cp = 15, .crn = 7, .crm = 0, .opc1 = 0, .opc2 = 4,
@@ -2136,7 +2156,9 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
      */
     { .name = "AIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 7,
-      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_R, .type = ARM_CP_CONST,
+      .accessfn = access_aa64_tid1,
+      .resetvalue = 0 },
     /* Auxiliary fault status registers: these also are IMPDEF, and we
      * choose to RAZ/WI for all cores.
      */
@@ -6732,7 +6754,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .resetvalue = cpu->midr },
             { .name = "REVIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 6,
-              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
+              .access = PL1_R,
+              .accessfn = access_aa64_tid1,
+              .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
             REGINFO_SENTINEL
         };
         ARMCPRegInfo id_cp_reginfo[] = {
@@ -6748,14 +6772,18 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             /* TCMTR and TLBTR exist in v8 but have no 64-bit versions */
             { .name = "TCMTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 2,
-              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+              .access = PL1_R,
+              .accessfn = access_aa32_tid1,
+              .type = ARM_CP_CONST, .resetvalue = 0 },
             REGINFO_SENTINEL
         };
         /* TLBTR is specific to VMSA */
         ARMCPRegInfo id_tlbtr_reginfo = {
               .name = "TLBTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 3,
-              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0,
+              .access = PL1_R,
+              .accessfn = access_aa32_tid1,
+              .type = ARM_CP_CONST, .resetvalue = 0,
         };
         /* MPUIR is specific to PMSA V6+ */
         ARMCPRegInfo id_mpuir_reginfo = {
-- 
2.20.1


