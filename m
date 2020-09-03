Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCBDC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D70206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuEn4HI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D70206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDt4j-0005LK-H0
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 13:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDt1x-0000p4-M9; Thu, 03 Sep 2020 13:28:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDt1w-0002VJ-7U; Thu, 03 Sep 2020 13:28:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id g4so4099168wrs.5;
 Thu, 03 Sep 2020 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6z5cEfqbH1n61y/Qo9klXj1n02roLHb+s1zVQcoUGeE=;
 b=kuEn4HI/eIiIw6lgZwTJh9saJTpX75BsdeT4+L6VGY4SQe3RxZpgLMzlc7gJQrzuzL
 TTtdmBN9rxC64ys1T1eNBs1Nk4BXYzOKx+Xv//Qswigi61/dYTSdQnpiiraggeYlnHOQ
 Be1A3udTVluN9FHg8lBTnq2+m3syyzpJI7G7K3P0SX6sB5b7a4g3Jq2oscSSwAv9OjbP
 VeGBhkkKqz+YNr0mVi1ChCilGRZyx3LGJn7H4ayNgovsMZLVDJPeGpZqlCrUfW5I7pF5
 mrXj0MEhhgGQH5SaI25xQnH80PJhvP8AzxvCqpn9rHNzDn4yyb8XkrtZLDoUC1gataQA
 78aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6z5cEfqbH1n61y/Qo9klXj1n02roLHb+s1zVQcoUGeE=;
 b=DYIqJE23wEicBn+erWMe5xfcTDVnpRugqneZgnKZb1KrUYR+YpOVuxMgKXnemfw1+6
 lz7n/QsQ3vnIHs3pmet9IyIQFMCNCMGue9vnimiupdEGkhE/jKNyPSKxMKBcRBwjspIF
 yjS70BMDT6ttJ+5mElGEPxFGlfQdtN5ZAHBMamlplId6vAr6kGlb1qxBA0dMD2WxxPcO
 q40Oss1g48uXXVihTHIhyURN9egLv487yk7Hn/8s0JuNgTmWfRGg4DnbMg0Db+LO9Mjj
 K3dkrqQQJ4q+tBk8Y8e0vPYHTNsiFGnRcTvVP0C2kZrzBzoz+/zhyxuQpfKvKhQmV+C0
 Ymjg==
X-Gm-Message-State: AOAM5336vwsFDs0EDHuv/YGaYW/bxt//HnjLll87Qo8SQec0IyF+FhZp
 JfilHnMKfElds75mi/Xty3zl6O3zpPc=
X-Google-Smtp-Source: ABdhPJycnzJCMF2kKhUHA9SdcOcbX2YQ6t4o4KVerMLwf+yB6rVQqE/z83B81PS9yilMH8MY8n/q5w==
X-Received: by 2002:a5d:61c2:: with SMTP id q2mr3849942wrv.25.1599154090147;
 Thu, 03 Sep 2020 10:28:10 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id b2sm5325802wmh.47.2020.09.03.10.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 10:28:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/sd/sdhci: Stop multiple transfers when block count is
 cleared
Date: Thu,  3 Sep 2020 19:28:03 +0200
Message-Id: <20200903172806.489710-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903172806.489710-1-f4bug@amsat.org>
References: <20200903172806.489710-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 Ruhr-University <bugs-syssec@rub.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clearing BlockCount stops multiple transfers.

See "SD Host Controller Simplified Specification Version 2.00":

- 2.2.3. Block Count Register (Offset 006h)
- Table 2-8 : Determination of Transfer Type

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ecbf84e9d3f..703357e94a7 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -728,6 +728,12 @@ static void sdhci_do_adma(SDHCIState *s)
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
 
@@ -753,7 +759,6 @@ static void sdhci_do_adma(SDHCIState *s)
 
         switch (dscr.attr & SDHC_ADMA_ATTR_ACT_MASK) {
         case SDHC_ADMA_ATTR_ACT_TRAN:  /* data transfer */
-
             if (s->trnmod & SDHC_TRNS_READ) {
                 while (length) {
                     if (s->data_count == 0) {
-- 
2.26.2


