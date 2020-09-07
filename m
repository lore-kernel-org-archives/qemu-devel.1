Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86147C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC0821927
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4ORQXt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC0821927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFK9U-0008Ag-8J
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4y-0008Tw-Ai; Mon, 07 Sep 2020 12:33:16 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:40790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4w-0007e4-Ar; Mon, 07 Sep 2020 12:33:15 -0400
Received: by mail-ej1-x642.google.com with SMTP id z22so18909553ejl.7;
 Mon, 07 Sep 2020 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=39vGPecl12q7amHLWo3+1dhvTYjWZnqSb7DebE6TMyI=;
 b=c4ORQXt5p3mIsNygpyg8uGyXK2YdhgONePrYj9xNLEyo2y+IlL/DhZrcsR9aKI1A62
 XpNHdReeRbZl+tnopgaVfG5JApL2ygDwLgrWz39hlj1MLRhjmeFxduRenhCB8enxLyi9
 axXPgq9VWtqSfj52BAOxDmC8bnKLuir64hTNSMtP5inmjEQI1gdzHlCZby3SB6+RP94N
 1ZUIwcx4Omyk6ZT87EABhnREynU00JGJlFvZ1YUxr7yXHC8rP+fYdznvHxoH2kwwVZhX
 Ywcvt2nX/b1dq6DoFAuOf1e/TRUdIb8bC4RjQk7q7hog4rvnrLKZoTUWlKmBWeXmxBC8
 FIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=39vGPecl12q7amHLWo3+1dhvTYjWZnqSb7DebE6TMyI=;
 b=P1oixbyteBRUNTz3jtYd5XcGfevrFwa99KNadUM3JtqJzoEc2ehQqraQYk58VUKzq9
 a3lbg2YpbmTNlvNDDMRYYm924LoB8TxaaKsBf6dkN4YUETufsS1aU/bS99eipPf7ZTmv
 hX+POP/kE0avn+09pN7CTw9Y3+wIY8w+YqZxm45gWn1yCKTKGkKYQ+i4Csht1qeg87A6
 ruUeoDGkAAR95LjPNjgbMJiY9Kq12akXozJzyUScaJw7fvb51lavBe+dcq+hP7AODMmA
 od2Vha/PguPuWF9z9v/rqwWKe+j02L62sy/mAF/FXB+8asYvnValXiu8ts0ajII7HFZ1
 wWaA==
X-Gm-Message-State: AOAM5309McLz5Dkdk8NWOvzgCfrQ7n55oxs92sJOHH/l4JYvmtAoksgV
 Ss5PXObb0kVQN9t/Raukoe8FsodnRnQ=
X-Google-Smtp-Source: ABdhPJxt1MMTkOVhjFJfnCIZZ7Uhj7zI8VlZiYK9WpwlPX97EA2DNAe9Tcvb3pTJLs8imJricYxiQA==
X-Received: by 2002:a17:906:8d8:: with SMTP id
 o24mr21240332eje.384.1599496392492; 
 Mon, 07 Sep 2020 09:33:12 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u13sm15700199ejn.82.2020.09.07.09.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:33:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 8/8] hw/arm/tosa: Make TYPE_TOSA_MISC_GPIO a plain QDev
Date: Mon,  7 Sep 2020 18:32:57 +0200
Message-Id: <20200907163257.46527-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907163257.46527-1-f4bug@amsat.org>
References: <20200907163257.46527-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Luc Michel <luc.michel@greensocs.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TYPE_TOSA_MISC_GPIO doesn't need to be a SysBus device,
make it a plain QDev.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because having to pass MachineState and call
object_property_add_child() simply makes things more
complex... but it seems to cleaner QOM design.

Cc: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/tosa.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index f23651fd775..524d5fcd10b 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -79,7 +79,7 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
     OBJECT_CHECK(TosaMiscGPIOState, (obj), TYPE_TOSA_MISC_GPIO)
 
 typedef struct TosaMiscGPIOState {
-    SysBusDevice parent_obj;
+    DeviceState parent_obj;
 } TosaMiscGPIOState;
 
 static void tosa_reset(void *opaque, int line, int level)
@@ -96,7 +96,7 @@ static void tosa_misc_gpio_init(Object *obj)
     qdev_init_gpio_in_named(dev, tosa_reset, "reset", 1);
 }
 
-static void tosa_gpio_setup(PXA2xxState *cpu,
+static void tosa_gpio_setup(MachineState *machine, PXA2xxState *cpu,
                 DeviceState *scp0,
                 DeviceState *scp1,
                 TC6393xbState *tmio)
@@ -104,7 +104,10 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
     DeviceState *misc_gpio;
     LEDState *led[4];
 
-    misc_gpio = sysbus_create_simple(TYPE_TOSA_MISC_GPIO, -1, NULL);
+    misc_gpio = qdev_new(TYPE_TOSA_MISC_GPIO);
+    object_property_add_child(OBJECT(machine), "pcb-container",
+                              OBJECT(misc_gpio));
+    qdev_realize_and_unref(misc_gpio, NULL, &error_fatal);
 
     /* MMC/SD host */
     pxa2xx_mmci_handlers(cpu->mmc,
@@ -253,7 +256,7 @@ static void tosa_init(MachineState *machine)
     scp0 = sysbus_create_simple("scoop", 0x08800000, NULL);
     scp1 = sysbus_create_simple("scoop", 0x14800040, NULL);
 
-    tosa_gpio_setup(mpu, scp0, scp1, tmio);
+    tosa_gpio_setup(machine, mpu, scp0, scp1, tmio);
 
     tosa_microdrive_attach(mpu);
 
@@ -307,7 +310,7 @@ static const TypeInfo tosa_ssp_info = {
 
 static const TypeInfo tosa_misc_gpio_info = {
     .name          = TYPE_TOSA_MISC_GPIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
+    .parent        = TYPE_DEVICE,
     .instance_size = sizeof(TosaMiscGPIOState),
     .instance_init = tosa_misc_gpio_init,
     /*
-- 
2.26.2


