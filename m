Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6738FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E1820767
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxTyrefT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E1820767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRNP-00085Z-Gw
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHI-0005Ya-7u; Mon, 22 Jun 2020 14:34:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHF-00081t-No; Mon, 22 Jun 2020 14:34:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id v3so10236374wrc.1;
 Mon, 22 Jun 2020 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w9zmq1kRJoejsqJTIGulL0Ce1JIRJ0ye1ggwRzkHcEg=;
 b=BxTyrefT2W7rvrE7kM6h+dP/jU3O+Mr7Mo3efzJqU01SP/TPJyNeUfvnPUVs9TDNkF
 C6y+tdWQulpF6TI/WcDe6pOViEsFyfYqDKXjJJUzW0cpMc32qw6BJYKx/bvBI6u3pCfx
 IpXd8lvrHZyT2++lgPopOs1V2ji1VVuxMB1ZK9i3XRUp/k39i1QPSOiyio3/T5iDeezd
 QZqQ0Q0zcpMweJCjkiYl4gpZgyKaAEGCP4eAAweRbw6lV9s0EsDEMttW5ifFEGNMXnGv
 9+2QsX7XnaRu45xCVjoG0rAC2MxgJLeSMKF/FkC/7ZqOkYxudMZJS0qfZdYmF9k3Nzpn
 Y+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=w9zmq1kRJoejsqJTIGulL0Ce1JIRJ0ye1ggwRzkHcEg=;
 b=tyGQE6IAS7Q3IazmC3tKA3WyN/zURoNdfD2nI5yg+ZamJRSOgjOxldd+qGYJGgGdhO
 56Bjo0vkp+/g+juD7wL8Fcxta9gN93n16g1j/CeaSw9VXYshAtGQEqUzAn2jE+k88V1d
 utUylvrqU+12c5Ak8/AyO4pP5ZewxZDuasSZBq16g9s7iaV2qpi3iT2nlrR2AbK4LEIP
 mPS3T6VvWwGkG7sjxhnNb1OWHrZU2kqOJoHkvz/F7bGhj+YlOXWU78hDsM2G1v5CvYvf
 wKSWj5LoIYbcZf3pYxHrfBAQz9b9sI7Kvavgl3Jr3jT/w9vtjihkBqHNsCUR7wUvqbGT
 rMvA==
X-Gm-Message-State: AOAM5300jUClFRZxv1cIb+3entc8vxXjAYM8JoBTlTuG9gm6LYxhozbM
 r0XC26p2HqZSJUTylnD0UTB4isc2
X-Google-Smtp-Source: ABdhPJxexw6Msb2sPOzIy8ynMsYXvROSyk7nPM0syaIyg53PtCzcLAymmcgmgdMqYjF9tzQBgLCJkw==
X-Received: by 2002:adf:92c4:: with SMTP id 62mr20161103wrn.290.1592850879854; 
 Mon, 22 Jun 2020 11:34:39 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h29sm20286161wrc.78.2020.06.22.11.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 11:34:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 7/9] hw/arm/aspeed: Describe each PCA9552 device
Date: Mon, 22 Jun 2020 20:34:26 +0200
Message-Id: <20200622183428.12255-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622183428.12255-1-f4bug@amsat.org>
References: <20200622183428.12255-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have 2 distinct PCA9552 devices. Set their description
to distinguish them when looking at the trace events.

Description name taken from:
https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Markus Armbruster <armbru@redhat.com>
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


