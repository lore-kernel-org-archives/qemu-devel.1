Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC5AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D6F20731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEzjT9Mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D6F20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYJ4O-0006pe-RZ
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIc0-0004Lk-Ff
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:48 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbu-0001rV-Ha
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:48 -0400
Received: by mail-pg1-x543.google.com with SMTP id f38so3768782pgm.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T96qfuK9LFACPCMFZJEu5AkD3dQj8mh/jlsxNmhHWgc=;
 b=aEzjT9MbPPJEh1dWF/Lcp/5LIMr+SHddMruzd6YFuUrSCOtTaE92IIgAqSMFepEvDg
 vZ4JSwcHLP+XBRiTQmNhOWPvWAXTxtDKbYJIHzt5nZqBLTjbxf/mYOnABBu4onHjSXUl
 nkAsALOBuisaP88jr3dGcqOOeBodzvdNqbsrcK0NCG8tqFVsSI32egzRtgcZ6b3FGDiw
 3C8Nqa2mJwF7s/eVo7szITQ1d985p6V+9EvV1uoijarMU87XlZCtfH+EnRCpavduXtsb
 B/QJBugUVyMJm7m+OLzty9ISlq8XuyngsH8+w2hccpihnNNBUvh7vjC44R/H4k//6etf
 GZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T96qfuK9LFACPCMFZJEu5AkD3dQj8mh/jlsxNmhHWgc=;
 b=a8fd5aS1DBJlsncGhwkGH5NcShFZiHSU4kyay3l9N9KVst6ViKcMdCycsA0Kn4ejdV
 P/2F+jk8IjzSd4NQ8smA764+Lxxt1UiOdcrQzUWGw6GXpuN92mdQYPkuezSEpN2wc3et
 0R9KBnq+VeHN2PEXjtKrg1XSB5nNiBBkJQA9gDmwRi0cCoczsePd5TxGvYXThj/FTGzO
 0qiGBmdP41zrQM0jX5c2Lu82fgOrROs0JGwM9HedF5pczNMWzXD3onqf2klIHZd5KePC
 FXaOdTBhGNzgeo2XgCz+IFkrFre5fPZGjc2nql80pC5Tebxwt4xJY/Tmjhd7cBF/mgdg
 5HEg==
X-Gm-Message-State: AOAM533Z1r5YXb4pRc0saYfHcpO1yZq3n75X0Zp85QCKv6bncs/ERjd+
 7FNU2+agGVmGSQWhKlj6JLDqNQkyvUHmBA==
X-Google-Smtp-Source: ABdhPJwUjfesT51VF5wK71IbTvsUs4sRCwWHUapt8R+qEUabJmP0iItLA/vE8NClwS6C10ebd1w18Q==
X-Received: by 2002:a63:f84c:: with SMTP id v12mr6265769pgj.125.1604018980939; 
 Thu, 29 Oct 2020 17:49:40 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/19] accel/tcg: Support split-rwx for linux with memfd
Date: Thu, 29 Oct 2020 17:49:15 -0700
Message-Id: <20201030004921.721096-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

We cannot use a real temp file, because we would need to find
a filesystem that does not have noexec enabled.  However, a
memfd is not associated with any filesystem.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 87 +++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8918a09f10..3e69ebd1d3 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1088,17 +1088,11 @@ static bool alloc_code_gen_buffer(size_t size, int mirror, Error **errp)
     return true;
 }
 #else
-static bool alloc_code_gen_buffer(size_t size, int mirror, Error **errp)
+static bool alloc_code_gen_buffer_anon(size_t size, int prot, Error **errp)
 {
-    int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
     void *buf;
 
-    if (mirror > 0) {
-        error_setg(errp, "jit split-rwx not supported");
-        return false;
-    }
-
     buf = mmap(NULL, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
         error_setg_errno(errp, errno,
@@ -1147,6 +1141,85 @@ static bool alloc_code_gen_buffer(size_t size, int mirror, Error **errp)
     tcg_ctx->code_gen_buffer = buf;
     return true;
 }
+
+#ifdef CONFIG_LINUX
+#include "qemu/memfd.h"
+
+static bool alloc_code_gen_buffer_mirror_memfd(size_t size, Error **errp)
+{
+    void *buf_rw, *buf_rx;
+    int fd;
+
+    fd = qemu_memfd_create("tcg-jit", size, false, 0, 0, errp);
+    if (fd < 0) {
+        return false;
+    }
+
+    buf_rw = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+    if (buf_rw == MAP_FAILED) {
+        error_setg_errno(errp, errno,
+                         "allocate %zu bytes for jit buffer", size);
+        close(fd);
+        return false;
+    }
+
+    buf_rx = mmap(NULL, size, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0);
+    if (buf_rx == MAP_FAILED) {
+        error_setg_errno(errp, errno,
+                         "allocate %zu bytes for jit mirror", size);
+        munmap(buf_rw, size);
+        close(fd);
+        return false;
+    }
+    close(fd);
+
+    tcg_ctx->code_gen_buffer = buf_rw;
+    tcg_ctx->code_gen_buffer_size = size;
+    tcg_rx_mirror_diff = buf_rx - buf_rw;
+
+    /* Request large pages for the buffer and the mirror.  */
+    qemu_madvise(buf_rw, size, QEMU_MADV_HUGEPAGE);
+    qemu_madvise(buf_rx, size, QEMU_MADV_HUGEPAGE);
+    return true;
+}
+#endif
+
+static bool alloc_code_gen_buffer_mirror(size_t size, Error **errp)
+{
+    if (TCG_TARGET_SUPPORT_MIRROR) {
+#ifdef CONFIG_LINUX
+        return alloc_code_gen_buffer_mirror_memfd(size, errp);
+#endif
+    }
+    error_setg(errp, "jit split-rwx not supported");
+    return false;
+}
+
+static bool alloc_code_gen_buffer(size_t size, int mirror, Error **errp)
+{
+    if (mirror) {
+        Error *local_err = NULL;
+        if (alloc_code_gen_buffer_mirror(size, &local_err)) {
+            return true;
+        }
+        /*
+         * If mirror force-on (1), fail;
+         * if mirror default-on (-1), fall through to mirror off.
+         */
+        if (mirror > 0) {
+            error_propagate(errp, local_err);
+            return false;
+        }
+    }
+
+    int prot = PROT_READ | PROT_WRITE | PROT_EXEC;
+#ifdef CONFIG_TCG_INTERPRETER
+    /* The tcg interpreter does not need execute permission. */
+    prot = PROT_READ | PROT_WRITE;
+#endif
+
+    return alloc_code_gen_buffer_anon(size, prot, errp);
+}
 #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
 
 static bool tb_cmp(const void *ap, const void *bp)
-- 
2.25.1


