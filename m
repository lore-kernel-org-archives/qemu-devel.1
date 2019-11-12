Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4F9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CBB214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T25XHkQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CBB214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUPum-0005XN-U2
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 01:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUPrZ-0003LL-2o
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUPrX-0007Nm-9G
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:41:16 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUPrV-0007MQ-0u; Tue, 12 Nov 2019 01:41:13 -0500
Received: by mail-pl1-x642.google.com with SMTP id j12so8930771plt.9;
 Mon, 11 Nov 2019 22:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hyG32yXenzdMQwklj1Cf+goAGOB3P8VjL1+e16W2tTQ=;
 b=T25XHkQuMFS//SzEMcFFkzcPzeHMHwW+FKXOVP+xN0WKIFl8gO9B6p6hXKp+67ICUX
 R6v40fhNnvTS3addm2IwaiHazkqNHvD21omuB18oDhF+4oX2C3qudc1F6Qw4BCT75yTE
 tDHyLao8IRlCTproIzoc+VvOSclCnnNZyhXk9CwaVxezkMoZToeFUxxUg5fEwcZHpEO1
 54GytjunDddPrvyDYnu/oLaRj8g9v0XJ3riXrSiu8oH+peyHu4R0S4dTIwzyyZsYh9Rn
 RDYdFwGlTQDC7hbmwFzbZbpMZOoORjL2GZOdklUfdmNqBqCgXjKtXytzUWS99mw4aXCI
 Ga2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hyG32yXenzdMQwklj1Cf+goAGOB3P8VjL1+e16W2tTQ=;
 b=OGJArxSJPVoQyfXi5Tk4/zg87P5cZ/EBPFV1549FSusrpRH0ltFiXOxuB0olJTxKxA
 wKwjKbqlMbBwqTwQgqmsDktx2xg7o42d9SXDqUzqbZ6vr91JX2ofj072NZ4NPuSrH8mH
 MDmdaYCou12o4GAhQj+Py8tyMlpPXGu2gHXazG0ehSmlaGPhl8UQdCfcys/5RHj7GZ03
 nLYf3PwSExdfaO+eUZTESsQOJB+LSlfZJ1k7xb1/xqPn7GqhUp8QnOYfmfA840mmHL3g
 2tohzKUwoQlUGEIDn+w++cAh7/cfsL+Ub009PWBQLBMVfM7UbeI21kx2yBmsIBIKYUuu
 8SYA==
X-Gm-Message-State: APjAAAU2mdOcUiP+spkzwr2M98Aa42gcD05tHYhZWA2HF591ctitxWQu
 IBExbBDqUqnU4IXyP3lnvthsquSNmHg=
X-Google-Smtp-Source: APXvYqzvn/n4vy4/wOsgGlP3NDaFhTx244joNQdxrljeIoW1rIEzTMq+mX3dZjrpcQoYPpRH0hY86g==
X-Received: by 2002:a17:902:8208:: with SMTP id
 x8mr30463850pln.6.1573540871933; 
 Mon, 11 Nov 2019 22:41:11 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id q8sm16375590pgg.15.2019.11.11.22.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 22:41:11 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 2/4] aspeed/scu: Fix W1C behavior
Date: Tue, 12 Nov 2019 17:10:56 +1030
Message-Id: <20191112064058.13275-3-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112064058.13275-1-joel@jms.id.au>
References: <20191112064058.13275-1-joel@jms.id.au>
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This models the clock write one to clear registers, and fixes up some
incorrect behavior in all of the write to clear registers.

There was also a typo in one of the register definitions.

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


