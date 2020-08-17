Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0010C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC10207FB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jDECeinR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC10207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bJ2-0006G1-MM
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asD-0001Qi-Kh
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:10 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7as6-0005B7-AT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:09 -0400
Received: by mail-pj1-x1041.google.com with SMTP id e4so7495981pjd.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AM5Ng0cmpmqI6dFhxVnR/024nL8x6ZLsgeuQelxmbC0=;
 b=jDECeinRMTa4+ySFW8aK8qdFgt4XdS+NKlm/QDdt+THpZTd2/YTwwVuWB/YOw26LB/
 3VQ1PFO/DUz9u25hVbb7wNbM1gmdMUaq14mYQKGBof2LuRD+TUF4NwcCMILHrJZan7of
 cgolE403SOiY+ox8f2rZsDVyFBPh54L/lqn5esY2hqxWY2s0z/UbcAIfsqWCjIpB40Gl
 qpWKDrEDuYQcoKHjW1Nz73t9wGCe7ognyukr845DKuAPiJ3X9C1Am+MombWYN+NYanZO
 MEwm3SKqOnFNUwIKC2mKo9XKQGglR4BVN3pEAC2s2Nw7uW/0Vw7PFe8vsBFpFgVe0XZT
 ufmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AM5Ng0cmpmqI6dFhxVnR/024nL8x6ZLsgeuQelxmbC0=;
 b=IgYKxjMjPKYj8FbJJUcJk7DkCrZun4DL8reqx7bXKo1P4nxd+awlU/DI1MHEoyklRF
 MNKZPpMP62mjZf9Mq1dyF6aFPohfXalzIdlr4g5gutwF327BKskHGzUUFwj8OohUpbyW
 /Y1N+MgG0TXGwWs9czR4oVMuPsi0b135Ux5C8v5nk7yIr9L0oXYWXlH1A/d/GPNtAa5o
 w+FQ8ehhytdF0WdYYxCMlt59mDWhAbBsYzBM0s0rC1Yiyv8kbx5KI2JRSv4mthpjfygS
 +sOGDoZzWeFpJypPzIS0JzYfWPuBHLMQGZ8b4HT4w8VFZt007Lue7FzEW9zxzGStnwvD
 7XKA==
X-Gm-Message-State: AOAM531qmAeVm3mdF6PgFQ3MISxQnnRrOCUnYs7xg4MG5AczCfGl2HQ8
 xKhvhpUDX0rVccSJCGNyms9MftgyQuvWew==
X-Google-Smtp-Source: ABdhPJwX76eur+Xoi/wFdFPB1tmPASar1bLSLxPjutDM2sHDOBcUEzL3E0KyoJx5dzaKFt1pU9RroQ==
X-Received: by 2002:a17:902:b282:: with SMTP id
 u2mr10078163plr.225.1597654320496; 
 Mon, 17 Aug 2020 01:52:00 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:00 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 41/70] target/riscv: rvv-1.0: single-width bit shift
 instructions
Date: Mon, 17 Aug 2020 16:49:26 +0800
Message-Id: <20200817084955.28793-42-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Truncate vsll.vi, vsrl.vi, vsra.vi's immediate values to lg2(SEW) bits.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 16e0941efb6..b763c3956cb 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1915,9 +1915,9 @@ GEN_OPIVX_GVEC_SHIFT_TRANS(vsll_vx,  shls)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsrl_vx,  shrs)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsra_vx,  sars)
 
-GEN_OPIVI_GVEC_TRANS(vsll_vi, IMM_ZX, vsll_vx, shli)
-GEN_OPIVI_GVEC_TRANS(vsrl_vi, IMM_ZX, vsrl_vx, shri)
-GEN_OPIVI_GVEC_TRANS(vsra_vi, IMM_ZX, vsra_vx, sari)
+GEN_OPIVI_GVEC_TRANS(vsll_vi, IMM_TRUNC_SEW, vsll_vx, shli)
+GEN_OPIVI_GVEC_TRANS(vsrl_vi, IMM_TRUNC_SEW, vsrl_vx, shri)
+GEN_OPIVI_GVEC_TRANS(vsra_vi, IMM_TRUNC_SEW, vsra_vx, sari)
 
 /* Vector Narrowing Integer Right Shift Instructions */
 static bool opivv_narrow_check(DisasContext *s, arg_rmrr *a)
-- 
2.17.1


