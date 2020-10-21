Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F4CC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD67E2224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfGUQlnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD67E2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVI7c-0000dp-Pz
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI14-00035y-7u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI12-00064a-So
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id e2so3471181wme.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qenmuCcnJ1D62WnJyuSqdVB8Tn5y6BCbZljNKEVfJGQ=;
 b=jfGUQlnEjIHR8AoZTx+A5arMjqBjO1NEUwl7ZOOotDGbIAoakyVz/IRSAjVTIam89A
 SP7ihZ7r4XTXJn4bZehNFVG3loQlfMRrE41PHzrF79xmmoZUdXUZcz0vMnyTNhFxVK2D
 12izHK73q7xFqaBiN0VIWIkNQuFMD9ileL52I0kvtAgymROxPBLie39iA+ehu3ig54LO
 AmbqpAasvPAYb1/H/PCINvpW6lHSLbWz8sLpgKni0HV/TK90iRA5eS2GBGHJxpwXOHgj
 gR7x9aV/96BuM/RlE6lFz2wV5ZfpNJRJCGstSiaOMpRyOb/ug5H96n2I/H/Uz3Uw+CF0
 A6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qenmuCcnJ1D62WnJyuSqdVB8Tn5y6BCbZljNKEVfJGQ=;
 b=YPZqxRz+ErJdjY/sBN2PaMhmjbdK2h/X6ZHWbCg1DboHH56WG1NYeUry16qjtNG/VT
 QfrhCQU2PHpu29k21L+BNp+XIwaYtCtvtoIlC95r3V37cpMVvpCxVHiYqU4RA/lT5Fgk
 indW32+m3Je4HIVSpegco/a5wXmCybpq1BodE1XINyaqb2XxkKjSWrnzljaWv8IbckYn
 khDhcSeQScaUlGBDQ3OXXLlntG+z2qlVAoGx4KngQ3T+PAUiO5LjoFbyFJA4iocS52is
 YS3V5Rd73pn+DfNXuvlSBi6Yrlr2oB+v3vV9iRIcEe4m5KQh2KlMlMNpQmEiGAD/j8nL
 g41w==
X-Gm-Message-State: AOAM533PZVAmB5cRs9V//Ud55A4Hz6sv+48Lqs28Bz/H9Nc8kTeVcbQF
 KZp059q6ihchIeJmkQbGeXH819wdmSk=
X-Google-Smtp-Source: ABdhPJxS5ezFrvPd0MHkWnh8QXM41bcr50V0Qz4hiz21TfvGE4xSkp4NZl5kFe+Gr38JitOK2YANAg==
X-Received: by 2002:a1c:8057:: with SMTP id b84mr4679185wmd.116.1603301711436; 
 Wed, 21 Oct 2020 10:35:11 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s2sm4900028wmf.45.2020.10.21.10.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/13] hw/sd/sdhci: Stop multiple transfers when block count is
 cleared
Date: Wed, 21 Oct 2020 19:34:41 +0200
Message-Id: <20201021173450.2616910-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clearing BlockCount stops multiple transfers.

See "SD Host Controller Simplified Specification Version 2.00":

- 2.2.3. Block Count Register (Offset 006h)
- Table 2-8 : Determination of Transfer Type

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200903172806.489710-2-f4bug@amsat.org>
---
 hw/sd/sdhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c849c3d99b8..61e469bd32f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -731,6 +731,12 @@ static void sdhci_do_adma(SDHCIState *s)
     ADMADescr dscr = {};
     int i;
 
+    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN && !s->blkcnt) {
+        /* Stop Multiple Transfer */
+        sdhci_end_transfer(s);
+        return;
+    }
+
     for (i = 0; i < SDHC_ADMA_DESCS_PER_DELAY; ++i) {
         s->admaerr &= ~SDHC_ADMAERR_LENGTH_MISMATCH;
 
@@ -756,7 +762,6 @@ static void sdhci_do_adma(SDHCIState *s)
 
         switch (dscr.attr & SDHC_ADMA_ATTR_ACT_MASK) {
         case SDHC_ADMA_ATTR_ACT_TRAN:  /* data transfer */
-
             if (s->trnmod & SDHC_TRNS_READ) {
                 while (length) {
                     if (s->data_count == 0) {
-- 
2.26.2


