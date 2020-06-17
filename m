Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A0CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319572166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwPPvfcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319572166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfRd-0002dE-D3
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEG-0003Wx-63
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:16 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:37880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEE-00007X-7u
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:15 -0400
Received: by mail-qk1-x731.google.com with SMTP id b27so3510324qka.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4aryhQbcmaB7oNBbR9UD5nwcxfkIN5/StOGhgwEfKig=;
 b=BwPPvfcY3SN6EkACB8Aw04cAGgk26UutV0tjcSaMPiPDr1sX1TwEwIxzHSNEM7VtFn
 XbApUFCS09sXSuvnsdChjTl4LOx4Q6GXccgbUrI67MPyIPtsIT6RjUFIDK131NiQZjr0
 HDXZLwi4OT0BmOf7kXLzMbLlIP22E7hQ0JVxpuajweYrdKMs+bwX2khBtvFGwvF/vaLs
 tDvn4n8dHBGMnLAVNw0OGT3MAeToKIHA0vzkbRdJ5UrCFSCD6B8Lrs5IQtYliEcQMKkv
 zHCJ4vXrmQjhc8K+Y5bsdtEJaCAuDSk55kIgCA04+FLw2nylCbE+KLbQANQGGCp0NuWM
 F1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4aryhQbcmaB7oNBbR9UD5nwcxfkIN5/StOGhgwEfKig=;
 b=N7PFu9oChtqbVvTsVvWvQXm6BQpX3xojLkSLEBWnhVkP7/nkTYZmzbBJWZHKm3XZHU
 kIl+RS3+CQoP8Hm+dahPmygp53r0qCAIw6nSzVAdG6hxFK9YsdRqgLu0RMs1tJ5MLGQz
 RhsrsYeFKjkTrDL3EHipsTdC+PHDoSRHRC9wxipEHrwjF2Lg4FV3qUAmen1R5pRocRlT
 V4d8elYUaJH+zLPDgKIPb5tRPJhchgEqyf7uKJc8+3TIoaKgd2pnAzgI1/SbGMaHi3Wq
 FeUqrigmsuogUU57gdLCR7yukpVQkHrPQZp2+eCPok7sIV4zZ+5KkxgskZG4je4gnqDX
 Lw8A==
X-Gm-Message-State: AOAM532cEw/LGaBq6oT4uYAjTYupoDkYZRbCjTHE7p5gtoLUjTUm2R/0
 aT4iwsqJ1Ix7Hs3qeHRlwp7ClGMKNriycA==
X-Google-Smtp-Source: ABdhPJyju7vmLoHpCcD0cYBcsx3wNUKHeGKSLAyqnl8xM8It0WMH5WMieDP5E/ZZyjTy8xDPZQhTCg==
X-Received: by 2002:a05:620a:3cc:: with SMTP id
 r12mr627072qkm.44.1592427852927; 
 Wed, 17 Jun 2020 14:04:12 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:12 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 39/73] i386: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:01:57 -0400
Message-Id: <20200617210231.4393-40-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x731.google.com
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/i386/cpu.c        | 2 +-
 target/i386/helper.c     | 4 ++--
 target/i386/svm_helper.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4d3ab0f3a2..59ac96bd01 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7093,7 +7093,7 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
 
 static bool x86_cpu_has_work(CPUState *cs)
 {
-    return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
+    return x86_cpu_pending_interrupt(cs, cpu_interrupt_request(cs)) != 0;
 }
 
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 058de4073d..623a7299ac 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -1029,12 +1029,12 @@ void do_cpu_init(X86CPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
     CPUX86State *save = g_new(CPUX86State, 1);
-    int sipi = cs->interrupt_request & CPU_INTERRUPT_SIPI;
+    int sipi = cpu_interrupt_request(cs) & CPU_INTERRUPT_SIPI;
 
     *save = *env;
 
     cpu_reset(cs);
-    cs->interrupt_request = sipi;
+    cpu_interrupt_request_set(cs, sipi);
     memcpy(&env->start_init_save, &save->start_init_save,
            offsetof(CPUX86State, end_init_save) -
            offsetof(CPUX86State, start_init_save));
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 63eb136743..c739bf0d9c 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -316,7 +316,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     if (int_ctl & V_IRQ_MASK) {
         CPUState *cs = env_cpu(env);
 
-        cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_VIRQ);
     }
 
     /* maybe we need to inject an event */
@@ -674,7 +674,7 @@ void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
                        env->vm_vmcb + offsetof(struct vmcb, control.int_ctl));
     int_ctl &= ~(V_TPR_MASK | V_IRQ_MASK);
     int_ctl |= env->v_tpr & V_TPR_MASK;
-    if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_VIRQ) {
         int_ctl |= V_IRQ_MASK;
     }
     x86_stl_phys(cs,
-- 
2.17.1


