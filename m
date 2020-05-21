Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F77BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4612072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmuuoF5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4612072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboNP-0004Ee-3j
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI8-000228-23
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:32 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:38339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI7-0006W2-4a
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:31 -0400
Received: by mail-qt1-x841.google.com with SMTP id i68so6005767qtb.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wrWqzZuurKLoDMN6QCL6bZgCudK/zrEU5r5KFbp+gtw=;
 b=YmuuoF5LDaLC9LPJFJ/OIGT/lFZhaggYW7guEd37vYOaxxRGX3CYGksjL+A29Pkhwf
 o++J4eNpgjnAUhOl/PaQW7sP2c4QlcHkcKOKf9A9CNQXmGssLOkqFR/dvVmq7KXJ9wup
 QjIkdJG8kC9o+aQOoMx1bZO3imXwxJk4lH5njtI8JcI32/ZiFccR03ksZeGTFBj5Xb3B
 W8TFGmLqGGjHpHZZvWJFTFD7+kN6u9EeakOrxTxTqPCiXP1IQP0uXGtW9L1s1K9yjZly
 TUcEiwNcTTkoK0Rl5gqWb5AnZS4D/HZbVDHT02fwfJt4Ep7F0seGmq1DTKfD/nue39FZ
 6ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wrWqzZuurKLoDMN6QCL6bZgCudK/zrEU5r5KFbp+gtw=;
 b=tq6VNt8SG9J8jhpIANrlRmSt5Tmnyp5u7sHzdcsN4YvuTqXMxAnIbQ17A7F15yI0gz
 JzoJTS8gIfhZFV6IWyt1ZNnr2NRc4jQjixMdC/X35GXaqICeM2L/sOH4sofiyx2FvJrv
 9WV040HBwHa26wXE9DscqVuuAkqdW/0CHNWXH9IAsskwGJ3zvNlpzdsKBNRHxHpd1bW9
 AnopmcrIhj633rILObtQ33zTmpTB3kOxxBMDdauK+Lv1GC4eW2m6JCYY8C9Cie7nja1e
 nwuFW5z8lXMCUfcdlGjU4SDBkWMQ6MW77LHFW8vnTlC9Qt80rejB9U3OHKkWRjoZSaoW
 vEWg==
X-Gm-Message-State: AOAM5310na1X6n0sKRG9PZKDXxmF7yDRzc0nzgVY2+J9TtZCnjZCXGpq
 +Ttgy4qTBoWcCF1X9A984C2QAOzXJMfjrA==
X-Google-Smtp-Source: ABdhPJxlEzsj/zaUIMcZ1jml40fDX5W9HatDTGpHa++ep0asPzDjUpRl3YoskiSCMJIHIs4RA4SyQQ==
X-Received: by 2002:aed:35a1:: with SMTP id c30mr11731970qte.228.1590079409933; 
 Thu, 21 May 2020 09:43:29 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:29 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 11/74] hppa: convert to helper_cpu_halted_set
Date: Thu, 21 May 2020 12:39:08 -0400
Message-Id: <20200521164011.638-12-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x841.google.com
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/hppa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 52d7bea1ea..9c4d5b28b0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2725,8 +2725,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
             tmp = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
-                                         offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
             gen_excp_1(EXCP_HALTED);
             ctx->base.is_jmp = DISAS_NORETURN;
-- 
2.17.1


