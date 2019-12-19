Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1A9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B81222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbT48iy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B81222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii18N-0007cv-78
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 14:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tj-0007AO-JS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0ti-0008BU-5L
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:43 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0th-00085U-R3; Thu, 19 Dec 2019 13:51:42 -0500
Received: by mail-wr1-x442.google.com with SMTP id j42so7020432wrj.12;
 Thu, 19 Dec 2019 10:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xqTqck0MunQzlvW3fvG1Eh5JVsO+310wsc6ir4XWOg8=;
 b=DbT48iy/7ZvB5pfzW11tJNj8wYlfwPabB00bOKJ0VQCM46ByzLZ4a49Xm0UmmMz/Gk
 BGzwYIr+W3WolPSvYe9MMm2oHybcm/jmi0jszdd7i557I3GQ8/ltFe9RruaamPmLfoT4
 4K9qkxJazaD2em1FwLUI1ZgEiOG4Xr8mXmYLBhkIZwAX/ZGsvPCvMEa8vu6jWHGFP0PL
 O+xvyO5ZZTE8Hes37CPKCnSis217ZDk27eSmewXK8UAnA3FEL4qSTxfQfTJda/nPg9P8
 yaXQlotZOlEeiz77X81NBHRWjEV+39FKZ1wBvsb8kXvsvscMZ6XMp5zazNLXq+f9fbf2
 bY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xqTqck0MunQzlvW3fvG1Eh5JVsO+310wsc6ir4XWOg8=;
 b=d2OQgjyq82a1PfZoGPtPp3E0PZoBd+NU15oX7Yxg0aKBoWwPbtEWxH/SLftSsNIUgf
 3b/xdxUqhcjxrNtvWM857PcTeKAGtWoQJiZo9YlZzdE8h6RG/UbvZqN5sI98hpH8olDq
 Pq7wlLJ53QaneO4IhYMV0x9Q18EcgAfs+wyShfJTCOIKcP3et0zx9HuDs3QAEVF3Wrhu
 7F7pwsO35d/6IPWU0KQ5Ho1QMSPxpJu1RQ8Zl3S9sOfBKUMrPqJRivaurVKhKA3dTAam
 oDw+J38GqZaspBh1xk25rPIeYgOgEV+BC3SrrH5jS3bZNpeSqzzf5KLLr828AufvYeFV
 qfLQ==
X-Gm-Message-State: APjAAAUn3ZFZnEY+xycK7s/WBPyufXVtWZIsYIeVwJg8MlSFM+4NG6T6
 U9FTqCdIMIoVKWbC73/Gla6VDdQu
X-Google-Smtp-Source: APXvYqx/VGHdVWsKIJFPURExgJ03KjIrRp4uQuR5eGkcfc5bbnhAU+9EE5LXjLtXy9fSJPgB7ME4Ig==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr11215374wrt.367.1576781500573; 
 Thu, 19 Dec 2019 10:51:40 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [RFC PATCH 09/13] hw/timer/allwinner: Rename AwA10TimerContext as
 AllwinnerTmrState
Date: Thu, 19 Dec 2019 19:51:23 +0100
Message-Id: <20191219185127.24388-10-f4bug@amsat.org>
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

This structure will be common to various Allwinner timer
controllers, rename it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/allwinner-a10-pit.h |  6 +++---
 hw/timer/allwinner-a10-pit.c         | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index 8c64c33f01..3a47633cc4 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -10,7 +10,7 @@
 
 typedef struct AwA10PITState AwA10PITState;
 
-typedef struct AwA10TimerContext {
+typedef struct AllwinnerTmrState {
     AwA10PITState *container;
     int index;
     ptimer_state *ptimer;
@@ -18,14 +18,14 @@ typedef struct AwA10TimerContext {
     uint32_t control;
     uint32_t interval;
     uint32_t count;
-} AwA10TimerContext;
+} AllwinnerTmrState;
 
 struct AwA10PITState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
     size_t timer_count;
-    AwA10TimerContext timer[AW_PIT_TIMER_MAX];
+    AllwinnerTmrState timer[AW_PIT_TIMER_MAX];
     MemoryRegion iomem;
     uint32_t clk_freq[4];
 
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 3f47588703..ecfc198937 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -234,10 +234,10 @@ static const VMStateDescription vmstate_aw_timer = {
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(control, AwA10TimerContext),
-        VMSTATE_UINT32(interval, AwA10TimerContext),
-        VMSTATE_UINT32(count, AwA10TimerContext),
-        VMSTATE_PTIMER(ptimer, AwA10TimerContext),
+        VMSTATE_UINT32(control, AllwinnerTmrState),
+        VMSTATE_UINT32(interval, AllwinnerTmrState),
+        VMSTATE_UINT32(count, AllwinnerTmrState),
+        VMSTATE_PTIMER(ptimer, AllwinnerTmrState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -252,7 +252,7 @@ static const VMStateDescription vmstate_a10_pit = {
         VMSTATE_STRUCT_ARRAY(timer, AwA10PITState,
                              AW_PIT_TIMER_MAX,
                              0, vmstate_aw_timer,
-                             AwA10TimerContext),
+                             AllwinnerTmrState),
         VMSTATE_UINT32(watch_dog_mode, AwA10PITState),
         VMSTATE_UINT32(watch_dog_control, AwA10PITState),
         VMSTATE_UINT32(count_lo, AwA10PITState),
@@ -289,7 +289,7 @@ static void a10_pit_reset(DeviceState *dev)
 
 static void a10_pit_timer_cb(void *opaque)
 {
-    AwA10TimerContext *tc = opaque;
+    AllwinnerTmrState *tc = opaque;
     AwA10PITState *s = tc->container;
     uint8_t i = tc->index;
 
@@ -319,7 +319,7 @@ static void a10_pit_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 
     for (i = 0; i < s->timer_count; i++) {
-        AwA10TimerContext *tc = &s->timer[i];
+        AllwinnerTmrState *tc = &s->timer[i];
 
         tc->container = s;
         tc->index = i;
-- 
2.21.0


