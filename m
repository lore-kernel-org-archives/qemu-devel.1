Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183D7C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4196222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9VHCzIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4196222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXit-0006Nw-4q
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg7-0004GX-SD
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg6-0002mV-86
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg6-0002jG-1C; Thu, 26 Sep 2019 13:35:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so3704914wru.7;
 Thu, 26 Sep 2019 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a931Z/K+dPRWtr6SANaGNktnywcwvFCOBlZIozS8msg=;
 b=g9VHCzIws7nmj6xArq9oUSTb1ZFb+ahO/PKqn96e+QRLH8jY1Wjm8isgqIFM9FPenA
 F0hdbjGJxaq4pfLdUPIbLxClAzwUVpIhKzUWFRjmNwsIuLkghx2gvwZign8Xn3Wc0GgA
 y0mFKGk3QAp1UMQgvf+AfwcIOGbPfKXMFG++9NCokskzotWwRXHsAriJt0gjpSo74JKq
 2zMBIzw79NuirWhAoQ7bGYXpZcD35uvyrUUXi9IVfVnwP8wsbQroCYS59wBip0E+wofK
 LRZlWCWz5S4bTEHi8e8rbwH6sdJn+upMXEFdMxwDjpqU1zdiaxep59/AODuBAdyhYfLz
 hECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=a931Z/K+dPRWtr6SANaGNktnywcwvFCOBlZIozS8msg=;
 b=I9RWhPFfiWpNmTHoeTw2/b0/F+g9h1YJUhxtgbZfs3kmNiut4jxgqROOgu9N9D0wMd
 Q5isHZBmTGm1eVmImOY2QmJ6AXasmBiMkzZMhQ7ynhyjC1jdwhrNcT2a1wDhwPcPu6Ve
 NAi/XAI8IZxRCadSoOe3QNmSAm3TYQc+FriSsWKP4Tl6z57J5FcUl5kNJ6KsSAL+ttJC
 bbed6v2MDWD3UsGssVsJ6oeX2Jnv2EB3U3WnM0A0UKM7xbFUv3DdiSfExI2piOR8b5+f
 28rLUY5pEgvmJxGmzzT0wwedIvuwV8tPApOIFoHlt6isGETZ8U7TC6eoD1BKCmbDUbUs
 fdLg==
X-Gm-Message-State: APjAAAWyU4pRa8f+n8m4DSXpnH5rLZJjY8K5XtNb4a0q05jDFyvJLJnQ
 OLMtjSvtVXaMjibsPWkSLlYxlFze8iI=
X-Google-Smtp-Source: APXvYqzsvQYH2fg0d40Ykkaf9nxe4iXOzMU8dl1PTZSycPv5dp8ouAIrjdPQj1zj8pChZLrUDyP0Rg==
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr4010196wru.317.1569519279988; 
 Thu, 26 Sep 2019 10:34:39 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/19] hw/arm/bcm2835_peripherals: Name various address spaces
Date: Thu, 26 Sep 2019 19:34:11 +0200
Message-Id: <20190926173428.10713-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various address spaces from the BCM2835 are reported as
'anonymous' in memory tree:

  (qemu) info mtree

  address-space: anonymous
    0000000000000000-000000000000008f (prio 0, i/o): bcm2835-mbox
      0000000000000010-000000000000001f (prio 0, i/o): bcm2835-fb
      0000000000000080-000000000000008f (prio 0, i/o): bcm2835-property

  address-space: anonymous
    0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
      0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

  [...]

Since the address_space_init() function takes a 'name' argument,
set it to correctly describe each address space:

  (qemu) info mtree

  address-space: bcm2835-mbox-memory
    0000000000000000-000000000000008f (prio 0, i/o): bcm2835-mbox
      0000000000000010-000000000000001f (prio 0, i/o): bcm2835-fb
      0000000000000080-000000000000008f (prio 0, i/o): bcm2835-property

  address-space: bcm2835-fb-memory
    0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
      0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

  address-space: bcm2835-property-memory
    0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
      0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

  address-space: bcm2835-dma-memory
    0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
      0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/bcm2835_fb.c    | 2 +-
 hw/dma/bcm2835_dma.c       | 2 +-
 hw/misc/bcm2835_mbox.c     | 2 +-
 hw/misc/bcm2835_property.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 8f856878cd..85aaa54330 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -425,7 +425,7 @@ static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
     s->initial_config.base = s->vcram_base + BCM2835_FB_OFFSET;
 
     s->dma_mr = MEMORY_REGION(obj);
-    address_space_init(&s->dma_as, s->dma_mr, NULL);
+    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_FB "-memory");
 
     bcm2835_fb_reset(dev);
 
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 6acc2b644e..1e458d7fba 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -383,7 +383,7 @@ static void bcm2835_dma_realize(DeviceState *dev, Error **errp)
     }
 
     s->dma_mr = MEMORY_REGION(obj);
-    address_space_init(&s->dma_as, s->dma_mr, NULL);
+    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_DMA "-memory");
 
     bcm2835_dma_reset(dev);
 }
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 7690b9afaf..77285624c9 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -311,7 +311,7 @@ static void bcm2835_mbox_realize(DeviceState *dev, Error **errp)
     }
 
     s->mbox_mr = MEMORY_REGION(obj);
-    address_space_init(&s->mbox_as, s->mbox_mr, NULL);
+    address_space_init(&s->mbox_as, s->mbox_mr, TYPE_BCM2835_MBOX "-memory");
     bcm2835_mbox_reset(dev);
 }
 
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 0a1a3eb5d9..43a5465c5d 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -407,7 +407,7 @@ static void bcm2835_property_realize(DeviceState *dev, Error **errp)
     }
 
     s->dma_mr = MEMORY_REGION(obj);
-    address_space_init(&s->dma_as, s->dma_mr, NULL);
+    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_PROPERTY "-memory");
 
     /* TODO: connect to MAC address of USB NIC device, once we emulate it */
     qemu_macaddr_default_if_unset(&s->macaddr);
-- 
2.20.1


