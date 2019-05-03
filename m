Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BB1C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 02:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189D92070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 02:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qB+bd1Tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189D92070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33206 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMNyi-0004ce-1I
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 22:31:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hMNxk-0004Aw-IE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 22:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hMNxj-0004Y8-GR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 22:30:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hMNxg-0004WJ-Ry; Thu, 02 May 2019 22:30:09 -0400
Received: by mail-pf1-x444.google.com with SMTP id 188so2098873pfd.8;
	Thu, 02 May 2019 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ImFcpEK++OdN2NYNnGGENQUJu5nKLClznJohWQ/wzxg=;
	b=qB+bd1TgqAjM7SFH+Xp8Fc3sBEeemrNRxcysNjEgKXS7Zn0qkTlJniIKtlR61PiVE2
	TtvWOPaUitfiiCAn/s0UOSfjzOhy1gbiyonJBQZSREEZTyv8/uWLhQYra1k5mEduimu+
	w7LH8rMXV1bHVc3Mql4+6slRcdUWJsC4EQsB2XfIRVfB0poH8V/K96jww8Et5zYbnaul
	WS3ne7g8LGcD9PdAOA224bt5RvgleigZM/CaMkuNQtENddmnsNUvCScbpkMNMHxgmbbr
	mHlswBk74NNscdRVLz0/gvodcTUonOe04QUO5pFn1kNFyKQ5UXK6EaOyv/oSvuoZYBF5
	W+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=ImFcpEK++OdN2NYNnGGENQUJu5nKLClznJohWQ/wzxg=;
	b=QJqtk4zog4K4Qk76waXNLd8VmZXPRPTmbi4Dcv5MUM7EFnWzV5wH07Gh9/tBh6kUx9
	vYOQABiBzK/7fZ3Ms+3bczSTsrmsmKsEqVytWIUs5O9GgOeWkSbfdm8+PNkeD1B76Rcj
	T/7VtbzeANZKvnKohuJS1M9Q+h+lLmaE7dinBvOZ6dW+eMUVezndgAl4vP5MrTP1UibI
	zunhslfernxn0QrTugGlfqnvnEU/ll21GWkhdqYStrvN7tkJGy9kK7RUfPcyHDBPT4lf
	AHYivHaWiBmqIcJv6mmvpxQUyMczNDvpUcjAJ6xYz2g9ALaDJWrYjoRhqiQGiqPwSq+y
	sh0Q==
X-Gm-Message-State: APjAAAU8C/7cg7xan4eGX/xhEAr35yZMQAUxMtXRUHJNTjSoPImqrNbW
	BKVWjWojYLMcGhcC/ll4JrY=
X-Google-Smtp-Source: APXvYqxoITmXnnDOx5xofKCXBEsD0wXqMA6SM14nNKoAehaoA6FG03zDzbqzaAe008KBxL8gbeA4FA==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr7921827pfi.126.1556850606977; 
	Thu, 02 May 2019 19:30:06 -0700 (PDT)
Received: from voyager.jms.id.au ([36.255.48.244])
	by smtp.gmail.com with ESMTPSA id m16sm723566pfi.29.2019.05.02.19.30.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 19:30:06 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
	Fri, 03 May 2019 11:59:59 +0930
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 May 2019 11:59:57 +0930
Message-Id: <20190503022958.1394-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2] arm: aspeed: Set SDRAM size
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
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503022957.uPcBcYSEluS4r9hKYmrCPwJpqr9ygU-SNgX2sdKIxtE@z>

We currently use Qemu's default of 128MB. As we know how much ram each
machine ships with, make it easier on users by setting a default.

It can still be overridden with -m on the command line.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2:
 - Fix 'if' style issue. Thanks patchew
 - Use units.h defines

 hw/arm/aspeed.c         | 8 ++++++++
 include/hw/arm/aspeed.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 1c23ebd99252..29d225ed1405 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -25,6 +25,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 
 static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
@@ -331,6 +332,9 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
+    if (board->ram) {
+        mc->default_ram_size = board->ram;
+    }
     amc->board = board;
 }
 
@@ -352,6 +356,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx25l25635e",
         .num_cs    = 1,
         .i2c_init  = palmetto_bmc_i2c_init,
+        .ram       = 256 * MiB,
     }, {
         .name      = MACHINE_TYPE_NAME("ast2500-evb"),
         .desc      = "Aspeed AST2500 EVB (ARM1176)",
@@ -361,6 +366,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx25l25635e",
         .num_cs    = 1,
         .i2c_init  = ast2500_evb_i2c_init,
+        .ram       = 512 * MiB,
     }, {
         .name      = MACHINE_TYPE_NAME("romulus-bmc"),
         .desc      = "OpenPOWER Romulus BMC (ARM1176)",
@@ -370,6 +376,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx66l1g45g",
         .num_cs    = 2,
         .i2c_init  = romulus_bmc_i2c_init,
+        .ram       = 512 * MiB,
     }, {
         .name      = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .desc      = "OpenPOWER Witherspoon BMC (ARM1176)",
@@ -379,6 +386,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx66l1g45g",
         .num_cs    = 2,
         .i2c_init  = witherspoon_bmc_i2c_init,
+        .ram       = 512 * MiB,
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


