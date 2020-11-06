Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97CAC55179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3942820756
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6hAM3hI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3942820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasll-0001w4-3U
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSE-0005di-5S
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:22 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:47055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSB-0007Fk-TD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:21 -0500
Received: by mail-pl1-x643.google.com with SMTP id g11so11785pll.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vrSqwZKXMyaSyRVRtm4Hh+vS+LTe1orOUMFlnbJhADM=;
 b=G6hAM3hIi28RAVNWEStLM2rNDVdFf0W9pSyPNmCzYHmAt1ZLLzUxjjCVHcVoj7jCjz
 Q9/HFnVNEptMNSHjzjl2bwMnDQC+WBcyJt7TksP859x2/ZN8F3cc12Xl4ABeKasquXdF
 qt/tgM75gi0cUvnJXhXj1k70urcWwlQzJsonXEaw75PI9L0vl7zv8wtpv818q3nWZyYs
 /DqeN6JvScQWzTRAuV/xpUUgKfY6Idl+IV6tQQRHDZHtP2APrAV2XgWyotijRtvJnbUI
 It9a9e3/m6x9BdKAzJjvnML2llNw2K8phx2XF43IKTM+mWir6QCAUIObR1oTnyTXBwrZ
 +5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vrSqwZKXMyaSyRVRtm4Hh+vS+LTe1orOUMFlnbJhADM=;
 b=rWNpwCwKP9G6al5Jpb3j2WuVxvjgLKMZyBQlLWc0cuTZLxkfy2ekHp2svh1ywcdNhQ
 BhQ9F+dYCI1Mn2Cxcv3tLtsYieRPl2o12FLFHcqI7tMKDdxhc+7xD+jI2xt1IQsCRG11
 +8W/DqjDBpAHef2JvARqfZIOLrEuBylt9GWVncAZRX3YdAF3v0ZN791wKb/zhQLbZt/w
 uyuz2aAJFKLp2OAWl9A0qWi7HHC92TDTbutAVa9BcxNHi7BLT6KJCt/GPbK6LvFyz83C
 1IkQvwoKPSk+FngWVyFWzaULKhXcDb1Lvi4pFhhmRZFkktU0AWK8gqpdgesvPEXMbOkw
 viWQ==
X-Gm-Message-State: AOAM530vSsmjb1bkIVvxFdj+zSelWX897ANmtce6kg5YpQgwl2LQiYUx
 DFiiZIHnY2FgHhXi1JXA0C7bjTKefF8ARw==
X-Google-Smtp-Source: ABdhPJy18AYH1Dsf2PDRQRLz6TFG5teLIJ1o4AOTnY3JThL2/1hG1pFJaUrmS2VzkEmDTHLgCK2RCQ==
X-Received: by 2002:a17:902:c20a:b029:d6:b2d6:8006 with SMTP id
 10-20020a170902c20ab02900d6b2d68006mr111993pll.31.1604633414342; 
 Thu, 05 Nov 2020 19:30:14 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 35/41] accel/tcg: Add mips support to
 alloc_code_gen_buffer_splitwx_memfd
Date: Thu,  5 Nov 2020 19:29:15 -0800
Message-Id: <20201106032921.600200-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Re-use the 256MiB region handling from alloc_code_gen_buffer_anon,
and replace that with the shared file mapping.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 46 ++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 17df6c94fa..b49aaf1026 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1137,24 +1137,40 @@ static bool alloc_code_gen_buffer_anon(size_t size, int prot,
 
 static bool alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
 {
-    void *buf_rw, *buf_rx;
+    void *buf_rw = NULL, *buf_rx = MAP_FAILED;
     int fd = -1;
 
+#ifdef __mips__
+    /* Find space for the RX mapping, vs the 256MiB regions. */
+    if (!alloc_code_gen_buffer_anon(size, PROT_NONE,
+                                    MAP_PRIVATE | MAP_ANONYMOUS |
+                                    MAP_NORESERVE, errp)) {
+        return false;
+    }
+    /* The size of the mapping may have been adjusted. */
+    size = tcg_ctx->code_gen_buffer_size;
+    buf_rx = tcg_ctx->code_gen_buffer;
+#endif
+
     buf_rw = qemu_memfd_alloc("tcg-jit", size, 0, &fd, errp);
     if (buf_rw == NULL) {
-        return false;
+        goto fail;
     }
 
+#ifdef __mips__
+    void *tmp = mmap(buf_rx, size, PROT_READ | PROT_EXEC,
+                     MAP_SHARED | MAP_FIXED, fd, 0);
+    if (tmp != buf_rx) {
+        goto fail_rx;
+    }
+#else
     buf_rx = mmap(NULL, size, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0);
     if (buf_rx == MAP_FAILED) {
-        error_setg_errno(errp, errno,
-                         "failed to map shared memory for execute");
-        munmap(buf_rw, size);
-        close(fd);
-        return false;
+        goto fail_rx;
     }
-    close(fd);
+#endif
 
+    close(fd);
     tcg_ctx->code_gen_buffer = buf_rw;
     tcg_ctx->code_gen_buffer_size = size;
     tcg_splitwx_diff = buf_rx - buf_rw;
@@ -1163,6 +1179,20 @@ static bool alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
     qemu_madvise(buf_rw, size, QEMU_MADV_HUGEPAGE);
     qemu_madvise(buf_rx, size, QEMU_MADV_HUGEPAGE);
     return true;
+
+ fail_rx:
+    error_setg_errno(errp, errno, "failed to map shared memory for execute");
+ fail:
+    if (buf_rx != MAP_FAILED) {
+        munmap(buf_rx, size);
+    }
+    if (buf_rw) {
+        munmap(buf_rw, size);
+    }
+    if (fd >= 0) {
+        close(fd);
+    }
+    return false;
 }
 #endif /* CONFIG_POSIX */
 
-- 
2.25.1


