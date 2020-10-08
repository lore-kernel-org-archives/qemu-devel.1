Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26202C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3FE2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+qQeB4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3FE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVao-0001nT-BO
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTu-0003d0-JB
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:14 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:41019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTr-0001xD-VF
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:14 -0400
Received: by mail-oi1-x231.google.com with SMTP id q136so4988905oic.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W+OIgxh1X4FjLRLRziiRSeMVMSIyenZxG7ukb0+dNkc=;
 b=g+qQeB4c/T1d7UYugCcJMwKOiHlEoytlKEfHf6Nxr3+33afnWlUnDS492wW01iQiLL
 JIRREpe0/mSiCkwmwnQ1PjiM+OanhkyVNEk4bHB4ondZVvBXOcwN4xtVZk7PRSe3tY7w
 gtEu8buA0jO/LGZsUvbxHlcL+zn1zzPscj3kNSyvoaosHxCOvvxCU12xu1KJsmLDrLyC
 M+We3EUpUGR7n/amYUeSdGuH1skDJF3ucn/Syb54Nn2gyUmD0iCxNIeiiNzTYj6dBsqb
 Bq2OoVvvi0wH/NHE7/QvXTiyCkl79Z/E61oLLoamFn5LppQfpiMtWFsdJ6Q41GIUli/E
 ABMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W+OIgxh1X4FjLRLRziiRSeMVMSIyenZxG7ukb0+dNkc=;
 b=dORgRM42RE8pl2gt6N2zGdwal7fZV+wg0rH5c10f3cY0VsPLDBMZEu9txgrK4u3EV1
 5eR2o/pS7z+Lyw00dAEFdmvn5nMRlR4FFmVzRotpsxygunqa/33Mz5cR4DN2adjnyuev
 YMWJYvnQCaS4gvoEqOTCrCy81ZYOR06HSs2lAPdrhL6aJI1DITDCocZZwRkttHGQsS/0
 pfW4i0MDbbiokx+B0LP33Ej/9+1ft0jSspRU+8HeB7lhZOL07TgykxkItEsljb4911JA
 IO8YMPi3KFxBZrNb2Pqd+wg2YCyZr17bl/uB5fMffaZXbCu6k78QdLVCwMSbOHvKEfzq
 A2Zw==
X-Gm-Message-State: AOAM532FOAOP3UfPHXjCl53Qxlz8TatOARPp9zN11cfv+BmG4gk2+QjM
 xYvydlHJwxMZBX5cVqDDjmMWrMPbA/XbEvd9
X-Google-Smtp-Source: ABdhPJwBKUrQWGLtnKIHKBRhedwJ37T212hsZgOWSpA0qpwBIBJpv8nJp4DDUpG8Dkf2Ufi2WmmkHg==
X-Received: by 2002:aca:ba07:: with SMTP id k7mr5195890oif.159.1602161829948; 
 Thu, 08 Oct 2020 05:57:09 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] tcg: Remove TCG_CT_REG
Date: Thu,  8 Oct 2020 07:56:52 -0500
Message-Id: <20201008125659.49857-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This wasn't actually used for anything, really.  All variable
operands must accept registers, and which are indicated by the
set in TCGArgConstraint.regs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            |  1 -
 tcg/tcg.c                    | 15 ++++-----------
 tcg/aarch64/tcg-target.c.inc |  3 ---
 tcg/arm/tcg-target.c.inc     |  3 ---
 tcg/i386/tcg-target.c.inc    | 11 -----------
 tcg/mips/tcg-target.c.inc    |  3 ---
 tcg/ppc/tcg-target.c.inc     |  5 -----
 tcg/riscv/tcg-target.c.inc   |  2 --
 tcg/s390/tcg-target.c.inc    |  4 ----
 tcg/sparc/tcg-target.c.inc   |  5 -----
 tcg/tci/tcg-target.c.inc     |  1 -
 11 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 63955ac85b..3168315bb8 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -979,7 +979,6 @@ void tcg_dump_op_count(void);
 #define TCG_CT_ALIAS  0x80
 #define TCG_CT_IALIAS 0x40
 #define TCG_CT_NEWREG 0x20 /* output requires a new register */
-#define TCG_CT_REG    0x01
 #define TCG_CT_CONST  0x02 /* any constant of register size */
 
 typedef struct TCGArgConstraint {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index da01e39fe4..55b2fc3ae3 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2194,21 +2194,14 @@ static void tcg_dump_ops(TCGContext *s, bool have_prefs)
 /* we give more priority to constraints with less registers */
 static int get_constraint_priority(const TCGOpDef *def, int k)
 {
-    const TCGArgConstraint *arg_ct;
+    const TCGArgConstraint *arg_ct = &def->args_ct[k];
+    int n;
 
-    int i, n;
-    arg_ct = &def->args_ct[k];
     if (arg_ct->ct & TCG_CT_ALIAS) {
         /* an alias is equivalent to a single register */
         n = 1;
     } else {
-        if (!(arg_ct->ct & TCG_CT_REG))
-            return 0;
-        n = 0;
-        for(i = 0; i < TCG_TARGET_NB_REGS; i++) {
-            if (tcg_regset_test_reg(arg_ct->regs, i))
-                n++;
-        }
+        n = ctpop64(arg_ct->regs);
     }
     return TCG_TARGET_NB_REGS - n + 1;
 }
@@ -2276,7 +2269,7 @@ static void process_op_defs(TCGContext *s)
                         int oarg = *ct_str - '0';
                         tcg_debug_assert(ct_str == tdefs->args_ct_str[i]);
                         tcg_debug_assert(oarg < def->nb_oargs);
-                        tcg_debug_assert(def->args_ct[oarg].ct & TCG_CT_REG);
+                        tcg_debug_assert(def->args_ct[oarg].regs != 0);
                         /* TCG_CT_ALIAS is for the output arguments.
                            The input is tagged with TCG_CT_IALIAS. */
                         def->args_ct[i] = def->args_ct[oarg];
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index dbe5c6a14c..26f71cb599 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -128,15 +128,12 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 {
     switch (*ct_str++) {
     case 'r': /* general registers */
-        ct->ct |= TCG_CT_REG;
         ct->regs |= 0xffffffffu;
         break;
     case 'w': /* advsimd registers */
-        ct->ct |= TCG_CT_REG;
         ct->regs |= 0xffffffff00000000ull;
         break;
     case 'l': /* qemu_ld / qemu_st address, data_reg */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffffu;
 #ifdef CONFIG_SOFTMMU
         /* x0 and x1 will be overwritten when reading the tlb entry,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 978eb1dd70..62c37a954b 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -253,13 +253,11 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         break;
 
     case 'r':
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffff;
         break;
 
     /* qemu_ld address */
     case 'l':
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffff;
 #ifdef CONFIG_SOFTMMU
         /* r0-r2,lr will be overwritten when reading the tlb entry,
@@ -274,7 +272,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 
     /* qemu_st address & data */
     case 's':
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffff;
         /* r0-r2 will be overwritten when reading the tlb entry (softmmu only)
            and r0-r1 doing the byte swapping, so don't use these. */
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8661ec3393..2f696074ab 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -208,42 +208,33 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 {
     switch(*ct_str++) {
     case 'a':
-        ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->regs, TCG_REG_EAX);
         break;
     case 'b':
-        ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->regs, TCG_REG_EBX);
         break;
     case 'c':
-        ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->regs, TCG_REG_ECX);
         break;
     case 'd':
-        ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->regs, TCG_REG_EDX);
         break;
     case 'S':
-        ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->regs, TCG_REG_ESI);
         break;
     case 'D':
-        ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->regs, TCG_REG_EDI);
         break;
     case 'q':
         /* A register that can be used as a byte operand.  */
-        ct->ct |= TCG_CT_REG;
         ct->regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xf;
         break;
     case 'Q':
         /* A register with an addressable second byte (e.g. %ah).  */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xf;
         break;
     case 'r':
         /* A general register.  */
-        ct->ct |= TCG_CT_REG;
         ct->regs |= ALL_GENERAL_REGS;
         break;
     case 'W':
@@ -252,13 +243,11 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         break;
     case 'x':
         /* A vector register.  */
-        ct->ct |= TCG_CT_REG;
         ct->regs |= ALL_VECTOR_REGS;
         break;
 
         /* qemu_ld/st address constraint */
     case 'L':
-        ct->ct |= TCG_CT_REG;
         ct->regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xff;
         tcg_regset_reset_reg(ct->regs, TCG_REG_L0);
         tcg_regset_reset_reg(ct->regs, TCG_REG_L1);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index aae4fd187b..41be574e89 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -195,11 +195,9 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 {
     switch(*ct_str++) {
     case 'r':
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         break;
     case 'L': /* qemu_ld input arg constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         tcg_regset_reset_reg(ct->regs, TCG_REG_A0);
 #if defined(CONFIG_SOFTMMU)
@@ -209,7 +207,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 #endif
         break;
     case 'S': /* qemu_st constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         tcg_regset_reset_reg(ct->regs, TCG_REG_A0);
 #if defined(CONFIG_SOFTMMU)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 0bd947b788..18ee989f95 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -224,19 +224,15 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 {
     switch (*ct_str++) {
     case 'A': case 'B': case 'C': case 'D':
-        ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->regs, 3 + ct_str[0] - 'A');
         break;
     case 'r':
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         break;
     case 'v':
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff00000000ull;
         break;
     case 'L':                   /* qemu_ld constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         tcg_regset_reset_reg(ct->regs, TCG_REG_R3);
 #ifdef CONFIG_SOFTMMU
@@ -245,7 +241,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 #endif
         break;
     case 'S':                   /* qemu_st constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         tcg_regset_reset_reg(ct->regs, TCG_REG_R3);
 #ifdef CONFIG_SOFTMMU
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 0a69839adb..d536f3ccc1 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -137,12 +137,10 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 {
     switch (*ct_str++) {
     case 'r':
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         break;
     case 'L':
         /* qemu_ld/qemu_st constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         /* qemu_ld/qemu_st uses TCG_REG_TMP0 */
 #if defined(CONFIG_SOFTMMU)
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index 9cd266a2d0..c5e096449b 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -408,23 +408,19 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 {
     switch (*ct_str++) {
     case 'r':                  /* all registers */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffff;
         break;
     case 'L':                  /* qemu_ld/st constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffff;
         tcg_regset_reset_reg(ct->regs, TCG_REG_R2);
         tcg_regset_reset_reg(ct->regs, TCG_REG_R3);
         tcg_regset_reset_reg(ct->regs, TCG_REG_R4);
         break;
     case 'a':                  /* force R2 for division */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0;
         tcg_regset_set_reg(ct->regs, TCG_REG_R2);
         break;
     case 'b':                  /* force R3 for division */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0;
         tcg_regset_set_reg(ct->regs, TCG_REG_R3);
         break;
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index e2de749af7..6775bd30fc 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -325,15 +325,12 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 {
     switch (*ct_str++) {
     case 'r':
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         break;
     case 'R':
-        ct->ct |= TCG_CT_REG;
         ct->regs = ALL_64;
         break;
     case 'A': /* qemu_ld/st address constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = TARGET_LONG_BITS == 64 ? ALL_64 : 0xffffffff;
     reserve_helpers:
         tcg_regset_reset_reg(ct->regs, TCG_REG_O0);
@@ -341,11 +338,9 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         tcg_regset_reset_reg(ct->regs, TCG_REG_O2);
         break;
     case 's': /* qemu_st data 32-bit constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = 0xffffffff;
         goto reserve_helpers;
     case 'S': /* qemu_st data 64-bit constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = ALL_64;
         goto reserve_helpers;
     case 'I':
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index a7215f346f..231b9b1775 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -392,7 +392,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'r':
     case 'L':                   /* qemu_ld constraint */
     case 'S':                   /* qemu_st constraint */
-        ct->ct |= TCG_CT_REG;
         ct->regs = BIT(TCG_TARGET_NB_REGS) - 1;
         break;
     default:
-- 
2.25.1


