Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E45C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D07206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEGyIRJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D07206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoYC-0007NU-Mj
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFm-0007qD-0p
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFk-0008Ht-F7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:50558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFk-0008Ej-8Q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id a5so6262287wmb.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=biJgw9AmxEjt8OjXP6jfcEtE+uZVIiqydwwtIiuDGOc=;
 b=cEGyIRJFFxkvZk5j0vcRFJlkFTT/3mr5BDVGssKH3ziIpvm/WXZ8H1OTzQQPlXz4N7
 MJQuchT6dYnI8AoyZ1bgWM9CtmWZBmAiN6NIdzkoCI9tJay3q6E+QwTvLGfgLn15bal5
 QkiHW3pBr8NF2LxYBbmaO6uW60Kmu2uMFVjhtlpr70OUOhXGvIPSaMT2r2To2Ds+7SfZ
 m8+d+pO/cc8jzd1BaSo5PmmiToIX22p7ldEj/Nd3g2hvkjA0bmMNuvxCOBCZqVUZdqhg
 wlZ3J/HBrz28nZDOEE4nsk6mZbTbgoU2yuCek4AFH77Ystt0NWofuID3ztZ9iNgj6oR8
 0KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=biJgw9AmxEjt8OjXP6jfcEtE+uZVIiqydwwtIiuDGOc=;
 b=aePRfnn18wHYBiz5tUy/rZpOQDQNByDwPsiuADGCZZD5Xp/VYyMxSvDaMHAeDTwTrP
 tarXM/rF2U5pYmo8QJCx0Hm4XKP//cIEHgWwaqVGqLWaWCN0fHy4BsFmdgXVgegTarMr
 OTIuAH8+WPrhl19hK+MkxTl8/WLbn85l5rbhVONmDDCIsBJu/PkWdBtzhENS0WTc4iKf
 UmS1mhsTAj9BKIWBwPxDx9gE5nhw/06TxZmpB4l0sAbhYnDb+MdMVnAlrXeJ9uTOaKtt
 eKX6eF67bW7m4W/NEv3qijUYzuoO4n7I+XDVEIwJxUkhpXmhpxVbs8f8/Ou9nCp3rs3u
 Ac1Q==
X-Gm-Message-State: APjAAAVws8Gkvv0WVsitJSugLZqPzx5z9lhVnypRuhXu9HwnOmmVVANO
 SGNRYSQWeIpx3Y+bG/mUFonFTL/EPk7y0w==
X-Google-Smtp-Source: APXvYqy+IrLpBAvPezEgepeuQPzn9xFwR5nHiMc6BpBhX6HfiuriIKH2ufaKKMF30bNycosY+FapKg==
X-Received: by 2002:a1c:6404:: with SMTP id y4mr25598784wmb.143.1576494566966; 
 Mon, 16 Dec 2019 03:09:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/34] aspeed: Change the "scu" property definition
Date: Mon, 16 Dec 2019 11:08:48 +0000
Message-Id: <20191216110904.30815-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

The Aspeed Watchdog and Timer models have a link pointing to the SCU
controller model of the machine.

Change the "scu" property definition so that it explicitly sets the
pointer. The property isn't optional : not being able to set the link
is a bug and QEMU should rather abort than exit in this case.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-17-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_ast2600.c  |  8 ++++----
 hw/arm/aspeed_soc.c      |  8 ++++----
 hw/timer/aspeed_timer.c  | 17 +++++++++--------
 hw/watchdog/wdt_aspeed.c | 17 ++++++++---------
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 0881eb25983..810fd7de0c0 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -146,8 +146,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
     sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
                           sizeof(s->timerctrl), typename);
-    object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
-                                   OBJECT(&s->scu), &error_abort);
 
     snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
     sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
@@ -177,8 +175,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
         sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
                               sizeof(s->wdt[i]), typename);
-        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
-                                       OBJECT(&s->scu), &error_abort);
     }
 
     for (i = 0; i < sc->macs_num; i++) {
@@ -323,6 +319,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_RTC));
 
     /* Timer */
+    object_property_set_link(OBJECT(&s->timerctrl),
+                             OBJECT(&s->scu), "scu", &error_abort);
     object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -415,6 +413,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->wdts_num; i++) {
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
 
+        object_property_set_link(OBJECT(&s->wdt[i]),
+                                 OBJECT(&s->scu), "scu", &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index b01c9774419..a6237e59401 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -163,8 +163,6 @@ static void aspeed_soc_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.timer-%s", socname);
     sysbus_init_child_obj(obj, "timerctrl", OBJECT(&s->timerctrl),
                           sizeof(s->timerctrl), typename);
-    object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
-                                   OBJECT(&s->scu), &error_abort);
 
     snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
     sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
@@ -194,8 +192,6 @@ static void aspeed_soc_init(Object *obj)
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
         sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
                               sizeof(s->wdt[i]), typename);
-        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
-                                       OBJECT(&s->scu), &error_abort);
     }
 
     for (i = 0; i < sc->macs_num; i++) {
@@ -291,6 +287,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_RTC));
 
     /* Timer */
+    object_property_set_link(OBJECT(&s->timerctrl),
+                             OBJECT(&s->scu), "scu", &error_abort);
     object_property_set_bool(OBJECT(&s->timerctrl), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -376,6 +374,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->wdts_num; i++) {
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
 
+        object_property_set_link(OBJECT(&s->wdt[i]),
+                                 OBJECT(&s->scu), "scu", &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index bcce2192a92..a8c38cc1189 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -19,6 +19,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "trace.h"
 
 #define TIMER_NR_REGS 4
@@ -603,15 +604,8 @@ static void aspeed_timer_realize(DeviceState *dev, Error **errp)
     int i;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedTimerCtrlState *s = ASPEED_TIMER(dev);
-    Object *obj;
-    Error *err = NULL;
 
-    obj = object_property_get_link(OBJECT(dev), "scu", &err);
-    if (!obj) {
-        error_propagate_prepend(errp, err, "required link 'scu' not found: ");
-        return;
-    }
-    s->scu = ASPEED_SCU(obj);
+    assert(s->scu);
 
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         aspeed_init_one_timer(s, i);
@@ -677,6 +671,12 @@ static const VMStateDescription vmstate_aspeed_timer_state = {
     }
 };
 
+static Property aspeed_timer_properties[] = {
+    DEFINE_PROP_LINK("scu", AspeedTimerCtrlState, scu, TYPE_ASPEED_SCU,
+                     AspeedSCUState *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void timer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -685,6 +685,7 @@ static void timer_class_init(ObjectClass *klass, void *data)
     dc->reset = aspeed_timer_reset;
     dc->desc = "ASPEED Timer";
     dc->vmsd = &vmstate_aspeed_timer_state;
+    dc->props = aspeed_timer_properties;
 }
 
 static const TypeInfo aspeed_timer_info = {
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 122aa8daaad..f50dab922e0 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -241,16 +241,8 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedWDTState *s = ASPEED_WDT(dev);
-    Error *err = NULL;
-    Object *obj;
 
-    obj = object_property_get_link(OBJECT(dev), "scu", &err);
-    if (!obj) {
-        error_propagate(errp, err);
-        error_prepend(errp, "required link 'scu' not found: ");
-        return;
-    }
-    s->scu = ASPEED_SCU(obj);
+    assert(s->scu);
 
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, aspeed_wdt_timer_expired, dev);
 
@@ -264,6 +256,12 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static Property aspeed_wdt_properties[] = {
+    DEFINE_PROP_LINK("scu", AspeedWDTState, scu, TYPE_ASPEED_SCU,
+                     AspeedSCUState *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -273,6 +271,7 @@ static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
     dc->reset = aspeed_wdt_reset;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->vmsd = &vmstate_aspeed_wdt;
+    dc->props = aspeed_wdt_properties;
 }
 
 static const TypeInfo aspeed_wdt_info = {
-- 
2.20.1


