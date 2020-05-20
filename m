Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC46C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C348205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiEUvca4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C348205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPn4-0002y2-Og
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.mikitas@gmail.com>)
 id 1jbPmU-0002Rf-67; Wed, 20 May 2020 10:33:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <e.mikitas@gmail.com>)
 id 1jbPmT-0008Pl-Dk; Wed, 20 May 2020 10:33:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id z72so3115383wmc.2;
 Wed, 20 May 2020 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=PXxBZetuYeBOwMYKyQFovUtIjAoxzqAocsmZ8HOO5i8=;
 b=uiEUvca4nZ5Oqzkf8wtGDcHrGU9jK9S5S3JHLngZBQJhNJ/kjcXVcWw2Q41l9RGTU+
 vn8fe9A6MzL9Q7w4Dhq+IQfJSRAqIGSysD7dRDkZzaEUxJKJcrjAKNNivH6XAV8X3bVi
 JL0WjNJI89M25S6S4pm6HQyvFr5G7p1QQXseQnklj9KdLsI9nWRZuLTP90kT65WTUz9R
 qSX4IIxr2lkPsvEs3p49Xc3f2DixbVbm+yuMYUVvzTGZ7DPTbCMABHDIJNOQuDHhvzWJ
 DIyQm9ik4T51I0Tz++H8OIyVBJtv8etu8Cxc5cNhtKCJ2QRG05h7mP1HV5qCCuC1yayZ
 dS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=PXxBZetuYeBOwMYKyQFovUtIjAoxzqAocsmZ8HOO5i8=;
 b=NhWqu2l1ETeU3UXBhoWgzWcG6rCDHxvOFsFDE4EN1Rk71aYHlNoobaVsOxwjaflc33
 hClg9RHAcWtT8tblMhRr+8NQF5/Oh1ktV8tr54mUgHLT4pYik+Jzo+cJ1V8ZgPpqKg/Y
 E92Y0ZARAluW68E6GZOzonNoNa4DPUld/NLpC/ZK+hSrEGalEFFO5q4CttIn3Q33UaeC
 RvC8kJ31Gn8+KdycSA7CTCZC2qcnvaRgn5SlPrS5YeK+pWfN3LEWCvVKBLaXzyE0H5Z7
 W7zLNEd7G9ECJytj3Qg6gyTBSh3RV0hZ7oZSvw355n2NVxbHIjI7Go1XpD6k0ZrHR1mj
 a/VQ==
X-Gm-Message-State: AOAM532lMt4Z3/KlLnN8CLYiQbeiYuq3grJz4caao3S4zttA6VqPS65E
 iJkQFJufQtmPZ3C4eP599MdUU4PSu5pxiQ==
X-Google-Smtp-Source: ABdhPJzTM2+VJbjJbYCth9jRCn3+Dojkh6SZC2R4GLztmApigLcmkkrR67gcVxqW1g/iv5HX7acs0A==
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr4689213wmh.157.1589985190334; 
 Wed, 20 May 2020 07:33:10 -0700 (PDT)
Received: from eden-linux.lan (bzq-109-66-59-205.red.bezeqint.net.
 [109.66.59.205])
 by smtp.gmail.com with ESMTPSA id l18sm3180072wmj.22.2020.05.20.07.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:33:09 -0700 (PDT)
From: Eden Mikitas <e.mikitas@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ssi/imx_spi: Removed unnecessary cast and fixed condition in
 while statement
Date: Wed, 20 May 2020 17:32:55 +0300
Message-Id: <20200520143255.27235-1-e.mikitas@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=e.mikitas@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 "open list:i.MX31 kzm" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Eden Mikitas <e.mikitas@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When inserting the value retrieved (rx) from the spi slave, rx is pushed to
rx_fifo after being cast to uint8_t. rx_fifo is a fifo32, and the rx
register the driver uses is also 32 bit. This zeroes the 24 most
significant bits of rx. This proved problematic with devices that expect to
use the whole 32 bits of the rx register.
I tested this change by running `make check` and by booting linux on
sabrelite (which uses an spi flash device).

Signed-off-by: Eden Mikitas <e.mikitas@gmail.com>
---
 hw/ssi/imx_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 2dd9a631e1..43b2f14dd2 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -182,7 +182,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
 
         rx = 0;
 
-        while (tx_burst) {
+        while (tx_burst > 0) {
             uint8_t byte = tx & 0xff;
 
             DPRINTF("writing 0x%02x\n", (uint32_t)byte);
@@ -206,7 +206,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
         if (fifo32_is_full(&s->rx_fifo)) {
             s->regs[ECSPI_STATREG] |= ECSPI_STATREG_RO;
         } else {
-            fifo32_push(&s->rx_fifo, (uint8_t)rx);
+            fifo32_push(&s->rx_fifo, rx);
         }
 
         if (s->burst_length <= 0) {
-- 
2.17.1


