Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594CFC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B29920820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKWKMr13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B29920820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXTm-0005bn-2F
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34120)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSN-000495-WE
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSL-0005Lm-IR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSH-0005HH-L1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:53 -0400
Received: by mail-wm1-x341.google.com with SMTP id w9so919719wmd.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B16UC5jpLoiB2eLXN09Oz9O+5YpGIzoXUKS3ahIfaxM=;
 b=CKWKMr13uVcD39gXizeBevl8HbVjB8O8Gp0lS6DlHbl0nW1I2dqWSDpvOEMJa3Q5fs
 WpJTLL8qUTE/fmluRYlKoFwQqEe7xaFC+aNBRGmddV4Xyr7Ob38l3u02UZHrJ5UlZeDg
 xB1uxwN3f37Ud2TvRwqNP8sU2nuZ6vLikn317Mps8cUdywFKxG2BVWIL43x29T1Ei7lF
 R4eYhL2XXQ4lBLsnaq/LusvnKOG8Fw/LOZAquIsMnzSu6LZVf4CYiVFc1kGplRrQcQ++
 7JyaUALAc6U0COZzWUo+2u3rBEWCqO+fjj3J+9jtZnCr6WdFSapKnYDMyUs6Ybouvcby
 gLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B16UC5jpLoiB2eLXN09Oz9O+5YpGIzoXUKS3ahIfaxM=;
 b=UMRgsafW9d0wzk6FzoyyXe7bfuLm9i+S06eM4fRuQhr8N53yC3mXJL97uugavRO/p5
 H2BmmH4aEweEraj9lYnbv2XsqvJhTvoX/AIp4wIb7a1kP+r+JBJWW7GBg97gnc9yFHQI
 s40fqfFVwj6p+h5hmyNYWL9deffllTi+VDS5fS9JWfyUdHENf/vc30hRmNva3cvMrLQl
 PWkXsa7z8sIxTEKWwqa2VB9Z1QtQPd+wgrqC3txhk6Y/tfLHBFv7R2dttFCyZFHnNqv0
 1BbmGHI53UnTcECGcRKb99zp03X9uGZBp/fQXmyefF92l8TEjqW7ZOetjswBNIdIiNfu
 yjIw==
X-Gm-Message-State: APjAAAXhfIOLt8RnFwGju6RJZtZxRAA7LM1EAASGTfK/byYp9P27tKFQ
 jwdOlo3KsjHSYkAABixKz8CKi8Ft
X-Google-Smtp-Source: APXvYqzx6dGBxEHnOqRH2pcxMWJdYDkNhoPgcHMlPPPj1CFcDaxFDNG1dKu0FvMuHqkepTlSORyurQ==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr18076367wml.52.1561415331785; 
 Mon, 24 Jun 2019 15:28:51 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l1sm646781wmg.13.2019.06.24.15.28.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:28:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:28:38 +0200
Message-Id: <20190624222844.26584-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624222844.26584-1-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 04/10] hw/mips/gt64xxx_pci: Fix 'spaces' coding
 style issues
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we'll move this code around, fix its style first:

  ERROR: space prohibited between function name and open parenthesis
  ERROR: line over 90 characters

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/gt64xxx_pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index cfd497960c..0b9fb02475 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -384,8 +384,8 @@ static const VMStateDescription vmstate_gt64120 = {
     }
 };
 
-static void gt64120_writel (void *opaque, hwaddr addr,
-                            uint64_t val, unsigned size)
+static void gt64120_writel(void *opaque, hwaddr addr,
+                           uint64_t val, unsigned size)
 {
     GT64120State *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
@@ -671,8 +671,8 @@ static void gt64120_writel (void *opaque, hwaddr addr,
     }
 }
 
-static uint64_t gt64120_readl (void *opaque,
-                               hwaddr addr, unsigned size)
+static uint64_t gt64120_readl(void *opaque,
+                              hwaddr addr, unsigned size)
 {
     GT64120State *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
@@ -1193,7 +1193,8 @@ PCIBus *gt64120_register(qemu_irq *pic)
                                      get_system_io(),
                                      PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS);
     qdev_init_nofail(dev);
-    memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d, "isd-mem", 0x1000);
+    memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d,
+                          "isd-mem", 0x1000);
 
     pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "gt64120_pci");
     return phb->bus;
-- 
2.19.1


