Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F0C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DA3206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3yHZL6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DA3206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV0ws-0003Wy-U3
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iV0tC-0001oO-VP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iV0tB-0001Du-LK
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:13:26 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iV0t7-00016P-V1; Wed, 13 Nov 2019 17:13:22 -0500
Received: by mail-pg1-x543.google.com with SMTP id z188so2264213pgb.1;
 Wed, 13 Nov 2019 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=thDO08iuJthlIoDRnaZrctxgEQ0GtnTwsT4oxGR+A5g=;
 b=f3yHZL6i3Bz8BDMXLZNwm6n9ggNx06bqe0BMu8NBTsvphxSlBtTrRur1Ck++FwZT8j
 69dxTztU2y6r7D1Y8NUWPH1HcqRnRZ42LYJvjA3hhUFRB+GgIV05t3TxSLo0sNG8jovS
 5Ud4mShPBZTm55SnDdJ9sekg6j9wvM1ra2JSF0p8a1EG9WGKNvAdQGb/16uzMswISDSl
 jYZjyiOgLL8Ccd1CZYLR7bNflKyZ7JpmO0oZsG9aqI6whHBqjL0JXPr2p29aptYJ78nf
 Jb7wTPIraZ9O9jyeBA5qodOHNHKl3E4J+4vLbBMFzj6OwxK1wbsQD8LmKSzNkuv6bIPe
 gBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=thDO08iuJthlIoDRnaZrctxgEQ0GtnTwsT4oxGR+A5g=;
 b=MNOlZ+R2ZixT9tSKokhCdmZSF47AHmtakmjX04tftxq7yGu0USg914DeWymTIWAhAS
 yX3ZBxh1gmnQTYLfMePsriVrx3G3tzwOp+faOkSbVmuBK+WvpNr9Dc0WEZWiw6GDmegE
 Lup5cV9OJwjbDLHkWHITNR5ypA5AZlG1N7ktJ1m9DTGEbKvQ9zW1X2KAqs1OwWi1hr1M
 rfH69NtM3lkFxpv2h9CFhr+J7DcWKwEVU9PLIpogy4U3pu1MBNtDY04VMopWieywx3lL
 cMnaMHdSjJQfiGWjxYQoYJomKo+CHLMN+3sU0mgKmaUbCPPq597grtQw3Z78a4yDP0DL
 7w0A==
X-Gm-Message-State: APjAAAVB281uQes06ebYXCXgXnixOQLYbMnIMJJ8xllx7KReWtbRG33k
 WKnbAC23dKGed2PU8tib2miQKNlBjjY=
X-Google-Smtp-Source: APXvYqz8d4rh92+HTJVxoMIitfjVp01ZwiF+WzZ8OQ9LhKCwmgwgy/MnxjpfaVKGkEn6N0uz60AAWw==
X-Received: by 2002:a65:624e:: with SMTP id q14mr6221514pgv.277.1573683199705; 
 Wed, 13 Nov 2019 14:13:19 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
 by smtp.gmail.com with ESMTPSA id w69sm5252005pfc.164.2019.11.13.14.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 14:13:19 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 2/4] aspeed/scu: Fix W1C behavior
Date: Thu, 14 Nov 2019 08:42:59 +1030
Message-Id: <20191113221301.8768-3-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113221301.8768-1-joel@jms.id.au>
References: <20191113221301.8768-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This models the clock write one to clear registers, and fixes up some
incorrect behavior in all of the write to clear registers.

There was also a typo in one of the register definitions.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: Beef up the comments
---
 hw/misc/aspeed_scu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 717509bc5460..5518168e48b4 100644
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
@@ -532,11 +532,13 @@ static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,
     return s->regs[reg];
 }
 
-static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64_t data,
+static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64_t data64,
                                      unsigned size)
 {
     AspeedSCUState *s = ASPEED_SCU(opaque);
     int reg = TO_REG(offset);
+    /* Truncate here so bitwise operations below behave as expected */
+    uint32_t data = data64;
 
     if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -563,15 +565,20 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64_t data,
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
-        /* W1C (Write 1 to clear) registers */
-        s->regs[reg] &= ~data;
+        /* W1C (Write 1 to clear) registers are offset by one address from
+         * the data register */
+        s->regs[reg - 1] &= ~data;
         return;
 
     case AST2600_RNG_DATA:
-- 
2.24.0


