Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F55EC2D0D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3002467E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5YwH8bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3002467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii1A0-0001Fy-3Z
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 14:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tn-0007Ib-5k
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tl-00005z-T8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tl-0008Rd-H0; Thu, 19 Dec 2019 13:51:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id j42so7020594wrj.12;
 Thu, 19 Dec 2019 10:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qyhQROH0zglq4XFW1HtOmFf0aWLykn31mbrW4dYgWlw=;
 b=i5YwH8bvSKpQxpoKJrLWZAqXtF9THcvR3lEO9kEGOQsJFg93pncnTmCvOGe+0LRMJI
 VJNcEjLRMfudXXBAbr5e0GFY2tuLHKzM5A44Jve7P5OjusD5ul3eNGhz3vb+TZADDYmC
 GAwl7ozdCO+amGeMBP604ChVmVJRjW3EGR/HBGTQLJVcrjr+06dNRXmAa5oNLt3MY80l
 OYIZi/TW95hb5+pOXo4zTRoks3G7IUPkIkT7Oo2/9RynfzlEf6gZD1tYm4EdzG49Cod0
 mqJdH1feN8TDjQ8vRZyJQT87WxD8135vpWsbOb8osGZOeK2IjFJoO+zaBjxF5XcN5JSH
 +Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qyhQROH0zglq4XFW1HtOmFf0aWLykn31mbrW4dYgWlw=;
 b=Q6L3yPFW83z/JeKG5NkXpFEXrMD7UpMUQAG3fs8ZbqcrQ6NHlfyjvMRFooQmTReIKP
 3rk9diS17YzXubB/zGsTtzlc6+Tv0Ix3ebDKsxl0K1EG9RvaxyYLqRlOMOoOfdzoY22+
 n/LJOK7bz8kRrEW2zbgkpiEnZA5BdV00qm40Xtrn10PMnZqEPILNjeG5G7CUCP3yBnh5
 Es6MSuPgIqRzHHd5/txNkhxllIdIb/rIxPWNRQHo43IN1HEwx+VBEoh7ElFgyh9AwoRh
 Oc8O2L04T5zAEUV7XJKc88fmimboHKztZ/Td190f3kxkQ2K83Z9Dh4toJdongtrSyZ+s
 xH4Q==
X-Gm-Message-State: APjAAAVH62bM50N9Cd9FyPHIbA6oItdYdRNX8Sj0K1WYjVgSuws0B0E8
 y4uEUBEe7CAaCKX6sna36FD11G56
X-Google-Smtp-Source: APXvYqwfViom5RRGMotWWzFz7ZtejLLvnO4yQepB8PTG9RICXrSIdBWCsQnRweCWjT0yyeFDztq8Pg==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr11320272wrq.64.1576781504198; 
 Thu, 19 Dec 2019 10:51:44 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [RFC PATCH 12/13] hw/timer/allwinner: Rename AW_A10_PIT() as
 AW_TIMER_CTRL()
Date: Thu, 19 Dec 2019 19:51:26 +0100
Message-Id: <20191219185127.24388-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
References: <20191219185127.24388-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This macro is now used by different Allwinner timer controllers,
rename it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/allwinner-a10-pit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index ad409b96a1..7413f046cc 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -51,8 +51,8 @@
 
 #define AW_A10_PIT_DEFAULT_CLOCK    0x4
 
-#define AW_A10_PIT(obj) \
-    OBJECT_CHECK(AllwinnerTmrCtrlState, (obj), TYPE_AW_A10_PIT)
+#define AW_TIMER_CTRL(obj) \
+    OBJECT_CHECK(AllwinnerTmrCtrlState, (obj), TYPE_AW_COMMON_PIT)
 
 typedef struct AllwinnerTmrCtrlClass {
     /*< private >*/
@@ -80,7 +80,7 @@ static void a10_pit_update_irq(AllwinnerTmrCtrlState *s)
 
 static uint64_t a10_pit_read(void *opaque, hwaddr offset, unsigned size)
 {
-    AllwinnerTmrCtrlState *s = AW_A10_PIT(opaque);
+    AllwinnerTmrCtrlState *s = AW_TIMER_CTRL(opaque);
     uint8_t index;
 
     switch (offset) {
@@ -144,7 +144,7 @@ static void a10_pit_set_freq(AllwinnerTmrCtrlState *s, int index)
 static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
                             unsigned size)
 {
-     AllwinnerTmrCtrlState *s = AW_A10_PIT(opaque);
+     AllwinnerTmrCtrlState *s = AW_TIMER_CTRL(opaque);
      uint8_t index;
 
     switch (offset) {
@@ -278,7 +278,7 @@ static const VMStateDescription vmstate_a10_pit = {
 
 static void a10_pit_reset(DeviceState *dev)
 {
-    AllwinnerTmrCtrlState *s = AW_A10_PIT(dev);
+    AllwinnerTmrCtrlState *s = AW_TIMER_CTRL(dev);
     uint8_t i;
 
     s->irq_enable = 0;
@@ -319,7 +319,7 @@ static void a10_pit_timer_cb(void *opaque)
 
 static void aw_pit_instance_init(Object *obj)
 {
-    AllwinnerTmrCtrlState *s = AW_A10_PIT(obj);
+    AllwinnerTmrCtrlState *s = AW_TIMER_CTRL(obj);
     AllwinnerTmrCtrlClass *c = AW_TIMER_GET_CLASS(s);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     uint8_t i;
@@ -330,7 +330,7 @@ static void aw_pit_instance_init(Object *obj)
         sysbus_init_irq(sbd, &s->timer[i].irq);
     }
     memory_region_init_io(&s->iomem, OBJECT(s), &a10_pit_ops, s,
-                          TYPE_AW_A10_PIT, c->region_size);
+                          TYPE_AW_COMMON_PIT, c->region_size);
     sysbus_init_mmio(sbd, &s->iomem);
 
     for (i = 0; i < s->timer_count; i++) {
-- 
2.21.0


