Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5AEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0469A20738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZb91J4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0469A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboSD-0006WN-0J
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIP-0002oR-CW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:49 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:43885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIO-0006YJ-8c
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:49 -0400
Received: by mail-qt1-x844.google.com with SMTP id o19so5959582qtr.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g63owhhb8d7q+R165WbO0bbEASJ91qSEhs9R7K8DZ68=;
 b=pZb91J4+YV1jkHgjHuVL16X0gRx2pwVmAFRvZc3r7ppD8tNl4e4ssbPY62XRNoDpZu
 IE0+VzWruGoYhdw9k2kqB8lrboZGXkAmX0rjGf9V85f7fcoV2ow4k7fHDkYjTeDOPltX
 s7bJZCktdCI7Gs+RN0YkXSONm7E3cYXLNTCx3HNDjCbkQPJU/19CVBEFH2DuxWWqqSO6
 a5s5ZbTwTZeAH/rrJsu2x1jeEWTgZjRQReo7AxajmxTNAiwAcrhNWXDaCQCIZ/7OK4YQ
 iUpfjJWQtoxw0uP4UB0g9iLOAW+SSfsX1bVeb0wPz2LCWy9xTJtOrqyVhg6J2wiN/idr
 DKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g63owhhb8d7q+R165WbO0bbEASJ91qSEhs9R7K8DZ68=;
 b=eYbEhl1GE0QUvOcv/NaxZT0lNzuoixxQeox1PUad9t/tI7E0lOcboV3KLrqiKtFNyi
 zIMh2/56BlC4lSA2pxLfwyZdAYuwMPQ0D5FNRKMtIN4RAnzqrQlU/3OR6qVknNRxu+3P
 SDB3e/FgxrcGBgmZKRI2c/eJwcNXjG4eiuJ9nC/dwoB05ILQb997WqSPckd27Arg3qLe
 hntgvIyOS62yoV4Ra9KQoL2ltlODHum3VotGLRwCpymSxUlBEHfloA2S4yh9sjowA6Ch
 dcGTGbA7Fv0YB1ykHOqdOeGudioIP3NUlzDTKYnZc+eBEc69gEKKoRCFSJbfrx9vlqOS
 fBow==
X-Gm-Message-State: AOAM530Td0fp3E6uW5Yi+VyFTwAFtjWLeo9mL6xGU95PMWhxFMuS4fJc
 rJPp8v4UGJDKVkPb16zdHldwq9zKUcFPVw==
X-Google-Smtp-Source: ABdhPJxoSA+WpbJOz0cRapSvWGyFgNqZskC4h70FVJaCxHtB3cxQ7wfGL4lkfk+WXbNiZu8tuO9BHg==
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr11445559qtu.76.1590079427042; 
 Thu, 21 May 2020 09:43:47 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:46 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 24/74] mips: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:21 -0400
Message-Id: <20200521164011.638-25-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
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
index 92b9b1a5f6..0123510fab 100644
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
index de3e26ef1f..2b7d680547 100644
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
index 25b595a17d..35ea86a49b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -31328,7 +31328,7 @@ void cpu_state_reset(CPUMIPSState *env)
             env->tcs[i].CP0_TCHalt = 1;
         }
         env->active_tc.CP0_TCHalt = 1;
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
 
         if (cs->cpu_index == 0) {
             /* VPE0 starts up enabled.  */
@@ -31336,7 +31336,7 @@ void cpu_state_reset(CPUMIPSState *env)
             env->CP0_VPEConf0 |= (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_VPA);
 
             /* TC0 starts up unhalted.  */
-            cs->halted = 0;
+            cpu_halted_set(cs, 0);
             env->active_tc.CP0_TCHalt = 0;
             env->tcs[0].CP0_TCHalt = 0;
             /* With thread 0 active.  */
-- 
2.17.1


