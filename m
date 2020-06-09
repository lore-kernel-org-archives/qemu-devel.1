Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17695C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2942207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNR3Apgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2942207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidcz-0007BX-W1
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSp-0000M5-KE; Tue, 09 Jun 2020 08:34:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSe-00074i-Hm; Tue, 09 Jun 2020 08:34:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id t18so21115874wru.6;
 Tue, 09 Jun 2020 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l+sqnGxutMS7S4hG3iKjsUBAXpEh0W5dJMui9M/7l+Q=;
 b=rNR3ApgveJWwvJDFhJ1IHBCPvRP2djQPNMMu/l2o5r+IK8aaHIOdsyVqZONAuAVG5n
 SSGV+hE3uNMDibES9uA7pDUmFkIQ3UYoA/4VyhHkCFoW/GnQ93fYz93FyIti9fcC6HtS
 OnuR2+f9+egw1CEK3SOwH9ftG6XhyWnbj3KfZVOlVjQdxyeUDhUbWrLnXTcf8IU55pSQ
 wsnvB0Iv3IChPzicuT8AJTmeW8IDi3kBXCS5lBiwVX0UBcSTaEFMBNxSMJp7oYwPoRb3
 im/ibldYmAcg0K9qcwnkOQifHbVNNyZI13vvbV72JFYc2u6qv8mjS16Oy7saA9q2u4yt
 nI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=l+sqnGxutMS7S4hG3iKjsUBAXpEh0W5dJMui9M/7l+Q=;
 b=fFkz4bdkNy25QLojLZUbgm8EYLpHQfivQjdK5ymUMRjkVOY8JbmejJYNnBXjcqHSwx
 +CtsI9qzMJXTcpxIFURXCta3KBIdzcSkFDRJ8z4c/jkqQEpPu9ZL647ZZKC5NJUUsOG/
 9sHtDRSryh/mtNXYYOKIZfBGKZh0F+5agRZ/zDZNqT7n/ZLeOfbcN7aKdmKTnW8xU0r7
 HZOEZTq9PAkMpcozEYuajJmdC9iUmkjtcOTWHEXvYyW3JZuV2qK8CETnles5kQgRzGIf
 4e/IIXuqCoDo6o3NKze8klgDNnMUZUr9k7tHBhSqXrSZNfcDkxKFixrNTIIYgdMjOOYU
 Ec/A==
X-Gm-Message-State: AOAM532P3K4cIRHihJYTy5klrO1Lpku+5xrD8X1Ze92VRxXono0dfV7X
 6MBG9+1FEoJJIfIP0vnJm0h7512h
X-Google-Smtp-Source: ABdhPJxIkIw5hvZ5XCCJBD6CQvXERDw2Jdb6ATD6aCR/4WE7i65U1P0Uf2uRRIFXV3w1wsjCgdlCDg==
X-Received: by 2002:adf:e887:: with SMTP id d7mr4148418wrm.62.1591706070498;
 Tue, 09 Jun 2020 05:34:30 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c81sm2920931wmd.42.2020.06.09.05.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 05:34:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/5] hw/misc/led: Add create_led_by_gpio_id() helper
Date: Tue,  9 Jun 2020 14:34:23 +0200
Message-Id: <20200609123425.6921-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609123425.6921-1-f4bug@amsat.org>
References: <20200609123425.6921-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add create_led_by_gpio_id() to easily connect a LED to
a GPIO output.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/led.h | 14 ++++++++++++++
 hw/misc/led.c         | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
index 427ca1418e..58393c16de 100644
--- a/include/hw/misc/led.h
+++ b/include/hw/misc/led.h
@@ -27,4 +27,18 @@ typedef struct LEDState {
     uint8_t reset_state; /* TODO [GPIO_ACTIVE_LOW, GPIO_ACTIVE_HIGH] */
 } LEDState;
 
+/**
+ * create_led_by_gpio_id: create and LED device
+ * @parent: the parent object
+ * @gpio_dev: device exporting GPIOs
+ * @gpio_id: GPIO ID of this LED
+ * @name: name of the LED
+ *
+ * This utility function creates a LED and connects it to a
+ * GPIO exported by another device.
+ */
+DeviceState *create_led_by_gpio_id(Object *parentobj,
+                                   DeviceState *gpio_dev, unsigned gpio_id,
+                                   const char *led_name);
+
 #endif /* HW_MISC_LED_H */
diff --git a/hw/misc/led.c b/hw/misc/led.c
index 233843f581..27882e2f9d 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -86,3 +86,23 @@ static void led_register_types(void)
 }
 
 type_init(led_register_types)
+
+DeviceState *create_led_by_gpio_id(Object *parentobj,
+                                   DeviceState *gpio_dev, unsigned gpio_id,
+                                   const char *led_name)
+{
+    DeviceState *dev;
+    char *name;
+
+    dev = qdev_create(NULL, TYPE_LED);
+    /* TODO set "reset_state" */
+    qdev_prop_set_string(dev, "name", led_name);
+    name = g_ascii_strdown(led_name, -1);
+    name = g_strdelimit(name, " #", '-');
+    object_property_add_child(parentobj, name, OBJECT(dev));
+    g_free(name);
+    qdev_init_nofail(dev);
+    qdev_connect_gpio_out(gpio_dev, gpio_id, qdev_get_gpio_in(dev, 0));
+
+    return dev;
+}
-- 
2.21.3


