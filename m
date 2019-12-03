Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F255BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15EE206DC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7X7emm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15EE206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby0B-0005Ds-BZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwf-0002zN-SG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwe-0007yg-JJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:45 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwe-0007xM-Cx
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:44 -0500
Received: by mail-pf1-x441.google.com with SMTP id b19so991642pfo.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+TWIlcZZrmEqGDmi7NHEaLblsjTyqMT3Bn6OGEgJfYE=;
 b=C7X7emm81rhXLpsyakilwuRbZmwY9k57/rLnqpPuLP2oDBHZC8kT1JZCo/QE/wgMya
 xmD1wwwYDIx9FomLmomyd93WLmzr9+kd4/AufCyVFxpl2ZbhULH3HtINeXSB2s0DAEdR
 4Jvk84gsOsR9Y1QtadUN61vbAWhKI/S9O8tgcdjw+QxranMRoLpRLbuGLngHJLEQst4d
 yNZWjV5pgOWMsGZyo4dFrEIfMf5U0Mo7hMvomd0YMOYK1ONsW9INsO4+wIVixdQVo/B9
 fRIVL4wYcWLVC5aX47qXeKiIahCGFTNilTJkNTpunc+Ym4ktvimSY9d7Pzbdfej+2lrs
 GTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+TWIlcZZrmEqGDmi7NHEaLblsjTyqMT3Bn6OGEgJfYE=;
 b=L/3d7QPHTcJLrwkQfBdIxl+SR5ZeJxr93XL/XezPhpLMZ5IZ/9k8tAW1QZek4XZOK/
 g2mqX+6COqZPB3wK98AwPmYiQklvj5ff2iVOuZg4oHz25ABk3GWwBC1ekrlynDxA9jsd
 4ZwMbbCz8C65qcWiATwFejPhPuc6XLTynnVY4qn/OqdENXg7ao1kkUlNrUWdfxCfOY1U
 txOGKuH04uW3vfacRZoJBFZN5KQdlxn5zsBWcQXyZVEyHvKodXv5CnG4Ie2zmZwjRDEv
 ZFEDtSK11DG0CiYBcm985m79YWvRTmd67IE5h+NomhXxXIFPiyBud5oRdSi2KtY1dJaE
 ow6w==
X-Gm-Message-State: APjAAAWy4LkF4DO782N5Zt610CcOHvGem/5XIbEWFg+gvs3BkZewaim0
 N9I1U5/i9ku8xJIG5vMtJ7s3JhUiiiw=
X-Google-Smtp-Source: APXvYqyXcpakRRlr9/Bmf40W1VRjxTgj7G076ZgihLbithgZaUvpMhgrWLfOLJ5DrAp6WgKcxUQ/mA==
X-Received: by 2002:a63:184c:: with SMTP id 12mr2829694pgy.418.1575340183028; 
 Mon, 02 Dec 2019 18:29:43 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/40] target/arm: Add CONTEXTIDR_EL2
Date: Mon,  2 Dec 2019 18:29:00 -0800
Message-Id: <20191203022937.1474-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all of the breakpoint types are supported, but those that
only examine contextidr are extended to support the new register.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/debug_helper.c | 50 +++++++++++++++++++++++++++++----------
 target/arm/helper.c       | 11 +++++++++
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index dde80273ff..2e3e90c6a5 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -20,6 +20,7 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     int ctx_cmps = extract32(cpu->dbgdidr, 20, 4);
     int bt;
     uint32_t contextidr;
+    uint64_t hcr_el2;
 
     /*
      * Links to unimplemented or non-context aware breakpoints are
@@ -40,24 +41,44 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     }
 
     bt = extract64(bcr, 20, 4);
-
-    /*
-     * We match the whole register even if this is AArch32 using the
-     * short descriptor format (in which case it holds both PROCID and ASID),
-     * since we don't implement the optional v7 context ID masking.
-     */
-    contextidr = extract64(env->cp15.contextidr_el[1], 0, 32);
+    hcr_el2 = arm_hcr_el2_eff(env);
 
     switch (bt) {
     case 3: /* linked context ID match */
-        if (arm_current_el(env) > 1) {
-            /* Context matches never fire in EL2 or (AArch64) EL3 */
+        switch (arm_current_el(env)) {
+        default:
+            /* Context matches never fire in AArch64 EL3 */
             return false;
+        case 2:
+            if (!(hcr_el2 & HCR_E2H)) {
+                /* Context matches never fire in EL2 without E2H enabled. */
+                return false;
+            }
+            contextidr = env->cp15.contextidr_el[2];
+            break;
+        case 1:
+            contextidr = env->cp15.contextidr_el[1];
+            break;
+        case 0:
+            if ((hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                contextidr = env->cp15.contextidr_el[2];
+            } else {
+                contextidr = env->cp15.contextidr_el[1];
+            }
+            break;
         }
-        return (contextidr == extract64(env->cp15.dbgbvr[lbn], 0, 32));
-    case 5: /* linked address mismatch (reserved in AArch64) */
+        break;
+
+    case 7:  /* linked contextidr_el1 match */
+        contextidr = env->cp15.contextidr_el[1];
+        break;
+    case 13: /* linked contextidr_el2 match */
+        contextidr = env->cp15.contextidr_el[2];
+        break;
+
     case 9: /* linked VMID match (reserved if no EL2) */
     case 11: /* linked context ID and VMID match (reserved if no EL2) */
+    case 15: /* linked full context ID match */
     default:
         /*
          * Links to Unlinked context breakpoints must generate no
@@ -66,7 +87,12 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
         return false;
     }
 
-    return false;
+    /*
+     * We match the whole register even if this is AArch32 using the
+     * short descriptor format (in which case it holds both PROCID and ASID),
+     * since we don't implement the optional v7 context ID masking.
+     */
+    return contextidr == (uint32_t)env->cp15.dbgbvr[lbn];
 }
 
 static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d81daadf45..b4d774632d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6953,6 +6953,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, lor_reginfo);
     }
 
+    if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, cpu)) {
+        static const ARMCPRegInfo vhe_reginfo[] = {
+            { .name = "CONTEXTIDR_EL2", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 1,
+              .access = PL2_RW,
+              .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[2]) },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, vhe_reginfo);
+    }
+
     if (cpu_isar_feature(aa64_sve, cpu)) {
         define_one_arm_cp_reg(cpu, &zcr_el1_reginfo);
         if (arm_feature(env, ARM_FEATURE_EL2)) {
-- 
2.17.1


