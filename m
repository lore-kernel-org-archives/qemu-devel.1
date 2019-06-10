Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F64C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F2420820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+sYOtk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F2420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha9qL-0000ka-Ti
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53005)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9du-0005wn-QZ
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9dt-0001gc-7M
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:38 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9ds-0001gD-Vk
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:37 -0400
Received: by mail-pf1-x442.google.com with SMTP id j2so4319015pfe.6
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2YlJXMPiyvFoAXCG6DRvfJeW5V6xBJbkISsj/LLUjoo=;
 b=I+sYOtk5x5Da27+J/CJjU1sX/fYyn1mbIlKOtEhkQp1HbV03Veze5WGIF8yv328eQb
 TbwANtX0Huj0Xs8BfhxV7xUoDSgBd/h62tzeBKv/L0GDaJpzZ/d+/Czolkxi9w5ZGbS2
 hvMPk7vFII69Lxj5JVVGr2gwP5tRjOybMFlfGYQo+LcWkOwNIF1Iljnv8PXDpGH1c7lV
 kwTJTBMokVWeies+oA6xxDbuyynj01Vxn7mcIh5yaubnWtiUiGq7qqU/b5JCo442gfP3
 9JtcfJ6zqWAqoaIakw/Hy4UkgK7YNE91xVBQVR3FiqhW6bSz6yRaHRaxdwOrIdXpvBwN
 IMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2YlJXMPiyvFoAXCG6DRvfJeW5V6xBJbkISsj/LLUjoo=;
 b=oMVXwWoy2D0HxJs0VqcNRIwzQvOJKb7d0VIN0PqfyhdgwxCOHYisxBJHRQCk00Idn+
 986U5340nklcXxdeMZlqJ6dxi/SlXtdkNBXqcj/nAwlWU4sIGmzoUhyvucZSfrixqbl6
 12Lygo1W7fnTEx17f8E4Q6a9Yo/S15vJx/VY5Fx4Egb5GzL6BQWQ9ue8uEf81qnQsL5F
 9am8QFMa9eN72vsONkGAbfTAwW156uVZBMGzE+8QAcyKF//j5nnGNDl89Am6z3Ak+szh
 1u0vDrewpYDW+mPHvR6qkepCglPg5gaA6/VzqfpbD7Be/pzEizEuJuCD0TBuUQt4kBoV
 xKnw==
X-Gm-Message-State: APjAAAWLLAoZohHvSV4wLOYJJSBDU36bxMwvpZh11SJ6ENvbYiELNs/a
 a11BtMfRZIlo9yqjekQ5ZwwD6WQXRy0=
X-Google-Smtp-Source: APXvYqysc96qymVIQgHfVBi4fkMnsC5Rw+oAQnO5zaidK/NoJXyY4ua/pSa1e50bedIOe+3SgokFCA==
X-Received: by 2002:a62:4e48:: with SMTP id c69mr49502417pfb.176.1560132155483; 
 Sun, 09 Jun 2019 19:02:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:01:51 -0700
Message-Id: <20190610020218.9228-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PULL 12/39] target/cris: Use env_cpu, env_archcpu
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
Cc: peter.maydell@linaro.org
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


