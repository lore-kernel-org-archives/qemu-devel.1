Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F156C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B00B20868
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EL8noG8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B00B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJX0-0003UO-K5
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:33:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJVX-0002sd-UY
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJVW-0006Oi-Lw
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:31:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGJVW-0006Mj-Aw
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:31:58 -0400
Received: by mail-pl1-x642.google.com with SMTP id y6so9945366pll.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OJTx2YMgBnLmxy9QSpmGl7JN/UE/jilvByUL/wxnNyQ=;
	b=EL8noG8gY3fvfVDXmkq8dC66MlvMNxPuTV0wvly49mejLzjDCMix8naBQUX59kQ1Iq
	5vKm20rwEa6mCaVyGxfDDDjujgIBUMutTvcYlC05RCzFLRJxKNxakPpp/nTiGBUiaZBT
	mY3CDP2TKGwP9rWsyOv9CdOt9/O2haemjKnue/AoSrtO19JJF5eDd2csGvgRY6Sl/ky0
	rGt82MbZwzqOLNQ51XWAaNb5kzWP/hR9gBlJ/+lNMh4+f6+dfPw2msaXwc85wKMT2MGA
	PDGnvzI5o0dfvvqvTUX4X++Nwup23YulJF+ohaDsrrH4B8a5KyrqjGRadsyfwr4j6hMh
	lfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OJTx2YMgBnLmxy9QSpmGl7JN/UE/jilvByUL/wxnNyQ=;
	b=i1PXl8ui2swS1zKbpP5Fq+wxlF1DKVq4qZA8jXpESZuZ3dkKj9jEvbCt/8TT2zlMkQ
	fI2MoB934+DlvFmkh4Ki7YG5mG82kPNZoN9IRplNRxx+opSK6pYOFZkqD8bbCRbDAHec
	atwb/+F2b68MytxE6AbYDPHLu9p5SFdYiOPNqKpOlHVVF+Q4488dxWGOIu6EQ34emUac
	7Ld32NSrifBfYoTUXa79orYABEUDP9fCJZ6SABkLnZTn3PVD5WA2hmVew2L9k16OR7fy
	bbhZtLqWMjiiBpTQEErqIjx9RZXQ+bvNQoaDp6jVZQeiVzWS/V0ooRnxYVg4T9IjjZDn
	iTww==
X-Gm-Message-State: APjAAAW1mvgW4XZLAuj0/mYVsea8afOheNOmkjKy3ucb66G0DBve/1vf
	H2mJRmz4bPNgqLRxsOj+EXyC9pEMnx8=
X-Google-Smtp-Source: APXvYqw40mP5GGDPKTfrmOMpg0B93wDji76qp0DcITBHf3ivbaO/Nr1+DKPvGvrwaK2NmI2zxWLmWg==
X-Received: by 2002:a17:902:521:: with SMTP id
	30mr50620388plf.248.1555403517037; 
	Tue, 16 Apr 2019 01:31:57 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	m23sm76992727pfa.117.2019.04.16.01.31.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 01:31:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 22:31:50 -1000
Message-Id: <20190416083150.19649-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416083150.19649-1-richard.henderson@linaro.org>
References: <20190416083150.19649-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 2/2] tcg: Restart after TB code generation
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416083150.wdLSaqG3jLWVKUvJNKIbgefddMaMcygNZHEdOTa4_yI@z>

If a TB generates too much code, try again with fewer insns.

Fixes: https://bugs.launchpad.net/bugs/1824853
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 39 +++++++++++++++++++++++++++++++++------
 tcg/tcg.c                 |  4 ++++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fcdfe6c0ec..7086d5fd2a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1721,6 +1721,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tcg_ctx->tb_cflags = cflags;
+ tb_overflow:
 
 #ifdef CONFIG_PROFILER
     /* includes aborted translations because of exceptions */
@@ -1754,14 +1755,40 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
+qemu_log("TB overflow: pc=%lx insns=%d\n", (unsigned long)pc, max_insns);
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


