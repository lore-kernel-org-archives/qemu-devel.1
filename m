Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A2C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9303A20776
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUW1bOw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9303A20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqN7-0004Jy-NO
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBu-0004PX-L6
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBt-0005ay-0M
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:38 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqBs-0005YH-R1
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id t11so2768523pgg.2
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GuLBXp+DHzvjBbWtLt3J1mN+KRme5ZQDBMNQ1V2Bki4=;
 b=qUW1bOw+SBbr6zLeMUTBFcV2tFSKdCgabbs5tgg/hXhDOFe9NounJu8binVdQxOL01
 FsxwdkDY5FofahDlsGbSoasi3FnUmI1VOFK9q9O4zsrS9UGSb2yBBowegf9Y4/jx33za
 4WflFVrj0MoCtBMFlY1SWkEiIGOWkLQpsnl3EoOMijhZX5Am3SVlRdnSQo+HjY/+RCO0
 YVloAeSjOdjCF7RhDbaZVmgZkNJj04LLkW8zpuigWPxx/7PcMidXZzTTsE2roYKR//+x
 O5DJ42xASeQptR4zLqV1V9r4llJg8MbQLzwX/DAWnBiuErb9Ljdah9tsW1RUtTBX/1y2
 8Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GuLBXp+DHzvjBbWtLt3J1mN+KRme5ZQDBMNQ1V2Bki4=;
 b=rbSx/RjAlebvsDeKr5FGU4jJqeSaMEI8LPqT7Kc2Cjfq8lPB1vP8XQx9NIdBj3H9+n
 +M8upLzinUi4vfL9Wpu2Tw41CXSu7mQPJJOoq+p/7kr0x14rfgAffVYCzD0EMi2xB2+H
 bJyKkXlwy3oUinLO2MmwdnFL3+PS42MuelU4tbg+USZ2stIy/s1cNoNTSyAm50kiCkRP
 Mcj3eaS32/Cb63dOMvZfvK0K7Ts2ISfzThhHcHnikfkVkknuI6/hQQvimmTb6o5T0d0r
 5rUHedO8iwHre7usxfsCa+ZJH5ZOHYaoUMsNFKbmgjrhRjv+clCpsbH+IRxRzmxOul2r
 2oTA==
X-Gm-Message-State: AGi0Pub+1zwrUfQcZd0Ari5Hg30cVoRGlhuI6zRklht0I19BA6ht9NI+
 fnUgHT/iEkneicQwhD5AcNfEp/wfVMQ=
X-Google-Smtp-Source: APiQypKAQhrTmArN+c2D/K5LPUEFzJW8wT/hbovUcfl2i4nq14T/24CjTJb8l7t2YiwNYcUJ6DKFgQ==
X-Received: by 2002:a63:6c83:: with SMTP id h125mr8941032pgc.168.1587226775385; 
 Sat, 18 Apr 2020 09:19:35 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i187sm22398382pfc.112.2020.04.18.09.19.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:19:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] tcg: Add tcg_reg_alloc_dup2
Date: Sat, 18 Apr 2020 09:19:12 -0700
Message-Id: <20200418161914.4387-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418161914.4387-1-richard.henderson@linaro.org>
References: <20200418161914.4387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

There are several ways we can expand a vector dup of a 64-bit
element on a 32-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index fc1c97d586..d712d19842 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3870,6 +3870,91 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     }
 }
 
+static void tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
+{
+    const TCGLifeData arg_life = op->life;
+    TCGTemp *ots, *itsl, *itsh;
+    TCGType vtype = TCGOP_VECL(op) + TCG_TYPE_V64;
+
+    /* This opcode is only valid for 32-bit hosts, for 64-bit elements. */
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+    tcg_debug_assert(TCGOP_VECE(op) == MO_64);
+
+    ots = arg_temp(op->args[0]);
+    itsl = arg_temp(op->args[1]);
+    itsh = arg_temp(op->args[2]);
+
+    /* ENV should not be modified.  */
+    tcg_debug_assert(!temp_readonly(ots));
+
+    /* Allocate the output register now.  */
+    if (ots->val_type != TEMP_VAL_REG) {
+        TCGRegSet allocated_regs = s->reserved_regs;
+        TCGRegSet dup_out_regs =
+            tcg_op_defs[INDEX_op_dup_vec].args_ct[0].u.regs;
+
+        /* Make sure to not spill the input registers. */
+        if (!IS_DEAD_ARG(1) && itsl->val_type == TEMP_VAL_REG) {
+            tcg_regset_set_reg(allocated_regs, itsl->reg);
+        }
+        if (!IS_DEAD_ARG(2) && itsh->val_type == TEMP_VAL_REG) {
+            tcg_regset_set_reg(allocated_regs, itsh->reg);
+        }
+
+        ots->reg = tcg_reg_alloc(s, dup_out_regs, allocated_regs,
+                                 op->output_pref[0], ots->indirect_base);
+        ots->val_type = TEMP_VAL_REG;
+        ots->mem_coherent = 0;
+        s->reg_to_temp[ots->reg] = ots;
+    }
+
+    /* Promote dup2 of immediates to dupi_vec. */
+    if (itsl->val_type == TEMP_VAL_CONST &&
+        itsh->val_type == TEMP_VAL_CONST) {
+        tcg_out_dupi_vec(s, vtype, ots->reg,
+                         (uint32_t)itsl->val | ((uint64_t)itsh->val << 32));
+        goto done;
+    }
+
+    /* If the two inputs form one 64-bit value, try dupm_vec. */
+    if (itsl + 1 == itsh &&
+        itsl->base_type == TCG_TYPE_I64 &&
+        itsh->base_type == TCG_TYPE_I64) {
+        if (!itsl->mem_coherent) {
+            temp_sync(s, itsl, s->reserved_regs, 0, 0);
+        }
+        if (!itsl->mem_coherent) {
+            temp_sync(s, itsl, s->reserved_regs, 0, 0);
+        }
+#ifdef HOST_WORDS_BIGENDIAN
+        TCGTemp *its = itsh;
+#else
+        TCGTemp *its = itsl;
+#endif
+        if (tcg_out_dupm_vec(s, vtype, MO_64, ots->reg,
+                             its->mem_base->reg, its->mem_offset)) {
+            goto done;
+        }
+    }
+
+    /* Fall back to generic expansion. */
+    tcg_reg_alloc_op(s, op);
+    return;
+
+ done:
+    if (IS_DEAD_ARG(1)) {
+        temp_dead(s, itsl);
+    }
+    if (IS_DEAD_ARG(2)) {
+        temp_dead(s, itsh);
+    }
+    if (NEED_SYNC_ARG(0)) {
+        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0));
+    } else if (IS_DEAD_ARG(0)) {
+        temp_dead(s, ots);
+    }
+}
+
 #ifdef TCG_TARGET_STACK_GROWSUP
 #define STACK_DIR(x) (-(x))
 #else
@@ -4261,6 +4346,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         case INDEX_op_dup_vec:
             tcg_reg_alloc_dup(s, op);
             break;
+        case INDEX_op_dup2_vec:
+            tcg_reg_alloc_dup2(s, op);
+            break;
         case INDEX_op_insn_start:
             if (num_insns >= 0) {
                 size_t off = tcg_current_code_size(s);
-- 
2.20.1


