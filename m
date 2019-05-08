Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD410C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932E5205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bf+UXG5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932E5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56614 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOANc-0005Yh-PH
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:24:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA77-0007XV-5s
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA76-0006wL-2U
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:13 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA75-0006sU-SY
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:12 -0400
Received: by mail-pf1-x441.google.com with SMTP id t87so8917187pfa.2
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=5og8taMNd4cgV1WKLzot8TeUTc2M1dLq+4W8jUNfOxc=;
	b=Bf+UXG5UVAtoeV/Xge8YovTKeh5Vkuw1ytcn61a+gTYYkMlURxrxdP6kl2I237/sD6
	O+YokYp8o1fPMoHjA8dWdvIjZBV8PyflFD5ftUbwnENuubGXZVQRsPdDK6HHbDoohMVe
	m9nRIRFd+vnJaZ14JItfNns3q/1iZQ8YUfc0a0ijYLHdVxu50/uwAZWXA7JWpgHAF3sb
	fq7a2XE8wStBZ9T5gde6cF5p5RR1f8A3sXtLb+rHRyZFmxWp5k2pCQvnbctPNA0Bdgil
	GclaRpdNT5yUaL15JEuW0hWP34O6wKYojEYZvyJYQX6E0VFBbr65ugUrKEXfxMwfS0n9
	t5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=5og8taMNd4cgV1WKLzot8TeUTc2M1dLq+4W8jUNfOxc=;
	b=uYQJFNa7lLhjq9MhVv/tBNwFkGrLB5H+/6OtE44QEXJvXd89XWGVI644k5y1H/4Psz
	w0/Dra9Ed2lYreK4GB/O0NDjGrut0Q28xtWrDIKWcaH5QA0PWj/gD0BWwCqrT2mbpZQC
	YYEZH6aiYacVBkKm5FMXy3JbRoOF5MHrDmvTHw7T0radjzp3c77hNHoevQh++7TqzJZP
	r9tynExo2hDG/N4NkBEDJHFrqlQqm0sggkE8Sq+UNiL4gEaMjVnD3CQko4Gy3fkE2pY9
	wwgRfHAoQiEE9VlretkHSnflVkgeqoqJvZM/VztZMFpYbGL4O4GH6zAW3bmioz+9w8yw
	RPBQ==
X-Gm-Message-State: APjAAAWGyJu5vZF9VT89/ZSwIO4w9P+SJzTwx5RrmLeLGpC9maHMxgix
	d7hO4ZsKScdOT6OnP53BSjSqv41URCI=
X-Google-Smtp-Source: APXvYqzki3fqrYY/q9W6hJmAlg5ZnaNfEecrXJexZL5C1BZE5CDQDBBuKxoRit3BNN9Nlj9vuekVUQ==
X-Received: by 2002:aa7:8a81:: with SMTP id a1mr11769392pfc.121.1557274029666; 
	Tue, 07 May 2019 17:07:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.08 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:22 -0700
Message-Id: <20190508000641.19090-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 20/39] target/nios2: Use env_cpu, env_archcpu
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h |  5 -----
 hw/nios2/cpu_pic.c |  5 +----
 target/nios2/mmu.c | 10 +++++-----
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index b14095b8dc..f2ffc1469f 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -193,11 +193,6 @@ typedef struct Nios2CPU {
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
index 33382bad1b..61eaa06b3e 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -73,7 +73,7 @@ unsigned int mmu_translate(CPUNios2State *env,
                            Nios2MMULookup *lu,
                            target_ulong vaddr, int rw, int mmu_idx)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     int pid = (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4;
     int vpn = vaddr >> 12;
 
@@ -115,7 +115,7 @@ unsigned int mmu_translate(CPUNios2State *env,
 static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
 {
     CPUState *cs = env_cpu(env);
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     int idx;
     MMU_LOG(qemu_log("TLB Flush PID %d\n", pid));
 
@@ -139,7 +139,7 @@ static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
 void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
 {
     CPUState *cs = env_cpu(env);
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
 
     MMU_LOG(qemu_log("mmu_write %08X = %08X\n", rn, v));
 
@@ -256,7 +256,7 @@ void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
 
 void mmu_init(CPUNios2State *env)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     Nios2MMU *mmu = &env->mmu;
 
     MMU_LOG(qemu_log("mmu_init\n"));
@@ -267,7 +267,7 @@ void mmu_init(CPUNios2State *env)
 
 void dump_mmu(CPUNios2State *env)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     int i;
 
     qemu_printf("MMU: ways %d, entries %d, pid bits %d\n",
-- 
2.17.1


