Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D2C2D0D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC62206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+aNElJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC62206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0wT-0001m8-As
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tl-0007Cx-13
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tj-0008JO-FN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:44 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tj-0008DA-7U; Thu, 19 Dec 2019 13:51:43 -0500
Received: by mail-wr1-x441.google.com with SMTP id b6so7094309wrq.0;
 Thu, 19 Dec 2019 10:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2xjfAFFEWDuI/P26T2zoS1xiDMGAz867DMgCQ/oLVWQ=;
 b=O+aNElJZM9BZIgZZ4qEWZvovUiVVhHa4bCbUzxy5LYpTL3dqp4lLuEpV0sCoYvSrsp
 R0mShX3Xsx0HkQXTfhWU4syLH9eIbzXIR+sunvozdbl34YVGZ44f7XMR9BbY2Tdo+/Zc
 fRWNPgGOxyBBBmrdKxat+Igs2PEZPQyhDzr+pZXbnpPTiX2jit0XF6aRhZ16T6HOgmkI
 pOnhokvGEfkUdTJXbADc+2gULgsGZpLHTWYzklcgXqWtTUKF2mfme0JUrFYpDOF3nKoX
 GYZX0/NrKCevHSV8ZblrJvRYjXknSN26XWDVpUPOkGNqYSNLYex0S2BHq1B/48+dZtVM
 V8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2xjfAFFEWDuI/P26T2zoS1xiDMGAz867DMgCQ/oLVWQ=;
 b=ZXcTsPE/MNNEteuC6fdO76HfMF+Fi+x28zFFM2DAhJWSSZRdL/G190JnkELzje1jkb
 GKZLEGzxqKKla7klhZTJjvU0yc/yzqnk3kYKgxfZnhinN9+Hvdp8owMCNB3W5odD6w00
 xDiUBLUi9OpWZYl+dRGsbDGM1k5K2jhR1k+P64FcXcG4mHkJ68/yTCrXl0xeKo/OJQd1
 DkOuEL/Gs6y3L994AYcH0Z5JOCupMvD21uGEFO0lcCJCyZGk/T4GFAu5A85cuF3+tA/9
 ZWJI9NxAiJMPwWHq2pyxNsArx3lFqedd9s214dFALKQsGYEYKw3XP+KHII8kw+clwuhT
 sEWA==
X-Gm-Message-State: APjAAAWGJmtFAv3HXB+qXttV7Zph9xfLH6NwJejwN9n/FOrWXbSm7Jta
 WOnUn6gx/Dvk7P5r7CbTdsPsb7B6
X-Google-Smtp-Source: APXvYqydFAnJ4hd8urMS8wcjdPKs7mvlWIMWKFjb7Kon0j1BLY3xh/b4iEBJr4aqbjcH43/HZhjvDw==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr10796119wrq.37.1576781501829; 
 Thu, 19 Dec 2019 10:51:41 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [RFC PATCH 10/13] hw/timer/allwinner: Rename AwA10PITState as
 AllwinnerTmrCtrlState
Date: Thu, 19 Dec 2019 19:51:24 +0100
Message-Id: <20191219185127.24388-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
References: <20191219185127.24388-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

This structure will be common to various Allwinner timer
controllers, rename it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/allwinner-a10.h       |  2 +-
 include/hw/timer/allwinner-a10-pit.h |  6 ++--
 hw/timer/allwinner-a10-pit.c         | 42 ++++++++++++++--------------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 7d2d215630..28c043db39 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -30,7 +30,7 @@ typedef struct AwA10State {
 
     ARMCPU cpu;
     qemu_irq irq[AW_A10_PIC_INT_NR];
-    AwA10PITState timer;
+    AllwinnerTmrCtrlState timer;
     AwA10PICState intc;
     AwEmacState emac;
     AllwinnerAHCIState sata;
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index 3a47633cc4..9e28c6697a 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -8,10 +8,10 @@
 
 #define AW_PIT_TIMER_MAX        6
 
-typedef struct AwA10PITState AwA10PITState;
+typedef struct AllwinnerTmrCtrlState AllwinnerTmrCtrlState;
 
 typedef struct AllwinnerTmrState {
-    AwA10PITState *container;
+    AllwinnerTmrCtrlState *container;
     int index;
     ptimer_state *ptimer;
     qemu_irq irq;
@@ -20,7 +20,7 @@ typedef struct AllwinnerTmrState {
     uint32_t count;
 } AllwinnerTmrState;
 
-struct AwA10PITState {
+struct AllwinnerTmrCtrlState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index ecfc198937..f2ac271e80 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -52,9 +52,9 @@
 #define AW_A10_PIT_DEFAULT_CLOCK    0x4
 
 #define AW_A10_PIT(obj) \
-    OBJECT_CHECK(AwA10PITState, (obj), TYPE_AW_A10_PIT)
+    OBJECT_CHECK(AllwinnerTmrCtrlState, (obj), TYPE_AW_A10_PIT)
 
-static void a10_pit_update_irq(AwA10PITState *s)
+static void a10_pit_update_irq(AllwinnerTmrCtrlState *s)
 {
     int i;
 
@@ -66,7 +66,7 @@ static void a10_pit_update_irq(AwA10PITState *s)
 
 static uint64_t a10_pit_read(void *opaque, hwaddr offset, unsigned size)
 {
-    AwA10PITState *s = AW_A10_PIT(opaque);
+    AllwinnerTmrCtrlState *s = AW_A10_PIT(opaque);
     uint8_t index;
 
     switch (offset) {
@@ -111,7 +111,7 @@ static uint64_t a10_pit_read(void *opaque, hwaddr offset, unsigned size)
 }
 
 /* Must be called inside a ptimer transaction block for s->timer[idx].ptimer */
-static void a10_pit_set_freq(AwA10PITState *s, int index)
+static void a10_pit_set_freq(AllwinnerTmrCtrlState *s, int index)
 {
     uint32_t prescaler, source, source_freq;
 
@@ -130,7 +130,7 @@ static void a10_pit_set_freq(AwA10PITState *s, int index)
 static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
                             unsigned size)
 {
-     AwA10PITState *s = AW_A10_PIT(opaque);
+     AllwinnerTmrCtrlState *s = AW_A10_PIT(opaque);
      uint8_t index;
 
     switch (offset) {
@@ -222,10 +222,10 @@ static const MemoryRegionOps a10_pit_ops = {
 };
 
 static Property a10_pit_properties[] = {
-    DEFINE_PROP_UINT32("clk0-freq", AwA10PITState, clk_freq[0], 0),
-    DEFINE_PROP_UINT32("clk1-freq", AwA10PITState, clk_freq[1], 0),
-    DEFINE_PROP_UINT32("clk2-freq", AwA10PITState, clk_freq[2], 0),
-    DEFINE_PROP_UINT32("clk3-freq", AwA10PITState, clk_freq[3], 0),
+    DEFINE_PROP_UINT32("clk0-freq", AllwinnerTmrCtrlState, clk_freq[0], 0),
+    DEFINE_PROP_UINT32("clk1-freq", AllwinnerTmrCtrlState, clk_freq[1], 0),
+    DEFINE_PROP_UINT32("clk2-freq", AllwinnerTmrCtrlState, clk_freq[2], 0),
+    DEFINE_PROP_UINT32("clk3-freq", AllwinnerTmrCtrlState, clk_freq[3], 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -247,24 +247,24 @@ static const VMStateDescription vmstate_a10_pit = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(irq_enable, AwA10PITState),
-        VMSTATE_UINT32(irq_status, AwA10PITState),
-        VMSTATE_STRUCT_ARRAY(timer, AwA10PITState,
+        VMSTATE_UINT32(irq_enable, AllwinnerTmrCtrlState),
+        VMSTATE_UINT32(irq_status, AllwinnerTmrCtrlState),
+        VMSTATE_STRUCT_ARRAY(timer, AllwinnerTmrCtrlState,
                              AW_PIT_TIMER_MAX,
                              0, vmstate_aw_timer,
                              AllwinnerTmrState),
-        VMSTATE_UINT32(watch_dog_mode, AwA10PITState),
-        VMSTATE_UINT32(watch_dog_control, AwA10PITState),
-        VMSTATE_UINT32(count_lo, AwA10PITState),
-        VMSTATE_UINT32(count_hi, AwA10PITState),
-        VMSTATE_UINT32(count_ctl, AwA10PITState),
+        VMSTATE_UINT32(watch_dog_mode, AllwinnerTmrCtrlState),
+        VMSTATE_UINT32(watch_dog_control, AllwinnerTmrCtrlState),
+        VMSTATE_UINT32(count_lo, AllwinnerTmrCtrlState),
+        VMSTATE_UINT32(count_hi, AllwinnerTmrCtrlState),
+        VMSTATE_UINT32(count_ctl, AllwinnerTmrCtrlState),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static void a10_pit_reset(DeviceState *dev)
 {
-    AwA10PITState *s = AW_A10_PIT(dev);
+    AllwinnerTmrCtrlState *s = AW_A10_PIT(dev);
     uint8_t i;
 
     s->irq_enable = 0;
@@ -290,7 +290,7 @@ static void a10_pit_reset(DeviceState *dev)
 static void a10_pit_timer_cb(void *opaque)
 {
     AllwinnerTmrState *tc = opaque;
-    AwA10PITState *s = tc->container;
+    AllwinnerTmrCtrlState *s = tc->container;
     uint8_t i = tc->index;
 
     if (s->timer[i].control & AW_A10_PIT_TIMER_EN) {
@@ -305,7 +305,7 @@ static void a10_pit_timer_cb(void *opaque)
 
 static void a10_pit_init(Object *obj)
 {
-    AwA10PITState *s = AW_A10_PIT(obj);
+    AllwinnerTmrCtrlState *s = AW_A10_PIT(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     uint8_t i;
 
@@ -341,7 +341,7 @@ static void a10_pit_class_init(ObjectClass *klass, void *data)
 static const TypeInfo a10_pit_info = {
     .name = TYPE_AW_A10_PIT,
     .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AwA10PITState),
+    .instance_size = sizeof(AllwinnerTmrCtrlState),
     .instance_init = a10_pit_init,
     .class_init = a10_pit_class_init,
 };
-- 
2.21.0


