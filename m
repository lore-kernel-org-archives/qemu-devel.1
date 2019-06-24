Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7330EC4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D2420665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/5pRsq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D2420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXaa-000329-JK
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34070)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSL-00047P-Lx
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSH-0005K5-Mt
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSG-0005Dv-Ev
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id f9so15528965wre.12
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AW/xKO7mT5etUQtESYRRO4Lg0VmgTpD5DqdFMv+nnSk=;
 b=t/5pRsq4kx9n6VdI7kt7a6mIBirBRCuz9f0XwXGJIb/QrFoVSEfOB2D8Sg1U1jdqIg
 3hEXPS+1UJU0B6psU1rImYNu7UaxO30Bx8Y7wea/NUlSFLVQsZAMlJNvJeXmniUxJphc
 yLdY5sSD2CrhmQCHRkNX76AEXcmLSvpwH6tr8qzccunMvs3k8V0rewjIexpwjAKBsP+N
 IP2NXMt40nsDVz76VlVfLExm+czkbWStu6Nnrk81xU3HEtNBnQ+t4Qk/LxJeUFwnDDL6
 jrgY3IRXuaS1nfBv0Z0lVa2Ozh5jngPIXjV7gkjMc6/wUIqVJAcRgRhJW/USFOrCcohJ
 YO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AW/xKO7mT5etUQtESYRRO4Lg0VmgTpD5DqdFMv+nnSk=;
 b=PAxpLZV3wgY4aOt4nTu7+PA4KPZbgM8ftp/lBNCibW8wNhx4d3GydOmokvrX3MSqoy
 1zs7aiE5rK1Qaf7fVa60do78ofjulUkUkriUegrQNgTfWBq73JgX/3pTp9CPwLvnU6uk
 M3m8eEYFncC4pXk4fiHJLWh36a1wNtxoRrFcuvuPqJTvJQXT03byqflH4ezrPfPRH1ya
 ZcLHTMAX7socB66zixucaaGQ9nfWvo3wocEA8crMYUHAwsq2hHlmTnA7JdC2TFOoR4dz
 +/5N4gI9u6nvI8oZCF5bE3nXdJxo7QWEpf7mqUtV/1VYl/9/tS8SsHW41CWWVpy8ug86
 IhCQ==
X-Gm-Message-State: APjAAAUmvWHERltrJoRNl6dkgMYuIVBMZ2Z2FwJQFDACc9eqy64hX0vY
 Mw+26J8upAAS6G0kbBlJZPQEQALG
X-Google-Smtp-Source: APXvYqwcEMzwaNOiA92PIjeXDSc/AxkEbAT4quzy0ms2scZsajbMRma2w6av9ON1TRzbY93InRwF+w==
X-Received: by 2002:adf:f581:: with SMTP id f1mr16415389wro.179.1561415328149; 
 Mon, 24 Jun 2019 15:28:48 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l1sm646781wmg.13.2019.06.24.15.28.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:28:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:28:35 +0200
Message-Id: <20190624222844.26584-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624222844.26584-1-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 01/10] hw/mips/gt64xxx_pci: Fix multiline
 comment syntax
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

Since commit 8c06fbdf36b checkpatch.pl enforce a new multiline
comment syntax. Since we'll move this code around, fix its style
first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/gt64xxx_pci.c | 64 +++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index f707e59c7a..c0924646b5 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -248,10 +248,11 @@ typedef struct GT64120State {
 } GT64120State;
 
 /* Adjust range to avoid touching space which isn't mappable via PCI */
-/* XXX: Hardcoded values for Malta: 0x1e000000 - 0x1f100000
-                                    0x1fc00000 - 0x1fd00000  */
-static void check_reserved_space (hwaddr *start,
-                                  hwaddr *length)
+/*
+ * XXX: Hardcoded values for Malta: 0x1e000000 - 0x1f100000
+ *                                  0x1fc00000 - 0x1fd00000
+ */
+static void check_reserved_space(hwaddr *start, hwaddr *length)
 {
     hwaddr begin = *start;
     hwaddr end = *start + *length;
@@ -650,8 +651,10 @@ static void gt64120_writel (void *opaque, hwaddr addr,
     case GT_SDRAM_B1:
     case GT_SDRAM_B2:
     case GT_SDRAM_B3:
-        /* We don't simulate electrical parameters of the SDRAM.
-           Accept, but ignore the values. */
+        /*
+         * We don't simulate electrical parameters of the SDRAM.
+         * Accept, but ignore the values.
+         */
         s->regs[saddr] = val;
         break;
 
@@ -674,8 +677,10 @@ static uint64_t gt64120_readl (void *opaque,
 
     /* CPU Configuration */
     case GT_MULTI:
-        /* Only one GT64xxx is present on the CPU bus, return
-           the initial value */
+        /*
+         * Only one GT64xxx is present on the CPU bus, return
+         * the initial value.
+         */
         val = s->regs[saddr];
         break;
 
@@ -685,17 +690,18 @@ static uint64_t gt64120_readl (void *opaque,
     case GT_CPUERR_DATALO:
     case GT_CPUERR_DATAHI:
     case GT_CPUERR_PARITY:
-        /* Emulated memory has no error, always return the initial
-           values */
+        /* Emulated memory has no error, always return the initial values. */
         val = s->regs[saddr];
         break;
 
     /* CPU Sync Barrier */
     case GT_PCI0SYNC:
     case GT_PCI1SYNC:
-        /* Reading those register should empty all FIFO on the PCI
-           bus, which are not emulated. The return value should be
-           a random value that should be ignored. */
+        /*
+         * Reading those register should empty all FIFO on the PCI
+         * bus, which are not emulated. The return value should be
+         * a random value that should be ignored.
+         */
         val = 0xc000ffee;
         break;
 
@@ -705,8 +711,7 @@ static uint64_t gt64120_readl (void *opaque,
     case GT_ECC_MEM:
     case GT_ECC_CALC:
     case GT_ECC_ERRADDR:
-        /* Emulated memory has no error, always return the initial
-           values */
+        /* Emulated memory has no error, always return the initial values. */
         val = s->regs[saddr];
         break;
 
@@ -785,8 +790,10 @@ static uint64_t gt64120_readl (void *opaque,
     case GT_SDRAM_B1:
     case GT_SDRAM_B2:
     case GT_SDRAM_B3:
-        /* We don't simulate electrical parameters of the SDRAM.
-           Just return the last written value. */
+        /*
+         * We don't simulate electrical parameters of the SDRAM.
+         * Just return the last written value.
+         */
         val = s->regs[saddr];
         break;
 
@@ -949,20 +956,20 @@ static int gt64120_pci_map_irq(PCIDevice *pci_dev, int irq_num)
     slot = (pci_dev->devfn >> 3);
 
     switch (slot) {
-      /* PIIX4 USB */
-      case 10:
+    /* PIIX4 USB */
+    case 10:
         return 3;
-      /* AMD 79C973 Ethernet */
-      case 11:
+    /* AMD 79C973 Ethernet */
+    case 11:
         return 1;
-      /* Crystal 4281 Sound */
-      case 12:
+    /* Crystal 4281 Sound */
+    case 12:
         return 2;
-      /* PCI slot 1 to 4 */
-      case 18 ... 21:
+    /* PCI slot 1 to 4 */
+    case 18 ... 21:
         return ((slot - 18) + irq_num) & 0x03;
-      /* Unknown device, don't do any translation */
-      default:
+    /* Unknown device, don't do any translation */
+    default:
         return irq_num;
     }
 }
@@ -980,8 +987,7 @@ static void gt64120_pci_set_irq(void *opaque, int irq_num, int level)
     /* XXX: optimize */
     pic_irq = piix4_dev->config[0x60 + irq_num];
     if (pic_irq < 16) {
-        /* The pic level is the logical OR of all the PCI irqs mapped
-           to it */
+        /* The pic level is the logical OR of all the PCI irqs mapped to it. */
         pic_level = 0;
         for (i = 0; i < 4; i++) {
             if (pic_irq == piix4_dev->config[0x60 + i])
-- 
2.19.1


