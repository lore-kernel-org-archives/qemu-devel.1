Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB86CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B432053B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTThksGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B432053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuJ1-0004Vy-6Q
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGK-00027r-8g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGI-00018s-QT
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:48 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:35259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGI-00018c-KI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id v9so265176wml.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GiGGoct5QT0NRciJUJZ8OfIOiz/gs+M8OMGCdLem8zI=;
 b=kTThksGcOrvic9/PBkd9pcPAfj2nLPp2N6yEUZd5IcQ71yucX57/V5NRLEezGtUAW5
 UYrsGERzSFHP/44fqkptoYtbpPituwjO6yf6j2ZfBS6/k42Oow5LjyMKGbAa9WWyogaX
 bx2d198S1cq3IApVjK/mYZcfiAXZpkqKqKnwNriIuCFyT0h/zYWaA0VeI7Yb7Bay31xr
 KlPWRcx2dx/Tq/rjsW63YyR31nnrsZO01AOzTzi3XoQQDEAlZQgoh5jlHeo1Mzv7cbX8
 FqazRn4EgjcKv36IfT6H3RjQ4KfydGn4zWUPVxHN515YH+nqaDuNvWZtub6j3nZ927Jb
 xcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GiGGoct5QT0NRciJUJZ8OfIOiz/gs+M8OMGCdLem8zI=;
 b=a2s5ZPU0/UA5E4XccMvcVL3b08Snkzr1CkPIpmx2Dq2NoDpH46Jx2QvKJ1lykCCCO8
 LarTRufSrhHywkeKkMSCGYBPUtZv0pcw2wzN6VipBu3FegIHVrqPRtefo2rLe9fKK+7h
 b5qlFe0aOzvdSK6duMFloLdn1szsostaJB+EIQ3JsFH1wWOXzs4LO7ULvn1h4X9fzfAA
 h28bE+tQ6V945SsMZXv3ijDM9t91Sv6N7YrYZF1jyuqIrwhN517Eoov1YqEcy2Ydf5ph
 wP2nJHTBOZdZp+92pXlprOIUr/pZr8sTEdCFc21I9SHry7bOwsruD/KoE4LWyl3z+i/G
 snHw==
X-Gm-Message-State: APjAAAWIwLmFZvPxPuDM3r3hgN5bWKPBYU/n6sVpxwPryWT3O9aAqeco
 LQQ0+DGhBY8ERvA6/Ake8oJbsH+9/nk=
X-Google-Smtp-Source: APXvYqxYuGbCUiE34bEKQA/fHTu00jhwpMTJZh/s9P5uiNtUTP9A+fbeEPGGpqs2iPEyvomjfmj2Zw==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr3195982wmc.143.1571751103637; 
 Tue, 22 Oct 2019 06:31:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.31.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:31:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/41] aspeed: Add an AST2600 eval board
Date: Tue, 22 Oct 2019 14:30:55 +0100
Message-Id: <20191022133134.14487-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

Define the board with 1 GiB of RAM but some boards can have up to 2
GiB.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20191016090745.15334-1-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed.h |  1 +
 hw/arm/aspeed.c         | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 02073a6b4d6..f49bc7081e4 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -18,6 +18,7 @@ typedef struct AspeedBoardConfig {
     const char *desc;
     const char *soc_name;
     uint32_t hw_strap1;
+    uint32_t hw_strap2;
     const char *fmc_model;
     const char *spi_model;
     uint32_t num_cs;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 52993f84b46..028191ff36f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -88,6 +88,10 @@ struct AspeedBoardState {
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
 
+/* AST2600 evb hardware value */
+#define AST2600_EVB_HW_STRAP1 0x000000C0
+#define AST2600_EVB_HW_STRAP2 0x00000003
+
 /*
  * The max ram region is for firmwares that scan the address space
  * with load/store to guess how much RAM the SoC has.
@@ -187,6 +191,8 @@ static void aspeed_board_init(MachineState *machine,
                              &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), cfg->hw_strap1, "hw-strap1",
                             &error_abort);
+    object_property_set_int(OBJECT(&bmc->soc), cfg->hw_strap2, "hw-strap2",
+                            &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), machine->smp.cpus, "num-cpus",
@@ -308,6 +314,12 @@ static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
 }
 
+static void ast2600_evb_i2c_init(AspeedBoardState *bmc)
+{
+    /* Start with some devices on our I2C busses */
+    ast2500_evb_i2c_init(bmc);
+}
+
 static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
@@ -455,6 +467,17 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .num_cs    = 2,
         .i2c_init  = witherspoon_bmc_i2c_init,
         .ram       = 512 * MiB,
+    }, {
+        .name      = MACHINE_TYPE_NAME("ast2600-evb"),
+        .desc      = "Aspeed AST2600 EVB (Cortex A7)",
+        .soc_name  = "ast2600-a0",
+        .hw_strap1 = AST2600_EVB_HW_STRAP1,
+        .hw_strap2 = AST2600_EVB_HW_STRAP2,
+        .fmc_model = "w25q512jv",
+        .spi_model = "mx66u51235f",
+        .num_cs    = 1,
+        .i2c_init  = ast2600_evb_i2c_init,
+        .ram       = 1 * GiB,
     },
 };
 
-- 
2.20.1


