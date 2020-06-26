Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E3DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAE6207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9I6MPnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAE6207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqJ6-0004P6-Ud
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3z-00024V-3I
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3r-0006HF-Uu
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id o8so9155250wmh.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=amm+Xwelw2VlS16IoGViV05sMwQyqKglsr1nUDeUMzc=;
 b=L9I6MPnBMynVstZHCNTeCqW3qUr/7ccQdoU+qM9PT+EOsSfQEMVYOtBa1kp4ryCFLu
 0y2fEm1SMmXZScba85AQpTJEhoc1sh18GdaKSj49LMrta6nr9Mux/iDOWfeg8rhixGdh
 gCgQJv84HoSSZhza/IdEjKbesTLa3e03sj5WrMiSQzi7t/322MYfsvcBTMWF307mB+GU
 6oSauxf8PvUiGpLWit25+78+c/6WT+a7QfuTyePF3SU23ky9uH3UVikK0AVsRBWJV0uC
 39XPBpbNYY2LYL4Rhwz6jWWBYGxwoHi8MRKyGAReQGRT1SgrAUmDN/i9m8BcITjbCu45
 F+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=amm+Xwelw2VlS16IoGViV05sMwQyqKglsr1nUDeUMzc=;
 b=W6RfdsFx9wK4v9z0biiVDB2yfmGLkcEARrwgtTG4W/JYM5ZouL64fn3aL3keV64RKk
 4eN99gXfewx2nj+tfPj5lVULOLi991Pw+QLsi+tLX3Jw3szMqttPnZG7HHZ5xwWhYLwq
 ns7PCYhDk2AqpYliWs3p11LPhmdBtXsEORyzt0RQ1rIPbZi9E2gnLYSFjxTJi0VwXclU
 IVjmSgXw9vj3oMqzFXAy/raSGhdzqoP4vuBakBr2Wdebfe4oDrWNtz6jLF4dbFb0tMgj
 iea7LzcUT79lQvqUyq895XczBPLBvrZKL8/RlEsmuvkm4ar16nRKpvepS+CM4CrYNwsz
 ZASg==
X-Gm-Message-State: AOAM5323Ll4PWEofJVOEKA9MK9Pk/SImE4FlrERTgwzHBz4LUE/FnbZs
 eZskKkTgyba4Yc1uKWa02PxKDcD9YXIA6A==
X-Google-Smtp-Source: ABdhPJxhCc25FxQW1bYV1tSWDd0I0659PEMnjTzbnTzZvBK9qBw0ArGLuChi5oSOU9tGC17mazsqZw==
X-Received: by 2002:a1c:2d83:: with SMTP id t125mr4026270wmt.187.1593184477864; 
 Fri, 26 Jun 2020 08:14:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/57] hw/arm/aspeed: Describe each PCA9552 device
Date: Fri, 26 Jun 2020 16:13:37 +0100
Message-Id: <20200626151424.30117-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We have 2 distinct PCA9552 devices. Set their description
to distinguish them when looking at the trace events.

Description name taken from:
https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072723.6324-8-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 665d04fbf68..379f9672a56 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -508,12 +508,15 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
+    DeviceState *dev;
 
     /* Bus 3: TODO bmp280@77 */
     /* Bus 3: TODO max31785@52 */
     /* Bus 3: TODO dps310@76 */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), TYPE_PCA9552,
-                     0x60);
+    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
+    qdev_prop_set_string(dev, "description", "pca1");
+    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3),
+                          &error_fatal);
 
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
@@ -528,8 +531,10 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
                           eeprom_buf);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), TYPE_PCA9552,
-                     0x60);
+    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
+    qdev_prop_set_string(dev, "description", "pca0");
+    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11),
+                          &error_fatal);
     /* Bus 11: TODO ucd90160@64 */
 }
 
-- 
2.20.1


