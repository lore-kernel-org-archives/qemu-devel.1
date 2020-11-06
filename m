Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60BBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3E12072E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7gUHdwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3E12072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasdu-000700-6r
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRg-0004tb-27
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:48 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRd-0006xO-Lu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:47 -0500
Received: by mail-pf1-x442.google.com with SMTP id y7so28322pfq.11
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lq4IkwTkjjjV6cEfjyzqrZr7JH5rLAW05aEI0Sl+9Jw=;
 b=L7gUHdwguNP4jAPxpnFrHEN0Zm+hJa/7DI9lwXNVrV/UmOQEC6wB/jqvRCwuELzI8/
 rRARviqfWrnGWfUwAbBwHQDmNpUYk/j0mWI8rNByReuPcoqFkA8ci4GLWA9e4Zwu1U5z
 N1mEVstlRexLy3mhvFVjB3h88w83IB0YnCOlDD0qTtMPDk5xarHdVmbpOqGPke7sjeQg
 L1hUfU104zpzpTcV1FYrtaJDaprf9EYglOVaKubllZL5MFyrV4XBuSMfhwNk4K/KWVVU
 cVNtdvb+3UXXspiPO1gdMw/y1NCvbl1M5VTw85Vl2sxsQZYAL1vbHq2xbRLVeT+dnaIm
 Tt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lq4IkwTkjjjV6cEfjyzqrZr7JH5rLAW05aEI0Sl+9Jw=;
 b=pt2IjQdEci1BrLPW4r4alENKxW5Kk4Ja5TEVLys0jWl8awLvskL7A9EVUugc7lR1ou
 l6smo0It/5HaKXrMjv08bx/wA9BWlYAaD1luTW6KARyZ0V7dcxGSlzjPfWM9fag2FWil
 sRCFH3cahelxnc7izENLtLbiDKt7LYEKzHI+mHwQYLGdqO65yT2W2sfpWXRtwngriG/9
 QijGgD1HZzRkSpFWLe1IOjM4rmDHLfoQ9LhHhH9BAKiSwuq73VC6ETtD8sDmbLAMeb2t
 v4Hwc7mLuFoJDtQ1ghfHc6fNQ9433Nm73k4PCuZJPCTjvaGxTW29MMHSslNkaLPZYner
 RtHQ==
X-Gm-Message-State: AOAM532lHft/XKnHX/8+S6NXoW7tR8Pu21hqrbVsman/o08BUTsE3MgY
 REye0FSZ0p3MjMPR3/KEtXFhHVezLEuUvQ==
X-Google-Smtp-Source: ABdhPJz00PzHzCtmUoiVhdR1vXp3DQwHjq94TIr0/r+y5W5hTDSziRxyOTECinXCM7jX0odc3q2Mkw==
X-Received: by 2002:aa7:96ce:0:b029:155:8c02:e74a with SMTP id
 h14-20020aa796ce0000b02901558c02e74amr722pfq.32.1604633384041; 
 Thu, 05 Nov 2020 19:29:44 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/41] accel/tcg: Support split-wx for darwin/iOS with
 vm_remap
Date: Thu,  5 Nov 2020 19:28:56 -0800
Message-Id: <20201106032921.600200-17-richard.henderson@linaro.org>
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

Cribbed from code posted by Joelle van Dyne <j@getutm.app>,
and rearranged to a cleaner structure.  Completely untested.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 1931e65365..17df6c94fa 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1166,9 +1166,71 @@ static bool alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
 }
 #endif /* CONFIG_POSIX */
 
+#ifdef CONFIG_DARWIN
+#include <mach/mach.h>
+
+extern kern_return_t mach_vm_remap(vm_map_t target_task,
+                                   mach_vm_address_t *target_address,
+                                   mach_vm_size_t size,
+                                   mach_vm_offset_t mask,
+                                   int flags,
+                                   vm_map_t src_task,
+                                   mach_vm_address_t src_address,
+                                   boolean_t copy,
+                                   vm_prot_t *cur_protection,
+                                   vm_prot_t *max_protection,
+                                   vm_inherit_t inheritance);
+
+static bool alloc_code_gen_buffer_splitwx_vmremap(size_t size, Error **errp)
+{
+    kern_return_t ret;
+    mach_vm_address_t buf_rw, buf_rx;
+    vm_prot_t cur_prot, max_prot;
+
+    /* Map the read-write portion via normal anon memory. */
+    if (!alloc_code_gen_buffer_anon(size, PROT_READ | PROT_WRITE,
+                                    MAP_PRIVATE | MAP_ANONYMOUS, errp)) {
+        return false;
+    }
+
+    buf_rw = (mach_vm_address_t)tcg_ctx->code_gen_buffer;
+    buf_rx = 0;
+    ret = mach_vm_remap(mach_task_self(),
+                        &buf_rx,
+                        size,
+                        0,
+                        VM_FLAGS_ANYWHERE,
+                        mach_task_self(),
+                        buf_rw,
+                        false,
+                        &cur_prot,
+                        &max_prot,
+                        VM_INHERIT_NONE);
+    if (ret != KERN_SUCCESS) {
+        /* TODO: Convert "ret" to a human readable error message. */
+        error_setg(errp, "vm_remap for jit splitwx failed");
+        munmap((void *)buf_rw, size);
+        return false;
+    }
+
+    if (mprotect((void *)buf_rx, size, PROT_READ | PROT_EXEC) != 0) {
+        error_setg_errno(errp, errno, "mprotect for jit splitwx");
+        munmap((void *)buf_rx, size);
+        munmap((void *)buf_rw, size);
+        return false;
+    }
+
+    tcg_splitwx_diff = buf_rx - buf_rw;
+    return true;
+}
+#endif /* CONFIG_DARWIN */
+
 static bool alloc_code_gen_buffer_splitwx(size_t size, Error **errp)
 {
     if (TCG_TARGET_SUPPORT_MIRROR) {
+#ifdef CONFIG_DARWIN
+        return alloc_code_gen_buffer_splitwx_vmremap(size, errp);
+#endif
 #ifdef CONFIG_POSIX
         return alloc_code_gen_buffer_splitwx_memfd(size, errp);
 #endif
@@ -1201,6 +1263,9 @@ static bool alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
 #ifdef CONFIG_TCG_INTERPRETER
     /* The tcg interpreter does not need execute permission. */
     prot = PROT_READ | PROT_WRITE;
+#elif defined(CONFIG_DARWIN)
+    /* Applicable to both iOS and macOS (Apple Silicon). */
+    flags |= MAP_JIT;
 #endif
 
     return alloc_code_gen_buffer_anon(size, prot, flags, errp);
-- 
2.25.1


