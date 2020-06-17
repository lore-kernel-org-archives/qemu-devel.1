Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20789C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0ED20897
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNYKdFfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0ED20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfoq-00073x-4I
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEV-00048Z-Ih
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:31 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:34438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfET-0000Lq-NS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:31 -0400
Received: by mail-qt1-x841.google.com with SMTP id u17so2787124qtq.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8Q2sL8ohmf8wunp2u0YbDC2Iqv7PQMpqvb2Mr0aPlxc=;
 b=gNYKdFfHfp3hprbcJcWx41N94LYYAkf3UbpgGT651vSBkXvSLCyegKbcfSdCvI5B6H
 8V1qZPe2JIxzxZOFKRF8vqk9h6aLJtWXYLnDeu8qFKzReZb9l7IUZbkT1c5wcWGZMpSi
 pYK6TRseneD8eztvJOmVmxEenNRly046sp7Feo/N8jjbR1vo7JWyBwB5VCxuvxAgOtEx
 RhHRkuG/qgFA7CVapVJ5X3Zx7JUMiOlwGdQ5DUqSekapIdwoh36N6owZWY01KW2PZxC5
 S4VJ4EgCaTKNTK9P9dBtQeTxgy5OnrOc4EVwYV/Vjx00SJR9q9S+WuQKYYe507vEDcuo
 vZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8Q2sL8ohmf8wunp2u0YbDC2Iqv7PQMpqvb2Mr0aPlxc=;
 b=LGne6plKbc7Nb2Nmwgj1f9tNCoT2EcLbT3hvpnukaZyC7adh3W05WFtjt5twSZfX2S
 cn2eQaer47U0ijdU0dBLT2Mlup0PJcXcqcSqaZpli9lUwKjXhjqTT4ZQcgGBvUWk9EB3
 5nRDimBL1vrW/VB4esb1SKi4ogwpM59ad5GZnAELcUWi2tQviEEGPCtVxpE09x+tlgB+
 spj/fVJ1ZryHtvR3K//7qcfzc6hwg6oEfF/BgvzADaHrI5DpOLrYQVdKAD9Uy8zss8FV
 JoS4ePqhXMl7M/fJ+QaU+VdJ2Z0K/FWl+9o+3IryBpEUOTv9E0M/UwCSbxDV45W+iV1r
 jHgw==
X-Gm-Message-State: AOAM532Zu4taQvIigJPZM5lGrSzBHgX1OiZ3ZoxaZ2y927n/9Sx78LH0
 l++KiNG7zJWkmtLQP8MbPVIl/vvJPAkgRw==
X-Google-Smtp-Source: ABdhPJwu7k0bFZmh+QSrr8ehQ+YnZJGLLpqcqSifhAjlMGt3JG2R2C8/ysiwY1XQZMoOvmVGclHGaA==
X-Received: by 2002:ac8:5354:: with SMTP id d20mr1106683qto.363.1592427868582; 
 Wed, 17 Jun 2020 14:04:28 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:27 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 50/73] mips: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:08 -0400
Message-Id: <20200617210231.4393-51-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, robert.foley@linaro.org,
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
index 92608cfe15..682b969579 100644
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


