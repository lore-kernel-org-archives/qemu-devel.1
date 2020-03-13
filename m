Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93844C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3A8206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ5TWoYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3A8206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmmb-0002OF-Jj
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jCmlT-0000zP-BH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jCmlS-00063l-BB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:02:23 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jCmlP-0005wy-W9; Fri, 13 Mar 2020 12:02:20 -0400
Received: by mail-pl1-x642.google.com with SMTP id h11so4447645plk.7;
 Fri, 13 Mar 2020 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=Rs/WyUa4shVeykflJcx6r7b0O7PZIErgGyGsCIM5V1U=;
 b=iJ5TWoYhH1awB5nB1GilLXL1qCed5ev+icGDCcAXU4pyeTD27gN2S/MCxwLCCtyYHo
 bpzcD8p60DAxyYHnN7iUKl/hIrcjmLuckTu0waNXueS6O7u1QccQpmRmgBPR3KCpRunT
 2KGyJ5pdCjTKVDThiOSJVcOvZ6FtB1ojZoVlie7KJN9a9PTfzE0/SmQyKXvdGhJB+SIC
 seom/jcSUQ3EB4Nco8MhDmwxqH3Qzd5h31XkQ6p86Y61KzJCc5g2olDUsFzejChwF1EL
 k4XnA0A33wf1SkZdXRTSGFGGhYZLBbfQ8PhWfLRrx9eIStFRGGT5u7WNMIyqdvmiK2hz
 Xqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=Rs/WyUa4shVeykflJcx6r7b0O7PZIErgGyGsCIM5V1U=;
 b=XU9umjfKj9p0Y259XWmbPswjqo1F9BmDcA/V4GbeV7psKiJCRYRAU2WbaVxMnWR+sq
 rxcStSOTr1J/ubcFBoTdBsv90yDFIvL7L/Tdt1BedpxOQYvXCgwdXaUe/pw3oRNWTS+Z
 bQdcIHqWZizV41vV7SbgovVmIFnf6RuptPeA81l6nzKHsUQD+ZIUOYdxVYZWuiAzDLF1
 5+qKeNAX8aX25Gdjl2BUDlPBvq31nLtEXjohWpzoO7RErRYtQji9IknF8xOiAKLuMaEK
 Xzu0w5+QRCMTcSpo9Mr6X3oH44qXKxWtb+0Y54AD11/7UBdyiOyFsyZLeEtLWGzHtck9
 T9TQ==
X-Gm-Message-State: ANhLgQ1Wl/AXjp3tQi8bq9RKSpI/2/sVY1MOquqiN9PHfvfu238fxDCr
 q4ZI9O1hy149EDB62VQ/81I=
X-Google-Smtp-Source: ADFU+vsRZymV/eAFl93hVS0kwHbJN2/pubindcPBtLbRQ149u4i9eRDxTGBJ9+Snx62664RxggJEqA==
X-Received: by 2002:a17:90a:fa95:: with SMTP id
 cu21mr6616849pjb.82.1584115338667; 
 Fri, 13 Mar 2020 09:02:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a24sm9139466pfl.115.2020.03.13.09.02.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 13 Mar 2020 09:02:17 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/arm/pxa2xx: Do not wire up OHCI for PXA255
Date: Fri, 13 Mar 2020 09:02:15 -0700
Message-Id: <20200313160215.28155-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PXA255 does not support a USB OHCI controller, so don't wire it up.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/pxa2xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 56a36202d7..336c9bad4a 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2290,9 +2290,6 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
         s->ssp[i] = (SSIBus *)qdev_get_child_bus(dev, "ssi");
     }
 
-    sysbus_create_simple("sysbus-ohci", 0x4c000000,
-                         qdev_get_gpio_in(s->pic, PXA2XX_PIC_USBH1));
-
     s->pcmcia[0] = pxa2xx_pcmcia_init(address_space, 0x20000000);
     s->pcmcia[1] = pxa2xx_pcmcia_init(address_space, 0x30000000);
 
-- 
2.17.1


