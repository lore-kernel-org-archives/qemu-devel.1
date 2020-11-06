Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E635FC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9EF20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSmWNu5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9EF20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasXs-0004fc-TD
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRf-0004sv-R1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:47 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRc-0006x4-Jo
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:47 -0500
Received: by mail-pf1-x442.google.com with SMTP id z3so45447pfz.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QxiqvQ209wXHxoJuZyW/ayX9Rmszqy3dKezpaxev5Pc=;
 b=TSmWNu5fGLyzHJJu9w08BvM4mojzlhQfiimiZuHvYITzrSh/8++k6IrCnS9ilUMPzR
 99N8C1HP2APDXp/TmDXA1ecVQIK/SeVOoaYEm6wY6FjjY4IJ9DSCDzYlO/D8XHgM8QyH
 EfJWGOKMhfp/sSr0cmI9RGC6hojUWEOqhW3T8alRR4FVNdC9oVCMEhFhJj3DgX2cqs+O
 GSfSW06TExb7BOrTlO3bdVJ0WaRhSqvxJ8NvaAP17XfD3DcSRux+XgGIuIXq7HNxPqsz
 cR9+XNILqRNbt2IaTOR+SsWIGAJsGOH1QyxeNJCh5xE+OJfKRvqLGU35d6AZw+JwjLkv
 Jp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QxiqvQ209wXHxoJuZyW/ayX9Rmszqy3dKezpaxev5Pc=;
 b=QeRmcBi3Y5BPgZACPv5yGb+w4DmVHbTOmPYgR72dqxy1vTJO7Uo2Hr2S6oWJh2csTy
 gEOqvKYJgX//rC1rbP80HQZGVkxj8prI29syju9rRJghV2vJjloHGJJBHUK0SDFOw8ow
 r0XZZrV5KMiCDagRmoRKfc/esVLBLrDiLIDaEKD2lfC1cgP3tun6OPFEZBpFJfSkqUiI
 sd9gXan2O5P38mAx0kMkBmHZrPuD6gs60Y5APhHzxxZOUlbl3Z+fPshNFgQ9KvNIchyC
 6eumxB6AqvC4POMGwEIrJ6Gatdr1zIUw8L0jRJe13quUk6HWulhcgk6jNMrdIYcjBN0Q
 le4g==
X-Gm-Message-State: AOAM530hnICOiYwksflDm6DVWir7TYAXAsCXw/d0AduT6K7pzeUECnHv
 DILuiNRAsHNmwdt00gfRYcfj8OZP0llgJA==
X-Google-Smtp-Source: ABdhPJwC8nKRQBeSgXlFT1QLMFd4F4bnVLsuvrmNB2FMvsoZBEedc+GLhSsEPANltyKCupua3WNESQ==
X-Received: by 2002:a63:134d:: with SMTP id 13mr5293337pgt.370.1604633382549; 
 Thu, 05 Nov 2020 19:29:42 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/41] accel/tcg: Support split-wx for linux with memfd
Date: Thu,  5 Nov 2020 19:28:55 -0800
Message-Id: <20201106032921.600200-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

We cannot use a real temp file, because we would need to find
a filesystem that does not have noexec enabled.  However, a
memfd is not associated with any filesystem.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 84 +++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a29cb4a42e..1931e65365 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1078,17 +1078,11 @@ static bool alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
     return true;
 }
 #else
-static bool alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
+static bool alloc_code_gen_buffer_anon(size_t size, int prot,
+                                       int flags, Error **errp)
 {
-    int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
-    int flags = MAP_PRIVATE | MAP_ANONYMOUS;
     void *buf;
 
-    if (splitwx > 0) {
-        error_setg(errp, "jit split-wx not supported");
-        return false;
-    }
-
     buf = mmap(NULL, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
         error_setg_errno(errp, errno,
@@ -1137,6 +1131,80 @@ static bool alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
     tcg_ctx->code_gen_buffer = buf;
     return true;
 }
+
+#ifdef CONFIG_POSIX
+#include "qemu/memfd.h"
+
+static bool alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
+{
+    void *buf_rw, *buf_rx;
+    int fd = -1;
+
+    buf_rw = qemu_memfd_alloc("tcg-jit", size, 0, &fd, errp);
+    if (buf_rw == NULL) {
+        return false;
+    }
+
+    buf_rx = mmap(NULL, size, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0);
+    if (buf_rx == MAP_FAILED) {
+        error_setg_errno(errp, errno,
+                         "failed to map shared memory for execute");
+        munmap(buf_rw, size);
+        close(fd);
+        return false;
+    }
+    close(fd);
+
+    tcg_ctx->code_gen_buffer = buf_rw;
+    tcg_ctx->code_gen_buffer_size = size;
+    tcg_splitwx_diff = buf_rx - buf_rw;
+
+    /* Request large pages for the buffer and the splitwx.  */
+    qemu_madvise(buf_rw, size, QEMU_MADV_HUGEPAGE);
+    qemu_madvise(buf_rx, size, QEMU_MADV_HUGEPAGE);
+    return true;
+}
+#endif /* CONFIG_POSIX */
+
+static bool alloc_code_gen_buffer_splitwx(size_t size, Error **errp)
+{
+    if (TCG_TARGET_SUPPORT_MIRROR) {
+#ifdef CONFIG_POSIX
+        return alloc_code_gen_buffer_splitwx_memfd(size, errp);
+#endif
+    }
+    error_setg(errp, "jit split-wx not supported");
+    return false;
+}
+
+static bool alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
+{
+    ERRP_GUARD();
+    int prot, flags;
+
+    if (splitwx) {
+        if (alloc_code_gen_buffer_splitwx(size, errp)) {
+            return true;
+        }
+        /*
+         * If splitwx force-on (1), fail;
+         * if splitwx default-on (-1), fall through to splitwx off.
+         */
+        if (splitwx > 0) {
+            return false;
+        }
+        error_free_or_abort(errp);
+    }
+
+    prot = PROT_READ | PROT_WRITE | PROT_EXEC;
+    flags = MAP_PRIVATE | MAP_ANONYMOUS;
+#ifdef CONFIG_TCG_INTERPRETER
+    /* The tcg interpreter does not need execute permission. */
+    prot = PROT_READ | PROT_WRITE;
+#endif
+
+    return alloc_code_gen_buffer_anon(size, prot, flags, errp);
+}
 #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
 
 static bool tb_cmp(const void *ap, const void *bp)
-- 
2.25.1


