Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78729C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DA62072E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfW98G6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DA62072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasee-0008Cp-Rh
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRi-0004ym-0E
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:50 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:41678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRg-0006yH-3O
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:49 -0500
Received: by mail-pl1-x62a.google.com with SMTP id w11so20453pll.8
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2fcZxHMc1N8IMdttXnckxhY78ayrgXYsVfY7nu4z0HQ=;
 b=yfW98G6TjHQjEOUKTeuzWMbHFxxJ24MVA3ojDfUt+r1BWrUvAylbtIMUsD760C9i1X
 1zwI8Q6dbS8ntt3lvTZYAxiR5uB/WNietqWaxMlbdzX3TWXS8VNeNfdwvuA76MpoV41G
 Pv0v/2WVaQLb4v4Nu55nL0OjtZF1kdF5WI3G9MhgzI5oEAepKdR2p+5DOKfQX4DHHRgU
 O6gW79jIIqILqpPUsekbSiX2NRF+ZphquyBuyjLNkEkObDlxCFDqpvymkpyvdLe+RiRY
 VXkpIpPdKw68iKSEr1cPDk8rpK9wsc1CKGwoJbR4AjfsvjVyUSl16E+uZGGR7MJ2M4/m
 tKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2fcZxHMc1N8IMdttXnckxhY78ayrgXYsVfY7nu4z0HQ=;
 b=naTrtQ5XGp5dMICFTXL8uLb7ECLIHnkGk8Dsf0dRJML+Lc5g++35o1M9ZLeKFMRZMw
 U/j/XkmYiXXjJbUHrsbvZj0V74d6ESaOuqdTYnTW9JbVkeAGqfTP3PIPzDu7EaELAYof
 1hJwLt1A8B7wGa/gDnXEkGQvc6HJRGExnGy8b+JqZmfGxTzWPezSFOUXnbBB+YVduoQM
 ggLrrRPFIdGcKgzbJrVTNPkrf5V+AprAG3WKDRQ75MUW2JiS4UwFAa/8soW27fptNcD8
 Gs+rai9m/wUWrpgXnObKdEuGYAu74H+dU9za5+Y8fW+J3nGuFBHyPOT6KkBpSN8/m2eb
 w17w==
X-Gm-Message-State: AOAM532jZpIJg2yCIUi5AR0FNyjKMoVWTtdDVPqe+akak/T+K+/hQJwM
 0njMyOIZQ3Jg3uSmnND2AM5IepiVBb6Gcg==
X-Google-Smtp-Source: ABdhPJwIjwkvrrRbdrrprdVtuj8lwoIN5T0wu7rZxAtL7+SH30/lXm0rwaG8z6wP1yCOCEvzc+7sOA==
X-Received: by 2002:a17:902:9347:b029:d3:b2c6:1500 with SMTP id
 g7-20020a1709029347b02900d3b2c61500mr31383plp.5.1604633386385; 
 Thu, 05 Nov 2020 19:29:46 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/41] tcg/i386: Support split-wx code generation
Date: Thu,  5 Nov 2020 19:28:58 -0800
Message-Id: <20201106032921.600200-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.c.inc | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 1b9d41bd56..bbbd1c2d4a 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -236,6 +236,6 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       0
+#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 7f74c77d7f..23c7a8a383 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -165,7 +165,7 @@ static bool have_lzcnt;
 # define have_lzcnt 0
 #endif
 
-static tcg_insn_unit *tb_ret_addr;
+static const tcg_insn_unit *tb_ret_addr;
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
@@ -173,7 +173,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     value += addend;
     switch(type) {
     case R_386_PC32:
-        value -= (uintptr_t)code_ptr;
+        value -= (uintptr_t)tcg_splitwx_to_rx(code_ptr);
         if (value != (int32_t)value) {
             return false;
         }
@@ -182,7 +182,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         tcg_patch32(code_ptr, value);
         break;
     case R_386_PC8:
-        value -= (uintptr_t)code_ptr;
+        value -= (uintptr_t)tcg_splitwx_to_rx(code_ptr);
         if (value != (int8_t)value) {
             return false;
         }
@@ -1006,7 +1006,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     }
 
     /* Try a 7 byte pc-relative lea before the 10 byte movq.  */
-    diff = arg - ((uintptr_t)s->code_ptr + 7);
+    diff = tcg_pcrel_diff(s, (const void *)arg) - 7;
     if (diff == (int32_t)diff) {
         tcg_out_opc(s, OPC_LEA | P_REXW, ret, 0, 0);
         tcg_out8(s, (LOWREGMASK(ret) << 3) | 5);
@@ -1615,7 +1615,7 @@ static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
     tcg_out_branch(s, 1, dest);
 }
 
-static void tcg_out_jmp(TCGContext *s, tcg_insn_unit *dest)
+static void tcg_out_jmp(TCGContext *s, const tcg_insn_unit *dest)
 {
     tcg_out_branch(s, 0, dest);
 }
@@ -1786,7 +1786,8 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, bool is_64,
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
-    label->raddr = raddr;
+    /* TODO: Cast goes away when all hosts converted */
+    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr[0];
     if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
         label->label_ptr[1] = label_ptr[1];
@@ -2280,7 +2281,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
             /* jump displacement must be aligned for atomic patching;
              * see if we need to add extra nops before jump
              */
-            gap = tcg_pcrel_diff(s, QEMU_ALIGN_PTR_UP(s->code_ptr + 1, 4));
+            gap = QEMU_ALIGN_PTR_UP(s->code_ptr + 1, 4) - s->code_ptr;
             if (gap != 1) {
                 tcg_out_nopn(s, gap - 1);
             }
@@ -3825,11 +3826,12 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
      * and fall through to the rest of the epilogue.
      */
-    tcg_code_gen_epilogue = s->code_ptr;
+    /* TODO: Cast goes away when all hosts converted */
+    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_EAX, 0);
 
     /* TB epilogue */
-    tb_ret_addr = s->code_ptr;
+    tb_ret_addr = tcg_splitwx_to_rx(s->code_ptr);
 
     tcg_out_addi(s, TCG_REG_CALL_STACK, stack_addend);
 
-- 
2.25.1


