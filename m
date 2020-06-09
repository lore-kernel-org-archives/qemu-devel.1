Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BB9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB68207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvbccWKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB68207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidbj-0004u9-Hv
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSl-0000Kh-Cx; Tue, 09 Jun 2020 08:34:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSe-00074q-JD; Tue, 09 Jun 2020 08:34:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id y20so2978780wmi.2;
 Tue, 09 Jun 2020 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oEq0TkRWvRrnUcFx8Wkpo5gILqhLeSIEML9csKX17G0=;
 b=rvbccWKE3d+cDt/172b58PZ+gdd6E5JYTEQHgPimsvA4PwpQO8r7Vn5HvhUgvBM3bQ
 4ppf/EBX3LqRCPMX335r4gQGV2286aKt+eFZbris7I1K+cPLsAseuUVGyx/rWMtiicvn
 AaZ8gMHJgypjDvqEcVuOtVFWCKNAiXI6/n7z28Yro48n4bJ6bQ2vPjbMGMcL09QJhSEC
 pXF+N/TfnG7N9JWLku0mUUQnDtDAMWSO6I1RM/YRFi9mlDukxQdr5OAEdY+D51yDaske
 iiNeNp4ZP7vtNV8MXw2lvThYup9RqB3Tr87jMtT8KJRVokfYzHv/JBjB555AcGAQpOUg
 6ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oEq0TkRWvRrnUcFx8Wkpo5gILqhLeSIEML9csKX17G0=;
 b=OJWGL8wURDEJlpuhSXVys44gZ2069JTuSCdi/6TK0FGQ0VkXzuvCikKIe73LZ26lKf
 bDf7xshINlw9c+GXfcCILNSyvPKknyrVb2OCNZYIre3exjB8U1x/3dSObK1QyEh4tJbl
 B+6W2Xzb4jzYyQ0ccAvN0A7GanRJIKKhl6/B6m01ATzNSLGZJOlevJeCq+hW2UecS5gW
 ypWzTvyzwnW5mJyFPf2et1p1dhTTtUNp3si7JVYIiariu5OmokcG+GEl/fllJOlTW9QM
 1Z0a5pjW45IgmJqMIMjX2ylXDYQo/zMhMY/RE8F+q29GsWtTaSa9M0TlHVgvgbAPuHPp
 t/MA==
X-Gm-Message-State: AOAM533l1s08hpTzu6AI1adZ03ym4okRi+Xy41fOz4R9TfKjXiEOMycj
 CHoJHp0/NVCRp33D4dmyg8iguzU3
X-Google-Smtp-Source: ABdhPJzzwVjGOsXWe6jd7iSJe6Bqhpi5WsewuOtGikzvGcXBTE5aBzkGHFSoHWpK7L6kpgBWD9d2bw==
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr4013337wmk.91.1591706072771; 
 Tue, 09 Jun 2020 05:34:32 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c81sm2920931wmd.42.2020.06.09.05.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 05:34:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 5/5] hw/arm/tosa: Use LED device for the Bluetooth led
Date: Tue,  9 Jun 2020 14:34:25 +0200
Message-Id: <20200609123425.6921-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609123425.6921-1-f4bug@amsat.org>
References: <20200609123425.6921-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/tosa.c  | 7 +++----
 hw/arm/Kconfig | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 5dee2d76c6..86d7e0283a 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -24,6 +24,7 @@
 #include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
+#include "hw/misc/led.h"
 #include "exec/address-spaces.h"
 
 #define TOSA_RAM    0x04000000
@@ -68,9 +69,6 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
 static void tosa_out_switch(void *opaque, int line, int level)
 {
     switch (line) {
-        case 0:
-            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
-            break;
         case 1:
             fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
             break;
@@ -119,7 +117,6 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
                         qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_JC_CF_IRQ),
                         NULL);
 
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED, outsignals[0]);
     qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED, outsignals[1]);
     qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED, outsignals[2]);
     qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED, outsignals[3]);
@@ -234,6 +231,8 @@ static void tosa_init(MachineState *machine)
 
     scp0 = sysbus_create_simple("scoop", 0x08800000, NULL);
     scp1 = sysbus_create_simple("scoop", 0x14800040, NULL);
+    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
+                          TOSA_GPIO_BT_LED, "blue LED");
 
     tosa_gpio_setup(mpu, scp0, scp1, tmio);
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2afaa7c8e9..009336cac8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -150,6 +150,7 @@ config TOSA
     select ZAURUS  # scoop
     select MICRODRIVE
     select PXA2XX
+    select LED
 
 config SPITZ
     bool
-- 
2.21.3


