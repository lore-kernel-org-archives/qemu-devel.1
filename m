Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C214BC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FBA218C3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAJFjcp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FBA218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55563 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxXT-0002JK-Lp
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:40:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVd-00017x-JO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVc-0006wF-DW
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:01 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIxVc-0006vl-78
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id 8so7693713pfr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=JBPAqdXLZd5UzUJFne762QusnErX3AudLwgPi4XfF9M=;
	b=kAJFjcp44B3P8/+43LMuTIeEmVQuTZHJK7wuLs68FCuu+NvK4PoqY0kmWyp+LoBHMG
	TTXQfKXKdMRjUtsGYDqK3TOjk6Ub9Toz7+I4s/8n3yO4rOPY2Gc20baTb3utUHoBdr8v
	SURxe8bARALXPbADOIbzCtJosQuALfhvDIBnj28QTrmbUEETLCjms9rHzOpbaKQi9c2m
	c9X9X5sgzoSHxYe8zcQ5U811SGwsUXjdGuYNKk+VGBn/3o5Tg8/hCyWcGAFCdsbxcduV
	2jrCG23z6DmlqvTi3yvBjObVRUpxzDYndGl5VWhaSRpbGVhvA+ROEsqJVWa+wnFytWJF
	Z72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=JBPAqdXLZd5UzUJFne762QusnErX3AudLwgPi4XfF9M=;
	b=EjdrvQumVeQsatypPGbKs1AKGublHJFaEfJwGB9GjuKAzQKNsvkLyvePj0tmtXezpT
	U84yohCjNSrXfhGX2WugFg2f4/+JOHEbd4XsGjFcrSnoNKoDfymoh2uYdwZT6ojTQHKS
	n7p2oSFemzS90N/D4hKN138WapdlLirUAHAVfawB53i0gb77wfY9UBScNZ1Ss5ZUa4Cr
	htiOjren5J4cMF58nhAJIIrxZ1J5XAggy69YHHkaCmJNhNQiD9kNQkkIpk/i4zi2wk1j
	EQ2fIoSkYNK1No3fZXY3c+4A+PrpBP9xMA646G669Od57BOKf0sLwK9xf/WLJN4khyrP
	J2PA==
X-Gm-Message-State: APjAAAXTuDIM+kXhBJhLGxyeX2or11pf+0nWvuIi5FD+7+7UCfFwUNEv
	Iw2dS3HAyTu/DBbLP/eoQ+yrIinvfNw=
X-Google-Smtp-Source: APXvYqxg8d1tpfsDNiAg2l+L5zksOJrNQWj/+2wBgeonr19u3ZLkXSp452sE5dO4fUKH7EzvESfhcA==
X-Received: by 2002:a63:4a45:: with SMTP id j5mr25738884pgl.426.1556033938784; 
	Tue, 23 Apr 2019 08:38:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c25sm24366591pfo.69.2019.04.23.08.38.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 08:38:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 08:38:48 -0700
Message-Id: <20190423153853.19790-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423153853.19790-1-richard.henderson@linaro.org>
References: <20190423153853.19790-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 2/7] tcg: Restart after TB code generation
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423153848.6ZV7AYw-S7iyF7EaAorN4qgzznSaSs_VTTOk7ePtFyw@z>

If a TB generates too much code, try again with fewer insns.

Fixes: https://bugs.launchpad.net/bugs/1824853
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 38 ++++++++++++++++++++++++++++++++------
 tcg/tcg.c                 |  4 ++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fcdfe6c0ec..65b8370cbe 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1721,6 +1721,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tcg_ctx->tb_cflags = cflags;
+ tb_overflow:
 
 #ifdef CONFIG_PROFILER
     /* includes aborted translations because of exceptions */
@@ -1754,14 +1755,39 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
index 9b2bf7f439..aa0e94521b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3991,6 +3991,10 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
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


