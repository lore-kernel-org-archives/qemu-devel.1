Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC2BC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1564021E6F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 00:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NawExmep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1564021E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUgwG-0003JU-3w
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 19:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUgtR-0001SH-CL
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUgtQ-0005JA-CE
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 19:52:21 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUgtO-0005IL-33; Tue, 12 Nov 2019 19:52:18 -0500
Received: by mail-pl1-x642.google.com with SMTP id d29so276768plj.8;
 Tue, 12 Nov 2019 16:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JHNUboLiwnMy8/zIcCYpOfkRFQBDDIonvvSVwq8TfVc=;
 b=NawExmepWfryxT3Y/BhVLWQa2IGjmfPs+mdklEQWUOPEdzj5gosO64tZi2xG+reloB
 5vgMpEC48H0yB2HLEZueLFc0Y8PzNtwGDUN+r12fBJtqaML0b1QaC0e1TeTAZvuFPWPV
 gotPJl8ZggkteY9LvZc2/Cb4WsXTVpqyU6GZRAfmh+gxzy2n7jrHWrzISIrlF2DfB3p+
 wnI1k9Zxiw8Nuo9cg/yqs0tqVdS2geIl/fyyLKG6UmC02tKE0/hRSoP7eb+UscROQ4ol
 Aj9FdHH/VPji1e0375IS5DIK0MsdyEJHTbcgIxdshBDd7zISJSqOVM8yaPc5gf5QuApH
 74Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JHNUboLiwnMy8/zIcCYpOfkRFQBDDIonvvSVwq8TfVc=;
 b=ozPSR6HrXySNaN7qUMZ2zUKFmzRKNqqjhrp3L/NdSjpRZSIMLz9IIOhRNgKKbGDFiI
 dKSH4jLXBHmzR/34xVIPiL0UqWeV68ENVhvcMiMyLB/rNrxdMjfcOUwQCZBACRkA7uoS
 tYRQPiyQ68QWGpNzMzy51t7qpYTB8sjj6VLFbmQ1bbraeRY3Ge9tMg6sM/Lo7QpoXk+s
 HvHUmE7dvNCu3YNHYQIaaYq5Ebpt8t1QepO7tBudlKnd3d+Tp2VM96XugYhtkSMP9kD7
 KBlSrw1Z54kv0717TGt2axJk2wddqsjiMphrHCEa8fCrIMnahQ9oIovS1eCxQWjTYPta
 Pzrg==
X-Gm-Message-State: APjAAAXbZyB2RSYfn4jj86089Wae12t6EIhKetHRNWHvzA1+Z1n7tbPX
 yX+AxqjwS1Lkr1xqYDykEeo=
X-Google-Smtp-Source: APXvYqzM7/J537U86vTXGOlt9055IM+EFcJoDvodefwEEVtVww0mJLKDt6Vcz6Rc7pUn2KtrQJW82A==
X-Received: by 2002:a17:902:ff0f:: with SMTP id
 f15mr747220plj.52.1573606336867; 
 Tue, 12 Nov 2019 16:52:16 -0800 (PST)
Received: from voyager.ozlabs.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id i13sm169848pfo.39.2019.11.12.16.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 16:52:16 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 2/4] aspeed/scu: Fix W1C behavior
Date: Wed, 13 Nov 2019 11:21:59 +1030
Message-Id: <20191113005201.19005-3-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113005201.19005-1-joel@jms.id.au>
References: <20191113005201.19005-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This models the clock write one to clear registers, and fixes up some
incorrect behavior in all of the write to clear registers.

There was also a typo in one of the register definitions.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_scu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 717509bc5460..aac4645f8c3c 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -98,7 +98,7 @@
 #define AST2600_CLK_STOP_CTRL     TO_REG(0x80)
 #define AST2600_CLK_STOP_CTRL_CLR TO_REG(0x84)
 #define AST2600_CLK_STOP_CTRL2     TO_REG(0x90)
-#define AST2600_CLK_STOP_CTR2L_CLR TO_REG(0x94)
+#define AST2600_CLK_STOP_CTRL2_CLR TO_REG(0x94)
 #define AST2600_SDRAM_HANDSHAKE   TO_REG(0x100)
 #define AST2600_HPLL_PARAM        TO_REG(0x200)
 #define AST2600_HPLL_EXT          TO_REG(0x204)
@@ -532,11 +532,12 @@ static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,
     return s->regs[reg];
 }
 
-static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64_t data,
+static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64_t data64,
                                      unsigned size)
 {
     AspeedSCUState *s = ASPEED_SCU(opaque);
     int reg = TO_REG(offset);
+    uint32_t data = data64;
 
     if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -563,15 +564,19 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64_t data,
         /* fall through */
     case AST2600_SYS_RST_CTRL:
     case AST2600_SYS_RST_CTRL2:
+    case AST2600_CLK_STOP_CTRL:
+    case AST2600_CLK_STOP_CTRL2:
         /* W1S (Write 1 to set) registers */
         s->regs[reg] |= data;
         return;
     case AST2600_SYS_RST_CTRL_CLR:
     case AST2600_SYS_RST_CTRL2_CLR:
+    case AST2600_CLK_STOP_CTRL_CLR:
+    case AST2600_CLK_STOP_CTRL2_CLR:
     case AST2600_HW_STRAP1_CLR:
     case AST2600_HW_STRAP2_CLR:
         /* W1C (Write 1 to clear) registers */
-        s->regs[reg] &= ~data;
+        s->regs[reg - 1] &= ~data;
         return;
 
     case AST2600_RNG_DATA:
-- 
2.24.0


