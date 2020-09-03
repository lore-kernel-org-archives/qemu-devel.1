Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FEAC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C146208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mY7W7h2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C146208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjjY-0003uD-PY
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDjeI-0002FH-Ec
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDjeG-0001mq-NK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id d22so1577911pfn.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hA0Q3ZvS9ZMt8mExwk35iB2Bwjpw4Nf408fgP9XSgOU=;
 b=mY7W7h2wq/n51O8Sp20oP6jL7RceK/BxYLfmBYx8BhgKKuFnbjiR+bUQZmvixo+RCr
 tlUhB9X/oYbCZpfOFMQEB7uyAfW25y0QuOV2j7iLo3D1kpL7wtiwqHpsaaLQ7+XLsPRh
 RQ3ooAdRx3OahUbLoIvu+esysGFBKRZLWZyEBN0ajMEVOMuRPH0byKeH2uxVbovAEQPN
 cEnwjK/+sNixCzlOL2bWf2dH+IQbUQpVZ8DN6ItYp9OXBAVlb4/b3M6yrBMgdekXKUS3
 bFmTmI1AE/5l6KbLAGrnZwTWaIRscjo16EqpTEiP8OKEbc0RZmkH1kRFDIoxA53DJR06
 qE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hA0Q3ZvS9ZMt8mExwk35iB2Bwjpw4Nf408fgP9XSgOU=;
 b=kAaonSp8KH5UcDwprlO7jpi8Drp2K50sqke0wbbR9LFwM+RhagJQ+U2omKyn+eWyJr
 td2b5hIbvZC1sbtj4thatHBiaRJq50r+rurcDKi59xL2w+6bG1rk5lmOt0INNtz3rdUO
 eN/FvHdbWifRHGPitqSIy8e5vVW+CWQzj0n0iXCqoX9uK7//PpDffyqBl9j17NzQhapK
 aq7wILlK5aWIoNV1AzgHolEGVj+bxeGf6rVtsfnKX0vaOMJc4PgAOdTiATL/elWnzvdv
 vLxN15GI213lSQQRgSaslAG5r26xXUWJu4Mfs6RRxNcLlws5n0NULDnsMfwGjjI7CvgY
 IEBQ==
X-Gm-Message-State: AOAM532x9qynuMVUrb02E/VmNLMZUFyTtxth+DihaWWZZhWYtdUX1Py9
 qKSwMGGR1VDZmprS+/ptaDP4VS41Vj0GLQ==
X-Google-Smtp-Source: ABdhPJz0K0qsPjhdvOiAKvQ3ZIhi/y8KhOiLhZ7QhQwmM8S4CeQlASG0ZAd59+YjniIpo+3w7ouluQ==
X-Received: by 2002:a17:902:9a44:: with SMTP id
 x4mr2542364plv.31.1599118027052; 
 Thu, 03 Sep 2020 00:27:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x185sm1930229pfc.188.2020.09.03.00.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:27:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/12] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Date: Thu,  3 Sep 2020 00:26:49 -0700
Message-Id: <20200903072650.1360454-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903072650.1360454-1-richard.henderson@linaro.org>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: edgar.iglesias@xilinx.com, thuth@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Normal indirect jumps, or page-crossing direct jumps, can use
tcg_gen_lookup_and_goto_ptr to avoid returning to the main loop
simply to find an existing TB for the next pc.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index da84fdb20b..d98572fab9 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -147,7 +147,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
         tcg_gen_exit_tb(dc->base.tb, n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb(NULL, 0);
+        tcg_gen_lookup_and_goto_ptr();
     }
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -1803,7 +1803,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         if (unlikely(cs->singlestep_enabled)) {
             gen_raise_exception(dc, EXCP_DEBUG);
         } else {
-            tcg_gen_exit_tb(NULL, 0);
+            tcg_gen_lookup_and_goto_ptr();
         }
         return;
 
-- 
2.25.1


