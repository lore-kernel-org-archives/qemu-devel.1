Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA33C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743E420675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJ0fgsIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743E420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOA8k-0000Gh-Ky
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:08:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6r-0007DZ-Oe
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6p-00068O-M8
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:56 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA6p-00066C-F2
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:55 -0400
Received: by mail-pl1-x644.google.com with SMTP id x15so8963093pln.9
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=OiKWP6/OoPfPIuCP7uADTa7Y66Y39q2egElf8tswYBg=;
	b=xJ0fgsIVnk1IeUNgVRf7oddqihPNVP+vsm1JK7UJlabD4IS3jEH2NDUA9/hkrNjaF2
	jSdL3rJOO4k0gFnSkhTwrmq/rVmExMVDF4JCk81DKYZklv/TJD88sPhKlDknrUM2nxut
	dL1VjO3lxvJT6cVhYT5dFJMOqpGQX8ZEY9IGCG1okN6pxb4MAt3lfDmpieB868h+VSZf
	sFW6QzIIYWgJNbxtkvRFEQ/ir/Y0/Iq6OWzrG6N+cpy0PgmQnSDR3tc8eRD8ztm7X7UK
	Hv56NDYL8W5WuYGwYDX84ZRB/slw8vNqdSvsxU020FS0a6ew53KOO9gCs/cVM/psOsfe
	WbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=OiKWP6/OoPfPIuCP7uADTa7Y66Y39q2egElf8tswYBg=;
	b=OiAO5U79mQmmJn5mRtliua26WRsKdR5vDsZeTW5C8wtkNrXTOd2WTrtQf3R74DLP2L
	Umex/+gK9f/z6vKsLteDQaMDpek3K/XJ85p8sTKGcG+vBMIHnkz11CsCVfT1EzCqjKtq
	0g5c+hVIoTJpFW0i6qgLV83+Tsy+HqzKeqbo5z5tOfyhRwkcsUFOk74Bgez2E/4BjXza
	3OLYfBWaBDFXWMlaJxq77RFLq0nklfnzRuVPGMSbDb2HP4v1UhqOkuyvb/6O7xWL+6L6
	PsgE+yu+L/L+sXW4kJcxiAkkarBZjQiDAsvALXBoyKhMvav+vIwp9gD5LIVQmDIMCci+
	49ng==
X-Gm-Message-State: APjAAAXj9clnPQ+jl9OiFed4aLZWPnkNlfw9crMnL/8atNyg8UrB8MIu
	7Je0NAiqhJreqojdFVl2aW+BkDHp9+s=
X-Google-Smtp-Source: APXvYqynqn4pPiGUSGdiCqum8Pbk7GmFcmoBFtROTyUtzwwEO5XmbAZVYHq+6tCDP6PcMw0UMzYG3g==
X-Received: by 2002:a17:902:5acb:: with SMTP id
	g11mr7381466plm.198.1557274014064; 
	Tue, 07 May 2019 17:06:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.06.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:06:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:10 -0700
Message-Id: <20190508000641.19090-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v3 08/39] target/alpha: Use env_cpu, env_archcpu
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

With exactly one exception, most uses of alpha_env_get_cpu
were failures to use the more proper, ENV_GET_CPU macro,
now replaced by env_cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h          | 5 -----
 linux-user/alpha/cpu_loop.c | 2 +-
 target/alpha/helper.c       | 8 +++-----
 target/alpha/sys_helper.c   | 8 ++++----
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 2c7f75f584..53c085f691 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -273,11 +273,6 @@ struct AlphaCPU {
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
index 7201576aae..08dfb834a5 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -119,7 +119,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
                                 int prot_need, int mmu_idx,
                                 target_ulong *pphys, int *pprot)
 {
-    CPUState *cs = CPU(alpha_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_long saddr = addr;
     target_ulong phys = 0;
     target_ulong L1pte, L2pte, L3pte;
@@ -463,8 +463,7 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
    We expect that ENV->PC has already been updated.  */
 void QEMU_NORETURN helper_excp(CPUAlphaState *env, int excp, int error)
 {
-    AlphaCPU *cpu = alpha_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     env->error_code = error;
@@ -475,8 +474,7 @@ void QEMU_NORETURN helper_excp(CPUAlphaState *env, int excp, int error)
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


