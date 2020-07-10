Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17ACC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C055620720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gu4W9CQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C055620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsbW-0003ee-Vu
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcQ-00050e-6f
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:51:02 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcO-0006VQ-O8
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:51:01 -0400
Received: by mail-pl1-x641.google.com with SMTP id q17so2092196pls.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=E7bp8grnE36z+eUmiKKXYp8Qe6/62Xe1PrKPT1X4MlA=;
 b=gu4W9CQpT/oFHnjyfpnsB/4Y4nC1tba0EQdO+4lkrCrZbh2OJBl/UbvqlZj4m49h3P
 PLlU1nbahDfMMSVxGwMEuOkCFykFukwzTMfO/w7AMjHA0A4gzKDYzzR8+XXiRcSPTC68
 zaKWm0H0Z+bTbJOyfK8ozorsBAhPeIdzIlBn2ZbEfajL2cRnvYouPsTDaJXWqqt1kQ/5
 GpAUjT8O9ykCK+mnLCbRkKC9RklfrYrWDOmA7JqEN8JtbKx6KpwijwkJqaTgMzca7sD9
 zguvxfvSBRZRwuTHyauPCoPawckB9byhcsxmqNGF4ob6hpThAs1cuDPJh2644re75rr8
 PMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=E7bp8grnE36z+eUmiKKXYp8Qe6/62Xe1PrKPT1X4MlA=;
 b=FvKXPkedWZUxZJT8G0+DNkxbUVPM44ohdZwbDpASUxvpPAprOaMaavWU/3yAUowAQ1
 w5sDKMcQ1mpmZhMo20qJXiKBx8s3A46/PS7fYjKPZO5xVz5cxovgD/L5jjQ8UgXloGvB
 e+faSH7l5iw6gY7FBUka5Dw0S/WZK5hibRZov7SmodcRpZ8T+SAcrhBvB3Vs2HZvTgyh
 1OXr3GQWqTQnL4iJcZGmEaqMNkJJvy242yeppwbs95xqnm+dwNF7x5J4MjvCWcSMmB7C
 HWyPWGqyg3vJNZrKKK9WuQzCsde7cFQ7P/o431bZmGbam23jY8Soh2XQbISqLd+77Jug
 9VFw==
X-Gm-Message-State: AOAM531U0BGzhgFY3KbMnHBqrvwuPr8lz8/0sljYpFjHt8RvwxIl+Z4i
 TmY74606jOYIUtpwjvj4cHnCrNuBOpyq9w==
X-Google-Smtp-Source: ABdhPJxK9OnuJTN95THgeCkudxVJwz9AhLGPttHGLpyYSoZw/zDrMnvOkcQ7Dt91qFGIdFifrz7NEw==
X-Received: by 2002:a17:90a:6509:: with SMTP id
 i9mr5107743pjj.104.1594378259373; 
 Fri, 10 Jul 2020 03:50:59 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:50:59 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 08/65] target/riscv: rvv-0.9: update mstatus_vs by tb_flags
Date: Fri, 10 Jul 2020 18:48:22 +0800
Message-Id: <20200710104920.13550-9-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x641.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h       | 2 ++
 target/riscv/translate.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0cf3fe9456..c02690ed0d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -361,6 +361,7 @@ void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
 
 #define TB_FLAGS_MMU_MASK   3
 #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
+#define TB_FLAGS_MSTATUS_VS MSTATUS_VS
 
 typedef CPURISCVState CPUArchState;
 typedef RISCVCPU ArchCPU;
@@ -411,6 +412,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 
 #ifdef CONFIG_USER_ONLY
     flags |= TB_FLAGS_MSTATUS_FS;
+    flags |= TB_FLAGS_MSTATUS_VS;
 #else
     flags |= cpu_mmu_index(env, 0);
     if (riscv_cpu_fp_enabled(env)) {
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a806e33301..02b4204584 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -796,6 +796,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pc_succ_insn = ctx->base.pc_first;
     ctx->mem_idx = tb_flags & TB_FLAGS_MMU_MASK;
     ctx->mstatus_fs = tb_flags & TB_FLAGS_MSTATUS_FS;
+    ctx->mstatus_vs = tb_flags & TB_FLAGS_MSTATUS_VS;
     ctx->priv_ver = env->priv_ver;
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVH)) {
-- 
2.17.1


