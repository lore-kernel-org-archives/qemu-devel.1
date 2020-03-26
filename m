Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B6FC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA17206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrTs5KSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA17206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYlx-0000DK-FH
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKw-0007SD-3O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKu-0001yn-VZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:41 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:38435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKu-0001yT-RS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:40 -0400
Received: by mail-qk1-x742.google.com with SMTP id h14so8191082qke.5
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oS4OFCHOXLNPVShms1TjWbnrC15wr+ouKwB5TcDXaeE=;
 b=BrTs5KSfDqJse3PHhVXCvaWh8fmqrKi7jif0EFXt8t06jcgtflX/qboikphU0kQmXP
 1AKni0uOnBCkDlwBa3Y1XeH2nwSHAET9wEbQpHE4SMUMiXg5ndbeWtEkvJjq6GYYzO/W
 ktbnpekNRF6N1wX3x7fl5PNj/ekLwh5qpVma5CEKQBpqiIiBTK4jclg/sLHHbohfIejU
 8aHK78tUfUktdyVLAuxPCsdqjjd3ko/f6Vkq6OQEGGMuZvcqN9akmDEMOsaJYrDjGNuF
 d36FnLZk5xBtOqnY1q7mEIiiw20Hw3JJiAHx/6mxEJ/aG7Qwz/TxFIz8tkffRVjepJu8
 NZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oS4OFCHOXLNPVShms1TjWbnrC15wr+ouKwB5TcDXaeE=;
 b=oyBHP+YGY0+WyLQQlY6evQkg/HWXiG53BvhGKpdy6IbajeVLDeTdgH5xkQ3OHVLdfm
 NQn1AJXNmLnN9PDvP2chfvXjagDFB8ToZbWKGR1XO3dSpoEeatqs5xHn3SacE0ts8p5E
 Yu+xRVhF4XvjhR9dtd9Gl9HhDd/TrFTGfloFSyeBkChK7Sp8kmcy2dg4xGZN3URxJhGx
 oDlKYAF4mp4GVNfMQtC0PBfNn63iBJWG/M+K8/S1N0vdM20KFP2Tkzu/k7BifYXBZoRU
 3d56Zforg1hy79l9ob43pDJ5hkakTBP80NLELvao+7TXLwuS27fSC6Sjp5RWpaa5/J+k
 4EUA==
X-Gm-Message-State: ANhLgQ2mOZH84kh4gkeVgOYcMuC5CT4iFLO7FVe3GTxnIKX3AfTf31mj
 45IiJagw6k4Y9h/v4vxI6XHJian3jA/65A==
X-Google-Smtp-Source: ADFU+vvjgOz5JsPeO63+lwGqmmBJYix8aHKH6qnRLIFpmt0lwGYk+hwbrqxGAfJKjMLdWTOEnOZRVw==
X-Received: by 2002:a37:741:: with SMTP id 62mr9728414qkh.422.1585251519725;
 Thu, 26 Mar 2020 12:38:39 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 48/74] hppa: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:30 -0400
Message-Id: <20200326193156.4322-49-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 71b6aca45d..287055f96e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -61,7 +61,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
 
 static bool hppa_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
-- 
2.17.1


