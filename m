Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85B4C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 06:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29C92081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 06:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1emp6tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29C92081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLiar-0002sQ-P1
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 02:19:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLiZx-0002VV-9D
	for qemu-devel@nongnu.org; Wed, 01 May 2019 02:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hLiZt-000224-B0
	for qemu-devel@nongnu.org; Wed, 01 May 2019 02:18:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hLiZk-0001t8-4t; Wed, 01 May 2019 02:18:41 -0400
Received: by mail-pg1-x543.google.com with SMTP id j26so7932988pgl.5;
	Tue, 30 Apr 2019 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=YQNY3Qs9SDZ8Rf6rl1MztV5ckrSsadpmpli/FQdnH7Q=;
	b=S1emp6tb/VZEYJ8wuDErCvzW81PNOhPmcr7smdEKSJ1O1Z+ocdAeZUC6NX1YF2xZjg
	Fk7eIg3HsZf0yq+EJNKrLsxNZWoOmMht0TQs/zaJhaxzj+yDtgFj3540ruxGSUlrV/tE
	6U+EKPqIE1ZND3toxV8vt1yTabZkVVmB6qy8MPNhR3w1izm96v9O1XXtjBP1cjzAH9kT
	doQH5sC3lkkJ1hh1+P0P46zZFWYGDcxN7olsI2jRUYytLmEHLmAT/TaEUcyMQKEHiRZv
	NzR3tKGFE+0Mok6oiWQz8l2gpfs11jwAMvHrSoknoPuooV39t3jF/KrgbmGyUjtJsFsR
	90BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=YQNY3Qs9SDZ8Rf6rl1MztV5ckrSsadpmpli/FQdnH7Q=;
	b=peGVVIzpk6NRzoqWxPivGRIQ66Mp2LeLXLBa1XdoYCn+CoR4IpjGMhKa3Ze+kbq00R
	Au2CMalh+yXyelpJQuAqIOeRe4zFbCejD0FaFSy4k6rLchkMKUM1W8CrReDR25EjVaxY
	+CQoKHb0kg6VCh4QmH1gc9sOwRHCYaTcYH99oxroYPAMz4XdlSHOc9SdtaaoCP4l//xw
	hCpgJurB/W93Jj7TUB8ueG+bCTsH7IHkYzjrnu10stxw3HVktJJaA6+VzMaCphNE/P96
	r6bj0u8u2fJOcm9vpKM9T+RsHbW2lnT3IfqJg8/meaPE9OpMX5DrACQR6sVSs+4y21rm
	Kqhg==
X-Gm-Message-State: APjAAAUn5iyCnf5xZIZHOWmGls6YuKk+e4KcwjUiL8NAn4voEWbJGhbs
	SVf7sAmUGQMuXhJJMGtxMbU=
X-Google-Smtp-Source: APXvYqyUqjQ69SbkDau/DNqO9hpeBBPaHX/XWFy6Lsr5AeP0/vxKd2VuOcL+Fkb3w+fIgLfQ29jePw==
X-Received: by 2002:aa7:8008:: with SMTP id j8mr48207854pfi.120.1556691516017; 
	Tue, 30 Apr 2019 23:18:36 -0700 (PDT)
Received: from voyager.jms.id.au ([36.255.48.244])
	by smtp.gmail.com with ESMTPSA id
	s7sm24493837pfb.38.2019.04.30.23.18.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 23:18:35 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
	Wed, 01 May 2019 15:48:29 +0930
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  1 May 2019 15:48:27 +0930
Message-Id: <20190501061827.23080-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH] arm: aspeed: Set SDRAM size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501061827.waskBuJHDCERgyBtdBRn4eif_o17lCNwViSmlB3mJkc@z>

We currently use Qemu's default of 128MB. As we know how much ram each
machine ships with, make it easier on users by setting a default.

It can still be overridden with -m on the command line.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/arm/aspeed.c         | 6 ++++++
 include/hw/arm/aspeed.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 1c23ebd99252..3f3d4162b3c5 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -331,6 +331,8 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
+    if (board->ram)
+        mc->default_ram_size = board->ram;
     amc->board = board;
 }
 
@@ -352,6 +354,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx25l25635e",
         .num_cs    = 1,
         .i2c_init  = palmetto_bmc_i2c_init,
+        .ram       = 256 << 20,
     }, {
         .name      = MACHINE_TYPE_NAME("ast2500-evb"),
         .desc      = "Aspeed AST2500 EVB (ARM1176)",
@@ -361,6 +364,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx25l25635e",
         .num_cs    = 1,
         .i2c_init  = ast2500_evb_i2c_init,
+        .ram       = 512 << 20,
     }, {
         .name      = MACHINE_TYPE_NAME("romulus-bmc"),
         .desc      = "OpenPOWER Romulus BMC (ARM1176)",
@@ -370,6 +374,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx66l1g45g",
         .num_cs    = 2,
         .i2c_init  = romulus_bmc_i2c_init,
+        .ram       = 512 << 20,
     }, {
         .name      = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .desc      = "OpenPOWER Witherspoon BMC (ARM1176)",
@@ -379,6 +384,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx66l1g45g",
         .num_cs    = 2,
         .i2c_init  = witherspoon_bmc_i2c_init,
+        .ram       = 512 << 20,
     },
 };
 
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 325c091d09e4..02073a6b4d61 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -22,6 +22,7 @@ typedef struct AspeedBoardConfig {
     const char *spi_model;
     uint32_t num_cs;
     void (*i2c_init)(AspeedBoardState *bmc);
+    uint32_t ram;
 } AspeedBoardConfig;
 
 #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
-- 
2.20.1


