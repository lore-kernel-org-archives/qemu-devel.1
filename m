Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC38C43457
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BEB2083B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ftn7bHiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BEB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRh75-00050X-8I
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5m-0002ni-7b; Sun, 11 Oct 2020 15:33:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5k-0006tV-JP; Sun, 11 Oct 2020 15:33:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so16550915wrp.10;
 Sun, 11 Oct 2020 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0QbPMBGbr2e8OygEfUqckUt1pMEO3ugEPGl8j5TDG5o=;
 b=Ftn7bHiDyZHW5cvXmnoVfxhIZ7x0GAUDWdhKYIp/hJsQQdkQjk3xFHKr2bE32ZUsTx
 OxkxZ8/FBeopmFzh9avflV6h87EtXxfM4cijGzielzjl88XTJCzZzfaxZUkTItX9gAHb
 CLrnZtGlC6tE+lxRTmg1270LdbOjcIkeG5WHj6jHawfqgjSKLufBdjis4mMwK66y/OSO
 TcqFClXiuxiiqAEcECDveoNEz6bLHh5C9rAB0CATtw6us/zyCMReFCPIb5H7mojw2CAj
 5IfyLDg26JDoJzaddYnqsUGTkg0GeR2ISv2WtIPtkEiGu9LaBMq5Aqy5cwLgdtLe3V82
 xdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0QbPMBGbr2e8OygEfUqckUt1pMEO3ugEPGl8j5TDG5o=;
 b=hDTteyPJSYbvnX6eX2PfJgnllS+sSpxIDRbnf9UK9YOa00ysE5/vVeDMdx1qhOpe3q
 jk667LVOLlzgtuTCP7ZDvXeSI0Hb/17pH7yyaEaRvBiQhGOzD19ensWo8uMXVW7ZMR+n
 CQIS7BzcGa3n2AESDfeyML47jd48k7Zv4KKZgwx97zcGFJC/RtAyvB4ALpReNeqTOjy2
 czBew6+pMfLEOWyS+VEfoj5QBd58TLHbEN59HdBnO4dJXPBlynjIxL9THCIpMAVoZnZS
 w0KjFEg84l0leXO57kVSYeGE5sTwYzdX/kRaG9l+qtVv6K8TXWdBmOoDUmKwo8m+7hSi
 RZVQ==
X-Gm-Message-State: AOAM533nr23KFmMJ/yEUIUb2oBvGP/OtFMaNUXxtTFHQpSToCQtXDLC+
 KK9eUi1yrxEJ94qRReNqBlI9KoC4Ff0=
X-Google-Smtp-Source: ABdhPJx2nHHdw1cijWbRr03kOBOnQuibBEjmOLn5hkpeJFmTJLtLlItz1XL8TxPfbcWpGyc3J4e5dQ==
X-Received: by 2002:adf:c5c3:: with SMTP id v3mr26840799wrg.205.1602444790002; 
 Sun, 11 Oct 2020 12:33:10 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z11sm21498835wrh.70.2020.10.11.12.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:33:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/10] hw/isa: Add the ISA_IRQ_RTC_DEFAULT definition
Date: Sun, 11 Oct 2020 21:32:26 +0200
Message-Id: <20201011193229.3210774-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011193229.3210774-1-f4bug@amsat.org>
References: <20201011193229.3210774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The RTC time keep clock ses IRQ #8 by default. Add this
default definition to the IsaIrqNumber enum.

Avoid magic values in the code, replace them by the
newly introduced definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/isa.h         | 1 +
 include/hw/rtc/mc146818rtc.h | 1 -
 hw/isa/piix4.c               | 2 +-
 hw/rtc/m48t59-isa.c          | 2 +-
 hw/rtc/mc146818rtc.c         | 4 ++--
 hw/timer/hpet.c              | 8 ++++----
 tests/qtest/rtc-test.c       | 8 ++++----
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 081fa446152..9f78ff11246 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -14,6 +14,7 @@ enum IsaIrqNumber {
     ISA_IRQ_TPM_DEFAULT =  5,
     ISA_IRQ_FDC_DEFAULT =  6,
     ISA_IRQ_PAR_DEFAULT =  7,
+    ISA_IRQ_RTC_DEFAULT =  8,
     ISA_NUM_IRQS        = 16
 };
 
diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
index 5b45b229244..1cca26399ce 100644
--- a/include/hw/rtc/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -47,7 +47,6 @@ struct RTCState {
     QLIST_ENTRY(RTCState) link;
 };
 
-#define RTC_ISA_IRQ 8
 #define RTC_ISA_BASE 0x70
 
 ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index a50d97834c7..d9cceff9c84 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -185,7 +185,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     if (!qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), errp)) {
         return;
     }
-    isa_init_irq(ISA_DEVICE(&s->rtc), &s->rtc.irq, RTC_ISA_IRQ);
+    isa_init_irq(ISA_DEVICE(&s->rtc), &s->rtc.irq, ISA_IRQ_RTC_DEFAULT);
 
     piix4_dev = dev;
 }
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index cae315e4885..bdde427a945 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -124,7 +124,7 @@ static void m48t59_isa_realize(DeviceState *dev, Error **errp)
 
     s->model = u->info.model;
     s->size = u->info.size;
-    isa_init_irq(isadev, &s->IRQ, 8);
+    isa_init_irq(isadev, &s->IRQ, ISA_IRQ_RTC_DEFAULT);
     m48t59_realize_common(s, errp);
     memory_region_init_io(&d->io, OBJECT(dev), &m48t59_io_ops, s, "m48t59", 4);
     if (d->io_base != 0) {
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 7a38540cb9d..ba156b9a0bd 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -981,7 +981,7 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
     if (intercept_irq) {
         qdev_connect_gpio_out(dev, 0, intercept_irq);
     } else {
-        isa_connect_gpio_out(isadev, 0, RTC_ISA_IRQ);
+        isa_connect_gpio_out(isadev, 0, ISA_IRQ_RTC_DEFAULT);
     }
 
     object_property_add_alias(qdev_get_machine(), "rtc-time", OBJECT(isadev),
@@ -1020,7 +1020,7 @@ static void rtc_build_aml(ISADevice *isadev, Aml *scope)
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE, RTC_ISA_BASE,
                            0x01, 0x08));
-    aml_append(crs, aml_irq_no_flags(RTC_ISA_IRQ));
+    aml_append(crs, aml_irq_no_flags(ISA_IRQ_RTC_DEFAULT));
 
     dev = aml_device("RTC");
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 05fd86af817..579a9faecf3 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -196,7 +196,7 @@ static void update_irq(struct HPETTimer *timer, int set)
          * timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
          * timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
          */
-        route = (timer->tn == 0) ? 0 : RTC_ISA_IRQ;
+        route = (timer->tn == 0) ? 0 : ISA_IRQ_RTC_DEFAULT;
     } else {
         route = timer_int_route(timer);
     }
@@ -615,11 +615,11 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
                 qemu_set_irq(s->pit_enabled, 0);
                 qemu_irq_lower(s->irqs[0]);
-                qemu_irq_lower(s->irqs[RTC_ISA_IRQ]);
+                qemu_irq_lower(s->irqs[ISA_IRQ_RTC_DEFAULT]);
             } else if (deactivating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
                 qemu_irq_lower(s->irqs[0]);
                 qemu_set_irq(s->pit_enabled, 1);
-                qemu_set_irq(s->irqs[RTC_ISA_IRQ], s->rtc_irq_level);
+                qemu_set_irq(s->irqs[ISA_IRQ_RTC_DEFAULT], s->rtc_irq_level);
             }
             break;
         case HPET_CFG + 4:
@@ -711,7 +711,7 @@ static void hpet_handle_legacy_irq(void *opaque, int n, int level)
     } else {
         s->rtc_irq_level = level;
         if (!hpet_in_legacy_mode(s)) {
-            qemu_set_irq(s->irqs[RTC_ISA_IRQ], level);
+            qemu_set_irq(s->irqs[ISA_IRQ_RTC_DEFAULT], level);
         }
     }
 }
diff --git a/tests/qtest/rtc-test.c b/tests/qtest/rtc-test.c
index c7af34f6b1b..9ae90d4925c 100644
--- a/tests/qtest/rtc-test.c
+++ b/tests/qtest/rtc-test.c
@@ -278,7 +278,7 @@ static void alarm_time(void)
     /* set DEC mode */
     cmos_write(RTC_REG_B, REG_B_24H | REG_B_DM);
 
-    g_assert(!get_irq(RTC_ISA_IRQ));
+    g_assert(!get_irq(ISA_IRQ_RTC_DEFAULT));
     cmos_read(RTC_REG_C);
 
     now.tm_sec = (now.tm_sec + 2) % 60;
@@ -288,14 +288,14 @@ static void alarm_time(void)
     cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) | REG_B_AIE);
 
     for (i = 0; i < 2 + wiggle; i++) {
-        if (get_irq(RTC_ISA_IRQ)) {
+        if (get_irq(ISA_IRQ_RTC_DEFAULT)) {
             break;
         }
 
         clock_step(1000000000);
     }
 
-    g_assert(get_irq(RTC_ISA_IRQ));
+    g_assert(get_irq(ISA_IRQ_RTC_DEFAULT));
     g_assert((cmos_read(RTC_REG_C) & REG_C_AF) != 0);
     g_assert(cmos_read(RTC_REG_C) == 0);
 }
@@ -645,7 +645,7 @@ static void uip_stuck(void)
 
 static uint64_t wait_periodic_interrupt(uint64_t real_time)
 {
-    while (!get_irq(RTC_ISA_IRQ)) {
+    while (!get_irq(ISA_IRQ_RTC_DEFAULT)) {
         real_time = clock_step_next();
     }
 
-- 
2.26.2


