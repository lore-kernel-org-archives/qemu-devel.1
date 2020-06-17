Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57FBC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A97421841
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZZo5knf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A97421841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfP5-0007Gq-FC
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDf-0002p4-80
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:39 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDc-0008RV-69
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:38 -0400
Received: by mail-qk1-x741.google.com with SMTP id b27so3508327qka.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8O2wd0xMJ+DcB/CefCYufYGHDOjb2p67mBVobEDCvB4=;
 b=EZZo5knfSSDy73/TMZC+g9YfOw3kPYfcF3JMZTKAwDBZ4SD9AxG1sdOmVBprdYx4Fz
 kMe9jM7AwQ+AqTmf8k0cMLGgsw6JpcKCxzqxOmgD2uZvSG4seCOGnTfgrC+H5c6M3kP5
 HwmMOxwDIOGSP5+3nUPAFr0iv0h6/rmtFNPN/90kf9kxcdYEh5bjvU7DAdiizz7pIEqf
 fSk61QFF9tufPWnFzYtoR0lsljChcD1Y1qFT3M/hbn3LXg2Wik9am7hQwhhSHnqKG+h1
 GDR42sWfmg9VLb2kwWDyY2c9YInj73nMuH7mbVp32ovpph73zEWQpXrhODuNmYTjydJ6
 qe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8O2wd0xMJ+DcB/CefCYufYGHDOjb2p67mBVobEDCvB4=;
 b=CMH7en96ymm6jXKiOeLIq4bfHFKNQN5rWJFygK3t0+qy94lfmB94xeR/JVgmbtjtk7
 FL6x4pXM5qsj8jbquNoE9ld3hBer5PH5E5JPtoEQtdLW1NHk7UnSbb1HHdLotEvfBP48
 m8vve/bb21f+kTk/+sBTtoluPpuShGnAM1sZa0vRgnsdZjt4sm57Q4s2dA2Mo/N5MFew
 mYH0Wa0XcJLSC6iX0puj3eVbS7Z8CWDszjjIMhgFktPbTQz4yXeknmsq9TZdwanj5l4M
 EMpcLmkocrPP0iER7Qb8bMkEp+/c2A07mCSh33NstRCJ2uDyreIaEmuCMNDJB4rmSPsZ
 1yTg==
X-Gm-Message-State: AOAM530kOepO6wNjEbP+JmBwRCdQIzNZy9JpDgP5Ya5DQpBL2HlmOd6x
 KkrJLyJU18g1rmyb9B0NvxH3qUL8cH5aPg==
X-Google-Smtp-Source: ABdhPJwYnCjD+TX4VXbPeoQ5sChwruzNvGYDcLPi/M+/41ITkgfREmTfK/7o3zmFOTAHSNkWObfhCQ==
X-Received: by 2002:a05:620a:200a:: with SMTP id
 c10mr590690qka.218.1592427813151; 
 Wed, 17 Jun 2020 14:03:33 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:32 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 12/73] alpha: convert to helper_cpu_halted_set
Date: Wed, 17 Jun 2020 17:01:30 -0400
Message-Id: <20200617210231.4393-13-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/alpha/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 8870284f57..b1cd55e6ca 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1226,8 +1226,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             /* WTINT */
             {
                 TCGv_i32 tmp = tcg_const_i32(1);
-                tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
-                                             offsetof(CPUState, halted));
+                gen_helper_cpu_halted_set(cpu_env, tmp);
                 tcg_temp_free_i32(tmp);
             }
             tcg_gen_movi_i64(ctx->ir[IR_V0], 0);
@@ -1381,8 +1380,7 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
         /* WAIT */
         {
             TCGv_i32 tmp = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
-                                         offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
         }
         return gen_excp(ctx, EXCP_HALTED, 0);
-- 
2.17.1


