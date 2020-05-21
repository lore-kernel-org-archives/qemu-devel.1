Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF67FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9D020759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+GT93lC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9D020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbopy-00087W-S5
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJG-0004Vu-9A
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:42 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJF-0006ke-98
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:41 -0400
Received: by mail-qk1-x741.google.com with SMTP id 190so7918081qki.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f6jTs4l1FUMMcryMnS/4lJD5Ni20LOW4nBzyszoy3L4=;
 b=U+GT93lCYq8RuQBsNpW0FvQNeYBg/ZDm0UBcKUlTv6NGzMx5QowNjosWOW4Hh6fFBR
 o5qDdlykIEaKgxcHDCZrh0HJ16sSegni6A1tRjV5ajlB8OSq/P9VYMlC97qb/fqIg3of
 S0nXOoxsvgybjD9x4aHyL8bpD+6ECZ+AiciwPI+wF3l4jMmaNOVjkZIKKXOMOCvo7pMC
 wD/EOQIucPF0VtHzaL9kiB1ZcSUCpn5DVo/M0XlXjCjoUXRSOay/HD30DSnsGFQmSGkv
 UsihxjAu/dVejODKWx423p61s7tP4sKGJCz6oVCbzwZ3QkmTiXLwaMlKsr/dPAdTR3lu
 uBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f6jTs4l1FUMMcryMnS/4lJD5Ni20LOW4nBzyszoy3L4=;
 b=WBvvlwrGDB1Gx8EyMZzJkjDUmReYOXutqoCGeTSsUhU+HeOqsiPh5/rapK/2dnY+Si
 YQebIMUPPhF+7cqAUj3S8A5xmQ7oLWQUKnHqZoCZHHNp2rGtsiLZOMmgMSLBfndV9IAG
 /F+Z7kJPnuLgy1MWxPD00nx4O3KYYrWaVijlW8POLuYyy57tTBXPDHqkqjqnVWH9mFxn
 VXp/Etoerx9pRbgZ0g3dRKWtp7MvvwPegym5QpTg6J4SnFNPQG2aLkDgd7SmEdil37r/
 C7Y+WwLQprlW5wFlMS6hyncVC1cKLeYMYZuGmTTomvuQmk8VUJGA+tENA2aWS2sHxnM6
 puOA==
X-Gm-Message-State: AOAM533NlcToEzmcSqsNOJ8dnl3GbfsBQOTbkUa3CzsMmiGKgQREb5fb
 +Npf5Ss+qhi8NOOKorv4oPR2EOs5d4J/NQ==
X-Google-Smtp-Source: ABdhPJzs90Pwp95Q4YWsVV7Q0rqm4Bp7Xbmm0LmluS7V13wMY2eWTxpv/A7YYTYSJEJaQQV1CfDbRg==
X-Received: by 2002:a05:620a:a83:: with SMTP id
 v3mr10997896qkg.84.1590079478970; 
 Thu, 21 May 2020 09:44:38 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:38 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 63/74] cpu: introduce cpu_has_work_with_iothread_lock
Date: Thu, 21 May 2020 12:40:00 -0400
Message-Id: <20200521164011.638-64-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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

It will gain some users soon.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/hw/core/cpu.h | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7bf7700630..9766477e62 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
+#include "qemu/main-loop.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
@@ -82,6 +83,8 @@ struct TranslationBlock;
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do. Called with the
  * CPU lock held.
+ * @has_work_with_iothread_lock: Callback for checking if there is work to do.
+ * Called with both the BQL and the CPU lock held.
  * @do_interrupt: Callback for interrupt handling.
  * @do_unaligned_access: Callback for unaligned access handling, if
  * the target defines #TARGET_ALIGNED_ONLY.
@@ -167,6 +170,7 @@ typedef struct CPUClass {
 
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
+    bool (*has_work_with_iothread_lock)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
                                 MMUAccessType access_type,
@@ -800,14 +804,41 @@ const char *parse_cpu_option(const char *cpu_option);
 static inline bool cpu_has_work(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool has_cpu_lock = cpu_mutex_locked(cpu);
+    bool (*func)(CPUState *cpu);
     bool ret;
 
+    /* some targets require us to hold the BQL when checking for work */
+    if (cc->has_work_with_iothread_lock) {
+        if (qemu_mutex_iothread_locked()) {
+            func = cc->has_work_with_iothread_lock;
+            goto call_func;
+        }
+
+        if (has_cpu_lock) {
+            /* avoid deadlock by acquiring the locks in order */
+            cpu_mutex_unlock(cpu);
+        }
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cpu);
+
+        ret = cc->has_work_with_iothread_lock(cpu);
+
+        qemu_mutex_unlock_iothread();
+        if (!has_cpu_lock) {
+            cpu_mutex_unlock(cpu);
+        }
+        return ret;
+    }
+
     g_assert(cc->has_work);
-    if (cpu_mutex_locked(cpu)) {
-        return cc->has_work(cpu);
+    func = cc->has_work;
+ call_func:
+    if (has_cpu_lock) {
+        return func(cpu);
     }
     cpu_mutex_lock(cpu);
-    ret = cc->has_work(cpu);
+    ret = func(cpu);
     cpu_mutex_unlock(cpu);
     return ret;
 }
-- 
2.17.1


