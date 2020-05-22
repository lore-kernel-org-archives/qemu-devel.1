Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC306C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A922070A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2W5klQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A922070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAQw-0006pX-KF
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKW-0003Bo-PT
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:28 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKV-0006Fb-0y
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id y18so5388902pfl.9
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RmwrC3sLLuRkvLN26zkcFirbGoGQYa0KIlDIjcwq1Ao=;
 b=N2W5klQADY+U2KyTIyrtrH2WNaG8WKXsoBq6Xhowpd6L48eQLDgZbu/RrQIRIgCGMK
 Rmn2ToDaewJL48Ir4W+XUFIQ9EUZC0PqpzUVJcofdAgLO0nrDUXuvvyqw3E/vJy2WBsx
 aI40QT1MZ91Zllwygdiaoh5+GUceOxLfUm659Y/AJdqQnz/DW/fdSTIemmkkweICIe1L
 CLyMKd0DrrLvyHsHqPQ7WTxptNFS+WrmLAuXyLTd1j1oc1HkD/EYqkAJSEr6wB4mo2Ze
 WO1Hch9QYkYvsAioGXtG8YjVBc/XLNJgojSRHX7P2HYR4bgURjYVpxoEM7EStKwCjApZ
 MSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RmwrC3sLLuRkvLN26zkcFirbGoGQYa0KIlDIjcwq1Ao=;
 b=ApVzKxoKq59ddE7u1R1/QUM6iENgmBBf1Wl4I5eFGIeojmeWI6qE5kn4qESL0ard7v
 S7FGVr/PMIU94ZdiUpjmQvONcxWKn0t7ekt6Yw9kXB1GWaLpociXjnQV1OSXEf2LuXhp
 9Uh5DUPyK2ZpQ0zzjVIn/MFlOR/T/LISGMRbYTOdDVaRjmROcZ07tJOI6RlHM0LXCwMU
 f5x0J8Gs/SXpQsOwuACkZFfOGPc6UKazRUlfmog8gwT9vKy5moaigJc0k5ya4dLGA52f
 jXIICbHeDQ4NVHyZW2IjJ4uUj2TAXslsljziKBT9NnfIynbZeE8sMSFtdqmECcRqW45Q
 Yb6Q==
X-Gm-Message-State: AOAM532vUE0BdGja9mhPAL6ylhll9NU/rkCszTGJWMGsIIJpifurLc6X
 oVXrdLHxwJ/WQWz4pPjHiNJJxvisNxnqWg==
X-Google-Smtp-Source: ABdhPJxejFJfyZ68h+SYgdNQ8DHz0GvmK3i8D7h/UlhfwZlpEI8w8jNZBT6iAiBfAcXrjPH8h3NEbg==
X-Received: by 2002:a62:1512:: with SMTP id 18mr4611082pfv.326.1590164125233; 
 Fri, 22 May 2020 09:15:25 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:24 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/19] accel/tcg: Fixed tsan warnings.
Date: Fri, 22 May 2020 12:07:49 -0400
Message-Id: <20200522160755.886-14-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: robert.foley@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For example:
WARNING: ThreadSanitizer: data race (pid=35425)
  Write of size 4 at 0x7bbc000000ac by main thread (mutexes: write M875):
    #0 cpu_reset_interrupt hw/core/cpu.c:107:28 (qemu-system-aarch64+0x843790)
    #1 arm_cpu_set_irq target/arm/cpu.c (qemu-system-aarch64+0x616265)
    #2 qemu_set_irq hw/core/irq.c:44:5 (qemu-system-aarch64+0x8462ca)
  Previous atomic read of size 4 at 0x7bbc000000ac by thread T6:
    #0 __tsan_atomic32_load <null> (qemu-system-aarch64+0x394c1c)
    #1 cpu_handle_interrupt accel/tcg/cpu-exec.c:534:9 (qemu-system-aarch64+0x4b7e79)
    #2 cpu_exec accel/tcg/cpu-exec.c:720:17 (qemu-system-aarch64+0x4b7e79)
or
WARNING: ThreadSanitizer: data race (pid=25425)
  Read of size 8 at 0x7f8ad8e138d0 by thread T10:
    #0 tb_lookup_cmp accel/tcg/cpu-exec.c:307:13 (qemu-system-aarch64+0x4ac4d2)
    #1 qht_do_lookup util/qht.c:502:34 (qemu-system-aarch64+0xd05264)
  Previous write of size 8 at 0x7f8ad8e138d0 by thread T15 (mutexes: write M728311726235541804):
    #0 tb_link_page accel/tcg/translate-all.c:1625:26 (qemu-system-aarch64+0x4b0bf2)
    #1 tb_gen_code accel/tcg/translate-all.c:1865:19 (qemu-system-aarch64+0x4b0bf2)
    #2 tb_find accel/tcg/cpu-exec.c:407:14 (qemu-system-aarch64+0x4ad77c)

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/tcg-all.c       | 4 ++--
 accel/tcg/tcg-runtime.c   | 7 ++++++-
 accel/tcg/translate-all.c | 6 +++++-
 hw/core/cpu.c             | 2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 3b4fda5640..f94ea4c4b3 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -54,8 +54,8 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
     int old_mask;
     g_assert(qemu_mutex_iothread_locked());
 
-    old_mask = cpu->interrupt_request;
-    cpu->interrupt_request |= mask;
+    old_mask = atomic_read(&cpu->interrupt_request);
+    atomic_or(&cpu->interrupt_request, mask);
 
     /*
      * If called from iothread context, wake the target cpu in
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 446465a09a..bd0cd77450 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -31,6 +31,7 @@
 #include "disas/disas.h"
 #include "exec/log.h"
 #include "tcg/tcg.h"
+#include "qemu/tsan.h"
 
 /* 32-bit helpers */
 
@@ -151,6 +152,7 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
+    void *tc_ptr;
 
     tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, curr_cflags());
     if (tb == NULL) {
@@ -161,7 +163,10 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
                            TARGET_FMT_lx "/" TARGET_FMT_lx "/%#x] %s\n",
                            cpu->cpu_index, tb->tc.ptr, cs_base, pc, flags,
                            lookup_symbol(pc));
-    return tb->tc.ptr;
+    TSAN_ANNOTATE_IGNORE_READS_BEGIN();
+    tc_ptr = tb->tc.ptr;
+    TSAN_ANNOTATE_IGNORE_READS_END();
+    return tc_ptr;
 }
 
 void HELPER(exit_atomic)(CPUArchState *env)
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3fb71a1503..6c0e61994c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -58,6 +58,7 @@
 #include "exec/log.h"
 #include "sysemu/cpus.h"
 #include "sysemu/tcg.h"
+#include "qemu/tsan.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
@@ -1704,6 +1705,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         max_insns = 1;
     }
 
+    TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();
  buffer_overflow:
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
@@ -1902,9 +1904,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
         atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
         tb_destroy(tb);
+        TSAN_ANNOTATE_IGNORE_WRITES_END();
         return existing_tb;
     }
     tcg_tb_insert(tb);
+    TSAN_ANNOTATE_IGNORE_WRITES_END();
     return tb;
 }
 
@@ -2409,7 +2413,7 @@ void dump_opcount_info(void)
 void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(qemu_mutex_iothread_locked());
-    cpu->interrupt_request |= mask;
+    atomic_or(&cpu->interrupt_request, mask);
     atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
 }
 
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 77703d62b7..6c16ccc426 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -104,7 +104,7 @@ void cpu_reset_interrupt(CPUState *cpu, int mask)
     if (need_lock) {
         qemu_mutex_lock_iothread();
     }
-    cpu->interrupt_request &= ~mask;
+    atomic_and(&cpu->interrupt_request, ~mask);
     if (need_lock) {
         qemu_mutex_unlock_iothread();
     }
-- 
2.17.1


