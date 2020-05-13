Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FF6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5EF205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCG7FvrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5EF205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvdS-0001kT-6X
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXu-000110-Nm
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXp-0004z3-OM
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id 50so492614wrc.11
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vIuy+49GjNnXS0U4P2UnKZDtDhiy+1MKHIiwaKmxtXk=;
 b=sCG7FvrFcphaiut0lleKtWhGxtRuMr9MwqFJ6uOfnkMcFRAchV3vciPJmmg3PFWQdy
 GbcWVuOQ21oliL21EnA9g6odK/KMA4on9HgZ6hSPmdPOubjGvYbpOuYvjWub+7S3oq20
 BSp0pzBbG8GB4X0soZuw/1Yyfrf3WfDB57Unz1tUDFDVeulDLixjsfrMWszFpNqBDtq4
 GxQRkFJOek3WOBEEA+J4Ys30iT01h9kdu0u2XfVDg1k5n6+YvqDDZFvWwXvkES/YaFDW
 Mm3gK1aAc/MizSYhyU0tykLPbqPKicMn9HwcMaMxjdRZed7wFNrTZ0t2EwNI72g/pO9H
 FOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vIuy+49GjNnXS0U4P2UnKZDtDhiy+1MKHIiwaKmxtXk=;
 b=q/LunSUhy3R3HopN3jag1lQ/r0l84ip6JD6l39xPZkXqi4yH87ypAPp7qcpv0KZzlj
 rVUIRsDQ4JxaSFRxIrISjL27pjjMqqC/h4M/S8enTZtj8c85/AKQzFIspiB9W2ARQLHL
 aOzhlau8JWx7pfbXNuSMysm1SKNP2bY/ybh/OsmfWJ4OSTiltXg/QB7RbW0ikdWT4Jn6
 C6y6CVjCbJJ21liA9ukSoIp2msJtIkGZTSY33TZdhkgTfJqI9FMfgu1eA9vJYeXIp3v3
 gvdhlYCGzDfDzqvDaSMtv9dnMfvw4QZwX/KpzUAO0bDZOSntGRf+8f0v2XmBYuW4LvvK
 OyyA==
X-Gm-Message-State: AOAM531ctg22PnDPDvYC8+TYwygnoOfDteqImKYuWunsc3cuF5el0doi
 2Pd4cY6C9gIEKRwXUvZ5xsdDSQ==
X-Google-Smtp-Source: ABdhPJwoK/+R9N4beQJaOLCoFhXwz2CGu1ctLPr9miXqFQ3qfCvdNne6jiYU0pl2ip2QlsURGVrSfA==
X-Received: by 2002:adf:edc1:: with SMTP id v1mr485126wro.125.1589392308395;
 Wed, 13 May 2020 10:51:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u127sm37160769wme.8.2020.05.13.10.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:51:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C574E1FF99;
 Wed, 13 May 2020 18:51:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/10] translate-all: include guest address in out_asm
 output
Date: Wed, 13 May 2020 18:51:34 +0100
Message-Id: <20200513175134.19619-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513175134.19619-1-alex.bennee@linaro.org>
References: <20200513175134.19619-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have information about where each guest instructions
representation starts stored in the tcg_ctx->gen_insn_data so we can
rectify the PC for faults. We can re-use this information to annotate
the out_asm output with guest instruction address which makes it a bit
easier to work out where you are especially with longer blocks. A
minor wrinkle is that some instructions get optimised away so we have
to scan forward until we find some actual generated code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v1
  - better logic for doing chunk at a time
  - use new "note" facility to tag address
  - rewrite the commit log
v2
  - don't terminate gen_insn_end_off, trust your termination
    conditions ;-)
---
 accel/tcg/translate-all.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index cdf58bb420e..42ce1dfcff7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1794,14 +1794,43 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
         FILE *logfile = qemu_log_lock();
+        int code_size, data_size = 0;
+        g_autoptr(GString) note = g_string_new("[tb header & initial instruction]");
+        size_t chunk_start = 0;
+        int insn = 0;
         qemu_log("OUT: [size=%d]\n", gen_code_size);
         if (tcg_ctx->data_gen_ptr) {
-            size_t code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
-            size_t data_size = gen_code_size - code_size;
-            size_t i;
+            code_size = tcg_ctx->data_gen_ptr - tb->tc.ptr;
+            data_size = gen_code_size - code_size;
+        } else {
+            code_size = gen_code_size;
+        }
 
-            log_disas(tb->tc.ptr, code_size, NULL);
+        /* Dump header and the first instruction */
+        chunk_start = tcg_ctx->gen_insn_end_off[insn];
+        log_disas(tb->tc.ptr, chunk_start, note->str);
 
+        /*
+         * Dump each instruction chunk, wrapping up empty chunks into
+         * the next instruction. The whole array is offset so the
+         * first entry is the beginning of the 2nd instruction.
+         */
+        while (insn <= tb->icount && chunk_start < code_size) {
+            size_t chunk_end = tcg_ctx->gen_insn_end_off[insn];
+            if (chunk_end > chunk_start) {
+                g_string_printf(note, "[guest addr: " TARGET_FMT_lx "]",
+                                tcg_ctx->gen_insn_data[insn][0]);
+                log_disas(tb->tc.ptr + chunk_start, chunk_end - chunk_start,
+                          note->str);
+                chunk_start = chunk_end;
+            }
+            insn++;
+        }
+
+        /* Finally dump any data we may have after the block */
+        if (data_size) {
+            int i;
+            qemu_log("  data: [size=%d]\n", data_size);
             for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
                 if (sizeof(tcg_target_ulong) == 8) {
                     qemu_log("0x%08" PRIxPTR ":  .quad  0x%016" PRIx64 "\n",
@@ -1813,8 +1842,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                              *(uint32_t *)(tcg_ctx->data_gen_ptr + i));
                 }
             }
-        } else {
-            log_disas(tb->tc.ptr, gen_code_size, NULL);
         }
         qemu_log("\n");
         qemu_log_flush();
-- 
2.20.1


