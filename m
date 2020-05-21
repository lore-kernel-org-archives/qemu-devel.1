Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74290C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D1820759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5aczt2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D1820759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbohg-0006oY-AV
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIw-000493-Ii
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:22 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:41362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIv-0006dj-MM
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:22 -0400
Received: by mail-qv1-xf43.google.com with SMTP id v15so3358333qvr.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=leGMjXpK2HH4jKgWKo9xRsuJr3HkPgiK0233yCfpGgs=;
 b=G5aczt2dpOKIKi9IgJcGV67xlqm5xPcdhGw4lK+DpCsr5YXe95LUhE4rFDIi4lofkb
 X4RVjQIWs5VxNiFHfoWr65rESg+N/TnxSY00KrrgBIvLL2bh6t3CWLBu9oe38w1HqTZt
 RVRstxlcE1JofmLuBd30bJYfkLu4V3/eBT1XEY19y8F6UyfxgEcyEPDD+PFhIC9W2NOW
 j/xfznMaiFTPQkeZ5uPFpqeq0pgA+j1Z+C4gLMHNVSPTbm6pJQwZQRhs++MFLeJT1a3d
 7S0sO1GIvzgYjyr1HyIy4HILq++AHGtXX/ST7tG5Oy1c3SR6bJwMGNBT8nfWqeR2qr5I
 pv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=leGMjXpK2HH4jKgWKo9xRsuJr3HkPgiK0233yCfpGgs=;
 b=GReuuiWywltA/IHgwbCFtEy5o6YXUx7mIH8iFG+rk8P5ssorbotkRjWqoiEBPSJMut
 nE2I0/8KNM9GnfBB95oZZxjcYHnxF/QzBk9YMyDly6WdXTVfIgpWnit/bsfCE2ZMCVN2
 gAQecjWMr8NqhROvX4ILeMTs9D8P4Q5NZ44w06/HnV3g9R74kWvFAalodlX7CtHmir5s
 9r3O4IiKMnb4e4RFCG4inkndfqfg6Vf2rcetPsjXWIFCUqZEdf+y2vYSYQSzAg/6T90Q
 NMvFNpcj1FY8q/kI+wGJG3ElXt//aBHfvswDdEEUo6+1cqby3ZeRB+61gaghOgotxuwY
 Js0Q==
X-Gm-Message-State: AOAM532j+QfxqN8t9bqZbgwEXYKGD3NJ63QiP6Ygx3ZR1c3GuYL7ig6A
 xRTr02Kb/E0shnI5/4hWWutCC4JNO3LnLw==
X-Google-Smtp-Source: ABdhPJxrqItGbtLUe1XkxIEFvZ1PQ2Fa+E7wcn0uQrojUd9HYX5HOHWg/OXPm+EnJxhGhWyc8Yp6Tg==
X-Received: by 2002:a0c:f887:: with SMTP id u7mr10969837qvn.32.1590079460585; 
 Thu, 21 May 2020 09:44:20 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:20 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 49/74] lm32: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:46 -0400
Message-Id: <20200521164011.638-50-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Michael Walle <michael@walle.cc>, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Michael Walle <michael@walle.cc>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/lm32/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index c50ad5fa15..9e7d8ca929 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -96,7 +96,7 @@ static void lm32_cpu_init_cfg_reg(LM32CPU *cpu)
 
 static bool lm32_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void lm32_cpu_reset(DeviceState *dev)
-- 
2.17.1


