Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C447C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7B920810
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvQxS9Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7B920810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfYh-000692-JK
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEA-0003M7-Tm
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:10 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:38879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE0-0008VI-Lt
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:10 -0400
Received: by mail-qv1-xf44.google.com with SMTP id ec10so1759797qvb.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pBQreEfimlo/TeCu0za1hNbEWK5jCOhKGwDICZx6xko=;
 b=mvQxS9BaVCNlAsDmYqVgirbmHemc9z5WGJbjnkzJv9ld/zyyZnu2xIuYAEslfWbhRH
 F0UFFmKK9x7rybo2O0NewTwltqm2r1k+4KdIBj/9sJ2/Vmokmyry8qIJaWNKfScDuH63
 qyu3ICvzmMwurx+Eoo+8C1+iFvJMGXX11vb+Uwx1e35m/kA8OPODIky6I7YThgaDKUf1
 INQtuUChZzhR4ix/qMdLcXTbRXp+kbLvJGjit+ApcHspQ51etdD1mX2UO1kiLgnirtGZ
 2rol7lbp1wGZ/6SbHz9PzLVSaJHsNlA0f8a7PFj0QK0f8530JVKEutKjUMfG/qPtMoPP
 uP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pBQreEfimlo/TeCu0za1hNbEWK5jCOhKGwDICZx6xko=;
 b=OCKk5osMC81pB/ardUXjVUk7urg0QspjIQg8YkYYHYDft6N8ESj4AsjWyNFzez4hVV
 SSSOr5oe7dtACOhN9PjXZYIlg96wjBYXv0cA9kEY9KaQAWkUK1lWSA9QDi/mhJqigC6E
 HlDwq11cQsNMUuQYntFkiHqg3JWqdv4PHHRBjo83J326EncwmK1H9MwjUrgsJ11/9YuU
 9icILbepu6aIpsSdrowCtORKhv9a6XQ5nCqgOLaeXa+W+5+jJzif2c6Y8/gjCh9pkuZr
 wDZ0gZJCZl1PKWjsu1Pqxe2TW27Zk//oQkUhjlMiXjRzV0xce0GToDJ4gFUYRfTR7NPv
 6wiA==
X-Gm-Message-State: AOAM532xGlLBVhoZEDT3+fpHmxB8c0RaQ/TgH+GyUWFBKewU8bvYWFk9
 K/pE3PJwImibw+3Ia+ASj7WybTJKKYew7w==
X-Google-Smtp-Source: ABdhPJyYrZ1uBKzifJhfGS0O+c6KGeE4xxlb8UUt+Gho5aEbJ3lKBpPux2D/YwwyH87j+UAFFgk2rw==
X-Received: by 2002:a0c:d40b:: with SMTP id t11mr623582qvh.0.1592427839478;
 Wed, 17 Jun 2020 14:03:59 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:58 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 30/73] cpu-exec: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:48 -0400
Message-Id: <20200617210231.4393-31-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf44.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
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
 accel/tcg/cpu-exec.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d95c4848a4..e296894ea1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -425,14 +425,21 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     return tb;
 }
 
-static inline bool cpu_handle_halt(CPUState *cpu)
+static inline bool cpu_handle_halt_locked(CPUState *cpu)
 {
-    if (cpu->halted) {
+    g_assert(cpu_mutex_locked(cpu));
+
+    if (cpu_halted(cpu)) {
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
         if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
             && replay_interrupt()) {
             X86CPU *x86_cpu = X86_CPU(cpu);
+
+            /* prevent deadlock; cpu_mutex must be acquired _after_ the BQL */
+            cpu_mutex_unlock(cpu);
             qemu_mutex_lock_iothread();
+            cpu_mutex_lock(cpu);
+
             apic_poll_irq(x86_cpu->apic_state);
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
             qemu_mutex_unlock_iothread();
@@ -442,12 +449,22 @@ static inline bool cpu_handle_halt(CPUState *cpu)
             return true;
         }
 
-        cpu->halted = 0;
+        cpu_halted_set(cpu, 0);
     }
 
     return false;
 }
 
+static inline bool cpu_handle_halt(CPUState *cpu)
+{
+    bool ret;
+
+    cpu_mutex_lock(cpu);
+    ret = cpu_handle_halt_locked(cpu);
+    cpu_mutex_unlock(cpu);
+    return ret;
+}
+
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -546,7 +563,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
             replay_interrupt();
             cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
-            cpu->halted = 1;
+            cpu_halted_set(cpu, 1);
             cpu->exception_index = EXCP_HLT;
             qemu_mutex_unlock_iothread();
             return true;
-- 
2.17.1


