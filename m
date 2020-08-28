Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94B5C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF2F20757
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXJUCSQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF2F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfWE-0002ux-MH
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFL-0001wq-0u
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:51 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFJ-0005PE-8y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:50 -0400
Received: by mail-pl1-x643.google.com with SMTP id h2so540615plr.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zwo2tLKRvQRJhDTbPnKciACBLjC4l/PhJRnGW8zacPw=;
 b=PXJUCSQeawL24bOK+pBya9y/6qqKkx1vVpKY9dPs6244AxiKuiaXzktpKPOsQqH+E1
 Iqh89YAhc2AzTQdXZWoKpfoE2seW+vGt3/h8BdIyQ5tAn1ABEeC/0PacB4qxpui6VgUN
 3Gs9QNQg/SazlTJtpFa5CQlG4gw22pGv351PRUZqaMog268zsgQGXb5fp+FkO9UTRTlb
 teH/yY32UseutouA3xLIABj3aijsmclzb9mW4v2tKLPhuzW4ETFXTL4Cn+b5EIepHn+V
 6z7uL8JVEWpBvYe0S1lid0DjIAFbomlvqpqPNEB9kCpf9mzFT45b7N0LWgtjj+wUerT5
 L2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zwo2tLKRvQRJhDTbPnKciACBLjC4l/PhJRnGW8zacPw=;
 b=AJT7+q8M+nlJQfSG/18w4CkdCsX5J/LWwATaJ4txEpcAzSXoOMN4w9x1WVkwvfN0hO
 04DqehiMhGUoTghTqtg5dB8J2hx90ZykMbI98FXUDX668g6kaAWbNQaKS0aYyyUmIYWC
 mQjgaRQMDDFznpUwEcrdHbE5pEm8dLTn7MjoOB4x8Dcfwu0MjcYEihBaN3sN50LKyj+J
 dr/LCXsTZlV+2l1YPzvJRt+WXa/zKboLHRkeRW5+4tpoxOQnhgD4eP9/V4ysA9yV+JNT
 riWZXSd6Avf/YLGkL7LQfynNBnqLAsKtMPQK/Y6SSK3mLgmhQXZ3YIEGhKsP6NHKxnbY
 OovA==
X-Gm-Message-State: AOAM532+8YWPpfrLYTmFNEgBmMvk2jqYOax0Di4/zUzlZb2XlQPUUFrA
 nRQmwwxzqJL4i1rXlP+8nJgF5v9gjgTlkA==
X-Google-Smtp-Source: ABdhPJzQ3Kew5drb9GoPCUv97gG6P5MnhE8DLC4etlKd6AspqwYRvhhWW5Yah/OYpQN/1KfU/krXbA==
X-Received: by 2002:a17:902:44c:: with SMTP id
 70mr1468024ple.293.1598624447602; 
 Fri, 28 Aug 2020 07:20:47 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 60/76] target/microblaze: Replace clear_imm with
 tb_flags_to_set
Date: Fri, 28 Aug 2020 07:19:13 -0700
Message-Id: <20200828141929.77854-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This more general update variable will be able to handle
delay slots as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 597b96ffb3..c0b586f467 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -75,7 +75,7 @@ typedef struct DisasContext {
     unsigned int cpustate_changed;
     unsigned int delayed_branch;
     unsigned int tb_flags;
-    unsigned int clear_imm;
+    unsigned int tb_flags_to_set;
     int mem_index;
 
 #define JMP_NOJMP     0
@@ -535,8 +535,7 @@ static bool trans_imm(DisasContext *dc, arg_imm *arg)
 {
     dc->ext_imm = arg->imm << 16;
     tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
-    dc->tb_flags |= IMM_FLAG;
-    dc->clear_imm = 0;
+    dc->tb_flags_to_set = IMM_FLAG;
     return true;
 }
 
@@ -1688,7 +1687,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
                   (uint32_t)dc->base.pc_next);
     }
 
-    dc->clear_imm = 1;
+    dc->tb_flags_to_set = 0;
+
     ir = cpu_ldl_code(env, dc->base.pc_next);
     if (!decode(dc, ir)) {
         old_decode(dc, ir);
@@ -1700,10 +1700,13 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         dc->r0_set = false;
     }
 
-    if (dc->clear_imm && (dc->tb_flags & IMM_FLAG)) {
-        dc->tb_flags &= ~IMM_FLAG;
+    /* Discard the imm global when its contents cannot be used. */
+    if ((dc->tb_flags & ~dc->tb_flags_to_set) & IMM_FLAG) {
         tcg_gen_discard_i32(cpu_imm);
     }
+
+    dc->tb_flags &= ~IMM_FLAG;
+    dc->tb_flags |= dc->tb_flags_to_set;
     dc->base.pc_next += 4;
 
     if (dc->delayed_branch && --dc->delayed_branch == 0) {
-- 
2.25.1


