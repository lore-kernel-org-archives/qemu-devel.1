Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287AEC32771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A2122522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKG6rhzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A2122522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itiVr-0002ZD-Ru
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 20:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1itiPy-0007UO-I2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1itiPx-0000ev-Fp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:33:22 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1itiPu-0000Zw-1E; Mon, 20 Jan 2020 20:33:18 -0500
Received: by mail-pf1-x441.google.com with SMTP id i6so623046pfc.1;
 Mon, 20 Jan 2020 17:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hJtyuqknzcxsdbaI1OusF0aaxr3aBxUm9vjGVFXsWtc=;
 b=JKG6rhzl3R+RzB7n17qcoZHX1ayw7i2LNIhuXpPPfg+MqZI2MPyzptCsi8RvjYSG/f
 AlXW6VZG6zFRNppaI4wGKmwd/stMeUr7oUvz4C9gDPoWDPTux4rQPi8BL7txnptAO6VE
 h0TT/Ny99FafWFQSF1V3AN/AnJj8NZZuAtcQkMqmx5RSBaUBXUBFoYJBxXrUaAsv3KdW
 rEZqLufKSkxxpFbfH6EtuttSGOp5+zIk3C4/ZBRUM1VY+etpLYTsFJF6MGaaZs9/qm3o
 gWddFMdQ3fD0OobbT+YYTmAq6iqiOp+3lCLIg4OHwf+KKw9jJ8CiGcxENly+2QyMUukF
 DF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hJtyuqknzcxsdbaI1OusF0aaxr3aBxUm9vjGVFXsWtc=;
 b=g7plP+MGjXy+M+6isInjQsf/2hITt1uHnzLGQJX2jeXl4O+VlRE4PKESDPvdk1Asle
 MF2LxX1ihijiErdM601o9HATHqjV5B5hJpVWc0okRSY7rAXwdPu9P6dTR+JlASBHCOmD
 emUHMPB8W/84a7s72bz4VWvWWkmVNux8BHGZQXk2sxJ8VkVavrooAaUgPNxwjjqhDSql
 miHMOK+3ovHJ24PTF7Fgczt/rxTt8SfukhGzVLfOZLDR5ZjiNC+Ak7DezQbUa/NewZ7C
 1oH14PPJTlp9UQ4CgvMRz1f+wQKyhMXggvibhpfdcciF+4ZstrAVj8xPyDdbMccemrk8
 qPtA==
X-Gm-Message-State: APjAAAUrDlURyihFS2VffpA1UvAUCacM2rnjim6drE0mvhufK8L6m3Bq
 fWSK38jiMkfqxr/nK8ZOLA7SfE2K
X-Google-Smtp-Source: APXvYqxagMYQYt/dN2veru9KaR58bCCOnESOP/9ZJnkMcCFtiU3dngqiIBXPFZSGtVQ2MJuELzOnyQ==
X-Received: by 2002:a63:2a06:: with SMTP id q6mr2636878pgq.92.1579570396944;
 Mon, 20 Jan 2020 17:33:16 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id x132sm40628397pfc.148.2020.01.20.17.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 17:33:16 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] aspeed/scu: Implement chip ID register
Date: Tue, 21 Jan 2020 12:03:02 +1030
Message-Id: <20200121013302.43839-3-joel@jms.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121013302.43839-1-joel@jms.id.au>
References: <20200121013302.43839-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

This returns a fixed but non-zero value for the chip id.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_scu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 7108cad8c6a7..19d1780a40da 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -77,6 +77,8 @@
 #define CPU2_BASE_SEG4       TO_REG(0x110)
 #define CPU2_BASE_SEG5       TO_REG(0x114)
 #define CPU2_CACHE_CTRL      TO_REG(0x118)
+#define CHIP_ID0             TO_REG(0x150)
+#define CHIP_ID1             TO_REG(0x154)
 #define UART_HPLL_CLK        TO_REG(0x160)
 #define PCIE_CTRL            TO_REG(0x180)
 #define BMC_MMIO_CTRL        TO_REG(0x184)
@@ -115,6 +117,8 @@
 #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
 #define AST2600_RNG_CTRL          TO_REG(0x524)
 #define AST2600_RNG_DATA          TO_REG(0x540)
+#define AST2600_CHIP_ID0          TO_REG(0x5B0)
+#define AST2600_CHIP_ID1          TO_REG(0x5B4)
 
 #define AST2600_CLK TO_REG(0x40)
 
@@ -182,6 +186,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
      [CPU2_BASE_SEG1]  = 0x80000000U,
      [CPU2_BASE_SEG4]  = 0x1E600000U,
      [CPU2_BASE_SEG5]  = 0xC0000000U,
+     [CHIP_ID0]        = 0x1234ABCDU,
+     [CHIP_ID1]        = 0x88884444U,
      [UART_HPLL_CLK]   = 0x00001903U,
      [PCIE_CTRL]       = 0x0000007BU,
      [BMC_DEV_ID]      = 0x00002402U
@@ -307,6 +313,8 @@ static void aspeed_ast2500_scu_write(void *opaque, hwaddr offset,
     case RNG_DATA:
     case FREE_CNTR4:
     case FREE_CNTR4_EXT:
+    case CHIP_ID0:
+    case CHIP_ID1:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
@@ -620,6 +628,8 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
     case AST2600_RNG_DATA:
     case AST2600_SILICON_REV:
     case AST2600_SILICON_REV2:
+    case AST2600_CHIP_ID0:
+    case AST2600_CHIP_ID1:
         /* Add read only registers here */
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
@@ -648,6 +658,9 @@ static const uint32_t ast2600_a0_resets[ASPEED_AST2600_SCU_NR_REGS] = {
     [AST2600_CLK_STOP_CTRL2]    = 0xFFF0FFF0,
     [AST2600_SDRAM_HANDSHAKE]   = 0x00000040,  /* SoC completed DRAM init */
     [AST2600_HPLL_PARAM]        = 0x1000405F,
+    [AST2600_CHIP_ID0]          = 0x1234ABCD,
+    [AST2600_CHIP_ID1]          = 0x88884444,
+
 };
 
 static void aspeed_ast2600_scu_reset(DeviceState *dev)
-- 
2.24.1


