Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DD0C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19732080C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZn8iXqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19732080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccMg-0007hM-7j
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hccLm-0007G9-JP
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hccLi-0002BB-AY
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:06:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hccLe-00025x-EO
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:06:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id d30so4570659pgm.7
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=PqJ1ISuGV2u+IdiY8ngyBhS17daHeZo+xRM6Jaz465M=;
 b=tZn8iXqs3XfARpWDC4gYs3wpKj4/K7T5a1M7N+c2uJgQe1ud5HERGSm0rXGZRw+PAi
 GUTRx0MJOV/Wi6wrnQ6PzlD3zDa6uHQBNbCE42Mk672+Inv4javqwKUL9rgNwCUkL7lW
 6ARRYIQgWLfoemoCYkupAABiIuA18lP9Ued8YbXCuaT0IlcPbNc3UvsWa/rCBoyA2Ckn
 +nKEstFfbYHrKvOcQgYx7G5ix+AQKd2OoNS/adIPiRbtgsiFfALecr17c9XrLrmVd+le
 b13UnilgQedB/rwFkeBlLipzVZQBimXpcqXNdjojnXpyhOKnfsTimZVFzwWXjMZ1I8vd
 OURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=PqJ1ISuGV2u+IdiY8ngyBhS17daHeZo+xRM6Jaz465M=;
 b=WvrgPuwDzd6Y12xS9TFHM0LYcT3bFkPlKsBsbTP9xMrhO3vtHF+4pqGDhqwKVCYKsy
 oRBD5LSivIuQEGKujgXLQPOB04x0SIQvsELYjCSNLNWdq7NticTQeLRL9gW4WrLayTRg
 STVY/GaaGyGRTjXMyEz8cmQd1OVVlUKXbG6dCW7MyRh6VEZhSTmWJPxc6xJFm4jxwz2I
 kffAPcIz2jun9FgoTkH2KXNK1oQID+3gLmxVI8DtZKWWAkE4jEVWQsitFOIxhSd0MQRi
 9XMPQ3qDcGNhGnBdnHOktuVG0xrCym1VU+wPnklgV39I3px4y86tdWigMy1GsjU0flrI
 sa5A==
X-Gm-Message-State: APjAAAWY2H7KHRghTde8eI7fC4JlZ4AbD002RidIi39AKaYeahaFJB4b
 xtBZPxDbMoT67sjegQtd3VsEU9Ls84Q=
X-Google-Smtp-Source: APXvYqxQYThO6UYWSN6ni8GtZ0EUYUBt5OLuVJPyDr1BbXzxSzGl7TfAaziEqXf2AR6qh0ZR6LFgJg==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr46383801pgv.76.1560719147860; 
 Sun, 16 Jun 2019 14:05:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id w187sm10448916pfb.4.2019.06.16.14.05.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:05:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 16 Jun 2019 14:05:46 -0700
Message-Id: <20190616210546.17221-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH] tcg: Fix mmap lock assert on translation
 failure
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
Cc: christophe.lyon@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check page flags before letting an invalid pc cause a SIGSEGV.

Prepare for eventially validating PROT_EXEC.  The current wrinkle being
that we have a problem with our implementation of signals.  We should
be using a vdso like the kernel, but we instead put the trampoline on
the stack.  In the meantime, let PROT_READ match PROT_EXEC.

Fixes: https://bugs.launchpad.net/qemu/+bug/1832353
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h                    |  1 +
 include/exec/cpu_ldst_useronly_template.h |  8 +++++--
 accel/tcg/translate-all.c                 | 29 +++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 536ea58f81..58b8915617 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -259,6 +259,7 @@ int walk_memory_regions(void *, walk_memory_regions_fn);
 int page_get_flags(target_ulong address);
 void page_set_flags(target_ulong start, target_ulong end, int flags);
 int page_check_range(target_ulong start, target_ulong len, int flags);
+void validate_exec_access(CPUArchState *env, target_ulong s, target_ulong l);
 #endif
 
 CPUArchState *cpu_copy(CPUArchState *env);
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index bc45e2b8d4..f095415149 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -64,7 +64,9 @@
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#if !defined(CODE_ACCESS)
+#ifdef CODE_ACCESS
+    validate_exec_access(env, ptr, DATA_SIZE);
+#else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, false));
@@ -88,7 +90,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#if !defined(CODE_ACCESS)
+#ifdef CODE_ACCESS
+    validate_exec_access(env, ptr, DATA_SIZE);
+#else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, true, MO_TE, false));
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..1d4a8a260f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2600,10 +2600,39 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
                 }
             }
         }
+        /*
+         * FIXME: We place the signal trampoline on the stack,
+         * even when the guest expects that to be in the vdso.
+         * Until we fix that, allow execute on any readable page.
+         */
+        if ((flags & PAGE_EXEC) && !(p->flags & (PAGE_EXEC | PAGE_READ))) {
+            return -1;
+        }
     }
     return 0;
 }
 
+/*
+ * Called for each code read, longjmp out to issue SIGSEGV if the page(s)
+ * do not have execute access.
+ */
+void validate_exec_access(CPUArchState *env,
+                          target_ulong ptr, target_ulong len)
+{
+    if (page_check_range(ptr, len, PAGE_EXEC) < 0) {
+        CPUState *cs = env_cpu(env);
+        CPUClass *cc = CPU_GET_CLASS(cs);
+
+        /* Like tb_gen_code, release the memory lock before cpu_loop_exit.  */
+        assert_memory_lock();
+        mmap_unlock();
+
+        /* This is user-only.  The target must raise an exception.  */
+        cc->tlb_fill(cs, ptr, 0, MMU_INST_FETCH, MMU_USER_IDX, false, 0);
+        g_assert_not_reached();
+    }
+}
+
 /* called from signal handler: invalidate the code and unprotect the
  * page. Return 0 if the fault was not handled, 1 if it was handled,
  * and 2 if it was handled but the caller must cause the TB to be
-- 
2.17.1


