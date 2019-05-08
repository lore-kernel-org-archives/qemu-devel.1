Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BEDC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0C8205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQKkAutq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0C8205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOANk-0005dk-G1
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:24:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA79-0007cI-Nv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA78-00073e-JN
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA78-0006w7-Dk
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:14 -0400
Received: by mail-pl1-x641.google.com with SMTP id x15so8963339pln.9
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=52zjib8k8hXnxTjLlPWtXLTTNAt1VVEt0hF/cXL6Z2g=;
	b=SQKkAutqOQLk3uYO3BqvHfuX7z6OPaFdPqq0Oa5GOaNtjOC4Z7lylblQV9NXPSfR8E
	MVuO6FI4WK8Qw99YvbxFtOt/7FE5uBkivuk+ST197IHxu10R2MnODaZILZPNr/Zk8FQE
	5PhJLUq/lBW+xEYUd0SuNlRtFMq+k3vjSngAWlk6yPcGy47Q6pMz0uvWTVD5m0tUuSbb
	XCTXNYdv9HrqZ2cnL/l9DHYp7dotL9LFmN98Y7IIAUoqZD7vdm08+5Wy7UoQayESDmCv
	inpuoe3UkjAIP6BKqvbsSjWHYgQ/M76MHFJKKE4iB1sMLECT7diggAVi2wbXMs8F5u2Y
	Kp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=52zjib8k8hXnxTjLlPWtXLTTNAt1VVEt0hF/cXL6Z2g=;
	b=DCL/wA0DCC4AXOjnWVn+hp3AZfZYZ5DxMxfQM6bnI7E33Mfvz1NQmQbtmRdWuWdPUy
	i4nyemoWvMpEIKv0Ns1NafadcPrqOWEvVMSCffiHSEOnMW629N54sbNUR9nDL8+XFJhG
	mwIik1MiXfwi7afR4+s+dMcaV8jYqN3a0xlQ4bno5DOGrnrCQRde3Sw2TB9X/YZtzZnP
	GIvSbn94vUCJqvwmeSZYdEWWVZE++MsdgM46oJAPIgpGLjABb/D/94dEThQyLjRJvQEb
	FpypbXZ+ch1VPgl9e7WlyLlxCobV+7zpEtyPJntR1U2GGpHwHqpn1X4fGW1QMk7qSO6C
	xdCg==
X-Gm-Message-State: APjAAAVvAfxtaz6cXQHlSXhk6weldDWnlhZzH4stvTPACQPOg1v0RoGS
	y39ODvpT3Vv4gGkra266u1Q6mNjQyZg=
X-Google-Smtp-Source: APXvYqy2d3tjR7jZI0loJCFNHQrUooeO3bJ0A52xVLakuGWpSJCYtK4D7K0cER1uALnGUdIPytZyAA==
X-Received: by 2002:a17:902:820c:: with SMTP id
	x12mr42185155pln.199.1557274031172; 
	Tue, 07 May 2019 17:07:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:23 -0700
Message-Id: <20190508000641.19090-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 21/39] target/openrisc: Use env_cpu,
 env_archcpu
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
 target/openrisc/cpu.h              | 5 -----
 linux-user/openrisc/cpu_loop.c     | 2 +-
 target/openrisc/exception_helper.c | 5 ++---
 target/openrisc/sys_helper.c       | 8 ++++----
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 0ba4ae3356..91ba667139 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -317,11 +317,6 @@ typedef struct OpenRISCCPU {
 
 } OpenRISCCPU;
 
-static inline OpenRISCCPU *openrisc_env_get_cpu(CPUOpenRISCState *env)
-{
-    return container_of(env, OpenRISCCPU, env);
-}
-
 #define ENV_OFFSET offsetof(OpenRISCCPU, env)
 
 void cpu_openrisc_list(void);
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index f496e4b48a..4b8165b261 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUOpenRISCState *env)
 {
-    CPUState *cs = CPU(openrisc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
     abi_long ret;
     target_siginfo_t info;
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
index 6073a5b21c..dd639ba5f2 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -25,15 +25,14 @@
 
 void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
 {
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
+    OpenRISCCPU *cpu = env_archcpu(env);
 
     raise_exception(cpu, excp);
 }
 
 static void QEMU_NORETURN do_range(CPUOpenRISCState *env, uintptr_t pc)
 {
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_RANGE;
     cpu_loop_exit_restore(cs, pc);
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 05f66c455b..8f11cb8202 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -30,8 +30,8 @@
 void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 {
 #ifndef CONFIG_USER_ONLY
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    OpenRISCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
     target_ulong mr;
     int idx;
 
@@ -194,8 +194,8 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
                            target_ulong spr)
 {
 #ifndef CONFIG_USER_ONLY
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    OpenRISCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
     int idx;
 
     switch (spr) {
-- 
2.17.1


