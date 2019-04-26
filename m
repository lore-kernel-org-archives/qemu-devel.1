Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFFEC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6189220652
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MonM3534"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6189220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50017 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4i1-0006yl-MA
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:32:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aT-0008WU-90
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aR-0006fl-W4
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aR-0006eX-QF
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:35 -0400
Received: by mail-pg1-x544.google.com with SMTP id 85so1943132pgc.3
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3CywljlasHfL8Ycnk57vM6Ac8IPl3XHI/QQlXit0YoU=;
	b=MonM3534UrqIVvSEtZvvDchMqiEFFiNcO8Y5L+Zei3KnAjWH8Pazvml/voPma/mHjk
	T65hokEglAPGIhkt6aluCVNkuo6ZZEeiThLz3futfmKVKirRl1K2TIVg/RdaYX6cIS2N
	D+FXYrqKHhWNBrQ67x/wpg8ZrwwUMqa/KL16biHFcgqy2WJAPyBVGT6xXYQp41q+JHVY
	xpEXBCzSJt3dw3uGO+u2SdbuIYqpmU07+yBUOaIgucXcAjt45yWBGUKDbV1m+IgBwjNk
	RxMQ0dtFb7kU1B8j1sgziqu8DohqzIZr1YKBQwPTvLKuxoi/85v9ew1WlY/7NxgOosSM
	vJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3CywljlasHfL8Ycnk57vM6Ac8IPl3XHI/QQlXit0YoU=;
	b=uVxwq4raJ8VQtPov2mrkBFo6t/JoLRrOGOrusdIvQ5BYkkJ6u/rLQxZMHF4jR21TWu
	s32yW5078ch+SoVh2IiLdGWZ+qCHz5R5J4k0Ph1v1lkMpDhmuWLtl1enSU16WyypMAgm
	8dNDi0Wbs+pxkNusLDmMH21UJaOUQ9UIKbgXKVU1tl4NcxoPuofN5+HZYkHOG1wFGTpD
	1X1bZt9EraVdG578V45rgELLYgWX56g0CDWOb5NWDXN8zOPumNdH7+dq3qfn3n3s96pH
	hq+2k8VSzO7SNB5Ly86EvLo/lhmWtL1V4H8Bb/SOo8LKLNiuBeoei3NatZVJBykyJfiy
	8qGg==
X-Gm-Message-State: APjAAAXr7K3JioqAes4ier/rWikL3k9J0Ye7wN0BVL8NEn0NbEyPNVdp
	mDketjA01jLj4LF2b2BwMn3FgYe4Pcs=
X-Google-Smtp-Source: APXvYqyHe79xbPrb5NpT4buAHB09RHsBQ2IDeZ0/4aSeixOZSYJbTIDuO7xLUmZbqc+e+U2dY5dybw==
X-Received: by 2002:a63:cc48:: with SMTP id q8mr15704362pgi.202.1556299474477; 
	Fri, 26 Apr 2019 10:24:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:15 -0700
Message-Id: <20190426172421.27133-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PULL 09/15] tcg: Restart after TB code generation
 overflow
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426172415.LSTd11-Pv_Ys71Yj35hYgtYeUkyb7T6mNhCwBfaWMvQ@z>

If a TB generates too much code, try again with fewer insns.

Fixes: https://bugs.launchpad.net/bugs/1824853
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 38 ++++++++++++++++++++++++++++++++------
 tcg/tcg.c                 |  4 ++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 39532fd44c..20b59f93f4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1722,6 +1722,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tcg_ctx->tb_cflags = cflags;
+ tb_overflow:
 
 #ifdef CONFIG_PROFILER
     /* includes aborted translations because of exceptions */
@@ -1755,14 +1756,39 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     ti = profile_getclock();
 #endif
 
-    /* ??? Overflow could be handled better here.  In particular, we
-       don't need to re-do gen_intermediate_code, nor should we re-do
-       the tcg optimization currently hidden inside tcg_gen_code.  All
-       that should be required is to flush the TBs, allocate a new TB,
-       re-initialize it per above, and re-do the actual code generation.  */
     gen_code_size = tcg_gen_code(tcg_ctx, tb);
     if (unlikely(gen_code_size < 0)) {
-        goto buffer_overflow;
+        switch (gen_code_size) {
+        case -1:
+            /*
+             * Overflow of code_gen_buffer, or the current slice of it.
+             *
+             * TODO: We don't need to re-do gen_intermediate_code, nor
+             * should we re-do the tcg optimization currently hidden
+             * inside tcg_gen_code.  All that should be required is to
+             * flush the TBs, allocate a new TB, re-initialize it per
+             * above, and re-do the actual code generation.
+             */
+            goto buffer_overflow;
+
+        case -2:
+            /*
+             * The code generated for the TranslationBlock is too large.
+             * The maximum size allowed by the unwind info is 64k.
+             * There may be stricter constraints from relocations
+             * in the tcg backend.
+             *
+             * Try again with half as many insns as we attempted this time.
+             * If a single insn overflows, there's a bug somewhere...
+             */
+            max_insns = tb->icount;
+            assert(max_insns > 1);
+            max_insns /= 2;
+            goto tb_overflow;
+
+        default:
+            g_assert_not_reached();
+        }
     }
     search_size = encode_search(tb, (void *)gen_code_buf + gen_code_size);
     if (unlikely(search_size < 0)) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c0730f119f..5d255166c0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3996,6 +3996,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         if (unlikely((void *)s->code_ptr > s->code_gen_highwater)) {
             return -1;
         }
+        /* Test for TB overflow, as seen by gen_insn_end_off.  */
+        if (unlikely(tcg_current_code_size(s) > UINT16_MAX)) {
+            return -2;
+        }
     }
     tcg_debug_assert(num_insns >= 0);
     s->gen_insn_end_off[num_insns] = tcg_current_code_size(s);
-- 
2.17.1


