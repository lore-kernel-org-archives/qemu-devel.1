Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227A8C5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02873208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02873208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgv9K-0001d2-AS
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54930)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgul0-0008Vl-9C
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hguku-0000e8-PR
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hguku-0000bN-I6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so3324599pfp.7
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=/utRw/o8PW3YQm+ZhJWNBeL8gDnPNYLiS6dXiDJvvqI=;
 b=WYgCRXdpGu4QTrQp5q2X8BrnwwXdbkM16Mzjq+CcRdp81LIp5p5uXYO0TYGSUNpa6R
 Gn1j9ThQxJDh4aYt6O87KG22PI3nod/+HtP/uca/y+xeIjteIFr90Gsua4UZjPpYbKWe
 bhDLsuR/RkEjU04o4CelQNllH7NS544cNUt+0E1ciXQSLkaUJeFSr0Qwr+xyicL7cueb
 UT44KwqTGtN3zcG4a7kEZQtNUIoZSzS67oI6lEUVf43c/x6gQei1YqS2VH4umPbHfeJx
 5lvlQ9vFwRedahQW00eZdDhbj3SKXzt1YqDxQ3X0+lm0HmUGaf2ZNJfivpN7pjMY2MF6
 Yq3A==
X-Gm-Message-State: APjAAAVfBhjdMzHbzKQOQYhTWsyf0htRzRq9wEZHj6WhmZ458cjMb6OW
 lg6N2F8pdkptq7luLfZWFBFVHHdH2cSFm/t4
X-Google-Smtp-Source: APXvYqzfaMjMMQgI9TpXaxgnob1w6PAJnW8K2KqVZ/8sgcG0/Eu6o+E6g/YEij18vRQZmXP7iS3eng==
X-Received: by 2002:a63:4c46:: with SMTP id m6mr10688357pgl.59.1561743224665; 
 Fri, 28 Jun 2019 10:33:44 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id x25sm3202020pfm.48.2019.06.28.10.33.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:43 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:16 -0700
Message-Id: <20190628173227.31925-24-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PULL 23/34] RISC-V: Clear load reservations on
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


