Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B73C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204752076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cM+oCqVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204752076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbft-0003np-7S
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZV-0002Qt-5V
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZU-0000zK-BB
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id z72so2963545wmc.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NDEc+9+kZ2Q3/E6kQh66WfIBSt6HPjYYbPv1ArIk0sg=;
 b=cM+oCqVY+A15dg+aq9QHooynfIT+ojxkuGKe+xiNpZf8uzD5ogo3LsPU+aJ+UlLPqb
 38EJPyjAzIEkFJibQM06boqrZvTaANnF9Tnkw/Jb54xrwNz3v2oFum3KZhvik6mDHuCL
 pRoOpACSbCMcNINL5l10jMfbScuBUCEcwIm81xPsxX+MiWkMqSHXBB8mQKf8EwI0YBPU
 BfPTPvqCXEMdIHZDZMY2GZsPBro8azBI8MUY59AGkmOpupMc9E6rqNyi/RlA1cJQ2FEM
 J63iD5JeDUzJ/rmhtaNMpx0+1aT8Y1ZQj8MWKSYQnLC2wSg7umeXCTSqsYDEekFz8z8j
 aNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NDEc+9+kZ2Q3/E6kQh66WfIBSt6HPjYYbPv1ArIk0sg=;
 b=aDaKPRnq/rs3+46NlRDxx5qA/riwVXufWevfXISaga+s99lLdq/p4Rp0g4waEbhjB5
 2Z0D8xFm4M6JU7Bv+ewWHYW3B2Ov0qYp6PKaTXJuDR/hzsYakcWLlw4dE8Wi4R0yMHh8
 bDGAFr+QMh9TL+2vKZHTvJhwrx7u5Sm0qU5Krbs1mGqF/QGMqC3bbgWq7geVHcNDngKi
 XUrL2t9tdel+csJiK86WIxBjJssK6A89fEmD44zEvhIgeO1cvAuembe7DL/az5ybJkOg
 sxhqRBgpUvUa2SKWl7DMmeA8fiOGiozwD8bCukFkZus+xlupuxvZkGSz/9azAur+Ch2Y
 ZnWA==
X-Gm-Message-State: AOAM5307lEdO9Fst0VQUGhZGlurQKX+8JwVCm3nI3vw9whPaPAyNic/0
 46qqfxAzBuFoKZVEboj5cr6V0Q==
X-Google-Smtp-Source: ABdhPJzLOrf416i2Gt25liPsCHrcV0VN98GCHRoDLfTY15Fc72FYjztEYEvxRyJKzmhgHs4yOy0Tjg==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr4258054wml.19.1589553858874; 
 Fri, 15 May 2020 07:44:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d6sm4584006wra.63.2020.05.15.07.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:44:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 06B951FF98;
 Fri, 15 May 2020 15:44:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 09/13] translate-all: include guest address in out_asm output
Date: Fri, 15 May 2020 15:44:01 +0100
Message-Id: <20200515144405.20580-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515144405.20580-1-alex.bennee@linaro.org>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
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

Message-Id: <20200513175134.19619-11-alex.bennee@linaro.org>

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


