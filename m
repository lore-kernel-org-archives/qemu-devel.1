Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BABC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FFE2166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+GjfbsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FFE2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfqZ-000232-PA
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEW-0004BO-Uf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:33 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:40079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEV-0000M0-88
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:32 -0400
Received: by mail-qt1-x842.google.com with SMTP id i16so2751709qtr.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1YbnvmhNqAhmF66BGNb4cMj4pII5ByUEQJWinpDd9pc=;
 b=e+GjfbsEEWzjau9GWD7/LJJe6jl/qjLCZqkpLJHYyjzsJqyO3f0cixECvSSGzqp9Fv
 G9IinPhQwS/UGqE+pQNKPLAgGDSAEJ+pDK/DHc3spOuTophvZqca4C44wKfjsF1CjywB
 VOBMRFuzDPOX4aEShCVrzdu/a9VFEZrsnwnwYZFq16sjd1rV7/+Yfz6r4Dl9CGkT/PAK
 g4xvZ0CiO1EV1pfahapwcAg9A5Y4WwW8fUlGEv8trydWXXjvr+Attir7XyGruwCdg6dR
 u5C1G8PlTKVwLMc9W8UCdXUXPopc0Ri+EtPAXl+i87HdBDJvxFU4z2OiwbaFsaT/v9f4
 kL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1YbnvmhNqAhmF66BGNb4cMj4pII5ByUEQJWinpDd9pc=;
 b=S90qeuMzjgy/W3Fp2fwM1DeUQmNguefCJafxp9ItBgr8SPsmBGpzL526L0ZbwxS/BI
 EutJVrtzU8arG0pdfF/cukaB/DllQEbAHqpeIkLDEVOzf3x4sgUbvmCXyyVRMbr2QrAx
 lwb4JNUttR1PEsb6cFTR4Kb9Mc330tRAR/Vd6L94/kYQM+J7ylawseyqRy6OI/8JugNK
 SUmTkGNyiTHfbZET00KQeYLZJlZh821l5u25ica9vVLrrx5BgqA86wROSDKUqzsMH2Fq
 2cc/AYyOkqMZ7L8qTZ8D379EMkzHl86LMQQti4YLSw4B9WLFR6hLb90tY5b5Cdqx2f45
 g0Gw==
X-Gm-Message-State: AOAM530D1LbObdl0nw/2H4Mourj1grhV2g+Cd4bFdQJSIh/+aWCxgmT9
 xHVWqW2+1Ci2yxqD6MFKs/YGa+IDJ6UC3g==
X-Google-Smtp-Source: ABdhPJxONwflqqnuoqK9oPE4dP+eWbKvJzw3x9QgYxy18hu83bb0zm7Z2MnqemFxud6tWGJ99hgSfA==
X-Received: by 2002:ac8:40dc:: with SMTP id f28mr1094990qtm.63.1592427870017; 
 Wed, 17 Jun 2020 14:04:30 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:29 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 51/73] nios: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:09 -0400
Message-Id: <20200617210231.4393-52-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
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
Cc: Marek Vasut <marex@denx.de>, robert.foley@linaro.org,
 Chris Wulff <crwulff@gmail.com>, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/nios2/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 8f7011fcb9..fe5fd9adfd 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -36,7 +36,7 @@ static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool nios2_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 static void nios2_cpu_reset(DeviceState *dev)
-- 
2.17.1


