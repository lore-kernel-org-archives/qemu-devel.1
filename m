Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37517C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DAF2474C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUttuOc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DAF2474C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmVQ-0006Tg-8O
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmS4-0000w9-Pf; Sat, 20 Jun 2020 18:59:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmS3-0000yh-9m; Sat, 20 Jun 2020 18:59:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id g10so11659869wmh.4;
 Sat, 20 Jun 2020 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DyoF/qLlFB6Eqm6PiYWnf/NDgGben7zze4O/C89Ofx4=;
 b=fUttuOc5T9+Vum1IoeF53eY8N9xHFxiKg1QORzz2CBWl4iRgr27gthZm7FOfRwoenl
 DUxnowonYsFlT73NZdK5+yqana+16k/Leobko+jg7R8KJn6A1uCqCZGBgoII4nfSKepj
 DRBhc+6XdewhICifS9L629CRZDm36a/ulm0U2OeAZOLKsBibGV+oPoObvWFIE1xmIdO7
 AcNLjdIGmkG5GzVZ1e4gR0QNZBKa1dQaAg1LTdEpLWq5r41cIPjsA6w/mMGAxlSw6gxF
 ugqlFD3gHSEyFngKDar5s+/jb45hDTFu9fwy9DOsAwaq9G80Y+dF7X8/y3PuJPO+pROi
 awWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DyoF/qLlFB6Eqm6PiYWnf/NDgGben7zze4O/C89Ofx4=;
 b=DFM2mJhXd6qfYw/cMI3nvtISjUO2cvDDc7O4C4m0N+PUa1LiFa62iRmTfQT8tiQhT4
 DLvQ6RZUl2nBhiUcwhthmHLcVee9jPxGIDpmZg6uzy1KOYporegqZ0WQn5wlnpZE/gQm
 tX6FRhNi0WFe4aN7Etk7YxDJdb66tZ8rN5IdQLRQtRVVkRi02/xBbIrGfVKSjK22km8Z
 lkLtCqLmRbnuRKGlRqXCBkHi7CpDOj/rJR7DPvBsV/UEuXFwtPBwB0nTgnuQ4svpoCVc
 ZaamX8WMjJVHXedvcM+5T4Hq9JEt55WnVSNwlhTlk90yzVP3n/5DkmY11KkLiVk6D+Wn
 AaRg==
X-Gm-Message-State: AOAM532tU4jbew96/kEz5ncEeJ4UAWdYA7hgNAJR6O+QKM5OVjCKgUOR
 LOKC7aqfUQDJEB6HiqkhUNizxmUb
X-Google-Smtp-Source: ABdhPJwmJuqvrmd+9+mSldLaZD1CttABpdele+POohVLviVItf1VS1jY4jF8AqeLqWoFY29d4AQhHA==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr9973381wmj.96.1592693945585;
 Sat, 20 Jun 2020 15:59:05 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x18sm11147127wmi.35.2020.06.20.15.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 15:59:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/8] hw/arm/aspeed: Describe each PCA9552 device
Date: Sun, 21 Jun 2020 00:58:52 +0200
Message-Id: <20200620225854.31160-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620225854.31160-1-f4bug@amsat.org>
References: <20200620225854.31160-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have 2 distinct PCA9552 devices. Set their description
to distinguish them when looking at the trace events.

Description name taken from:
https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6b7533aeee..3d5dec4692 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -508,12 +508,15 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
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
@@ -528,8 +531,10 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 
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
2.21.3


