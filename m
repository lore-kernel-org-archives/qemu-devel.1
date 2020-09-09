Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FCEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C0F2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoCBD4Bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C0F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnoD-000194-If
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnH-0007fa-VN
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:59 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:40904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnF-00029k-4i
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:59 -0400
Received: by mail-pg1-x530.google.com with SMTP id j34so728092pgi.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8o0uWhLzeN38mYwNmOczSIkntUGVwMo0kdZUPs4vnow=;
 b=BoCBD4BzW+AO1LLUMxIrUqNhGQhHQwq/R6RMyTr31FfG8qfzDoIQ1QZNfkqhXZimXO
 Y+xjT0sU69Cf70OPFbuMRGf19NJk5rsTDX0KYUPFKtdQtyCjnxU+GoYxTvH98kd1FZpV
 RK3KU3yPgNBFFWntmUUi5o7hErvrcoEKio1cybQQ02kFVBsSH/VXNp6BteMEkz+0mpBk
 /lrKAacRx359714DgO0iLwmaphGwo69q+5ft6wVDarHPhYVzqZ89x0baBTlx6Nw8zBq6
 IDD5wi+gQtQKiFO0k6FKy245Ge0JB7G3XvY4zp4Ea0Cop+qsK3ZTwwr2VwOXpJxHcjWS
 DH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8o0uWhLzeN38mYwNmOczSIkntUGVwMo0kdZUPs4vnow=;
 b=F0WtAYVt+AhHvL6zz+wVA6YjLsjsEa4tSW7eQl37bacABrwAXx800LFdV9UoIW1rfQ
 uudrfOoQ5uVAD08FVM1Ta37CbQKb4XoQXsHJyeIOL6tGU4ZzuBk5nQdbzET9N333bdj5
 Se66ZQrve3swwucnePK+0Qy8ihFQLWUtIx73lxgYk0d73JjXdD4n+06eB7SdKjQQfVoT
 VXMwojOCT3wJxQ32fZ4LZnh6VqHybtY7or5tsDcks8JnFTclHjiIq4z45YjnajvTC3q+
 rg+FV60TbDZO3hdNVx4MyNvn9suN3qV1yatVSn8tBWuWqQW3+AjHZ0WiXT+VkpcQasS9
 p8yA==
X-Gm-Message-State: AOAM532OTtp1udJjO6GjlptVaR0/OYqBpVeWioiPJLn8MDdNaxRTPm47
 AWSEpPOo8Alnirlt7y9evXdR6bZce1IhWQ==
X-Google-Smtp-Source: ABdhPJyzzBXJRm84FzikqZZ3Qvw14/jKkd92CIEpe4fNCYjvWC62P37rqPYnl0wuItBtxgl4rmvdgw==
X-Received: by 2002:aa7:961b:0:b029:13e:d13d:a140 with SMTP id
 q27-20020aa7961b0000b029013ed13da140mr1547069pfg.40.1599610614952; 
 Tue, 08 Sep 2020 17:16:54 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.16.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:16:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/43] tcg: Remove TCG_CT_REG
Date: Tue,  8 Sep 2020 17:16:08 -0700
Message-Id: <20200909001647.532249-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
index 0a04b6cbd9..a618497c94 100644
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
index d4b7cb4867..479a9d26be 100644
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
index d49a02bb03..98c6a41caf 100644
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
index 450b555522..7a5760bb23 100644
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
index c662293fc7..44373d742b 100644
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


