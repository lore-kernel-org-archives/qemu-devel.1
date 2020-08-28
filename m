Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F4BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F396A207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X517tc+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F396A207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfb2-0004qd-7I
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFC-0001bP-VD
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:43 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF7-0005I2-ET
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:42 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ds1so565600pjb.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iiLlNgJrdHfhscp1aVBO6P+kxbA4/R9Ha0WeuU0s3+0=;
 b=X517tc+HzAIdyUpQ/iplzhqDa1de+HN8MW/TrII1EAB47ANYFjK2umcBdntbxUf8zJ
 sIyXrl3X2wc1OAvUyp+HVKu1ZdgWznU8jm1QD8K42mdyVd0Lz2uT4R5ZCwbj/cogjLU3
 iDUBKrLlPJS2dEKp0mUbS671hNKaOb3mPPPq1OWg3vEfBID+L0+RkKp9zOHblLgbZZcV
 nu0zJXsnYP5/XRucsviWwIKeT7UAQfB0BcQLoXRIxsODa1kX4wWBbVFbj2+syfMzea/G
 p8JVkoK2qw0aEM6rGnlE8vj4M8+h/4cCVueIMzKAtnfM5pEFnImh68UmTHaDervcpC/j
 oNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iiLlNgJrdHfhscp1aVBO6P+kxbA4/R9Ha0WeuU0s3+0=;
 b=T6wVlR/nhnanSptM3Lz9SPD+YtOWD3azNQU+R9jnzYLfudWBwwHNi8YzX1AFUW8/QC
 VBoGDTa9KTymA8yTlOFDscwnuPd5iWTeNahNdy6RRWiC1pzAqSQp5783bSIoXVOG3bXH
 hPUUzY8wWXpMIvYliliZNriStxGlNF2sV6MkPm8ZHelBA8CA6Nup9HwGDsvM1gEMEaDV
 y81xEHbGOKscXeYsdv47AqXSZ6jeHma8VBsI88HypcZMkHBO5soRjb2YSXD1hHdNYpf7
 v39uWyEEEPObaooV0AVp2+UE9MGpFXNvP5roLsnYJHv49OzhV/d5ZYiK+Wursr9PhfCY
 fHfA==
X-Gm-Message-State: AOAM531YBuNjOn9VyRcorax8+8PT1KaUzidPrZngf4tJunI5YE02u9XE
 GnO2xqRocpp6ZJgxh6NQc4pj50QV7wW/1A==
X-Google-Smtp-Source: ABdhPJz+x5iSxBtT9RUnIzsxIKF+W2r8l5/om6Ke5vwFJn1EEjjEMY2uQve3c2hkzR6alwZxYYHfKQ==
X-Received: by 2002:a17:90b:4d0d:: with SMTP id
 mw13mr1362668pjb.43.1598624435943; 
 Fri, 28 Aug 2020 07:20:35 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 51/76] target/microblaze: Cache mem_index in DisasContext
Date: Fri, 28 Aug 2020 07:19:04 -0700
Message-Id: <20200828141929.77854-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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

Ideally, nothing outside the top-level of translation even
has access to env.  Cache the value in init_disas_context.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 1f6731e0af..a55e110171 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -73,6 +73,7 @@ typedef struct DisasContext {
     unsigned int delayed_branch;
     unsigned int tb_flags, synced_flags; /* tb dependent flags.  */
     unsigned int clear_imm;
+    int mem_index;
 
 #define JMP_NOJMP     0
 #define JMP_DIRECT    1
@@ -175,8 +176,7 @@ static bool trap_illegal(DisasContext *dc, bool cond)
  */
 static bool trap_userspace(DisasContext *dc, bool cond)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-    bool cond_user = cond && mem_index == MMU_USER_IDX;
+    bool cond_user = cond && dc->mem_index == MMU_USER_IDX;
 
     if (cond_user && (dc->tb_flags & MSR_EE)) {
         gen_raise_hw_excp(dc, ESR_EC_PRIVINSN);
@@ -968,7 +968,7 @@ static void dec_load(DisasContext *dc)
     TCGv addr;
     unsigned int size;
     bool rev = false, ex = false, ea = false;
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
+    int mem_index = dc->mem_index;
     MemOp mop;
 
     mop = dc->opcode & 3;
@@ -1077,7 +1077,7 @@ static void dec_store(DisasContext *dc)
     TCGLabel *swx_skip = NULL;
     unsigned int size;
     bool rev = false, ex = false, ea = false;
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
+    int mem_index = dc->mem_index;
     MemOp mop;
 
     mop = dc->opcode & 3;
@@ -1540,6 +1540,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
     dc->r0_set = false;
+    dc->mem_index = cpu_mmu_index(&cpu->env, false);
 
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
     dc->base.max_insns = MIN(dc->base.max_insns, bound);
-- 
2.25.1


