Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2963CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30032065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8rt/9YY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30032065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEkr-0003I5-0y
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcv-0007il-TF
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:21 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b]:37004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcu-0003nq-VR
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:21 -0400
Received: by mail-lf1-x12b.google.com with SMTP id 8so2785383lfp.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cdqb6YfEnUEOZ9+1iE9YYK31lx3pNnIUCeb18hsJxJs=;
 b=e8rt/9YY/PiTZBRxClnOBelZoDeKUflQn/FM+2u7lhwn4vTAJcoqC2gROKM+PvBxLI
 cszU/9/iErG54X15q//gmh4EvtS5Hw4EeuV7Z5BOZa+NmSRxEOdDstPo7t+Y2l+HJZ1v
 3VdwfkjaMh6uHzieUg9qzxx5l7lCe1jn5dfR2ge4Lp9zjwYtqiX4abfY8S8Z0fHJo3TY
 VXn69BEJRLcUla9gu+aDDICS5hvlLYPPB0O8+whtSP622FSACTT5NiFUS4TyOFtJeT/n
 PzxxOIm8xIZ/54tmFHg2GI9y9hcIX6b9/8hEzSv0+NytITlwwLSSvdp9rZI/a3hFJsrG
 kobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cdqb6YfEnUEOZ9+1iE9YYK31lx3pNnIUCeb18hsJxJs=;
 b=nDS/dJjUkTbWf8WhkKpBr7boW9e/Y/4vhde0vGIXucVBVUJeYWq5V+v8aas4oJTLs7
 5lGku0h+PdY6Czl8QItLL987Oj/R1fNOTzTVsYllRHE1g07KAyXZj1GcyQGyu1yd91lB
 OJf5FPAkJ5up0sS9O9MCENgYz+4UYfo/MGKcqfsud5HHlxDkyg+WKC+orEqXHtXpbW4f
 jtkYRoa9ojBEgt5BYQ2PImu/ljMWUbv+7S0cBg9aR/xmY4F2bWsBqIzP3QnRBLc5MvJA
 FYMVLu3cvZPs7VuI06BdQYyXTelxe+qqIOhs0a6lhP6+mqrSoEUJur7Lg79elKHxEKtH
 td8g==
X-Gm-Message-State: AOAM532jOKz3ebrXSu4TBA08OebKuR1pLLnxnXjGJxoJ1Euax1yvsyba
 QdmGgUzUpt60uD/iIfkyMYqyhsGuSs0=
X-Google-Smtp-Source: ABdhPJwOedG4C5dNUh6HlP0ISJXczYVAmAnAz2CnIiq8H9JKQ8CHZO3ryT9cqSau7iYsBtsk42h6Vw==
X-Received: by 2002:ac2:558e:: with SMTP id v14mr3507672lfg.138.1589465659126; 
 Thu, 14 May 2020 07:14:19 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 26sm1619235ljp.22.2020.05.14.07.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:18 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 11/14] target/microblaze: Fix FPU2 instruction check
Date: Thu, 14 May 2020 16:13:59 +0200
Message-Id: <20200514141402.12498-12-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joe Komlodi <joe.komlodi@xilinx.com>

The check to see if we can use FPU2 instructions would return 0 if
cfg.use_fpu == 2, rather than returning the PVR2_USE_FPU2_MASK.

This would cause all FPU2 instructions (fsqrt, flt, fint) to not be used.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <1589219346-106769-2-git-send-email-komlodi@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 92b3630804..8079724f32 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1392,7 +1392,7 @@ static int dec_check_fpuv2(DisasContext *dc)
         tcg_gen_movi_i64(cpu_SR[SR_ESR], ESR_EC_FPU);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
-    return (dc->cpu->cfg.use_fpu == 2) ? 0 : PVR2_USE_FPU2_MASK;
+    return (dc->cpu->cfg.use_fpu == 2) ? PVR2_USE_FPU2_MASK : 0;
 }
 
 static void dec_fpu(DisasContext *dc)
-- 
2.20.1


