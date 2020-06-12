Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B257BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A94207ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgeaN6ED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A94207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjnuU-0008VV-Nv
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 13:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntQ-0006m1-5P; Fri, 12 Jun 2020 13:55:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38188)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntO-0004C0-JE; Fri, 12 Jun 2020 13:55:03 -0400
Received: by mail-wm1-x341.google.com with SMTP id f185so9061581wmf.3;
 Fri, 12 Jun 2020 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VXyjbLpDTuE00ge+DHFSib5N0fJzn7CQXE4wINPUlB8=;
 b=WgeaN6EDTCdw9MxoftZstnYi8CHZ3U1JYCFxBleSkd7EbSpdzQmfOjx5OS1JVxjWt5
 OYtwtqf7Xzcbef/HRl8EIqd/ICQxRSZcEAqLboLb1mOlae4VdM/9Fj5FfCI1KlRHz95h
 ucagw2uSH6/nTXs6mSywTuO0iPgPfgpQagg89vt8dx/25k8i6MSIdkyT4HB2C4BhViK6
 RvyfkIUqpVh5Lh9q+lGn+3phwsqqRmLs5XD0Gz+xGvkdM00F5z0WoXl+aSXUMkO5BEzF
 QTbTBb7ZTnxcV3WRG5EejgH7NixXpk5/W1p0QLqM2YFzcH5ml1yF7GrVNBZTvO1wOhOW
 ZwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VXyjbLpDTuE00ge+DHFSib5N0fJzn7CQXE4wINPUlB8=;
 b=dMXU3jLF1st/3MTHuZQpOP3oWSkO/En54GwOWvXA58KdOiUeiEt/wohebUUtFYCTv7
 MQqVc4ObCc9EeuAvd6urLmvA93ecLl8Qp95SpO4TFKbnsmSs+tIfj++rwRyrQal/iPhu
 wq2sqcYuxX8FX2OuU3HoqNdvnIL3yxDbdM3Sc22Zx+Yj6O1coFe02ALAs8Hv2Tkb4onF
 cMZ1SS1RvAKt782dSnqPKNNVcB11Qplv0kF+Mg4R7Dh1xrOdD/YNS41YR1ib4jv/G4Lj
 NIQfzSTIlkHHvZ9vqIaPXQoSabRHpmdYvUFodcAV4VKTKfAG5+f3LEBwuwgm3AjVAt8W
 JBtw==
X-Gm-Message-State: AOAM530O4i2/7HVLH7UkDsgSoROqEhou/iR3KnR+K4y5nFBG3J89oDZg
 L4i467WRnghe2P0FX6ne7bHUbelZ
X-Google-Smtp-Source: ABdhPJxWMG2ljyxvNa2EyKGahX5TRjZxbLcDOCIUo6Yfrw4SMEvBrQydD7CstuwSKqq/8jUUmN/aFw==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr115342wmb.90.1591984488319; 
 Fri, 12 Jun 2020 10:54:48 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id e12sm11288658wro.52.2020.06.12.10.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 10:54:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 3/5] hw/misc/led: Add create_led_by_gpio_id() helper
Date: Fri, 12 Jun 2020 19:54:38 +0200
Message-Id: <20200612175440.9901-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612175440.9901-1-f4bug@amsat.org>
References: <20200612175440.9901-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Esteban Bosse <estebanbosse@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
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
index 9300d4db6c..1b2bb96712 100644
--- a/include/hw/misc/led.h
+++ b/include/hw/misc/led.h
@@ -28,4 +28,18 @@ typedef struct LEDState {
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
index 11c7e8bb89..36de80dd67 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -104,3 +104,23 @@ static void led_register_types(void)
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


