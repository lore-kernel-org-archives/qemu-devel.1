Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA58C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899BC2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOGcuCch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899BC2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIkH-0007lQ-GF
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbw-0004En-5Y
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:44 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbs-0001rG-Ps
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id t22so2131932plr.9
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iw63tVm/gJW8ix0+OZbB8FxuagBCr8ISw8kd0ux54hg=;
 b=cOGcuCchwaUIeQTOR18NTSmT0AtmucDwexJKrvVZ82aIClJjxQjvb6UTnPmi8TcF9M
 DTVyBoi2ByCBF6yErPJv8/n4uvUZjaU0rdR9cC1cIzz9RASlX5KKe5qGxX84XavKTyc9
 gMcPmc/VcqggAZLYzinNzwylUeFmZHVt8MhlRnWm06XxTV2Q6FSxpYT543pCEr8wnNn/
 cB3seysgD3sNhIq2vqqONNCmFirp3zzhf/ERayyFUK+k2Riv8TcJ6IIs08e5sSuJMIAr
 t6vCeeOFOmLtgeaYh2fixmxfrmpLVtC6VWYEIhNHgDBG5PYEvwniqdhsoZw8P7kQD4GH
 BU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iw63tVm/gJW8ix0+OZbB8FxuagBCr8ISw8kd0ux54hg=;
 b=CI3i8K6zxW+/jKbps9rTaV5M672mh4e0PuNUGGFG6Dg1T3CIosd+m74uGZo7sBXO37
 ACVRINtUTf4tEb6TmN1aIKwwXKEgTO0CuxwECAYhz9eQINp6iHO/N+Wk/6b04dpxlZes
 4Ampb1jOitc4ppWPlK6iWGrSFI2fcd/pR2GLlXtLF7CACZ6xANpL/jTk8NlAB5tpwg9w
 XnmcY0KtPSr/kdny6vvvpKhhYnl3pUGmv243UrkCTKUIGjgNZ/8Z4axM3MIx1bTbXBtp
 XGYuKX5GKE97DN9n3iBzIf63PTS3ibdaEQQuyQBzzk/yhpkVGqTQYMLcagU/aIY+GvZW
 V72A==
X-Gm-Message-State: AOAM531gCmGBLcc9ASaLN76qpyY7pmU0SNZRZKS0mRmV7HyNJHd63B75
 VWmdgtGCkkXUcDs8bG06xWdaUzXRbgOMAQ==
X-Google-Smtp-Source: ABdhPJwzJZniYFAeBxsqwv/5d0wyFZHWoMYuah1+Yr9gZTfKHh+AxIlYKLO8IEs6BJScgvC/Ss5Lgw==
X-Received: by 2002:a17:902:934b:b029:d4:e4c7:26f5 with SMTP id
 g11-20020a170902934bb02900d4e4c726f5mr6793966plp.60.1604018978445; 
 Thu, 29 Oct 2020 17:49:38 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/19] tcg: Use Error with alloc_code_gen_buffer
Date: Thu, 29 Oct 2020 17:49:13 -0700
Message-Id: <20201030004921.721096-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
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
index c3e35bdee6..fca632eefa 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -59,6 +59,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
+#include "qapi/error.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
@@ -973,7 +974,7 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
    ? DEFAULT_CODE_GEN_BUFFER_SIZE_1 : MAX_CODE_GEN_BUFFER_SIZE)
 
-static inline size_t size_code_gen_buffer(size_t tb_size)
+static size_t size_code_gen_buffer(size_t tb_size)
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
@@ -1024,7 +1025,7 @@ static inline void *split_cross_256mb(void *buf1, size_t size1)
 static uint8_t static_code_gen_buffer[DEFAULT_CODE_GEN_BUFFER_SIZE]
     __attribute__((aligned(CODE_GEN_ALIGN)));
 
-static inline void *alloc_code_gen_buffer(void)
+static bool alloc_code_gen_buffer(size_t tb_size, Error **errp)
 {
     void *buf = static_code_gen_buffer;
     void *end = static_code_gen_buffer + sizeof(static_code_gen_buffer);
@@ -1037,9 +1038,8 @@ static inline void *alloc_code_gen_buffer(void)
     size = end - buf;
 
     /* Honor a command-line option limiting the size of the buffer.  */
-    if (size > tcg_ctx->code_gen_buffer_size) {
-        size = QEMU_ALIGN_DOWN(tcg_ctx->code_gen_buffer_size,
-                               qemu_real_host_page_size);
+    if (size > tb_size) {
+        size = QEMU_ALIGN_DOWN(tb_size, qemu_real_host_page_size);
     }
     tcg_ctx->code_gen_buffer_size = size;
 
@@ -1051,31 +1051,43 @@ static inline void *alloc_code_gen_buffer(void)
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
@@ -1114,20 +1126,11 @@ static inline void *alloc_code_gen_buffer(void)
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
@@ -1154,11 +1157,16 @@ static void tb_htable_init(void)
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


