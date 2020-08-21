Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB7C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3F220FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItaX6zxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3F220FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Asp-0003t8-Fc
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar0-0000zD-5G; Fri, 21 Aug 2020 13:29:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Aqy-00019C-Kx; Fri, 21 Aug 2020 13:29:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id 88so2660981wrh.3;
 Fri, 21 Aug 2020 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xUpjhtTxpzUTDOloVL0txBsx/e4JrhuPXdmZU+sQCYU=;
 b=ItaX6zxwiYGbYVQZh+rDu7WGLAUUqU648AnuWIat1pItXko/TB3zJtO45hVTbMqeD8
 C36idWBjhnKjLkct9P/sxhdZxPbBPnJCThFY41Q0GeQyvFbtYW1Cy4xG5yjE7csP8NST
 B73KWwgGWwyL2JwLXTMEoyecCd8o0Qc26QHFdXZ1opJuEMdY2RtSG3V7aYYisXhCPFA5
 FuAViNbuEynGO2QTT2AtE844XlHgqLY30t1vl/2KBQzA3jUKrYlKnirx3/JlnATTcCWB
 JgbSNpGSnMavorjHg9TOeu8a0V5pGqOjFEnWOoVwS9vTRXmMu3Fz1mzUOjTsKX3aaoZ7
 SuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xUpjhtTxpzUTDOloVL0txBsx/e4JrhuPXdmZU+sQCYU=;
 b=r6Q1zvJ0n12hwWiBHu4T2lHwRPKr8LyzN+rMPoJDNuT7y8DBCGOYczYJUup5PvUG+g
 jdA1RD3qRQIoVnK7LbciRa973Cenp3vWvx6HTGpeWttaRfVnlxKTz5sYXD9sszi7hGsU
 Vv/w5qwjjeRI5mJg75hi1KxDWfKPocfMJ8Dt03hCs5KSj0JDlDtt2jDZ6JKq8zA2bdBa
 YdYVNru7jTXMe7CQtEDq7gXSwz6Z7Dgp4ftjdh6ZuPVIeGMVGjNdh/HCCOyQ/3BUjiTv
 geJU/YQ3nXxBL7mJV9B70T9qgMStnwfJ4OJYw/AUhp1MxYztwuShvzHACVepzwr/NCnx
 Xp+g==
X-Gm-Message-State: AOAM532JRJMN88mwukrHJsbt113PJQtSYlzlleZu0EC/yoxZlwFgqfNw
 D38sOqM4Kdy2yS4XcNslQrbKJBEIwTg=
X-Google-Smtp-Source: ABdhPJzMzy4VWt6szX+Hhwqj5xqFQEB7hSgYPD3BQiIeWy/mPcHKzVZHbU80nfp3sq8gC8doIqezYQ==
X-Received: by 2002:adf:90d1:: with SMTP id i75mr3489277wri.278.1598030962138; 
 Fri, 21 Aug 2020 10:29:22 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/23] hw/sd/pxa2xx_mmci: Trivial simplification
Date: Fri, 21 Aug 2020 19:28:55 +0200
Message-Id: <20200821172916.1260954-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Laurent Vivier <laurent@vivier.eu>, Beniamino Galvani <b.galvani@gmail.com>,
 Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid declaring PXA2xxMMCIState local variable, return it directly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200705213350.24725-3-f4bug@amsat.org>
---
 hw/sd/pxa2xx_mmci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 9482b9212dd..2996a2ef177 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -480,10 +480,8 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
 {
     DeviceState *dev;
     SysBusDevice *sbd;
-    PXA2xxMMCIState *s;
 
     dev = qdev_new(TYPE_PXA2XX_MMCI);
-    s = PXA2XX_MMCI(dev);
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sbd, 0, base);
     sysbus_connect_irq(sbd, 0, irq);
@@ -491,7 +489,7 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
     qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
     sysbus_realize_and_unref(sbd, &error_fatal);
 
-    return s;
+    return PXA2XX_MMCI(dev);
 }
 
 static void pxa2xx_mmci_set_inserted(DeviceState *dev, bool inserted)
-- 
2.26.2


