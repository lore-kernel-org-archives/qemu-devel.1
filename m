Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0960C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAE921841
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIrJ8GPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAE921841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfPM-0007me-JI
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE5-0003F4-EK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:05 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:43931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDt-0008UP-PL
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:05 -0400
Received: by mail-qk1-x741.google.com with SMTP id j68so138959qkb.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bHkAJHEjthSszeufZ4EcOnf2q9qJPdqEDnGkc3v/vAE=;
 b=UIrJ8GPSOnQW0OYDixWOg0Ybkar/cEywpT23s8H0785SiHHmx3gE3BkDOC8S24TbhO
 W2i7TfbkHj9fWXVoB7yCDfNSX+KfZct2JU4HcvrXnib+Bqnw7hJJnKhiZazpEFyPPXp1
 YigjPlOw6PJjDLNazEzKxiSsgwjv4F0NVtS7qpjeFrmJE9KIFY5uarATkJZhw5dhwVw4
 dHU3kNmH1iO911UiwLfJ5TOl0kXrfDND1Iv/O5YNK0bwn/RpBDNx/vJOEwcsqZQTKaJr
 F3GPexT8cH2blQdGoUBDDevmJUxs9RQ8TrOhLGNaRsq3CROVDrsBYYDChGtKn8ze10XB
 /gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bHkAJHEjthSszeufZ4EcOnf2q9qJPdqEDnGkc3v/vAE=;
 b=HyelD1T+q21/thf0c8MnWbvIjghOxZuIlcDZ02FjuzIpuZt3UdPmroiUFEHjfJHrgu
 tAZHsV5Qufi1fQ3CXe4kyIQvwIRT3W2zLr/LeFMrdJcM1GqNQ1obeJSbUIIyLjLfFjmW
 6iViiuhjC9BvQLTyhjeotRnNQtArrv7O8dSvGNf6qqvyyFUzGIheS72E2HRqBMF+ict4
 bVRgcxaeQY/nRZNtgIAzFE13yzkHdLgLTF43ZMS1BQfnFKPfB7ya2MWEz6sKSqRNomAq
 mSLHfeurAJukWOj1jA3URd3njlPIneAYBUV/GbFJIEhbSllyWhsvTMke7lLqISOKlKj7
 HF8g==
X-Gm-Message-State: AOAM531J3nqMBM7aAA5VQgE5lGh/3dJJY5B23/faJuDhV38jDvH0Gz/P
 rO2FBjLWhuvGqEAndvtKFqodIpOARfr+UA==
X-Google-Smtp-Source: ABdhPJzcf8hlsnvo61iMLLG6l2rwNU0iCc/dkJAmKakGeKLizjN15fvR8yK6GJ70Tj7JeQQethXYvw==
X-Received: by 2002:a37:9ad5:: with SMTP id c204mr546510qke.413.1592427829379; 
 Wed, 17 Jun 2020 14:03:49 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:48 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 23/73] mips: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:41 -0400
Message-Id: <20200617210231.4393-24-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x741.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Converted code in target/mips/kvm.c to cpu_halted.]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/mips/cps.c            | 2 +-
 hw/misc/mips_itu.c       | 4 ++--
 target/mips/cp0_helper.c | 6 +++---
 target/mips/kvm.c        | 2 +-
 target/mips/op_helper.c  | 2 +-
 target/mips/translate.c  | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index cdfab19826..51176e1be0 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -54,7 +54,7 @@ static void main_cpu_reset(void *opaque)
     cpu_reset(cs);
 
     /* All VPs are halted on reset. Leave powering up to CPC. */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
 }
 
 static bool cpu_mips_itu_supported(CPUMIPSState *env)
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 3540985258..623a600ed1 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -183,7 +183,7 @@ static void wake_blocked_threads(ITCStorageCell *c)
 {
     CPUState *cs;
     CPU_FOREACH(cs) {
-        if (cs->halted && (c->blocked_threads & (1ULL << cs->cpu_index))) {
+        if (cpu_halted(cs) && (c->blocked_threads & (1ULL << cs->cpu_index))) {
             cpu_interrupt(cs, CPU_INTERRUPT_WAKE);
         }
     }
@@ -193,7 +193,7 @@ static void wake_blocked_threads(ITCStorageCell *c)
 static void QEMU_NORETURN block_thread_and_exit(ITCStorageCell *c)
 {
     c->blocked_threads |= 1ULL << current_cpu->cpu_index;
-    current_cpu->halted = 1;
+    cpu_halted_set(current_cpu, 1);
     current_cpu->exception_index = EXCP_HLT;
     cpu_loop_exit_restore(current_cpu, current_cpu->mem_io_pc);
 }
diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index bbf12e4a97..4d413c24d3 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -43,7 +43,7 @@ static bool mips_vpe_is_wfi(MIPSCPU *c)
      * If the VPE is halted but otherwise active, it means it's waiting for
      * an interrupt.\
      */
-    return cpu->halted && mips_vpe_active(env);
+    return cpu_halted(cpu) && mips_vpe_active(env);
 }
 
 static bool mips_vp_is_wfi(MIPSCPU *c)
@@ -51,7 +51,7 @@ static bool mips_vp_is_wfi(MIPSCPU *c)
     CPUState *cpu = CPU(c);
     CPUMIPSState *env = &c->env;
 
-    return cpu->halted && mips_vp_active(env);
+    return cpu_halted(cpu) && mips_vp_active(env);
 }
 
 static inline void mips_vpe_wake(MIPSCPU *c)
@@ -74,7 +74,7 @@ static inline void mips_vpe_sleep(MIPSCPU *cpu)
      * The VPE was shut off, really go to bed.
      * Reset any old _WAKE requests.
      */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
 }
 
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 96cfa10cf2..92608cfe15 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -162,7 +162,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9552b280e0..152b45826c 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1124,7 +1124,7 @@ void helper_wait(CPUMIPSState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
     /*
      * Last instruction in the block, PC was updated before
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 9fad58ea2c..0d0792d701 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -31495,7 +31495,7 @@ void cpu_state_reset(CPUMIPSState *env)
             env->tcs[i].CP0_TCHalt = 1;
         }
         env->active_tc.CP0_TCHalt = 1;
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
 
         if (cs->cpu_index == 0) {
             /* VPE0 starts up enabled.  */
@@ -31503,7 +31503,7 @@ void cpu_state_reset(CPUMIPSState *env)
             env->CP0_VPEConf0 |= (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_VPA);
 
             /* TC0 starts up unhalted.  */
-            cs->halted = 0;
+            cpu_halted_set(cs, 0);
             env->active_tc.CP0_TCHalt = 0;
             env->tcs[0].CP0_TCHalt = 0;
             /* With thread 0 active.  */
-- 
2.17.1


