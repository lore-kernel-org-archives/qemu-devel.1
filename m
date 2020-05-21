Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB02C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B1820759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q81pMuSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B1820759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbomK-0007ud-7F
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIz-0004Gp-6z
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:25 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:46379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIy-0006fA-4U
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:24 -0400
Received: by mail-qk1-x743.google.com with SMTP id f83so7781462qke.13
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V+COCY1tch1+h8AFER7aKTPV6Dtrz1h9iyiTM5X9pZo=;
 b=q81pMuSfHpaSQP0Bg6AOmJQPY1Vlzu4VEsHUhanDswxU9oDMvvuwuHCItNV6UMUlSN
 WJE6cPs1TGCrcbYeiXqWQBLwP+jrqDLqK2Bx1EDHupkPAN/EZ8jtNlqfB1kfYWMpvlgO
 LO8wcmOyMgbak/4n5Ha2hcsfA1zukYy9zYxDet9wmyy7AaZ4sZkhcjUOALHD59K5w9bd
 A6e3bp7AKFZ44F4dimb101S0HIlqh4Wul5Xi2U6R/+EGLIOo/7dNSJ7i3m0kI6R3n7yl
 YywP9XkFwuzvjbB18qSf6Q83W203JDvYYimzN69TwngzwR8VXqfsEzx6rT4vBzdt1K1t
 iQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V+COCY1tch1+h8AFER7aKTPV6Dtrz1h9iyiTM5X9pZo=;
 b=fQnBFE3HkzlpRu8Tzb8FuC6IRdj5NrKfPVy7xkgBA4uq9qs/D0rSolWsdM6we02F8C
 D5rTlegvUeN+jttwpiBH5GY6DIDvNvxNnie59oB2bjL9r6JNZD7KvMJJJa8+e0/iS60f
 8dz01uRphVaWG9o4O6COjDRKubNVVhHjsfVeUaSKU5po2CDqGqQ5duBVPlv7j5fSLV4N
 9/Op1TcdTqP2kN9EzWCJbXar8JFf4AWfZcIkPpLZdMISpMXP21AIsLnW+Y4/0/Zt1UBF
 PsiRvmRyB4RBwmjqi9dU5HMlR5QaGRuZ5O8uPsWEyM99wk29vH8myOXgeEZTbIvmsSsu
 KJVA==
X-Gm-Message-State: AOAM532+Vn38hGiLqfxSepLfzmnTfBK6G1LiEB7xp4QePkzshKSYWzNN
 kZXt+ngrPVaYEhdhnh8jp0f0PhNtaojQgQ==
X-Google-Smtp-Source: ABdhPJzk2WbH9zDu6VpBbJowVTHiZDut64J9RM4Lw81nXXoP3MK2OSLzjko3PeLhAn/miy5AUBSTGw==
X-Received: by 2002:a37:f517:: with SMTP id l23mr10962919qkk.475.1590079463093; 
 Thu, 21 May 2020 09:44:23 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:22 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 51/74] mips: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:48 -0400
Message-Id: <20200521164011.638-52-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, cota@braap.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/mips/cpu.c | 7 ++++---
 target/mips/kvm.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e86cd06548..761d8aaa54 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -56,13 +56,14 @@ static bool mips_cpu_has_work(CPUState *cs)
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
     bool has_work = false;
+    uint32_t interrupt_request = cpu_interrupt_request(cs);
 
     /*
      * Prior to MIPS Release 6 it is implementation dependent if non-enabled
      * interrupts wake-up the CPU, however most of the implementations only
      * check for interrupts that can be taken.
      */
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((interrupt_request & CPU_INTERRUPT_HARD) &&
         cpu_mips_hw_interrupts_pending(env)) {
         if (cpu_mips_hw_interrupts_enabled(env) ||
             (env->insn_flags & ISA_MIPS32R6)) {
@@ -76,7 +77,7 @@ static bool mips_cpu_has_work(CPUState *cs)
          * The QEMU model will issue an _WAKE request whenever the CPUs
          * should be woken up.
          */
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (interrupt_request & CPU_INTERRUPT_WAKE) {
             has_work = true;
         }
 
@@ -86,7 +87,7 @@ static bool mips_cpu_has_work(CPUState *cs)
     }
     /* MIPS Release 6 has the ability to halt the CPU.  */
     if (env->CP0_Config5 & (1 << CP0C5_VP)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (interrupt_request & CPU_INTERRUPT_WAKE) {
             has_work = true;
         }
         if (!mips_vp_active(env)) {
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 2b7d680547..e9b7a9f2ad 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -141,7 +141,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 
     qemu_mutex_lock_iothread();
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
             cpu_mips_io_interrupts_pending(cpu)) {
         intr.cpu = -1;
         intr.irq = 2;
-- 
2.17.1


