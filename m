Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEE9C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88336206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RL5YB2oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88336206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAhH-0004lY-Q6
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAae-0000fM-Jq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAad-0003l1-J8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAad-0003dA-BP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id y2so9714272wrn.11
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ua1+sx+ArThYkjHUd6R8UKXnZNXGP9jD04wMaayZK/g=;
 b=RL5YB2oG3iArlwHLksWx2nyZPiRFTp2VvJLygY4em9a9szirrPcXmfjykmXYR8Ocrz
 qAm+oVzdnDmtp5BKl7d9266Dl0goENy0DC8oQSuAZZMwAwM6ggA0jr2Bdlat399Q9SMj
 Bu5+Kk+fJO/HcZH7O8qqlCw1NocrggcEXFA6EL+6QOw3zWMZqQo6ZyR8jQgEnnmoFNjB
 JML39hu5fXsBRSrH7PWbkVv5dUMM49F5rgzPSgE/p6FpG4+xCrArEMmF4+85odtLUdxy
 Yt3WvV4hC0NJUXKg7TZ/mN+ks3kOKBdAoAajjQWpt67sOtVs8qPXbnyJ4cj7EAOBlZW9
 HXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ua1+sx+ArThYkjHUd6R8UKXnZNXGP9jD04wMaayZK/g=;
 b=M4MtIZCKY9dQuRA4fcgu8jwziMB4iTZnv5b2/SeStfZ7e4iyAq1Hh9Yp0Vxt/eXgrr
 OGK8GV9Q2KtiLgIncTxrpeTh02Nwjgxg4p5oYJ9+c3Q2RFTPMGcq88N1myXWtaPp+2M4
 TimP0+flr2b4cKAMsMIpw53taG2PqMUmO4gEqC8KTayhzRFyDYpsBisVfgRA1iI32unY
 b0R0mHLVTxs2/pcVM+j6XATyYNZyA8W90b47zw/PcBtQyeEnRbssxTtOlykmE+FtP7mH
 DGvExW381Jv5Mvc7L4H6FY5P6ZpwecDDbFD+iLQVpTOpS9zDgDnczpp3znDikRG4ph9t
 ZLDQ==
X-Gm-Message-State: ANhLgQ3erLoDkB/HJSJKRhQ1lDsB62GOlhZInRBNnxmNGX6Vk9KckIfa
 qOxtHP8mz5KtdJr+5ewW643chg7vgwaKuA==
X-Google-Smtp-Source: ADFU+vsDgqItHnRVMDxy1toPka4x8136yMjRoUaxSSOYOZsDUyMa4RX/H4XtwgCNGHeJatmLUf9e6g==
X-Received: by 2002:adf:e883:: with SMTP id d3mr5548209wrm.75.1584445254011;
 Tue, 17 Mar 2020 04:40:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] hw/arm/pxa2xx: Do not wire up OHCI for PXA255
Date: Tue, 17 Mar 2020 11:40:39 +0000
Message-Id: <20200317114039.26914-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
References: <20200317114039.26914-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

PXA255 does not support a USB OHCI controller, so don't wire it up.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200313160215.28155-1-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 56a36202d71..336c9bad4ae 100644
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
2.20.1


