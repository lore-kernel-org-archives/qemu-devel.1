Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98210C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6758120663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfCQZ62H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6758120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK45Q-0005me-0R
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qz-0005gx-Vl
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qy-0008JS-Eh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qy-0008J3-8I
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so20395216wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5DChURQVufIfpY2xmSqPZYPNyt4Hv2t7GUJcEwkfdFw=;
 b=VfCQZ62HBJ9tSBk4QCmGgmm/9Ya2PLzS0LcCDxCyiJVWByYXv/luthzuWcP0QL3+yR
 0acAriY48uz0bUuKNBQagRXtPvoQ9ICabUwqZZhT3SXHZG1gQQXet+88+Axcyp+k4ZvF
 tv2EOgVv82lVFXoIZy+UXzeyhJddX2sx9oUbPTVqROEXKqn9rBjjhFEkXovuq5N6XGbg
 Wq5Xs3IFqDUNcDmeCFUL0UsSAAkD2J56/HapfzXuXUJrXLooMJ0Y0897aa89Vh8zAlPY
 D+lBZLypsl4ddNfJAvJIWeum4XPnFwGMYosVLaIxxVPtCCPFipOFU3dEi8AN7llhfNwh
 R0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5DChURQVufIfpY2xmSqPZYPNyt4Hv2t7GUJcEwkfdFw=;
 b=QlK+4GlsAkPSiLBJzjA6mg30nYXGZIaj/iip5PkK48xHhWsdyK2WkS5nyAsw0WqCfG
 aGu/3bu/pYIMhfLFntTKkinGgessG2qyAXJk7hiMJ23EvxrI6srqC2ZFExeGB9IMyTFl
 gTS2g59Mk025xgAXTp9Gc4UeeeM685j9ALM1PlNiq9ijfu0UgwyWvTocYQillm5Exn4p
 VCQ/sOxhZIrTzX0HWhYvz8FXK0Jq9aMr7/pQiTK1+cZ0wdcNTam/msQ3CkPC+8ssXLYR
 Avm5XZEoNz3LsF9yiWuQHN1mbz4rJnS7gwW0xhPXxBbGlLrwJTc0lX28FAAMIa1KLrS0
 naQg==
X-Gm-Message-State: APjAAAXWNYlKyyfMrGFRiz5EOdzLqSvHKgpZoHgFiddHTyJzaQfmJBKP
 QrBcvBEZtL8/c0rxf++kVpeE99nHvQ7dYQ==
X-Google-Smtp-Source: APXvYqxB3lQf6DXu4GieenZAZTxWxg2Ibsiv/VhWEkMAUViAKYeIhMQ7swzmNEB1Dzdod5LAkk3qSQ==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr26480060wrr.220.1571069146909; 
 Mon, 14 Oct 2019 09:05:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/68] hw/arm/bcm2835_peripherals: Name various address spaces
Date: Mon, 14 Oct 2019 17:04:01 +0100
Message-Id: <20191014160404.19553-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-id: 20190926173428.10713-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/bcm2835_fb.c    | 2 +-
 hw/dma/bcm2835_dma.c       | 2 +-
 hw/misc/bcm2835_mbox.c     | 2 +-
 hw/misc/bcm2835_property.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 8f856878cd5..85aaa54330e 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -425,7 +425,7 @@ static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
     s->initial_config.base = s->vcram_base + BCM2835_FB_OFFSET;
 
     s->dma_mr = MEMORY_REGION(obj);
-    address_space_init(&s->dma_as, s->dma_mr, NULL);
+    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_FB "-memory");
 
     bcm2835_fb_reset(dev);
 
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 6acc2b644ec..1e458d7fba5 100644
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
index 7690b9afaf8..77285624c9f 100644
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
index 0a1a3eb5d92..43a5465c5dc 100644
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


