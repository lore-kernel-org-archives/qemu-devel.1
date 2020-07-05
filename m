Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09AAC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6BF2073E
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1KFWg4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6BF2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBYg-0006ZE-SQ
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 16:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBXA-0004eh-MV; Sun, 05 Jul 2020 16:46:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBX7-0000pk-Pz; Sun, 05 Jul 2020 16:46:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id j4so36312025wrp.10;
 Sun, 05 Jul 2020 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oBbjHGJBucg5THxZq7KR1Jrgf1YjvhSClfXgvgV5JcQ=;
 b=Y1KFWg4JbGmm5RET/B82Sot6qGMvhQslhwXjX1IOWPnQ8H37mqCIN8Tvwp9DmxQ2J5
 IXE2QtsgZrQvwxeEI2KdoORTnuuVOrisUYe4lxso5VH5oe9A/u+3hX/PPnjtXy3lr5y0
 Eb5rLbV8jpKvzjdc5LhoTMTjp0dnNuyT/O419mwm4kenSVWsXfp+fDCxftaH1VdjZWOI
 XyZLlOtmuB6bbDaRyR1QoIuxJ0LNr0x0R4TCF9GV3EuMwRNmhqLHgb8hmdJgnmh1+W3k
 sJxxAOhO9rXo5NlNYurp3UaA3maaxOx1OCsQQ0Kl/jsaR4i1Z8wSaomp+bYlnl+ObEHH
 MywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oBbjHGJBucg5THxZq7KR1Jrgf1YjvhSClfXgvgV5JcQ=;
 b=WYRHS2WOlDoNAZRy/zQcOKXEGkkGFgEt/pZlDwBjp4hioMhOvqhJcWKijOnRJi5MWc
 506OtuvPl0wZcpJ22PeElOzUVVVGmAcR5hFcXARWDUzjz1jZatS5TpviUC9DzwqbARSJ
 h0ke2ayNHZIDFVbIPlgsQZi9+wGR7E2b79LWdFg0ONaYbBgJmaPuXhyjjWyy5OK1yQAu
 5CfhQJWOyKf+sX4HihUb2xC76vtDgF6dqYF/I5Osf0ovYaH984eZHXC0XjXHnh3v9eWX
 o6EgyvJXjQFkw5Tg64J5YbJdAwHe6d83C9vIRhMIH3yKfyvvq6bPgQHSIsSzzsGs+tUM
 wZxw==
X-Gm-Message-State: AOAM531oN1YOeVPmXo++KBmZyQgjx3G4+2gEoMweMRAhnuJWcCvzhLQU
 binmiIokag6P2FHmFwOuKFZC3+1ZaiI=
X-Google-Smtp-Source: ABdhPJxOITLXvnAw/Ph5iYXBLAuQjO3e57tDfcvXcUrNup+TxLdjbI2xhRLlLj9tenqWNg7qGtFRfw==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr48377933wrp.77.1593981999790; 
 Sun, 05 Jul 2020 13:46:39 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g144sm51397817wme.2.2020.07.05.13.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 13:46:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/10] hw/sd/pl181: Expose a SDBus and connect the SDCard
 to it
Date: Sun,  5 Jul 2020 22:46:26 +0200
Message-Id: <20200705204630.4133-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705204630.4133-1-f4bug@amsat.org>
References: <20200705204630.4133-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the controller to the SDBus API:
- add the a TYPE_PL181_BUS object of type TYPE_SD_BUS,
- adapt the SDBusClass set_inserted/set_readonly handlers
- create the bus in the PL181 controller
- switch legacy sd_*() API to the sdbus_*() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v3:
Addressed Peter comment, adding TYPE_PL181_BUS:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg515866.html
---
 hw/sd/pl181.c | 67 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index ab4cd733a4..f6de06ece8 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "hw/qdev-properties.h"
 
 //#define DEBUG_PL181 1
 
@@ -32,11 +33,13 @@ do { printf("pl181: " fmt , ## __VA_ARGS__); } while (0)
 #define TYPE_PL181 "pl181"
 #define PL181(obj) OBJECT_CHECK(PL181State, (obj), TYPE_PL181)
 
+#define TYPE_PL181_BUS "pl181-bus"
+
 typedef struct PL181State {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    SDState *card;
+    SDBus sdbus;
     uint32_t clock;
     uint32_t power;
     uint32_t cmdarg;
@@ -183,7 +186,7 @@ static void pl181_do_command(PL181State *s)
     request.cmd = s->cmd & PL181_CMD_INDEX;
     request.arg = s->cmdarg;
     DPRINTF("Command %d %08x\n", request.cmd, request.arg);
-    rlen = sd_do_command(s->card, &request, response);
+    rlen = sdbus_do_command(&s->sdbus, &request, response);
     if (rlen < 0)
         goto error;
     if (s->cmd & PL181_CMD_RESPONSE) {
@@ -224,12 +227,12 @@ static void pl181_fifo_run(PL181State *s)
     int is_read;
 
     is_read = (s->datactrl & PL181_DATA_DIRECTION) != 0;
-    if (s->datacnt != 0 && (!is_read || sd_data_ready(s->card))
+    if (s->datacnt != 0 && (!is_read || sdbus_data_ready(&s->sdbus))
             && !s->linux_hack) {
         if (is_read) {
             n = 0;
             while (s->datacnt && s->fifo_len < PL181_FIFO_LEN) {
-                value |= (uint32_t)sd_read_data(s->card) << (n * 8);
+                value |= (uint32_t)sdbus_read_data(&s->sdbus) << (n * 8);
                 s->datacnt--;
                 n++;
                 if (n == 4) {
@@ -250,7 +253,7 @@ static void pl181_fifo_run(PL181State *s)
                 }
                 n--;
                 s->datacnt--;
-                sd_write_data(s->card, value & 0xff);
+                sdbus_write_data(&s->sdbus, value & 0xff);
                 value >>= 8;
             }
         }
@@ -456,6 +459,20 @@ static const MemoryRegionOps pl181_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void pl181_set_readonly(DeviceState *dev, bool level)
+{
+    PL181State *s = (PL181State *)dev;
+
+    qemu_set_irq(s->card_readonly, level);
+}
+
+static void pl181_set_inserted(DeviceState *dev, bool level)
+{
+    PL181State *s = (PL181State *)dev;
+
+    qemu_set_irq(s->card_inserted, level);
+}
+
 static void pl181_reset(DeviceState *d)
 {
     PL181State *s = PL181(d);
@@ -479,12 +496,9 @@ static void pl181_reset(DeviceState *d)
     s->mask[0] = 0;
     s->mask[1] = 0;
 
-    /* We can assume our GPIO outputs have been wired up now */
-    sd_set_cb(s->card, s->card_readonly, s->card_inserted);
-    /* Since we're still using the legacy SD API the card is not plugged
-     * into any bus, and we must reset it manually.
-     */
-    device_legacy_reset(DEVICE(s->card));
+    /* Reset other state based on current card insertion/readonly status */
+    pl181_set_inserted(DEVICE(s), sdbus_get_inserted(&s->sdbus));
+    pl181_set_readonly(DEVICE(s), sdbus_get_readonly(&s->sdbus));
 }
 
 static void pl181_init(Object *obj)
@@ -499,19 +513,24 @@ static void pl181_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq[1]);
     qdev_init_gpio_out_named(dev, &s->card_readonly, "card-read-only", 1);
     qdev_init_gpio_out_named(dev, &s->card_inserted, "card-inserted", 1);
+
+    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
+                        TYPE_PL181_BUS, dev, "sd-bus");
 }
 
 static void pl181_realize(DeviceState *dev, Error **errp)
 {
-    PL181State *s = PL181(dev);
+    DeviceState *card;
     DriveInfo *dinfo;
 
     /* FIXME use a qdev drive property instead of drive_get_next() */
+    card = qdev_new(TYPE_SD_CARD);
     dinfo = drive_get_next(IF_SD);
-    s->card = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, false);
-    if (s->card == NULL) {
-        error_setg(errp, "sd_init failed");
-    }
+    qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                            &error_fatal);
+    qdev_realize_and_unref(card,
+                           qdev_get_child_bus(dev, "sd-bus"),
+                           &error_fatal);
 }
 
 static void pl181_class_init(ObjectClass *klass, void *data)
@@ -533,9 +552,25 @@ static const TypeInfo pl181_info = {
     .class_init    = pl181_class_init,
 };
 
+static void pl181_bus_class_init(ObjectClass *klass, void *data)
+{
+    SDBusClass *sbc = SD_BUS_CLASS(klass);
+
+    sbc->set_inserted = pl181_set_inserted;
+    sbc->set_readonly = pl181_set_readonly;
+}
+
+static const TypeInfo pl181_bus_info = {
+    .name = TYPE_PL181_BUS,
+    .parent = TYPE_SD_BUS,
+    .instance_size = sizeof(SDBus),
+    .class_init = pl181_bus_class_init,
+};
+
 static void pl181_register_types(void)
 {
     type_register_static(&pl181_info);
+    type_register_static(&pl181_bus_info);
 }
 
 type_init(pl181_register_types)
-- 
2.21.3


