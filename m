Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C858C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B75B206E9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/vESHtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B75B206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshdV-0001Iy-Fc
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshai-00066i-NX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshah-0002ef-2L
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id o11so43978385wrv.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=45gqo128NQDtIYcxM1tYqwMqbUrJDll0ND7eZVJPFlA=;
 b=s/vESHtA/E+Lp4gI5IxOHzz4B17ntJwloQS/a1hgz7Wd7XmBusi463fP90FtEo2rFE
 lxVZrweP/+zQ67D3gSsgWEzD+adacl5CiGTBGZZCsYVrg0JZttxJN9ebcxROueOVKXE9
 wPLuAar4jc3R0qXyFhu+S115nyB5KbcgtvSgkfvXN3We3E1Owv0WCyIh4HT+haVoQYbL
 R5ZQToheGyXq3vRxafXSJFhCfUDcGGBwFCWW6kU4YcyjhjZs6wv1R82dJzTsQx4/PMhd
 Nbx9KBzLl70DHLKFMff0uwLMHlrzkJQH9C4JMWRm34dk5XanmNPlmCs/ifA92QwlwLRX
 WQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=45gqo128NQDtIYcxM1tYqwMqbUrJDll0ND7eZVJPFlA=;
 b=j46fgk0kMNkVyvKeNkFHLcSUFnKMEjuNVcWyA54mxV2fDlWL7XQIFdpu6orebDyJyO
 OsTEnR/tjlrJnWMZz7M5BZ2Cm/zmkQFlGyYXZf+33UugsBhZABPqQKce8fab2Ed2FOtz
 jdyJEsOj3zKTBvvjPyIytJx9clB88W7G9vgp6MVrOLMKfuDOV11HcOMReGilV6HAIbPl
 ezwYHRWyncFq4hzlVm6JxcqmUNDQ7dOFZWMiHcZ4sHjX6B11SBcRwMrSMbJVpTL39OTo
 cTGve9jyD90aUpMfCMAIdqG4KcyC5mFO3+kgEtAv4ZLSozI6h2ojIQnQPwr8rswLrY5P
 7rbA==
X-Gm-Message-State: AOAM532l7ht3hjq0qpyUzwI1XQRXamfRL5Kwv8LY2cIrRWjApzfgYhFh
 8AL7CxEwF+eTHmTRXhxNzh4p0xQU
X-Google-Smtp-Source: ABdhPJyXA7YPh2gl8el151cF4s7uObplwwGfgZ2f+0Tw+bCWP/PurkPeL0dkN3vPSTgoNq2Gb+ab1Q==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr51197461wrs.84.1594105229575; 
 Tue, 07 Jul 2020 00:00:29 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id r3sm30763634wrg.70.2020.07.07.00.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:00:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 4/4] target/avr/translate: Fix SBRC/SBRS instructions
Date: Tue,  7 Jul 2020 09:00:21 +0200
Message-Id: <20200707070021.10031-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707070021.10031-1-f4bug@amsat.org>
References: <20200707070021.10031-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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


