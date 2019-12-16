Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA53C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EB620700
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9Uomrsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EB620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igolI-0001Gt-JI
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFr-00082A-RJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFq-000062-Jt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:35 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFq-0008Vn-Du
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:34 -0500
Received: by mail-wr1-x443.google.com with SMTP id q6so6697565wro.9
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KOuvuhSQj8eVtemKGzERysHw3TTzF7KdECnJyVpBO44=;
 b=L9UomrsiCIUENvz8DMMGlb1kRhNSSAIyCIk9XqREeCcPypLv628qQ9gUDMFDBBS8d7
 KZ28E9uSTcOwn9mJgXx3yRdCA7pKZw9z5CJEDHfX6CLb0NTm/jP7/z7tTHuai8q0mbwW
 6vqJrN9kkQB4PxbZ7pkNODoQ1WfnmZ+geYlOTn553PCmjGz//RXh5+zeR/JM0s3uADEv
 PATZzkuQDImdJKqdBkj5x+8eSv8T/n6QLBjcWnghWNLJhRQ0yabESoiDeuhq62Cas0tY
 rEvdQ2p7maLkG8imKLYVmwreW2BkODmbDCm20u73Jf5syOqG5SZutn5WSn1X+AgikPYg
 GKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KOuvuhSQj8eVtemKGzERysHw3TTzF7KdECnJyVpBO44=;
 b=OfJL0kxm6nie43FITB/Xtpnl/mxpkH9uB+CqNFsp4i9FBB/LScuV+VDP+T6fRjjPJA
 fsXYdsJBMwwGer0AW3I6qP+Aymi61X9nEETBi0+DZX3pb1uneXyy61rWLQ68jqMPtZAY
 SlxNjg6Ja9SHEskhg0gOiVgylxDJCM695ppkyjQ0wWhT4uQw90Y/l61iLm3ssxZIjZRk
 q63K0Cx7ozWqAmT0bMSlbyzcFtQ759GQPepptxPVtNBkS5qesfcp3tlCNBNmncVeetWQ
 3BuiU8Fy2WQM0Z35cxzqs1Ev0DcSlfQaBGygLynlUFvh3NoQcSxciN884ly3sEqheSUF
 NDjw==
X-Gm-Message-State: APjAAAUP2JDQOP/oOuRUR+vtMu3CZVP7fMSuE5L87GFE+qe/oirW+cUx
 ypG25S/hpq7Beb8Ts5DP53U8ceBFr69oyw==
X-Google-Smtp-Source: APXvYqylEoh8JbyhwbHouBrj5it3Z1rJA4SLQMlnLHslhust0lAauhOkqGuooNkFvxM0JLvXJSQNVw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr29310022wrp.1.1576494573226; 
 Mon, 16 Dec 2019 03:09:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/34] target/arm: Add support for missing Jazelle system
 registers
Date: Mon, 16 Dec 2019 11:08:54 +0000
Message-Id: <20191216110904.30815-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc Zyngier <maz@kernel.org>

QEMU lacks the minimum Jazelle implementation that is required
by the architecture (everything is RAZ or RAZ/WI). Add it
together with the HCR_EL2.TID0 trapping that goes with it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191201122018.25808-6-maz@kernel.org
[PMM: moved ARMCPRegInfo array to file scope, marked it
 'static global', moved new condition down in
 register_cp_regs_for_features() to go with other feature
 things rather than up with the v6/v7/v8 stuff]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0ba08d550aa..a4f7b61b4e1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6040,6 +6040,30 @@ static CPAccessResult access_aa32_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_jazelle(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TID0)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static const ARMCPRegInfo jazelle_regs[] = {
+    { .name = "JIDR",
+      .cp = 14, .crn = 0, .crm = 0, .opc1 = 7, .opc2 = 0,
+      .access = PL1_R, .accessfn = access_jazelle,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "JOSCR",
+      .cp = 14, .crn = 1, .crm = 0, .opc1 = 7, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "JMCR",
+      .cp = 14, .crn = 2, .crm = 0, .opc1 = 7, .opc2 = 0,
+      .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
+    REGINFO_SENTINEL
+};
+
 void register_cp_regs_for_features(ARMCPU *cpu)
 {
     /* Register all the coprocessor registers based on feature bits */
@@ -6699,6 +6723,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         define_arm_cp_regs(cpu, lpae_cp_reginfo);
     }
+    if (cpu_isar_feature(jazelle, cpu)) {
+        define_arm_cp_regs(cpu, jazelle_regs);
+    }
     /* Slightly awkwardly, the OMAP and StrongARM cores need all of
      * cp15 crn=0 to be writes-ignored, whereas for other cores they should
      * be read-only (ie write causes UNDEF exception).
-- 
2.20.1


