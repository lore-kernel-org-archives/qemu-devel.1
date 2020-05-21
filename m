Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3212C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91AB20829
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGlzNEeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91AB20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboQ8-0002aa-Sq
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIB-0002DU-TI
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:35 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:36667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIA-0006Wj-T3
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:35 -0400
Received: by mail-qt1-x842.google.com with SMTP id v4so6011980qte.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XpDaiKPid7/Y+hg6nqP95tP3OCZMiTwwygoeI2gWXpY=;
 b=fGlzNEeR+AGHFmUdJLgnarLRXf99CwCGNAMiQCTn9H601nP2Hcg/aUpVO9/5yWrHP8
 QDnIMMcoqv5JJTwMsSUwigFsQ4QjNwYqxXoeu75feV6pJerGQSB5ZcWjx5g6tMPXx4GI
 oxjyFNNy5/hvpsx7cUJq61czTKeq+F4T3WBu7mFlFg8uOlTUQbYE0/fsm6vRXKRMJFpP
 Yx9mvozDatStV/fMlWujfU3wUke8Kws8BJoSoeNWs2IIEpyGGsbmBvJoHhXsI138CX5l
 x1YNW5SpSPdcUNEzhVrpIlcQ5NRcRZewK21f2BEfZfToGFS9EaVCurHFUnxEnCNJLjpj
 UTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XpDaiKPid7/Y+hg6nqP95tP3OCZMiTwwygoeI2gWXpY=;
 b=UWJTyAdzbeiMx/cFM7HaiW9wy6G3p4CyR0GEcCMkARzUq/Gze4xN83U7U2QjoB7D1W
 rcyitfjT+AgYsx44qytG0Qr2cafvZTFIDudJVoIDxUslL9mFRXCpzSkc7WEabo0thZyz
 Aw+jcJmNMDvFGiCGwEQh4Ars88jPbtsZA9eEqnTyPauTz3B6VGSPimE98cDYdw2eUEyW
 bz499b/4XJ7i2x+F8rrjIPjJwe+gyPGT2TOdw4eD8v5JRhV2ADuwjia4lOTxRtIRSxk7
 WvrYEwgQCgfNQMCILElLBvIWtyzlJaU7caQCh2TO6dfn2yQ81UttzQ8COfb7cGPWVGSk
 sdxg==
X-Gm-Message-State: AOAM5322pF2uTYRbEEK2kegSIjj7nh8mlcU2iS6PgRHGayffjDKr8qx4
 +DuMBTPESddb74hLwuQHxn3qYQjnLjdgkw==
X-Google-Smtp-Source: ABdhPJxiAkWjnUyncoGUJ64jr9FpbPYwBFXeqvm3swgpTNjekVeAOvAY5DOjk2F/z0dgiMmFWPzjEw==
X-Received: by 2002:ac8:543:: with SMTP id c3mr11108406qth.8.1590079413577;
 Thu, 21 May 2020 09:43:33 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:33 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 14/74] microblaze: convert to helper_cpu_halted_set
Date: Thu, 21 May 2020 12:39:11 -0400
Message-Id: <20200521164011.638-15-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x842.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 peter.puhov@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/microblaze/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index f6ff2591c3..c08a7f1d39 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1237,9 +1237,7 @@ static void dec_br(DisasContext *dc)
             LOG_DIS("sleep\n");
 
             t_sync_flags(dc);
-            tcg_gen_st_i32(tmp_1, cpu_env,
-                           -offsetof(MicroBlazeCPU, env)
-                           +offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp_1);
             tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc + 4);
             gen_helper_raise_exception(cpu_env, tmp_hlt);
             tcg_temp_free_i32(tmp_hlt);
-- 
2.17.1


