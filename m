Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B604C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA832137B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApazatZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA832137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolbQ-0007LS-6W
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jolaL-0005uq-7V; Fri, 26 Jun 2020 06:27:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:39116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jolaJ-0001wn-M5; Fri, 26 Jun 2020 06:27:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id t194so8871806wmt.4;
 Fri, 26 Jun 2020 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+RGAeI2YQi8BvYPpg0jL49kCXhZNllGvIOiiTVLYTbU=;
 b=ApazatZNqHn4k3MF99XvzH6lKw+NE+uFPAQ81Qn9DLjU5UUsUQa+wVjkig55QJbdqY
 pDVGeXypbBunazp0cYlSFI0WjVkVz2SFQmHY3onQ09A4RZfQjpvj1PABoxED+iqGaJc0
 dgQnJaV8vB0y3LLtBgccyA1In9/goyxttNzWIQN3VjjpNUqrs6KQyAW4za7u43J8eDCy
 emMWeRXEO2nCdU2K/B1A/VE0XKT6pZNyqrZvI39u/gSvg7TT8KMSgUE5nQg0V/1qq137
 TBZWtNNtoDPgGZmFWRkEz4YFpgjpMej7O4rHQy3YGqqUQnu2niHVeIYgriPIFy1BIV+c
 7Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+RGAeI2YQi8BvYPpg0jL49kCXhZNllGvIOiiTVLYTbU=;
 b=PVAouLlGN4vtQTwZlNpoaShMn4giUMI/gbJjhMy7sCDRunRvPrYjRaZhqtn1UGfSOg
 +X9aYURFoeYxzNMlG/7X5RD4zSLmSVeGg2VxMPZWpRg7TS5PuCeboU44mjn7HYNkaEGH
 SCfSu3EDGIJzb5kR7xPOr1dHmBrl0xj6W93cfCLkM8AZAuxbnzMbxQ+ZlSRIij4xczsS
 XpmdQFNC373VRMn8mjl2xW/Z1EyMfAEqqF2YVEBXSks7o7B++C2/WaFTuRRbIqiDi0rb
 UAaSa/XCBuPA4lnA7lOPAHvE84iiDrtiX/iOkj5egPNCQ+YMEDfM+LglH6rZFvdphKF8
 3E9g==
X-Gm-Message-State: AOAM531fJGKh//KEKej8EJyr+ti48DrrA+QLWWFydVi4VuYfNjyBjnhn
 W9pJxFVgtL5N3kiHuR6CwIo=
X-Google-Smtp-Source: ABdhPJyvasXasrsn1HBuFEDzvGxvu1XYBhfFf3I3PaMAgWraoex16kxPbF1KY0Vp3kRGf47v+1kWLg==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr962291wmd.122.1593167270036; 
 Fri, 26 Jun 2020 03:27:50 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f13sm15598194wmb.33.2020.06.26.03.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 03:27:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 2/3] hw/i2c/smbus_eeprom: Add description based on child
 name
Date: Fri, 26 Jun 2020 12:27:43 +0200
Message-Id: <20200626102744.15053-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626102744.15053-1-f4bug@amsat.org>
References: <20200626102744.15053-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
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
 hw/i2c/smbus_eeprom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 879fd7c416..22ba7b20d4 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -47,6 +47,7 @@ typedef struct SMBusEEPROMDevice {
     uint8_t *init_data;
     uint8_t offset;
     bool accessed;
+    char *description;
 } SMBusEEPROMDevice;
 
 static uint8_t eeprom_receive_byte(SMBusDevice *dev)
@@ -134,7 +135,9 @@ static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
     smbus_eeprom_reset(dev);
     if (eeprom->init_data == NULL) {
         error_setg(errp, "init_data cannot be NULL");
+        return;
     }
+    eeprom->description = object_get_canonical_path_component(OBJECT(dev));
 }
 
 static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
-- 
2.21.3


