Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52421C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C32F2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzIYlYe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C32F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfkY-0006KL-0z
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFM-00020B-7u
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:52 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFK-0005PM-G5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:51 -0400
Received: by mail-pl1-x641.google.com with SMTP id c15so533250plq.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NBFrP1+/jgZ0aFs6sSu+fBXeEHUysvclKSZS577gabk=;
 b=IzIYlYe9WJW40VnuC+eVYCy60hCic28Lw06mAUzM4bXKmsCVMDMaLSFPWvco9jvXML
 SgtnGbBdOq1X8Oof/cDKl2gO0GN9TJ2/M9RkMmKFl3+Z6fEhVuwYjp5vFPefalizkrmk
 pbGr7aGiIqFhOGbCouThQoKbL9NABJE5SyJqF/YnwZbPy/3mH96Ju2IbBGcAwh3rdiuH
 MOAsig5MYrZwFqmdPoeYqtFkP3cchqy53XYASi5J37Ofi+6kyPAHiLE2RdzRzRmeIanx
 BnRMlh9+dItDasFzNnDTXLW56sbHtfcFB520T9eG481QnJp73/w1F1QcsG+njNna1idK
 GqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NBFrP1+/jgZ0aFs6sSu+fBXeEHUysvclKSZS577gabk=;
 b=GoH4OGQOCmprArc+tFyfPqpZnezqpandZ4nNnBQex0q1OiRXXE5XtQiS3+JzJLz0bH
 dVPKPXSpl9b8vJ1WTIJWUCntmp9scQRF7kbYROaTuYOSjLND7hKQzlwRNm3GD3BbNyuF
 UfK+OAPoobpkRx5pyOUN6MGH/pJ+0mUky5wPx3Wa5FIwzryFCvLDG5sB82A+WaIaT7Ps
 QOfMWwzRqXrrNxVpHcfuu+pbsk7FOf2KuXyQ1Kc5DL/HbCp61s8KUruuJZHvAPXdMcBn
 OD1E1dkQ8PvRwx0nppFP2swxbVemX+AROBx7vEgZpaXYqSkgVYioNBdvZJzyMXxT2rug
 UlPw==
X-Gm-Message-State: AOAM5335zFL9XYwWXtgTP/rJGpUBNsZIScqXMy3i6S3zyrcbmcEZy6y4
 jSL0elF2jD4udk8EFXqBsvV+6lwm5+7pjA==
X-Google-Smtp-Source: ABdhPJxGZ/gGZtTU/XVhZha0ME+t+yBa8oylIDh02lpdm9RP6QZHHmk4koGv0vSNzsZOJvxqZg3V7A==
X-Received: by 2002:a17:902:6a8b:: with SMTP id
 n11mr1502705plk.75.1598624448860; 
 Fri, 28 Aug 2020 07:20:48 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 61/76] target/microblaze: Replace delayed_branch with
 tb_flags_to_set
Date: Fri, 28 Aug 2020 07:19:14 -0700
Message-Id: <20200828141929.77854-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

The multi-stage counter can be replaced by clearing D_FLAG,
the or'ing in tb_flags_to_set.  The jump then happens when
D_FLAG is finally cleared.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c0b586f467..811c92d23b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -73,7 +73,6 @@ typedef struct DisasContext {
     uint16_t imm;
 
     unsigned int cpustate_changed;
-    unsigned int delayed_branch;
     unsigned int tb_flags;
     unsigned int tb_flags_to_set;
     int mem_index;
@@ -1328,10 +1327,9 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
 
 static void dec_setup_dslot(DisasContext *dc)
 {
-    dc->delayed_branch = 2;
-    dc->tb_flags |= D_FLAG;
+    dc->tb_flags_to_set |= D_FLAG;
     if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
-        dc->tb_flags |= BIMM_FLAG;
+        dc->tb_flags_to_set |= BIMM_FLAG;
     }
 }
 
@@ -1343,7 +1341,6 @@ static void dec_bcc(DisasContext *dc)
     cc = EXTRACT_FIELD(dc->ir, 21, 23);
     dslot = dc->ir & (1 << 25);
 
-    dc->delayed_branch = 1;
     if (dslot) {
         dec_setup_dslot(dc);
     }
@@ -1419,7 +1416,6 @@ static void dec_br(DisasContext *dc)
         }
     }
 
-    dc->delayed_branch = 1;
     if (dslot) {
         dec_setup_dslot(dc);
     }
@@ -1633,8 +1629,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 
     dc->cpu = cpu;
     dc->tb_flags = dc->base.tb->flags;
-    dc->delayed_branch = !!(dc->tb_flags & D_FLAG);
-    dc->jmp = dc->delayed_branch ? JMP_INDIRECT : JMP_NOJMP;
+    dc->jmp = dc->tb_flags & D_FLAG ? JMP_INDIRECT : JMP_NOJMP;
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
     dc->ext_imm = dc->base.tb->cs_base;
@@ -1705,11 +1700,11 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         tcg_gen_discard_i32(cpu_imm);
     }
 
-    dc->tb_flags &= ~IMM_FLAG;
+    dc->tb_flags &= ~(IMM_FLAG | BIMM_FLAG | D_FLAG);
     dc->tb_flags |= dc->tb_flags_to_set;
     dc->base.pc_next += 4;
 
-    if (dc->delayed_branch && --dc->delayed_branch == 0) {
+    if (dc->jmp != JMP_NOJMP && !(dc->tb_flags & D_FLAG)) {
         if (dc->tb_flags & DRTI_FLAG) {
             do_rti(dc);
         }
@@ -1719,8 +1714,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         if (dc->tb_flags & DRTE_FLAG) {
             do_rte(dc);
         }
-        /* Clear the delay slot flag.  */
-        dc->tb_flags &= ~D_FLAG;
         dc->base.is_jmp = DISAS_JUMP;
     }
 
-- 
2.25.1


