Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD87C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADDB20738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGKCHWDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADDB20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboQG-0002nY-VL
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIA-000284-A7
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:34 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI9-0006WW-EC
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:34 -0400
Received: by mail-qk1-x742.google.com with SMTP id m11so7880098qka.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8O2wd0xMJ+DcB/CefCYufYGHDOjb2p67mBVobEDCvB4=;
 b=SGKCHWDZY09KK8Z1xny9ksZlvnpuBkaMA+nswHU9X7bUmRqFGzEiucF7NoTK1l/bOJ
 64RqsnWqmnCA8xUnECSl5fnKyz3QJtefvmu1ADa400dt+VWbrVgy9cR3hUaSaikLPHVv
 0FdV/QuI0AA/R0hjhIDOrMUqbpTcRFK013i7Kh3ib7sjNIkFBxD5eIefrSnL32negTwP
 CnZRA6fJ5PF6+3c1Vk/q6ZRJxFiC/8+iBCIYzQWCjx2N5lLQmntYOeih63T3wBpUh+XC
 uHJUgp1ULKWBv+kaItsEHgq6uFBoCnPjdX3HhKd4YL6ADKKscnkOaSWCfIf7jZ1dbO7R
 VYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8O2wd0xMJ+DcB/CefCYufYGHDOjb2p67mBVobEDCvB4=;
 b=F8kSWphnAa7/2nFu7rK82Ez3V8WEgo7awQsx+BRBNPxrjZna6vwU2iME8Vx8CuzO9+
 JaKoUt2KiR0VH4LHqa4Ds3LHa0ym9LMpo5Dnx3Zjb33TW5NmH8LSha5uPUsZiFFK7lkd
 fIO3yFqNDYTzHCLJD498UjKMOC9SIKkTwFFFnCRRlzWFDvNS1DIMQ2uIscf/8Qi9Ook7
 qHbwlogMK/FXi+z3cRTPaFSYar1Mf4t0MalvwGdOGIPSwGlpRBmsi6gRoUI214ECvxhS
 0oJ5Q0tIaxoqMfvt51vso72r0bJRhAo72K6b5ERo0LKKeNx+T89hohAyEU93OI8Kf1zf
 /2BA==
X-Gm-Message-State: AOAM532yle7yM1m0CGb6yV4mhxpgbfkiznWs1F1I0Jr0qLaq2e28IBCw
 Lze/w8BHWhhEEJMIJPWHIyvQ7WhR40zZsQ==
X-Google-Smtp-Source: ABdhPJx3Mo8GxEYzBapH9hwVYDeYYP9os77fwsP9oUbEzSNSyemMG/NmadXsFafe9NaGAEvoqcgYyg==
X-Received: by 2002:a37:6cd:: with SMTP id 196mr1795854qkg.393.1590079412346; 
 Thu, 21 May 2020 09:43:32 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:31 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 13/74] alpha: convert to helper_cpu_halted_set
Date: Thu, 21 May 2020 12:39:10 -0400
Message-Id: <20200521164011.638-14-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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


