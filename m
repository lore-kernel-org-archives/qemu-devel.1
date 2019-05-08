Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8FFC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83FA9205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oa6hy+HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FA9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAM5-0004HI-FC
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:22:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7G-0007iH-Ug
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7D-0007Go-3Y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:22 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA6x-0006Qs-0a
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:18 -0400
Received: by mail-pg1-x543.google.com with SMTP id p6so9105384pgh.9
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=qX4aZ+A9/OscbPKEbO4STHtuJoM0+Sox6DQDCYTvW9c=;
	b=Oa6hy+HJa9O3dna9VDomm/uxJWHb8VW4mR0EyzWAJK0pc+8BDPwOvqddk9G/XSvxKJ
	OiynYKtmSyHwvW7tsQjrNj5K0i5Us3nyUOYaNeZzf6DCYVbb0HXQu/4mclzUqW6Oa/l2
	XyZIqiOzYBwVF00vpXI8zQD68jJbDDMxIqqJdZsq26J7y0l5lGtJtKGG82KCYctvP6tR
	jikFIM7vnEYDV06Fj55VGLSneKqRl2RCIqrryc4kBSAdId8OfufC79adKZPKUR8v7huF
	1VIuT8fs4q0PlcX4VPaxXmvumfPfQ9ruw6pDAlycto4zsv38F9LK7Dh99bGlbf24B6/D
	VX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=qX4aZ+A9/OscbPKEbO4STHtuJoM0+Sox6DQDCYTvW9c=;
	b=etxCyl1Zj3mdFW4nKWLghVxBLO5qpS3pddl7N28O3Bc/u1+Ma+cWRHyymHUdQPa3p1
	A9uk7I/P9AaBX6IFpUnvJrVHF1MZeXzNXPwwU7MEz5oZYAiVisdRLrxIBSOA9Fyhpf22
	QyrPMcp92SpS2VzvNRfjEfxBLOgi73jcQBVIXCETYgSHS5ksCtfGR3WieQ01Sc6i4qV3
	7DwkW+S5Ppl4fxK4IZDzwCasJKVlAPp901lGa2o0CMxblGWSyoA1QJPPTCHZbnM/LHs+
	kxY3Hv1pLeMgRIoj/SFOYkSqVvtI6UrJXK7tcCp+klhvbu0n/hJ02jxCqask73AF+WTb
	dx3A==
X-Gm-Message-State: APjAAAUOPWUv0q17plmu/VvftjzchKfF7KnS234op/KjnXeNVP0qsSha
	ORmwhEaBbaUI7BaAROHA/UNPnf3s1m8=
X-Google-Smtp-Source: APXvYqxPbkTKZYAfbJGdrLQ/TzvFLuoQhntNSkZtohsZoQ9h5/KIpsZcib9R1jTQpKVaEongzYQ/aA==
X-Received: by 2002:a63:6a42:: with SMTP id f63mr43756860pgc.377.1557274020608;
	Tue, 07 May 2019 17:07:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.06.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:06:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:15 -0700
Message-Id: <20190508000641.19090-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 13/39] target/hppa: Use env_cpu, env_archcpu
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

Combined uses of CPU(hppa_env_get_cpu()) were failures to use
the more proper, ENV_GET_CPU macro, now replaced by env_cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h          |  5 -----
 linux-user/hppa/cpu_loop.c |  2 +-
 target/hppa/helper.c       |  3 +--
 target/hppa/int_helper.c   |  4 ++--
 target/hppa/mem_helper.c   | 10 ++++------
 target/hppa/op_helper.c    |  8 +++-----
 6 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 887e10398a..a5ddc53bf1 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -222,11 +222,6 @@ struct HPPACPU {
     QEMUTimer *alarm_timer;
 };
 
-static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
-{
-    return container_of(env, HPPACPU, env);
-}
-
 #define ENV_OFFSET      offsetof(HPPACPU, env)
 
 typedef CPUHPPAState CPUArchState;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 880955fdef..9915456a1d 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -105,7 +105,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
 
 void cpu_loop(CPUHPPAState *env)
 {
-    CPUState *cs = CPU(hppa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_siginfo_t info;
     abi_ulong ret;
     int trapnr;
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 11c61b3ca2..0dcd105b88 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -71,8 +71,7 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
     /* If PSW_P changes, it affects how we translate addresses.  */
     if ((psw ^ old_psw) & PSW_P) {
 #ifndef CONFIG_USER_ONLY
-        CPUState *src = CPU(hppa_env_get_cpu(env));
-        tlb_flush_by_mmuidx(src, 0xf);
+        tlb_flush_by_mmuidx(env_cpu(env), 0xf);
 #endif
     }
 }
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 8d5edd3a20..89241c31e7 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -77,7 +77,7 @@ void HELPER(write_eirr)(CPUHPPAState *env, target_ureg val)
 {
     env->cr[CR_EIRR] &= ~val;
     qemu_mutex_lock_iothread();
-    eval_interrupt(hppa_env_get_cpu(env));
+    eval_interrupt(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 }
 
@@ -85,7 +85,7 @@ void HELPER(write_eiem)(CPUHPPAState *env, target_ureg val)
 {
     env->cr[CR_EIEM] = val;
     qemu_mutex_lock_iothread();
-    eval_interrupt(hppa_env_get_cpu(env));
+    eval_interrupt(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 77fb544838..e2f464c78c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -55,7 +55,7 @@ static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
 
 static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent)
 {
-    CPUState *cs = CPU(hppa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     unsigned i, n = 1 << (2 * ent->page_size);
     uint64_t addr = ent->va_b;
 
@@ -323,7 +323,7 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
 
 void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
 {
-    CPUState *src = CPU(hppa_env_get_cpu(env));
+    CPUState *src = env_cpu(env);
     CPUState *cpu;
     trace_hppa_tlb_ptlb(env);
     run_on_cpu_data data = RUN_ON_CPU_TARGET_PTR(addr);
@@ -340,17 +340,15 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
    number of pages/entries (we choose all), and is local to the cpu.  */
 void HELPER(ptlbe)(CPUHPPAState *env)
 {
-    CPUState *src = CPU(hppa_env_get_cpu(env));
     trace_hppa_tlb_ptlbe(env);
     memset(env->tlb, 0, sizeof(env->tlb));
-    tlb_flush_by_mmuidx(src, 0xf);
+    tlb_flush_by_mmuidx(env_cpu(env), 0xf);
 }
 
 void cpu_hppa_change_prot_id(CPUHPPAState *env)
 {
     if (env->psw & PSW_P) {
-        CPUState *src = CPU(hppa_env_get_cpu(env));
-        tlb_flush_by_mmuidx(src, 0xf);
+        tlb_flush_by_mmuidx(env_cpu(env), 0xf);
     }
 }
 
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 952e97a7d7..04d23c1b22 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -29,8 +29,7 @@
 
 void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
 {
-    HPPACPU *cpu = hppa_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     cpu_loop_exit(cs);
@@ -38,8 +37,7 @@ void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
 
 void QEMU_NORETURN hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
 {
-    HPPACPU *cpu = hppa_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     cpu_loop_exit_restore(cs, ra);
@@ -630,7 +628,7 @@ target_ureg HELPER(read_interval_timer)(void)
 #ifndef CONFIG_USER_ONLY
 void HELPER(write_interval_timer)(CPUHPPAState *env, target_ureg val)
 {
-    HPPACPU *cpu = hppa_env_get_cpu(env);
+    HPPACPU *cpu = env_archcpu(env);
     uint64_t current = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t timeout;
 
-- 
2.17.1


