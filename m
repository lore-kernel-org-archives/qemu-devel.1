Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB2AC433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205AC2087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOuKwYgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205AC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htz9t-000185-Ew
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60690)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4k-0006EG-6L
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4i-0007B1-06
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:18 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4h-00079z-3Y
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:15 -0400
Received: by mail-pl1-x641.google.com with SMTP id az7so34857647plb.5
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BmJBoz3ocCwfjPIQpLnVRF2wr3dk36b5G/HujhxQoNg=;
 b=XOuKwYgouGDpkaX6L6Uu/ztO4LamAjukWRR1TU+AbO+9d8EmzEJYGDgd3wbWL+1eQn
 FoDehmYmUS91lcRg8bfPfB94G6o/PJLpxhj86ESqDCIBvqYfIH3+AH9bJvaa+UdX7iPk
 jvuhHyVBQD1BGOx1IIU+wgGZN8QBO/0omjs6XaXVN7XIdVAHGJE8Qnc7KKnvmQV+/jyF
 FLW5nklHtdH2xKYULu3K82i8NFlqdfNFh2giImdOFsgyivibizZVPqg62mqkrvHKEIF4
 Vq7/+zZCwlmLTqkj/DomwraVUncNHLrHbGLpQc1/lczLH+39ypVYm5oRoVo0WJvRuhQZ
 bXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BmJBoz3ocCwfjPIQpLnVRF2wr3dk36b5G/HujhxQoNg=;
 b=eek/sgSSHBqLoqQ61ey7tPAVSrFCZqSMNbcg0P1ROrCa0tFSGpp172eQqKLnRH32MO
 zJv53T8xwScPcXCmDMPh26VqINfIoGk2pquaQL6LJWvp3ZYi9Ro2Op8uXh5/egakL9T7
 5qMSrdjJHTslIU9onrw0Yx6yzYmiqmsKI70QI0eplGGrIRgbSMadYCdvoZQ7VezPm+bl
 nUGmmxXOWp3erhG5dfAU0urwN4/XOlOwr/aui4dx5WL0UUVVxldJrrdPf6xlPIIPfFnZ
 dxOQ88d++/rgbT2d/EA837q2HgNZD2yAkmm2A+ka5Q/ptUOUpoxmaFVYWLbB05FD18AX
 lGiw==
X-Gm-Message-State: APjAAAV5fIwryGzznebbwrsmIkyhh2nUIUfGORQCFXEYv6rAGyfwgEJc
 zDE6q2fq8BnEqjeyEm6bShQNuGqO/NM=
X-Google-Smtp-Source: APXvYqy3NZ0JwOMcjCjgjaGzWuxYx3JBrhUhZSKO73Lmx08vvEg1w/X1okbZIcUL/2TTKu7mSSGoMQ==
X-Received: by 2002:a17:902:bc83:: with SMTP id
 bb3mr140601680plb.56.1564858092641; 
 Sat, 03 Aug 2019 11:48:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:34 -0700
Message-Id: <20190803184800.8221-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 08/34] target/arm: Add CONTEXTIDR_EL2
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
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
index 9a18ecf8f6..8baeb3f319 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6801,6 +6801,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


