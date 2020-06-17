Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DBAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2582089D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uf2sSmV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2582089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfK9-0006Gy-Jt
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDe-0002nG-KF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:38 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:38875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDV-0008Qv-K6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:38 -0400
Received: by mail-qv1-xf43.google.com with SMTP id ec10so1758972qvb.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nYtL05IMdrK2PLihxK9n2nGdaQygV4Nn/DL2l37l62U=;
 b=uf2sSmV1u0B0TpF0NljmOMjFOfBWEdoYIHpMMtB5x4sJWIcBCHgIL6cvPlhDmOhjBR
 upte1RQ8EBrJXbztVgOgi1AocARBTmewIZtuWR7Msmuu1hsKj1d9heUzvsTvVQ5c+W38
 LVbKP+t00bXNQgoGlFVsWnfjhKr14GsABcg9SWB8Xdp4+YxGMJEKRd6TralB2KIdfiRr
 URFQ+UKgtPa6hJqwgy36FjfJkSWvXMhPh1gGnslt7SXaPJeqFo5s6wB0t6CnSEbusW/F
 rLWdRnXPM+NXOhatbziPAHdLQ2LijA0liaM7Hfb5ZYU1q21CsxFesqpmceaxWqjJm2r5
 T3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nYtL05IMdrK2PLihxK9n2nGdaQygV4Nn/DL2l37l62U=;
 b=UM1ejAs5qak4atDqXbbhslIJYAmZlwo1RJfBdOxVq0CC3W1AT3vn4PejXkkbgr686d
 XHDC/XrYpc/U6FF45Y/UTPRvCG+rp+ucl80dWJT0S6ChnJUeWUiKj7PWxBpDZB0D0NCa
 XMYN0Zh1OQ/Irwv/LMz4aRn2EcKLts9kcmhuaqKwv/Cy/7zCs9/BHXztsttYuNxHhaVL
 tuIjGqwGWLgSmWDtrjKV03BG0opkM6Lycy8BCkZkQ19d7x1dU1LwE9SoXJ4WKwabOZzo
 AbP2JqvxgduB3YiJSZJ1rosBRzkXNQdJ1zuLleRQzfxq4z0AWgswPzOYC2J+eA1iCzOP
 a7Lw==
X-Gm-Message-State: AOAM532S7f4sVHE24wn1Fhrg6nrvgI5IIJjHVcKN21vLUql7MfO0yt3W
 UcM0Ouk93iYgfZ+3A1051PvKCRDkgmlKOQ==
X-Google-Smtp-Source: ABdhPJzji1mSwfmzePOg3XmvoEiPxmDGMTDZj6OXuvD0In8yX2m32x5XSC5TN011l2rP5+qOtcBWsQ==
X-Received: by 2002:ad4:4851:: with SMTP id t17mr594808qvy.160.1592427807531; 
 Wed, 17 Jun 2020 14:03:27 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:26 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 08/73] ppc: convert to helper_cpu_halted_set
Date: Wed, 17 Jun 2020 17:01:26 -0400
Message-Id: <20200617210231.4393-9-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf43.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org, qemu-ppc@nongnu.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/ppc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4ce3d664b5..d30c2159fa 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1596,8 +1596,7 @@ GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER);
 static void gen_pause(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_const_i32(0);
-    tcg_gen_st_i32(t0, cpu_env,
-                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, t0);
     tcg_temp_free_i32(t0);
 
     /* Stop translation, this gives other CPUs a chance to run */
@@ -3621,8 +3620,7 @@ static void gen_sync(DisasContext *ctx)
 static void gen_wait(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_const_i32(1);
-    tcg_gen_st_i32(t0, cpu_env,
-                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, t0);
     tcg_temp_free_i32(t0);
     /* Stop translation, as the CPU is supposed to sleep from now */
     gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-- 
2.17.1


