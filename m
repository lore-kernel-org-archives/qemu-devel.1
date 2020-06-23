Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3776C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F592073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPEsLVGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F592073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndTX-000324-RE
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndLG-0007Oq-Bz; Tue, 23 Jun 2020 03:27:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndLE-00053E-Nq; Tue, 23 Jun 2020 03:27:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so1974372wmj.0;
 Tue, 23 Jun 2020 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cQWrrOjiH+RMyDmWVM8pHcDG12KNvT2rkKlC4EXMTXY=;
 b=sPEsLVGHeOqD/Zj02ggTSwtJ54QlPAC/Cp13eSWnefLNMW/z6G6BfbLBj0kDn1C0iI
 IzR0J9pPjtVqS2cYqGSmvipyhTW369k2QGZRTB03tlYenoVswdW5L+UpW0jQvkMlibG1
 EKlSygvhHcd+7D5Xg36pbEOlSESCMhARkH7f8w5LBodytLDFKrKnCYYXCUoZQUFn5cs/
 f0C6sr4ZfXidF8/YeAHxzhmkNYg3P9GF0Vjr4RfW3AmplK1ReaQ0XzuYRC9Ig3brwOh7
 glmE0554OYKvXuayewP1B76US5Kdr6R5tbbFLvRDa0rCKo9wiSrHB2UE6V847qxlam9w
 nz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cQWrrOjiH+RMyDmWVM8pHcDG12KNvT2rkKlC4EXMTXY=;
 b=NZoZzTIdzfp189WFvvffDdsSSv24WYOYThhwERhrExxfJf6Z0ffFsg8A6HQGfJf15l
 112FZOKwHngw9jlqe5J5vjo2MR0DkrSO3vceAKpiuC6ucpawwPaXH8uGU+RAzaDe4Vis
 mqL4rdUqvMbAiIXijVccF+k1YjefwD9NL0sFG6qwCmjjjNVmaq5D3Fm+bGlIolqAJqXL
 w3WbNKbazumSrxQkRUMpM/C3hRjVNrACo0n0UPpwysKByiMq6vUQG/OF/yq62i083hDX
 7mnGwBhbohsJTTIlWN89kqQtw7R0BTke2ypCpGAaULQ/DtAtAhTOEbvqLrHHNX8rGy7s
 DHOw==
X-Gm-Message-State: AOAM532YmTEQwhevAziU9IMcmZGbnORQGLAg/e7Isg5M7IHNKEAJ8cDF
 Cl4J/gJNOi8KpDqNb0wS02NvYvtV
X-Google-Smtp-Source: ABdhPJwHnJUMourNMxne2P/1naP81dDxJUmbtmXNz1BW1mr0wkVR5+ULjKMMOjs3Ki4nLZuyczwhLA==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr23654146wmc.159.1592897254759; 
 Tue, 23 Jun 2020 00:27:34 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l14sm4200059wrn.18.2020.06.23.00.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 00:27:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 7/9] hw/arm/aspeed: Describe each PCA9552 device
Date: Tue, 23 Jun 2020 09:27:21 +0200
Message-Id: <20200623072723.6324-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623072723.6324-1-f4bug@amsat.org>
References: <20200623072723.6324-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have 2 distinct PCA9552 devices. Set their description
to distinguish them when looking at the trace events.

Description name taken from:
https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Corey Minyard <cminyard@mvista.com>
---
 hw/arm/aspeed.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ccf127b328..307dba5065 100644
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
2.21.3


