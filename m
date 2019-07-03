Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015EBC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB27B21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB27B21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibW6-0002kE-4b
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiaqB-0006Zv-Ty
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0008IS-RG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0007cb-Du
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so1492986ljf.4
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=/utRw/o8PW3YQm+ZhJWNBeL8gDnPNYLiS6dXiDJvvqI=;
 b=aydO5qRv0MZHJasIJt9coTntx6OSPCBF+C4K63z1ofKpT2HaUEwWe7ElCwtB9RLBHU
 a4aMY/jK0W49FY2ygJpq2EzwJjyhcPRSs4hwZFFe2rPDVTIQITCQjgQR8AZ2hLI1hpxY
 Tq75oaY+/mN7dxAECltE5TO44ZtLP1QO90KnvXiKWxEGy3ruoqr6NaeWum5VEqbeAt5U
 sLu+9ycfys4G0echA/ruYLBQ8+6Uwsb2R1RLQCr6EF6uftZKH+bPIUpDAKoMRu8xT6fd
 yLfnn1YeTLoQat1org18wJjkOtmywxsjJ3zh6L25CZRuwo/Y+NTUqhbd62IwVfCZWJcK
 6Rww==
X-Gm-Message-State: APjAAAX3E769J5lLW9e2tM74/pyYeB8VPlxqQUqy5a0fr8h+SxBZ5co1
 0WHam5/DqsK0pTeMv211E0KiGphLb+AHjA==
X-Google-Smtp-Source: APXvYqwGpBWt6Yx/6IWdhDu+RLCVxAo7bxHLoVhzx6fS4509MFLkLUkGWQEljy2TjaFY7EVf0lk+Cg==
X-Received: by 2002:a2e:980e:: with SMTP id a14mr20931995ljj.60.1562143310149; 
 Wed, 03 Jul 2019 01:41:50 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id z6sm319879lfa.45.2019.07.03.01.41.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:49 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:39 -0700
Message-Id: <20190703084048.6980-24-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.193
Subject: [Qemu-devel] [PULL 23/32] RISC-V: Clear load reservations on
 context switch and SC
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joel Sing <joel@sing.id.au>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Sing <joel@sing.id.au>

This prevents a load reservation from being placed in one context/process,
then being used in another, resulting in an SC succeeding incorrectly and
breaking atomics.

Signed-off-by: Joel Sing <joel@sing.id.au>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c                      |  1 +
 target/riscv/cpu_helper.c               | 10 ++++++++++
 target/riscv/insn_trans/trans_rva.inc.c |  8 +++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 915b9e77df33..f8d07bd20ad7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -297,6 +297,7 @@ static void riscv_cpu_reset(CPUState *cs)
     env->pc = env->resetvec;
 #endif
     cs->exception_index = EXCP_NONE;
+    env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
 }
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e1b079e69c60..e32b6126af05 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -132,6 +132,16 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
     }
     /* tlb_flush is unnecessary as mode is contained in mmu_idx */
     env->priv = newpriv;
+
+    /*
+     * Clear the load reservation - otherwise a reservation placed in one
+     * context/process can be used by another, resulting in an SC succeeding
+     * incorrectly. Version 2.2 of the ISA specification explicitly requires
+     * this behaviour, while later revisions say that the kernel "should" use
+     * an SC instruction to force the yielding of a load reservation on a
+     * preemptive context switch. As a result, do both.
+     */
+    env->load_res = -1;
 }
 
 /* get_physical_address - get the physical address for this virtual address
diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
index f6dbbc065e15..fadd88849e2b 100644
--- a/target/riscv/insn_trans/trans_rva.inc.c
+++ b/target/riscv/insn_trans/trans_rva.inc.c
@@ -61,7 +61,7 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
 
     gen_set_label(l1);
     /*
-     * Address comparion failure.  However, we still need to
+     * Address comparison failure.  However, we still need to
      * provide the memory barrier implied by AQ/RL.
      */
     tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + a->rl * TCG_BAR_STRL);
@@ -69,6 +69,12 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
     gen_set_gpr(a->rd, dat);
 
     gen_set_label(l2);
+    /*
+     * Clear the load reservation, since an SC must fail if there is
+     * an SC to any address, in between an LR and SC pair.
+     */
+    tcg_gen_movi_tl(load_res, -1);
+
     tcg_temp_free(dat);
     tcg_temp_free(src1);
     tcg_temp_free(src2);
-- 
2.21.0


