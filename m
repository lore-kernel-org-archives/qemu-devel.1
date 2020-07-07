Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D998C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56EC5206E9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbIRTfP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EC5206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshQX-0001s6-KD
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 02:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshNX-0005yp-8m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:46:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshNV-0000cS-Q2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:46:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id q5so43876161wru.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=45gqo128NQDtIYcxM1tYqwMqbUrJDll0ND7eZVJPFlA=;
 b=CbIRTfP5fVKDPO1sN6Nm0ogTmJfT+Dfo1iIcerZgjhiH0iDVsjz/5QNznQnTdGf5wx
 9Eim4CkUeEGTObMUz3StaGabfv+uehIX/ldfUu6HSEO9wRsrQB1WClui423ZkxwjMlmc
 yXhXbdSCKU1955OjD+8mOdh48gsLLUZZFOQbV+Z++9Bd0RPsdvTEyBfSqaiN0Z3Msgz7
 Zz05Ru18w/H/e22aPE8s5BqikwBf+ddHdE4X2esNJ6tHs64Q8xViTjKwjJcMtEjN0O7j
 rkUAj1uQA5Gj6eurEWlglgS4EbwYDAIm88nky5xj+9IDgOT6WqCleEa+QVGCbz8xOO07
 fEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=45gqo128NQDtIYcxM1tYqwMqbUrJDll0ND7eZVJPFlA=;
 b=RZcjijMt5LlA8my42YNe6xu53z6hNm3RbA4oB+o7tdSlqvC5I2DTKNR0fRNHULuJns
 mRzkgjxmaxDyth3Vxieoo5M3MPPm0HdbQpb0BFPKRxO82lmDZgYLRUnBlMQKLLx/HA6u
 jrDLCvVuNtCx3Jh55QXJ602lQ9zMhrzAyAf/3HcXcs6GYr/o1SJQmdaMzBqfB9ixwlvy
 5042i037yfMCW1aGa89uLLDNO5JK6npOIV5dkP6vFYoETmGdw8IT1zN9LJ3MWpvKAE0N
 DcHC7qcFitmeiop7Us2U4ZaIMoepfpjwC0kxDVQSMoBht2uF2YUBP7ukhItBgrURNnx/
 DPjg==
X-Gm-Message-State: AOAM5300WCeqZSxVTusOZEcOFDj+qxmol8OdpbI4a3ABVW5rFDa1so+H
 uj6cLsAJY8224oB0yZ+VJxYvj3AA
X-Google-Smtp-Source: ABdhPJz1e+iyP5oeF2NLNfiia5QAPkhVTinWNpZs7ATzEslZOrqFFWpj7t81XolHzMqqHHmhCo/GOQ==
X-Received: by 2002:a5d:518a:: with SMTP id k10mr51088210wrv.316.1594104412217; 
 Mon, 06 Jul 2020 23:46:52 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 5sm2172545wmk.9.2020.07.06.23.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 23:46:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] target/avr: Fix SBRC/SBRS instructions
Date: Tue,  7 Jul 2020 08:46:46 +0200
Message-Id: <20200707064646.7603-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707064646.7603-1-f4bug@amsat.org>
References: <20200707064646.7603-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SBRC/SBRS instructions seem to be inverted.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index fe03e676df..2f77fe3ba7 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -1385,7 +1385,7 @@ static bool trans_SBRC(DisasContext *ctx, arg_SBRC *a)
 {
     TCGv Rr = cpu_r[a->rr];
 
-    ctx->skip_cond = TCG_COND_EQ;
+    ctx->skip_cond = TCG_COND_NE;
     ctx->skip_var0 = tcg_temp_new();
     ctx->free_skip_var0 = true;
 
@@ -1401,7 +1401,7 @@ static bool trans_SBRS(DisasContext *ctx, arg_SBRS *a)
 {
     TCGv Rr = cpu_r[a->rr];
 
-    ctx->skip_cond = TCG_COND_NE;
+    ctx->skip_cond = TCG_COND_EQ;
     ctx->skip_var0 = tcg_temp_new();
     ctx->free_skip_var0 = true;
 
-- 
2.21.3


