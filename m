Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E74C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80F22075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jiF+zYDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80F22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGQf-0008Il-2z
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:53:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8c-0001K6-7O
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8b-0004Q6-7Q
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:30 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8b-0004PM-2G
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:29 -0400
Received: by mail-oi1-x241.google.com with SMTP id b21so12668685oic.8
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=tSiI4G5J5ouiA/gsVkWkdNcl9+jS6pdNMYuFN+MKcoA=;
	b=jiF+zYDfziQIWsSLbY3qDc8I+sLKQVvgdJtiOLtlpnKPGRm1QzKc9pMKi1Y4LqCC1e
	b3PxHsP33RiaC33MXSMSD58AmDey5CU2u+8kOaZ1D8Y3Ds/8+CsSDC+yPF/LiwppZ194
	x6BZNurk2Vzyfs3BIf+ArQSTjkGkfuJ1WZhbdZWUclCZf2QeSHNdGjxRP125zFMDeUsx
	r+4P8uZB44u/THcDynkL9XYeU0Z1knvS4oSQdx9ijnmBrv3OkBTjNq3RrbLkKXLVHxxJ
	l72XRQNAG3kYPVOfOSrdx3DShwD7N8ZDesZpgsf/9ICiCUxpvV/EhAPRpGCI+WFiXXch
	gSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=tSiI4G5J5ouiA/gsVkWkdNcl9+jS6pdNMYuFN+MKcoA=;
	b=saHF9L5Xr+REGykqdw/dBfeuN4oD6pqF93mbxY2UAsErBqilzqDdb+g3rIGUuFqIC+
	Ff2/Tg2iHZySWkTqp/IL1/mq1oo4Ylp3kOAv2HqLRPzVUcgIcBdpdYgEHSInnNqqXFNg
	vtaCK8IS9/s/hbD2Wwie+FWj5p3QaAtuU7e10HI9Rb+zagswnQrlOtRsEAapPyW1maGa
	fHrHS5dspVAd+gQqrBe+JrgLYJYKg63g9dOFRpqZy03IwOjUzN3Keb79Ddo790jd5dA6
	emSYdCn+r0uN0gOapiSc9wOVNaP80IILa5475ucyfSjQJfbY2ASTB1cCr/F16dh93EFU
	oPaw==
X-Gm-Message-State: APjAAAUrp3NGBA8g73BBz4+6vLNhtVjmtrhRTHHb6fnsUY60eKlI6/z3
	6V2DPQRg5uL7d6umXB9IgR2dJhsV6psa0g==
X-Google-Smtp-Source: APXvYqyry3ccnGol7smOk24OC2BSLzUQ/KENwsFf4iV3iSFSRjf14JlsSKCkVhV8Zk5+56N4N0VIcg==
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr5736686oib.85.1559680468104; 
	Tue, 04 Jun 2019 13:34:28 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.27
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:33 -0500
Message-Id: <20190604203351.27778-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: [Qemu-devel] [PATCH v4 21/39] target/openrisc: Use env_cpu,
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

Cleanup in the boilerplate that each target must define.
Replace openrisc_env_get_cpu with env_archcpu.  The combination
CPU(openrisc_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h              | 5 -----
 linux-user/openrisc/cpu_loop.c     | 2 +-
 target/openrisc/exception_helper.c | 5 ++---
 target/openrisc/sys_helper.c       | 8 ++++----
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 50f79d540b..9e46ac5266 100644
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
index 0797cc9d38..d02a1cf0aa 100644
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


