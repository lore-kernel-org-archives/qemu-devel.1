Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CD2C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45332070B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnTpZ6bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45332070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57620 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGB8-0003Ch-2t
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:37:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8I-00010K-Lb
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8H-00047e-IG
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:10 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8H-00047B-Cr
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:09 -0400
Received: by mail-oi1-x242.google.com with SMTP id s184so5590511oie.9
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=98JOxuqlJVZoGMNI/F+3Atqcd/SU0QC/Vy6EmOYsiac=;
	b=VnTpZ6bdb7MM+iod+J2HKdFaLyn1EOd/hOxQkdXbAOmsNm19WZ9OLXuMA48QV0w+zH
	DajQbhYH406NkMw1RUtH17EGfWt0u8qfxdPbbb+gROqv4lJwYvvja7PnOHSGRelV7ZdJ
	7gvqgJ25EdoEii2zpD9h3eX7jxpvQiyXK1SmldCKuRH0FtxyEdEZQ0QFpGQS+fPQzxNO
	0aOJoeWEV0RkKCxSY9dhqrts7srlwUkXNGvHxELMehj3hFGcFvHbr6IlnUzwXlHOVysA
	crhyem6BgwrVrwa5xQFLJ65lx9YChdSeJthnEDxbeVb2oj0BP8Xfhy+ntmc+ZOF+bRQl
	my1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=98JOxuqlJVZoGMNI/F+3Atqcd/SU0QC/Vy6EmOYsiac=;
	b=odsnGFS345WeHMVKz7oWN00hm8bJbYgvzl3wfyIgrcbXPPQWo9pZYYvrOksMVv7u/f
	qsK8OMD0ovaBhTalgP+zAetRfV9PilsNYJBoIBf3SO2ycYyyryqH1XU5WVjCLNSEffPB
	7GMQgbevM77IVW5nxKGbYXO7HKIJ0K12j0vjG4lcS7nQw1uTPlczyiyHzgX40NIhme/X
	ud1aaf99Lxi6XV7r4vNIrJ75MENuigZEZakLey1Udr6SVdR1vpox7CcfvpHTzNwBzPfx
	gdDhYYsQ+edkUpike/EYd91PI+nUos/sKHkxzdzjKvWDKgWDN5gdMHn9ekjEt5xSHL2g
	7c+A==
X-Gm-Message-State: APjAAAWoAixE6jWgZqcJuhLQbQp2o3cBzrrGN8rq7Gyo/HKLjE8ellVY
	z3RiyMJ3bEwDBP/necbiQaiJGF3U26ltjw==
X-Google-Smtp-Source: APXvYqyoTDg28I6UJbS+TaOxwsQqphAXju5hEafGZer80OPP0BppIr8fqQJJOiIRSd9ySlKLlfJubA==
X-Received: by 2002:aca:4708:: with SMTP id u8mr5680448oia.166.1559680448152; 
	Tue, 04 Jun 2019 13:34:08 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.06
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:20 -0500
Message-Id: <20190604203351.27778-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: [Qemu-devel] [PATCH v4 08/39] target/alpha: Use env_cpu, env_archcpu
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
Replace alpha_env_get_cpu with env_archcpu.  The combination
CPU(alpha_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h          | 5 -----
 linux-user/alpha/cpu_loop.c | 2 +-
 target/alpha/helper.c       | 8 +++-----
 target/alpha/sys_helper.c   | 8 ++++----
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index e391195be0..86d3e953b9 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -278,11 +278,6 @@ struct AlphaCPU {
     QEMUTimer *alarm_timer;
 };
 
-static inline AlphaCPU *alpha_env_get_cpu(CPUAlphaState *env)
-{
-    return container_of(env, AlphaCPU, env);
-}
-
 #define ENV_OFFSET offsetof(AlphaCPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index 61992571e1..7a94eee84c 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUAlphaState *env)
 {
-    CPUState *cs = CPU(alpha_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
     target_siginfo_t info;
     abi_long sysret;
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2134ee1e9d..93b8e788b1 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -136,7 +136,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
                                 int prot_need, int mmu_idx,
                                 target_ulong *pphys, int *pprot)
 {
-    CPUState *cs = CPU(alpha_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_long saddr = addr;
     target_ulong phys = 0;
     target_ulong L1pte, L2pte, L3pte;
@@ -486,8 +486,7 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
    We expect that ENV->PC has already been updated.  */
 void QEMU_NORETURN helper_excp(CPUAlphaState *env, int excp, int error)
 {
-    AlphaCPU *cpu = alpha_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     env->error_code = error;
@@ -498,8 +497,7 @@ void QEMU_NORETURN helper_excp(CPUAlphaState *env, int excp, int error)
 void QEMU_NORETURN dynamic_excp(CPUAlphaState *env, uintptr_t retaddr,
                                 int excp, int error)
 {
-    AlphaCPU *cpu = alpha_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     env->error_code = error;
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index ac22323191..f9c34b1144 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -44,17 +44,17 @@ uint64_t helper_load_pcc(CPUAlphaState *env)
 #ifndef CONFIG_USER_ONLY
 void helper_tbia(CPUAlphaState *env)
 {
-    tlb_flush(CPU(alpha_env_get_cpu(env)));
+    tlb_flush(env_cpu(env));
 }
 
 void helper_tbis(CPUAlphaState *env, uint64_t p)
 {
-    tlb_flush_page(CPU(alpha_env_get_cpu(env)), p);
+    tlb_flush_page(env_cpu(env), p);
 }
 
 void helper_tb_flush(CPUAlphaState *env)
 {
-    tb_flush(CPU(alpha_env_get_cpu(env)));
+    tb_flush(env_cpu(env));
 }
 
 void helper_halt(uint64_t restart)
@@ -78,7 +78,7 @@ uint64_t helper_get_walltime(void)
 
 void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
 {
-    AlphaCPU *cpu = alpha_env_get_cpu(env);
+    AlphaCPU *cpu = env_archcpu(env);
 
     if (expire) {
         env->alarm_expire = expire;
-- 
2.17.1


