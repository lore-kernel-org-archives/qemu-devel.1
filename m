Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FCFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131402070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkHs/KL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131402070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolcp-0000t8-8w
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jolaJ-0005sV-TG; Fri, 26 Jun 2020 06:27:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:55948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jolaI-0001wJ-A8; Fri, 26 Jun 2020 06:27:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id g75so8325794wme.5;
 Fri, 26 Jun 2020 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I4gUsATQ2ZD6rXbZ6R4i9ZHkTxgbVpcNWZTvIvkVuAY=;
 b=bkHs/KL4fX9D5GqDcxYvskU1Wc0cfcbxUgEU2ntVl/B4gqdtcDcPxlShUtiiJiuIaX
 Vr/P7J+J0ITHX3Pe9n4ib+kxuzqTJV3Z5pWVj1jttiIXE4fwqVNqFoRlm9x+aL8Qqks7
 Hi7TO8RjuDoExRyHrK02W3CCNIyL6Jg/lUoXVVtTDmYsE3nY+nBbNFxR/4pPIsKESxvu
 sH2vNsKc7xYVI/9ozcSL2YL7q3KSv9wkAM+Am9hVw+Hcj4yz2bK10LDSuv9Imb0Fyi6L
 /AuImvGENJTXej+oISnWC4KaSDy3sQl2JsL67CvXtYNxwq4+jsynnwpHGT3ssMtkbpWQ
 Pikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=I4gUsATQ2ZD6rXbZ6R4i9ZHkTxgbVpcNWZTvIvkVuAY=;
 b=h/tNTIBd7p3EBb1FItfUcqc5YlNl3Ae1RjBGV39suxe4OoEWxxKZyoT1yxLpoXzs63
 rNEtxpXsGWqXEeFy+Tptdr1jhtkxHJWzQQjrgqgWPUWCCyVNQpQ1M0HQntXlZvjwssDw
 YycPOGtWm3vHxbgIp+UAOCwJqCQp7nI/FB6uRxOGmwPuq0jZWhSFnir/2vaVsV7v5hRF
 qZu8B/fEHQoN5efAgzf+44FJ/huIs9mde0tCuxBQ8mdhQHjvRL4Sbg71K7OsqFc6T/KK
 j0nKHN8VENmPDaEtBHuMXzdXOgHvpyYS6A7U7vfsaLznlaFdrlNyCHuLFA9mAhCjDmkL
 AIHA==
X-Gm-Message-State: AOAM5310BAMgDq21vKfv+DEMXWLjp0TzSq1bb9Z3OghYYu9ROuj4dLEA
 V9jWOJZc9IhFnDoDLUFpm6c=
X-Google-Smtp-Source: ABdhPJxyL9hVvmZLGKBAE5GQThkXql4poC2yev5Cyb0fhH7rywCnXTqInC6vF5XY6itOJiy6vnTNVA==
X-Received: by 2002:a1c:a74c:: with SMTP id q73mr2604260wme.96.1593167268649; 
 Fri, 26 Jun 2020 03:27:48 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f13sm15598194wmb.33.2020.06.26.03.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 03:27:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 1/3] hw/i2c/smbus_eeprom: Set QOM parent
Date: Fri, 26 Jun 2020 12:27:42 +0200
Message-Id: <20200626102744.15053-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626102744.15053-1-f4bug@amsat.org>
References: <20200626102744.15053-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Aspeed change pending latest ARM pull-request, so meanwhile sending
as RFC.
---
 include/hw/i2c/smbus_eeprom.h |  9 ++++++---
 hw/i2c/smbus_eeprom.c         | 13 ++++++++++---
 hw/mips/fuloong2e.c           |  2 +-
 hw/ppc/sam460ex.c             |  2 +-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.h
index 68b0063ab6..037612bbbb 100644
--- a/include/hw/i2c/smbus_eeprom.h
+++ b/include/hw/i2c/smbus_eeprom.h
@@ -26,9 +26,12 @@
 #include "exec/cpu-common.h"
 #include "hw/i2c/i2c.h"
 
-void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t *eeprom_buf);
-void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
-                       const uint8_t *eeprom_spd, int size);
+void smbus_eeprom_init_one(Object *parent_obj, const char *child_name,
+                           I2CBus *smbus, uint8_t address,
+                           uint8_t *eeprom_buf);
+void smbus_eeprom_init(Object *parent_obj, const char *child_name_prefix,
+                       I2CBus *smbus, int nb_eeprom,
+                       const uint8_t *eeprom_spd, int eeprom_spd_size);
 
 enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
 uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size);
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index b7def9eeb8..879fd7c416 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -165,7 +165,9 @@ static void smbus_eeprom_register_types(void)
 
 type_init(smbus_eeprom_register_types)
 
-void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
+void smbus_eeprom_init_one(Object *parent_obj, const char *child_name,
+                           I2CBus *smbus, uint8_t address,
+                           uint8_t *eeprom_buf)
 {
     DeviceState *dev;
 
@@ -173,10 +175,12 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
     qdev_prop_set_uint8(dev, "address", address);
     /* FIXME: use an array of byte or block backend property? */
     SMBUS_EEPROM(dev)->init_data = eeprom_buf;
+    object_property_add_child(parent_obj, child_name, OBJECT(dev));
     qdev_realize_and_unref(dev, (BusState *)smbus, &error_fatal);
 }
 
-void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
+void smbus_eeprom_init(Object *parent_obj, const char *child_name_prefix,
+                       I2CBus *smbus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int eeprom_spd_size)
 {
     int i;
@@ -189,8 +193,11 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
     }
 
     for (i = 0; i < nb_eeprom; i++) {
-        smbus_eeprom_init_one(smbus, 0x50 + i,
+        char *name = g_strdup_printf("%s-%d", child_name_prefix, i);
+
+        smbus_eeprom_init_one(parent_obj, name, smbus, 0x50 + i,
                               eeprom_buf + (i * SMBUS_EEPROM_SIZE));
+        g_free(name);
     }
 }
 
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 8ca31e5162..304a096c6a 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -377,7 +377,7 @@ static void mips_fuloong2e_init(MachineState *machine)
 
     /* Populate SPD eeprom data */
     spd_data = spd_data_generate(DDR, machine->ram_size);
-    smbus_eeprom_init_one(smbus, 0x50, spd_data);
+    smbus_eeprom_init_one(OBJECT(machine->ram), "spd", smbus, 0x50, spd_data);
 
     mc146818_rtc_init(isa_bus, 2000, NULL);
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1a106a68de..064d07f4e2 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -337,7 +337,7 @@ static void sam460ex_init(MachineState *machine)
     spd_data = spd_data_generate(ram_sizes[0] < 128 * MiB ? DDR : DDR2,
                                  ram_sizes[0]);
     spd_data[20] = 4; /* SO-DIMM module */
-    smbus_eeprom_init_one(i2c, 0x50, spd_data);
+    smbus_eeprom_init_one(OBJECT(machine->ram), "spd", i2c, 0x50, spd_data);
     /* RTC */
     i2c_create_slave(i2c, "m41t80", 0x68);
 
-- 
2.21.3


