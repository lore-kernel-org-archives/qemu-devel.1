Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940B9C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663E520702
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNCOfdbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663E520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZnV-0002I1-LB
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxZmP-0001cv-8Z
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:40:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxZmM-00067V-Vs
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:40:44 -0400
Received: by mail-pl1-x644.google.com with SMTP id d1so8999074plr.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D828gI1JmqlE61S0UJP1FfSeyb47LbCu+2td18hI0V0=;
 b=pNCOfdbwXBC83zTc+hHfaBfbYlLp5rrXwA1yMz7xHoOKiuW18YGwKM61SrAYxTuMqx
 RApcz+edduiRRTKt0joyZ5xqCM2Vh1UTs3ZMzh1hxgz+4E4s8EVWWZWfUvVVVF+Lx+L7
 I8OrlABPy3nXjiu6zrwfgTVkHlonqNJyTH/g92PABfFbkFGGTO1IfyqCW5S7fvPLxalD
 rajRgLFaG7aqdG6tbub6d8mZguaYwyXvmrlZNOEg0I3tDqBz4uC7OZCSm2JHt9ywneTg
 yW3v/UmNRx3YcDGI8IoVuR5Xqyr2rCiWhRsGPuOakOoo5+0G3+jW+RIfc2csvOnrSuIz
 vUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D828gI1JmqlE61S0UJP1FfSeyb47LbCu+2td18hI0V0=;
 b=Nxn/a/6hN+HVrkGIPv3fGIg2a3LNVw9AgpRdaDUUUaTJ0bpb0SmG4kWjtvD5pSNTOn
 tuCZ6z43O19JeXOOLYB+lzMN33KpNnt3iTjeoYfQpB7xj9BqVRr9j/e8Cyw6UkzQvkhw
 nCi8axWxNaFb1ZXrWs95n5ALnvhkNa6hmU2Qn3MhBrQv0/g2hMMvA+uWTgKNEy+tgHHr
 PRUypAe62O9QfrKH4R/xJQojBjwakyYZxYognVcK0FUj5NWwjOPjLz5l3yqF9lWInYns
 C5x+cyA8eiHUVp+3+FlYjv1o/7+WXp1QI8I8RqxcRkfa6UacxAryu2Ua2odctcjDAptp
 yT4g==
X-Gm-Message-State: AOAM532GxhUNyDLbJ8Y6VgHnPRKBcaGx+I/tjcsLeejWW9kmSMl+5UmZ
 cgsqUsp5LMuLdw9x8dFYsBwpj0flGaA=
X-Google-Smtp-Source: ABdhPJwUIVeARty0L4ElRaRAPWOEEXgjrUbIHkWDRNGMvloJJujmGebzfDCEeVfmEV4W02sjOFySDA==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr512671pjw.35.1595266841212; 
 Mon, 20 Jul 2020 10:40:41 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id y7sm184650pjy.54.2020.07.20.10.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 10:40:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] target/hppa: Free some temps in do_sub
Date: Mon, 20 Jul 2020 10:40:39 -0700
Message-Id: <20200720174039.517902-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: deller@gmx.de, svens@stackframe.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two temps allocated but not freed.  Do enough subtractions
within a single TB and one can run out of temps entirely.

Cc: qemu-stable@nongnu.org
Buglink: https://bugs.launchpad.net/qemu/+bug/1880287
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 52d7bea1ea..4bd22d4820 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1294,6 +1294,8 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     save_or_nullify(ctx, cpu_psw_cb_msb, cb_msb);
     save_gpr(ctx, rt, dest);
     tcg_temp_free(dest);
+    tcg_temp_free(cb);
+    tcg_temp_free(cb_msb);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-- 
2.25.1


