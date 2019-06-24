Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1C9C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2CD20665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n261ZvXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2CD20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXgh-000826-L4
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSN-000493-Vt
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSL-0005Md-Qf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfXSL-0005JT-J3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:28:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id c6so891826wml.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/SgTNPPsJfCxHETluQbG5NnxhDJEDStW+F5nN1fBiA4=;
 b=n261ZvXHjr+N/pglJVMtesxuU17Fh2nAO+2wEwC0m/S9W0bFfNfAI1AGgfqihJBaMA
 2G/lfmf8M9KuJsK0hklVa8qEPx6MSWSuCcnoZAMGmbDo5KoOfkqi9FyVKHtXZ610v5Op
 sLom89ZZ9/y6xvBh2zWLLxKOxoVHz0meymM3eEPoGo/44oVFLDt06hpvc8QqHL3DOT/4
 ha/txKCbEsaIBTLvgx0a2aIOinL41ktlujIooEulOwSbIOyUp/q5zN4b6qDh7V5U9Efe
 ZYYqzSyJU3ZnZT8Lyn370mqqPC5HV1K1y9zRAkGM5Myy6/wJrV6QP6qNUjD6v7fvCcgF
 ra8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/SgTNPPsJfCxHETluQbG5NnxhDJEDStW+F5nN1fBiA4=;
 b=IpXHaBLAi+sanPw7DGXBwiLIDmMW9Bjjvx5JxKsS4rN6BtWXHCTTvKktLg97Fdtj8c
 gwxJF22LnsztuaNT0CfvXaxGuK6wXd4W6xIxrnVLd8wpMdaIbC8ZGUzmRgncrMasAIX2
 6vgGnxMZWvWJ18wDxxFI5P9TAPkv22CRKdbbHFacF34ivBwS69ZBP/TrKoQMv1VZ7A22
 JQxAR0yN9cRNX6rXSKR5odrrNGb4x9l3gXIGgBZ3Zv9FimhK7crs01ufJsAnskPCJn+4
 s/1ly2Wt5bjO8Z2yp5BpffkP2fDD/s4xOfOIiA65bWRelhSO3o0jltgiY6qyKwneET+P
 R9Ug==
X-Gm-Message-State: APjAAAXeb4GZR3OWEEKN8KfvgehESJ3IbAPOskrxjiDOXTUIUw2BqSbj
 I441ogtKk5ejKtJnqk1BvKX+ceFc
X-Google-Smtp-Source: APXvYqxWDLhu44DmFzobLzftBpLohxi0WgtigD3Bp1eHtcAqb08ysyW1j73j/4e+C9IQPMBtZYoqPQ==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr16797119wme.12.1561415332999; 
 Mon, 24 Jun 2019 15:28:52 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l1sm646781wmg.13.2019.06.24.15.28.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:28:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:28:39 +0200
Message-Id: <20190624222844.26584-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624222844.26584-1-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 05/10] hw/mips/gt64xxx_pci: Use qemu_log_mask()
 instead of debug printf()
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/gt64xxx_pci.c | 48 +++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 0b9fb02475..f44326f14f 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/mips/mips.h"
 #include "hw/pci/pci.h"
@@ -466,12 +467,20 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_CPUERR_DATAHI:
     case GT_CPUERR_PARITY:
         /* Read-only registers, do nothing */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Read-only register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
 
     /* CPU Sync Barrier */
     case GT_PCI0SYNC:
     case GT_PCI1SYNC:
         /* Read-only registers, do nothing */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Read-only register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
 
     /* SDRAM and Device Address Decode */
@@ -510,7 +519,10 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_DEV_B3:
     case GT_DEV_BOOT:
         /* Not implemented */
-        DPRINTF ("Unimplemented device register offset 0x%x\n", saddr << 2);
+        qemu_log_mask(LOG_UNIMP,
+                      "gt64120: Unimplemented device register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
 
     /* ECC */
@@ -520,6 +532,10 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_ECC_CALC:
     case GT_ECC_ERRADDR:
         /* Read-only registers, do nothing */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Read-only register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
 
     /* DMA Record */
@@ -543,23 +559,20 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_DMA1_CUR:
     case GT_DMA2_CUR:
     case GT_DMA3_CUR:
-        /* Not implemented */
-        DPRINTF ("Unimplemented DMA register offset 0x%x\n", saddr << 2);
-        break;
 
     /* DMA Channel Control */
     case GT_DMA0_CTRL:
     case GT_DMA1_CTRL:
     case GT_DMA2_CTRL:
     case GT_DMA3_CTRL:
-        /* Not implemented */
-        DPRINTF ("Unimplemented DMA register offset 0x%x\n", saddr << 2);
-        break;
 
     /* DMA Arbiter */
     case GT_DMA_ARB:
         /* Not implemented */
-        DPRINTF ("Unimplemented DMA register offset 0x%x\n", saddr << 2);
+        qemu_log_mask(LOG_UNIMP,
+                      "gt64120: Unimplemented DMA register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
 
     /* Timer/Counter */
@@ -569,7 +582,10 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_TC3:
     case GT_TC_CONTROL:
         /* Not implemented */
-        DPRINTF ("Unimplemented timer register offset 0x%x\n", saddr << 2);
+        qemu_log_mask(LOG_UNIMP,
+                      "gt64120: Unimplemented timer register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
 
     /* PCI Internal */
@@ -610,6 +626,10 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_PCI1_CFGADDR:
     case GT_PCI1_CFGDATA:
         /* not implemented */
+        qemu_log_mask(LOG_UNIMP,
+                      "gt64120: Unimplemented timer register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
     case GT_PCI0_CFGADDR:
         phb->config_reg = val & 0x80fffffc;
@@ -666,7 +686,10 @@ static void gt64120_writel(void *opaque, hwaddr addr,
         break;
 
     default:
-        DPRINTF ("Bad register offset 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Illegal register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
     }
 }
@@ -940,7 +963,10 @@ static uint64_t gt64120_readl(void *opaque,
 
     default:
         val = s->regs[saddr];
-        DPRINTF ("Bad register offset 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Illegal register read "
+                      "reg:0x03%x size:%u value:0x%0*x\n",
+                      saddr << 2, size, size << 1, val);
         break;
     }
 
-- 
2.19.1


