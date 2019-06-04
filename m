Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3B0C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02A9207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EY322XWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02A9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57777 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGLl-0004Oy-Tg
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:48:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8P-000144-IJ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8O-0004CJ-93
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:17 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8O-0004C5-3g
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:16 -0400
Received: by mail-ot1-x342.google.com with SMTP id l15so1106097otn.9
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=2YlJXMPiyvFoAXCG6DRvfJeW5V6xBJbkISsj/LLUjoo=;
	b=EY322XWAvZvQJVV4QAqcLMUr0r7lRokt6qf7jl/Ge+RbsZGwQhbU+mjmGZfARFljvI
	9COuTn3++nZZNCLrTOmx16t0E4EGkpz+V3fGcmTiuTFevGNByiKHHJPOwBDdOhria1nH
	JS0QZw3BgJf2crmT/nmOqP7eXpdQxHcJ3rctFGUN7vWc9jN1k+wxGeYMZMrZt46A+HPb
	llfHOI4LPljcsPfDTV0/5PDAkxayd19Q4zmPgelU5VLM24AKaAEA3eU5Y7ASfkpuRcKr
	+bVuTPjvrBc+agIPm928DRwdYik6eop8P4T+8g7gpUFqEYcac/h4su1rXmoTVjH8FZqQ
	OkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=2YlJXMPiyvFoAXCG6DRvfJeW5V6xBJbkISsj/LLUjoo=;
	b=uNGP4PExo4M/0atpnalHCu9kwQZCSeQ6gxqLZZ018dLalhEHHb66WiZWHcdYdAwizT
	cVEiWOfvLJPbq/0GAogC0JZhHvIoPZlCI1jYoX7KuWb4HNn09/bReqHfwZjvRrNMZ55g
	xfqftp9sMwiPOwvlxLLPLZuSOt/sPNDeqMfASw1tnO0+f4iNBhuh20/ipurz2+kqIZnd
	hzbPbEa6kV+w4XnLKiSR/WhUahzADvBMRWEdNCo9uQg9ZdcP/pDk8L0gXSkpVTh7SwF8
	WHPX+M3oiJHCmqTfNCaSr5Q5jyku8s5p4SPAiozg/XTp9ThTfsBy4G5yXL808Qqvn7fA
	vSxA==
X-Gm-Message-State: APjAAAURYx2Vf9elj/Ay/gkD5xEEL9ElMtPWDYlNtxRJV3o6QlK3BOaR
	fmYsjIwqBoon6efM2UV9t3LbMBdku9hJEw==
X-Google-Smtp-Source: APXvYqzPAd2r1a21gYCNg+87yC8OzL05OdIP8rQ57voHWufr0fhm9wbnosS8kLngWqLX7r5JSzZP8w==
X-Received: by 2002:a9d:4c17:: with SMTP id l23mr6515409otf.367.1559680455136; 
	Tue, 04 Jun 2019 13:34:15 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.13
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:24 -0500
Message-Id: <20190604203351.27778-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [PATCH v4 12/39] target/cris: Use env_cpu, env_archcpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace cris_env_get_cpu with env_archcpu.  The combination
CPU(cris_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/cpu.h          |  5 -----
 linux-user/cris/cpu_loop.c |  2 +-
 target/cris/mmu.c          |  3 +--
 target/cris/op_helper.c    | 10 +++-------
 target/cris/translate.c    |  2 +-
 5 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 0746d19f38..e9e4e39a40 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -183,11 +183,6 @@ struct CRISCPU {
     CPUCRISState env;
 };
 
-static inline CRISCPU *cris_env_get_cpu(CPUCRISState *env)
-{
-    return container_of(env, CRISCPU, env);
-}
-
 #define ENV_OFFSET offsetof(CRISCPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
index 7ec36cb0b5..86e711108d 100644
--- a/linux-user/cris/cpu_loop.c
+++ b/linux-user/cris/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUCRISState *env)
 {
-    CPUState *cs = CPU(cris_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr, ret;
     target_siginfo_t info;
     
diff --git a/target/cris/mmu.c b/target/cris/mmu.c
index 9cb73bbfec..2acbcfd1c7 100644
--- a/target/cris/mmu.c
+++ b/target/cris/mmu.c
@@ -288,7 +288,6 @@ static int cris_mmu_translate_page(struct cris_mmu_result *res,
 
 void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
 {
-    CRISCPU *cpu = cris_env_get_cpu(env);
     target_ulong vaddr;
     unsigned int idx;
     uint32_t lo, hi;
@@ -312,7 +311,7 @@ void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
                 if (tlb_v && !tlb_g && (tlb_pid == pid)) {
                     vaddr = tlb_vpn << TARGET_PAGE_BITS;
                     D_LOG("flush pid=%x vaddr=%x\n", pid, vaddr);
-                    tlb_flush_page(CPU(cpu), vaddr);
+                    tlb_flush_page(env_cpu(env), vaddr);
                 }
             }
         }
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index e4c6942922..6b1e7ae4a8 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -39,7 +39,7 @@
 
 void helper_raise_exception(CPUCRISState *env, uint32_t index)
 {
-    CPUState *cs = CPU(cris_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = index;
     cpu_loop_exit(cs);
@@ -58,8 +58,7 @@ void helper_tlb_flush_pid(CPUCRISState *env, uint32_t pid)
 void helper_spc_write(CPUCRISState *env, uint32_t new_spc)
 {
 #if !defined(CONFIG_USER_ONLY)
-    CRISCPU *cpu = cris_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_page(cs, env->pregs[PR_SPC]);
     tlb_flush_page(cs, new_spc);
@@ -72,9 +71,6 @@ void helper_spc_write(CPUCRISState *env, uint32_t new_spc)
 
 void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
 {
-#if !defined(CONFIG_USER_ONLY)
-    CRISCPU *cpu = cris_env_get_cpu(env);
-#endif
     uint32_t srs;
     srs = env->pregs[PR_SRS];
     srs &= 3;
@@ -112,7 +108,7 @@ void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
             D_LOG("tlb flush vaddr=%x v=%d pc=%x\n",
                   vaddr, tlb_v, env->pc);
             if (tlb_v) {
-                tlb_flush_page(CPU(cpu), vaddr);
+                tlb_flush_page(env_cpu(env), vaddr);
             }
         }
     }
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 31b40a57f9..3429a3b768 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3097,7 +3097,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
      * delayslot, like in real hw.
      */
     pc_start = tb->pc & ~1;
-    dc->cpu = cris_env_get_cpu(env);
+    dc->cpu = env_archcpu(env);
     dc->tb = tb;
 
     dc->is_jmp = DISAS_NEXT;
-- 
2.17.1


