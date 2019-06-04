Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F5C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD29207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVThC9fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD29207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGJK-0002GZ-P6
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:45:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8b-0001Ix-4V
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8a-0004No-2n
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:29 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8Z-0004ND-UP
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:28 -0400
Received: by mail-oi1-x244.google.com with SMTP id w79so7536730oif.10
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=pnOBaWOuZI6RQh/0O1nDjt3Ap0L8f++M/zWc9l2w1jE=;
	b=ZVThC9fvSeJE7W+JVmKtAVtQVEboSApjL1uni4bSucp1nj3W9UkCrr5rPcgGItZBiz
	DNOp+3EDUqzJNhvzA9nLuI2XX307HfS/+haXIPvZps1//uc/3TbHts6rLgIJAYyW4+SI
	pdk5kyDb4T6wTcZLrmJmeCi8qOhFPGTkNuItIdK/M9NEZQLHmQ7apLqaiZv2joFw3oVl
	XWnpmYNbetfWdBgzCOmWygJOyC0UU2eMtlRiHBgwLU+Ulcqyls9KekelSOHkV+2uzCMn
	V0nCLirOYBceBekCmay0gmA4iCyzA/4PttrXGn1zfgmn6CcUudHTFBnZt1B8JwNE0Imd
	4VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=pnOBaWOuZI6RQh/0O1nDjt3Ap0L8f++M/zWc9l2w1jE=;
	b=qEviuKEW4rhj4RwDRTZ8EZHahIyXNJ6h8xSRq4VCw+Zcvs/9YDA8iklff0/p6x+/Uh
	VHL5+Dawg2NLqX22kSmVoKwynrVLJNdwDkhoeVkxI1ZiwbDLfzxk8BkTDzlgUfjIKuEd
	cukKBshHAiflJ15nZl64WGIc40cMMdMsdxA5JsYVf3S4hLbraILMf7HHUdF0+x87rM77
	PVZAfwLYkg2FPAhy4G7sgxu6tYcoXouxgW4BHTULXSYxZwB0SfwjI1+snuBaIX2QUW2X
	sH6GugAbh8UWzxP/8LvNra247w8Lukg84hNQNGwlsoGhZTaua57zGI3tg3WgAq8KMFig
	kUfg==
X-Gm-Message-State: APjAAAWYgT08Lt/ibHCPwVfv5ZS60yvP82DUzukx9fkNN5edle0za+5C
	qUTEOCjEWfZVKsUiiuojmFOabHmE//yysA==
X-Google-Smtp-Source: APXvYqwfPWqvLW5gLaRRqHjn4qvuxgAWLFWGKRjcSUSaRak51rMY69SstMDgzR2VnnE/1FEIAya2Jg==
X-Received: by 2002:aca:5b57:: with SMTP id p84mr5550599oib.4.1559680466947;
	Tue, 04 Jun 2019 13:34:26 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.25
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:32 -0500
Message-Id: <20190604203351.27778-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: [Qemu-devel] [PATCH v4 20/39] target/nios2: Use env_cpu, env_archcpu
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
Replace nios2_env_get_cpu with env_archcpu.  The combination
CPU(nios2_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h |  5 -----
 hw/nios2/cpu_pic.c |  5 +----
 target/nios2/mmu.c | 10 +++++-----
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index ae6cf1b4d1..9490ba83e4 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -194,11 +194,6 @@ typedef struct Nios2CPU {
     uint32_t fast_tlb_miss_addr;
 } Nios2CPU;
 
-static inline Nios2CPU *nios2_env_get_cpu(CPUNios2State *env)
-{
-    return NIOS2_CPU(container_of(env, Nios2CPU, env));
-}
-
 #define ENV_OFFSET offsetof(Nios2CPU, env)
 
 void nios2_tcg_init(void);
diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
index 6bccce2f32..9e39955bd1 100644
--- a/hw/nios2/cpu_pic.c
+++ b/hw/nios2/cpu_pic.c
@@ -54,12 +54,9 @@ static void nios2_pic_cpu_handler(void *opaque, int irq, int level)
 
 void nios2_check_interrupts(CPUNios2State *env)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
-
     if (env->irq_pending) {
         env->irq_pending = 0;
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HARD);
     }
 }
 
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index 53ed6413b4..9a0bafe786 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -61,7 +61,7 @@ unsigned int mmu_translate(CPUNios2State *env,
                            Nios2MMULookup *lu,
                            target_ulong vaddr, int rw, int mmu_idx)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     int pid = (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4;
     int vpn = vaddr >> 12;
 
@@ -103,7 +103,7 @@ unsigned int mmu_translate(CPUNios2State *env,
 static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
 {
     CPUState *cs = env_cpu(env);
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     int idx;
     MMU_LOG(qemu_log("TLB Flush PID %d\n", pid));
 
@@ -127,7 +127,7 @@ static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
 void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
 {
     CPUState *cs = env_cpu(env);
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
 
     MMU_LOG(qemu_log("mmu_write %08X = %08X\n", rn, v));
 
@@ -244,7 +244,7 @@ void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
 
 void mmu_init(CPUNios2State *env)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     Nios2MMU *mmu = &env->mmu;
 
     MMU_LOG(qemu_log("mmu_init\n"));
@@ -255,7 +255,7 @@ void mmu_init(CPUNios2State *env)
 
 void dump_mmu(CPUNios2State *env)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     int i;
 
     qemu_printf("MMU: ways %d, entries %d, pid bits %d\n",
-- 
2.17.1


