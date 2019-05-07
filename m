Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93413C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C4E205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEFkh4Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C4E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45727 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyv1-0006Se-KK
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:09:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylp-0007Yd-7p
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNyll-0003YT-AT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:40732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNyll-0003T3-3H
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id h11so19612913wmb.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=PrRjWEvXDJOpA+k1xEwYJM/zCv1rnAwRsRuPQ3BARac=;
	b=SEFkh4Ts8NUCcvJYgBZUTsIazOT9KxG7PjAHXR2MYYwWINybauAR/I/bEOA3CuqhQi
	OnM/G786BZbgwmaV+qWvUygG7y+IbwmieOUfNYELOygKYsCy3pZRucXwHCVFMtb6p9zS
	RBC3JyFNsU8ACbvWM+kpCUyEzkU11bGZzI0iAkTnwXCzYiRfzGKd0rMsKMblc485b7Z+
	uzhU+L43WlrdiHeVFey04Z+/1z9wGkPjZY3j3mtjOVkhXxBnglG5rRNgpoqyGai4XfEf
	BbzUryJcMMqGhtmBBTLPEuZQBQ4b9PRa7WBSwV2LijGv4PT0oedkx5tXyqupA/NTvQIH
	NBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PrRjWEvXDJOpA+k1xEwYJM/zCv1rnAwRsRuPQ3BARac=;
	b=Ujeduspx6vOLzKxuaZH1v4yKyPuAFZT7H3m6uyIO2PZE7VzpeJ8/KALtNesYbjBJ2M
	nXrNJb8eXtrEBoAfb6acap/NbfXZCb7Fu+wo/vTs2+CK9+mORMatbM2fseEdRacDyzDv
	+EY0848401LUFPOdYM5WIqWTNTRiMsFIKN7TW890PuLimPDqC+CZog1w+BDb3sFjJ/49
	yCJXLvGgXFq7NNrzpKVo5l6OzVMt6O6I0tQMAAuMhs5Ga2HEQb3sO5bqsTPZiDdVHeVB
	r4x+Hwc01zivSraxiPPYl9clpMhxldRfM7soDcZEzl6N7QdfugpUQ7quK7GRFu78Fres
	7JQQ==
X-Gm-Message-State: APjAAAV3LpcktfJJyZruXtvT0FCJSmE9r91qdg6ePWKD5I8yb97p6bU7
	C7BLyyNYue+syTtZI8kdge5ty2dF958=
X-Google-Smtp-Source: APXvYqyENZCl8bjr1qVYft8KjoAvxuuZeCcdSAmR3AQqo1zbSKaXxv9h3vHQ825L++uh83Pu56R/lw==
X-Received: by 2002:a1c:cc18:: with SMTP id h24mr20151738wmb.13.1557230423217; 
	Tue, 07 May 2019 05:00:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.21
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:02 +0100
Message-Id: <20190507120011.18100-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 06/15] arm: aspeed: Set SDRAM size
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Stanley <joel@jms.id.au>

We currently use Qemu's default of 128MB. As we know how much ram each
machine ships with, make it easier on users by setting a default.

It can still be overridden with -m on the command line.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190503022958.1394-1-joel@jms.id.au
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed.h | 1 +
 hw/arm/aspeed.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 325c091d09e..02073a6b4d6 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -22,6 +22,7 @@ typedef struct AspeedBoardConfig {
     const char *spi_model;
     uint32_t num_cs;
     void (*i2c_init)(AspeedBoardState *bmc);
+    uint32_t ram;
 } AspeedBoardConfig;
 
 #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 1c23ebd9925..29d225ed140 100644
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
 
-- 
2.20.1


