Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273EAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65E721841
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWUG+Nn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65E721841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfRt-0002vv-26
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDh-0002t4-Cr
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:41 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDc-0008Rb-6Q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:41 -0400
Received: by mail-qk1-x743.google.com with SMTP id j68so138258qkb.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XOL0McJNxpiiKDMcuEDzDPwcyrSarpMmiP9igPMccJY=;
 b=bWUG+Nn58G7tf1GVpLj8HXfMR8FrqALNXTDR30Ey5jrxh4ryzsblivnkfST/l5sm0e
 WAx/s9rdvzkFkCNuoblOq+NDoYMdotzjYIJaC+uINryWEwPfzxrTrEKUlQaTSwCgjI7a
 Phudp5IaC3VZPmO1Mzm1h474xpskwCp78qAb2Q22heWlEetVQVEsRaLFRgLptur39CPY
 CJBF6ckB4l3uRFdkque5De7gdofqS8i42aHWGnYHt98B9/+Z1f3rG5yUFZGv9PeWcTDn
 DBAhH+D4r+5m1pIstGRmB4TwI1FunumjbhwCuyY6QhbEwJmJSHqwSQYbT86c1pnGyVbD
 8ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XOL0McJNxpiiKDMcuEDzDPwcyrSarpMmiP9igPMccJY=;
 b=p77qYu3Hm8vewZxrkwq+L2kaA1GE3Nni6axZWywBvgXNqEQXPuXRyfqMmocAyOqfYS
 RUqojaAdW+HFsf5h5cYt4leGu2MAdoNd1GfWtTEXuBEZACerYMMm3Y9l9qmCobSavgUK
 f5ooQ5KSC/PCJhlG+84yAb2gC+WTUOgB4+lpJYB7Q97ujEvZ/IbJiv2f+zJRE7M0mX/2
 eVzKs919Dju+roEb5FxjmXUY9vPf79kDmrKuzKTSh8vsyS4O2LoO62KNZeP6Rf4anZXt
 KTxEdv5fXkKS3bDZzuhU6U63w89EfB66JOdcT39z6P4clx05DS4fYcdPgGsFo4WIMPv+
 uoog==
X-Gm-Message-State: AOAM5331fFfQY1PTfJ5rKYexoI/AU0r+rURRn2kne8T4xSD8O7ce7pLb
 IlZln+JI7iaqdbj5m+2041eWYYloYMK/pw==
X-Google-Smtp-Source: ABdhPJxUqltz36O4G7d9obYHNBaTLYS+nsyK5AD+rZdnTG4tLcbSM05Al1sm5b1gY3EYHGjpDwNYAQ==
X-Received: by 2002:a05:620a:12cd:: with SMTP id
 e13mr567675qkl.143.1592427814586; 
 Wed, 17 Jun 2020 14:03:34 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:34 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 13/73] microblaze: convert to helper_cpu_halted_set
Date: Wed, 17 Jun 2020 17:01:31 -0400
Message-Id: <20200617210231.4393-14-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
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
 robert.foley@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


