Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7AC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBDB207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCDVqzfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBDB207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXBzo-00006E-HK
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 19:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBwK-0003BF-4T
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:15 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:33455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBwF-0000JD-B5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:10 -0400
Received: by mail-ej1-x62f.google.com with SMTP id c15so16522189ejs.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ByHyPPqDa1B0Z2A0GB22PMBVgYYCiahQCzikXG3rHfE=;
 b=nCDVqzfHJDfKssmIVW/lJS3qdYaCfFEqyYwpayAM5sTxjHLP0WJjNHlmIqKcGgS0RW
 7qvqDPL5AVXF1DgaTBqTtbSsx3w9OUPzg48I/tqniVHQA8U+80b+SnKOlDmy65HeXE3M
 HTKu3i1ZDkrZYqwl8VsD7oNCDoqx0FANLGbdkaqacc0T/LWaki1wFdiWt2uy+wGlbcl4
 FaHwsERLQosvuqd/zksmqlpmSCNIZFM25+IYK11CUf/GTSYqlJZ+LbbpWsyRkjMcBIrW
 D8GsIFUXNqBRepLJ+0JFunPVQQPZUBv9nP7VhG/QAWiz+0e//nR2soMTjhcSs1uasXbU
 alQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ByHyPPqDa1B0Z2A0GB22PMBVgYYCiahQCzikXG3rHfE=;
 b=H5cb9QBBnxbyDncBdc9oy+E5f1PUhntD75+B8mMzE+nsAd30C7JIk5JKdSPdKPsveb
 AeYThNa00Tuczrp88Ob0CmGBTk10Ev4bfm8WP18bU9v+23eyDIcrI7l/H6TBA0n3ZVnG
 e0OFya3ld50Jocb35Y51a3z8GLrq1UZXykRPudjtpwC/egLXmPoxtsgn/Oc7gCgjVk4K
 u0SrEttEee9JaxqnMEt0NmpyzMZUICSXF3ssVqjOjDJ0fmU505NE/lF9EOs4HbZvtsxM
 2A4kSbxpYJFgNI6/yLz3J9oIJqctphW8xOeob4w0jxvAispy/pUdLKPrRWmhDKRgX02g
 lIcw==
X-Gm-Message-State: AOAM530KdRK27aefvcqULdesZmdw9jfSMm388lesugLppFey/ENkiMWG
 xBnV2L46AtJDrF2f8AF87XMvd7SJjRY=
X-Google-Smtp-Source: ABdhPJz2kjBKqV0Pjh0ofWny0kDlaRA08V2CrKQXUnnZRnuvqs+G6Kf3MM4Czb/b7pedng1X9deghA==
X-Received: by 2002:a17:906:4351:: with SMTP id
 z17mr17968767ejm.110.1603755005557; 
 Mon, 26 Oct 2020 16:30:05 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d20sm5907484edp.85.2020.10.26.16.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 16:30:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] target/sh4: Update coding style to make checkpatch.pl happy
Date: Tue, 27 Oct 2020 00:29:32 +0100
Message-Id: <20201026232935.92777-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026232935.92777-1-f4bug@amsat.org>
References: <20201026232935.92777-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid checkpatch.pl warnings in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/sh4/op_helper.c | 8 +++++---
 target/sh4/translate.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 14c3db0f485..fcd9ac7271c 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -398,9 +398,11 @@ float32 helper_fsrra_FT(CPUSH4State *env, float32 t0)
     /* "Approximate" 1/sqrt(x) via actual computation.  */
     t0 = float32_sqrt(t0, &env->fp_status);
     t0 = float32_div(float32_one, t0, &env->fp_status);
-    /* Since this is supposed to be an approximation, an imprecision
-       exception is required.  One supposes this also follows the usual
-       IEEE rule that other exceptions take precidence.  */
+    /*
+     * Since this is supposed to be an approximation, an imprecision
+     * exception is required.  One supposes this also follows the usual
+     * IEEE rule that other exceptions take precidence.
+     */
     if (get_float_exception_flags(&env->fp_status) == 0) {
         set_float_exception_flags(float_flag_inexact, &env->fp_status);
     }
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 60c863d9e1b..ec5b04889e1 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1959,9 +1959,11 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
     NEXT_INSN;
     switch (ctx->opcode & 0xf00f) {
     case 0x6003: /* mov Rm,Rn */
-        /* Here we want to recognize ld_dst being saved for later consumtion,
-           or for another input register being copied so that ld_dst need not
-           be clobbered during the operation.  */
+        /*
+         * Here we want to recognize ld_dst being saved for later consumtion,
+         * or for another input register being copied so that ld_dst need not
+         * be clobbered during the operation.
+         */
         op_dst = B11_8;
         mv_src = B7_4;
         if (op_dst == ld_dst) {
-- 
2.26.2


