Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB9EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCAF20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxqUqH+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCAF20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasc7-0004cm-4z
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRe-0004p2-CS
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:46 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRc-0006wk-Fb
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:46 -0500
Received: by mail-pg1-x542.google.com with SMTP id x13so2880121pgp.7
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8YnkrBigavL+C33hr6dUiCjy8qumFXs3cayqbgFA/m8=;
 b=mxqUqH+BWQ26sJiNfIn68XQ3gHoLP/bmGhk6VoFytLpZGEe3sAyB8u/Zx6J4ZV1ynj
 LjPn8GNr4RB/d7n0H8ry6+D5CqVqemRWhGK3nLWe7nBHPG9pbdsrTZ5Ve++v8TSBMy+4
 BZtCdsz4LpE0IaUKTXSL2gF0pydLDQWoLX+UQD41PEE6mn1Gc3AUkIaLTE2DzhaT+f3S
 LD61+AJLnflvZvMUkFLquPVkOaSFyie65TD5KHHjfjSnWj+U+Xtv69T96G8HbTDp1hSw
 /9nz5C6YsJSSaG+dTe599kXOc+GEtBSLOUKvfPy0+LpF08sED6OqU0Qv0uoFr6IjFjsL
 zPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8YnkrBigavL+C33hr6dUiCjy8qumFXs3cayqbgFA/m8=;
 b=aFUGQ84bcWYJyP/Uqqj5jJ7CkjyrVSz2XXFRDtJs3L8jxT8xTNjM9NpjtDyue0B8Hu
 FlkYGQmfNTISdbKDf7oFxVBhIqsO683VpALfhu9ss0z2I1XMmd0RUD/0R/b6KvrKWGv2
 uigL0gjrDQduJk6vK27qO11UnV9fBjxcjQbBeYkweuMd9N5a9FhgTnWwxPufxrzCD/OY
 THBlY7LkYOVo1qWrqshfj70OR44uaWqfj9CLUDgEdhMh8CZr3SfyiFu7K/FOPWIKhEJG
 aglkOJ60NB2UW3U4+UQ5JW+Sv3w5F3YHGHv/6oHpEVJJonZYrZ+29ZdSDAsGrn9KUsD6
 KeAw==
X-Gm-Message-State: AOAM5319DyFYkDmBs7namTGgEzkbXiEsjy+KrtzTH8/eoIEcpXMLinDX
 9dyysiIu4ZdvtisGTkwoNNM2rAAcBYVjZw==
X-Google-Smtp-Source: ABdhPJxDbA4eEhreLH+Mv0CLiM6PMMCAgVtMdkHmAahjMK7Dz/3/BkQ3niqZY96afg+zajPPyypwyw==
X-Received: by 2002:a63:4825:: with SMTP id v37mr5222841pga.256.1604633379990; 
 Thu, 05 Nov 2020 19:29:39 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/41] tcg: Use Error with alloc_code_gen_buffer
Date: Thu,  5 Nov 2020 19:28:53 -0800
Message-Id: <20201106032921.600200-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Report better error messages than just "could not allocate".
Let alloc_code_gen_buffer set ctx->code_gen_buffer_size
and ctx->code_gen_buffer, and simply return bool.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 60 ++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7b85ddacd2..2824b3e387 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -59,6 +59,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
+#include "qapi/error.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
@@ -963,7 +964,7 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
    ? DEFAULT_CODE_GEN_BUFFER_SIZE_1 : MAX_CODE_GEN_BUFFER_SIZE)
 
-static inline size_t size_code_gen_buffer(size_t tb_size)
+static size_t size_code_gen_buffer(size_t tb_size)
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
@@ -1014,7 +1015,7 @@ static inline void *split_cross_256mb(void *buf1, size_t size1)
 static uint8_t static_code_gen_buffer[DEFAULT_CODE_GEN_BUFFER_SIZE]
     __attribute__((aligned(CODE_GEN_ALIGN)));
 
-static inline void *alloc_code_gen_buffer(void)
+static bool alloc_code_gen_buffer(size_t tb_size, Error **errp)
 {
     void *buf = static_code_gen_buffer;
     void *end = static_code_gen_buffer + sizeof(static_code_gen_buffer);
@@ -1027,9 +1028,8 @@ static inline void *alloc_code_gen_buffer(void)
     size = end - buf;
 
     /* Honor a command-line option limiting the size of the buffer.  */
-    if (size > tcg_ctx->code_gen_buffer_size) {
-        size = QEMU_ALIGN_DOWN(tcg_ctx->code_gen_buffer_size,
-                               qemu_real_host_page_size);
+    if (size > tb_size) {
+        size = QEMU_ALIGN_DOWN(tb_size, qemu_real_host_page_size);
     }
     tcg_ctx->code_gen_buffer_size = size;
 
@@ -1041,31 +1041,43 @@ static inline void *alloc_code_gen_buffer(void)
 #endif
 
     if (qemu_mprotect_rwx(buf, size)) {
-        abort();
+        error_setg_errno(errp, errno, "mprotect of jit buffer");
+        return false;
     }
     qemu_madvise(buf, size, QEMU_MADV_HUGEPAGE);
 
-    return buf;
+    tcg_ctx->code_gen_buffer = buf;
+    return true;
 }
 #elif defined(_WIN32)
-static inline void *alloc_code_gen_buffer(void)
+static bool alloc_code_gen_buffer(size_t size, Error **errp)
 {
-    size_t size = tcg_ctx->code_gen_buffer_size;
-    return VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT,
-                        PAGE_EXECUTE_READWRITE);
+    void *buf = VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT,
+                             PAGE_EXECUTE_READWRITE);
+    if (buf == NULL) {
+        error_setg_win32(errp, GetLastError(),
+                         "allocate %zu bytes for jit buffer", size);
+        return false;
+    }
+
+    tcg_ctx->code_gen_buffer = buf;
+    tcg_ctx->code_gen_buffer_size = size;
+    return true;
 }
 #else
-static inline void *alloc_code_gen_buffer(void)
+static bool alloc_code_gen_buffer(size_t size, Error **errp)
 {
     int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
-    size_t size = tcg_ctx->code_gen_buffer_size;
     void *buf;
 
     buf = mmap(NULL, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
-        return NULL;
+        error_setg_errno(errp, errno,
+                         "allocate %zu bytes for jit buffer", size);
+        return false;
     }
+    tcg_ctx->code_gen_buffer_size = size;
 
 #ifdef __mips__
     if (cross_256mb(buf, size)) {
@@ -1104,20 +1116,11 @@ static inline void *alloc_code_gen_buffer(void)
     /* Request large pages for the buffer.  */
     qemu_madvise(buf, size, QEMU_MADV_HUGEPAGE);
 
-    return buf;
+    tcg_ctx->code_gen_buffer = buf;
+    return true;
 }
 #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
 
-static inline void code_gen_alloc(size_t tb_size)
-{
-    tcg_ctx->code_gen_buffer_size = size_code_gen_buffer(tb_size);
-    tcg_ctx->code_gen_buffer = alloc_code_gen_buffer();
-    if (tcg_ctx->code_gen_buffer == NULL) {
-        fprintf(stderr, "Could not allocate dynamic translator buffer\n");
-        exit(1);
-    }
-}
-
 static bool tb_cmp(const void *ap, const void *bp)
 {
     const TranslationBlock *a = ap;
@@ -1144,11 +1147,16 @@ static void tb_htable_init(void)
    size. */
 void tcg_exec_init(unsigned long tb_size)
 {
+    bool ok;
+
     tcg_allowed = true;
     cpu_gen_init();
     page_init();
     tb_htable_init();
-    code_gen_alloc(tb_size);
+
+    ok = alloc_code_gen_buffer(size_code_gen_buffer(tb_size), &error_fatal);
+    assert(ok);
+
 #if defined(CONFIG_SOFTMMU)
     /* There's no guest base to take into account, so go ahead and
        initialize the prologue now.  */
-- 
2.25.1


