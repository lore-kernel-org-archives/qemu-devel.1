Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837DC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60122133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUsp0QMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60122133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyX4z-0007Rn-CB
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 03:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rashmica.g@gmail.com>) id 1hyWjS-0006Ti-Gx
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hyWjQ-0000AA-7E
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:33:05 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hyWjI-0008VX-Do; Fri, 16 Aug 2019 03:32:56 -0400
Received: by mail-pl1-x642.google.com with SMTP id go14so1809239plb.0;
 Fri, 16 Aug 2019 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B6NXQRQeCGanV2ONUcT5078tmiJBI2SoR0Tty4lkfZY=;
 b=jUsp0QMBnX30pUKSuiboAtI9oAK92OqbCK5G2vN1OzOj99VTuuws8X7w1Ki27dteMZ
 KCGcuAAEIoy0+hhWfvnuJrNrMhLaoz+sBN6aKdeE8aWh4L04ju3rQ/spgY9lZY2qR02N
 jyL/f7OO4a9R2GRW7Y8iMXXd4zkUt4AGEOFuTjG05biLoGasKeOlgwR/QlezmL0c3Jj6
 AWHEVVlkTxd8Hg4VSmNBuv3cdhw8IS3Rzi3iV5YRlTytIbZ/QGfcIzX5lDtHNK4iF8k6
 upoyrpaULdr3AYi+4kO7OX6DKRh/VGtD3sWTQWFzSfeQ+SNc5mThUKvk/b8DwFg2TAzL
 SU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B6NXQRQeCGanV2ONUcT5078tmiJBI2SoR0Tty4lkfZY=;
 b=acDTBmIdj2JAqKw/D/OvZUcuI8m3dWVui9cC9fR1nyABEZkeMpMDCJhVat/ZksICWq
 I3mr7/3fQvI1i5+C8HZpS1unUxXa0ankkdBe679lJJKUwOVokMT0npcbpB6OUxHEb5os
 TqRI6BN4XZUzUFrxZWLQ9BgalUrX6hRaiswsU1Tf2xdfY8GX92SlpCH+5SXW2YKXYNFI
 pt7F9h7Pm/XBKJqCYfngs9eG6STRY0khiJyRpffcyQwc11y5uB6VRUlokWvww9ILljDy
 ksoZI88hRB2bQ1y7oaOkkNutEjtEYvywTtd1gthf/jsYNH3KIw6XOXwSqqCQgUoC0ZmX
 xiDA==
X-Gm-Message-State: APjAAAX21QzthyMvab8Kbcl/HIbmUD4mlj9JVBIv3Dt8flodz6T0HsY5
 j4O0CeWRmxb+OhOgCX9yRRs=
X-Google-Smtp-Source: APXvYqzVniOJS1yT0FCPw9EvkqJxutPDElRM0o2OIXGD/YRJh6hfrn1zV9wNEu8clyWCNcg42obwkA==
X-Received: by 2002:a17:902:82c4:: with SMTP id
 u4mr8038206plz.196.1565940771859; 
 Fri, 16 Aug 2019 00:32:51 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id w129sm5638589pfd.89.2019.08.16.00.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 00:32:51 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Date: Fri, 16 Aug 2019 17:32:26 +1000
Message-Id: <20190816073229.22787-1-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v4 0/3] Add Aspeed GPIO controller model
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
Cc: andrew@aj.id.au, qemu-devel@nongnu.org, aik@ozlabs.ru, joel@jms.id.au,
 Rashmica Gupta <rashmica.g@gmail.com>, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v5:
- integrated AspeedGPIOController fields into AspeedGPIOClass
- separated ast2600_3_6v and ast2600_1_8v into two classes

v4:
- proper interupt handling thanks to Andrew
- switch statements for reading and writing suggested by Peter
- some small cleanups suggested by Alexey

v3:
- didn't have each gpio set up as an irq 
- now can't access set AC on ast2400 (only exists on ast2500)
- added ast2600 implementation (patch 3)
- renamed a couple of variables for clarity

v2: Addressed Andrew's feedback, added debounce regs, renamed get/set to
read/write to minimise confusion with a 'set' of registers.

Rashmica Gupta (3):
  hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
  aspeed: add a GPIO controller to the SoC
  hw/gpio: Add in AST2600 specific implementation

 include/hw/arm/aspeed_soc.h   |    3 +
 include/hw/gpio/aspeed_gpio.h |  100 ++++
 hw/arm/aspeed_soc.c           |   17 +
 hw/gpio/aspeed_gpio.c         | 1006 +++++++++++++++++++++++++++++++++
 hw/gpio/Makefile.objs         |    1 +
 5 files changed, 1127 insertions(+)
 create mode 100644 include/hw/gpio/aspeed_gpio.h
 create mode 100644 hw/gpio/aspeed_gpio.c

-- 
2.20.1


