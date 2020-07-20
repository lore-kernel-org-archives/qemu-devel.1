Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1A520709
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4RTsxLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1A520709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZvx-0006VX-KN
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxZuq-0005CX-KT; Mon, 20 Jul 2020 13:49:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxZup-0007CJ-5K; Mon, 20 Jul 2020 13:49:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id f18so352937wml.3;
 Mon, 20 Jul 2020 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AJn3EPMi5risgGeTitpR29/MpANRfQ+7uGn+a0i6Wus=;
 b=Q4RTsxLN6g0PDldAw7wr5DsTEVWvSL0nKJfQR9YaShBb+pcOBGCF8P947cruP3TKp6
 WpVTKsjeG4ENa5chLgqwP6WGPjMkvirEdPaFNKbwm2h/0ipYqOpoeoZOA7e4ThFeof9c
 +2IMQd4FilhQKr8LpnYeDcbmoRnt0S057dRSX8ocuZ6PaMEdl9sIpieg/iqoDqnn4K4v
 KU2UX84+mV3MeyaaX/iFVqt6HR2URjQy431GUnaAYgVRxBLjnnIkPfPNl64Ms05RS3x0
 v8pzT1IbTYhejZiT+gPK/bNajYLZpitmSgAIMdDfszuPwNnt2A1zKxEJZnrRegZf+YNQ
 wB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=AJn3EPMi5risgGeTitpR29/MpANRfQ+7uGn+a0i6Wus=;
 b=tbFKEOBuDrSLq5Xf6TnV9Txt99JWsktDVgMaBUN5ooPNLjIRP+H5/1bJiKfUeFZOGw
 fVMSKiD+sxDikfSgNUNHS2gTUMq5M36kVx9S12ZRi4Hxtb4C+87lMxYhLZzqef2R6nIg
 NYp0DUd0wOve/dlkj0TQeAaXN3EypR4GBGLkwjleblNrQg/B7ZTRjbnXd9RKFqkYN2y1
 maku0EZNN7zU6Thbdk35fCEYKX4h9jgz2xsu5uqa/t1e7UEHdPbql5V9zaIgk5tLn+Mx
 jd3N+IX6RNJH/U4QBMHkAt3wWViy+m8I77h608M2B4cY+BfXcnpxV6xVdxoUjksYrnh8
 CJJw==
X-Gm-Message-State: AOAM531Y+t4tDLgMUQzfjcw7aKd//EVmdb4R+r1EqjD8tOkGBqb2Aln6
 4sg9uyk4+xb1/rUjb7ucp6SQBoqEQO0=
X-Google-Smtp-Source: ABdhPJzkQfBPXvhxzeQ4hsl2516LL3cvxqkiDlnPrz2HOPs7lueicNRnm3l29GxfVeY49PMb/EhSvg==
X-Received: by 2002:a1c:3245:: with SMTP id y66mr420514wmy.64.1595267364821;
 Mon, 20 Jul 2020 10:49:24 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id z8sm271183wmg.39.2020.07.20.10.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 10:49:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2] hw/misc/aspeed_sdmc: Fix incorrect memory size
Date: Mon, 20 Jul 2020 19:49:22 +0200
Message-Id: <20200720174922.16303-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SDRAM Memory Controller has a 32-bit address bus, thus
supports up to 4 GiB of DRAM. There is a signed to unsigned
conversion error with the AST2600 maximum memory size:

  (uint64_t)(2048 << 20) = (uint64_t)(-2147483648)
                         = 0xffffffff40000000
                         = 16 EiB - 2 GiB

Fix by using the IEC suffixes which are usually safer, and add
an assertion check to verify the memory is valid. This would have
catched this bug:

  $ qemu-system-arm -M ast2600-evb
  qemu-system-arm: hw/misc/aspeed_sdmc.c:258: aspeed_sdmc_realize: Assertion `asc->max_ram_size < 4 * GiB' failed.
  Aborted (core dumped)

Fixes: 1550d72679 ("aspeed/sdmc: Add AST2600 support")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Assert (Cédric)
---
 hw/misc/aspeed_sdmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0737d8de81..855848b7d2 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -255,6 +255,7 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
     AspeedSDMCState *s = ASPEED_SDMC(dev);
     AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
+    assert(asc->max_ram_size < 4 * GiB); /* 32-bit address bus */
     s->max_ram_size = asc->max_ram_size;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
@@ -341,7 +342,7 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2400 SDRAM Memory Controller";
-    asc->max_ram_size = 512 << 20;
+    asc->max_ram_size = 512 * MiB;
     asc->compute_conf = aspeed_2400_sdmc_compute_conf;
     asc->write = aspeed_2400_sdmc_write;
     asc->valid_ram_sizes = aspeed_2400_ram_sizes;
@@ -408,7 +409,7 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2500 SDRAM Memory Controller";
-    asc->max_ram_size = 1024 << 20;
+    asc->max_ram_size = 1 * GiB;
     asc->compute_conf = aspeed_2500_sdmc_compute_conf;
     asc->write = aspeed_2500_sdmc_write;
     asc->valid_ram_sizes = aspeed_2500_ram_sizes;
@@ -485,7 +486,7 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2600 SDRAM Memory Controller";
-    asc->max_ram_size = 2048 << 20;
+    asc->max_ram_size = 2 * GiB;
     asc->compute_conf = aspeed_2600_sdmc_compute_conf;
     asc->write = aspeed_2600_sdmc_write;
     asc->valid_ram_sizes = aspeed_2600_ram_sizes;
-- 
2.21.3


