Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196B5C2BB86
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73C520735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ931QxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73C520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO65j-000788-1d
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 16:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO64o-0006Fe-I2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO64n-0008D7-El
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:53:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO64n-0008B0-8K
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:53:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id a81so11455383wmf.5
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UhAVvFgdKZItMBK76DLdu4ImD7RTe3y+DxnwlUR9418=;
 b=OQ931QxBe8caqBbmyj6AF1nHPmcco/xdLpSnTciOWUPbMnjrEIIXrPiZQLv6d+aOXG
 2K6N74v3A+7bYckfUU8mOFUwROwXZ8ThNjMhIl8NPqN9H99zV0OUlAFGmudWFhMne1Kw
 jhhcZnS93Gkr4eDK+3t2RUPFGb201sZC2lA+a9t5bIhdwnl9yt8agSUDse5DSPla3V+E
 +E+EEbrobDl8XioSBXuMUW8snw31TRS028Xpk5tUeCS8dBLt0aqj0eMfPnqsIobGkXyY
 VeUl65awKJse3rd9X5y8HfS+V1vyDQb+hg10WhoFEDtXORJMba8f4gUA5OoYiYvEnt2z
 kouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UhAVvFgdKZItMBK76DLdu4ImD7RTe3y+DxnwlUR9418=;
 b=pkuDYfvibv/tSpAyqtY5ajzh72W2DfvXKQjfdBiP7Nc7YUiGqRCjzkj7I7qVUjZp1a
 O+xTQrToeSQQbBGb8YuMkAJJLIdJz+lrcuoifIfUWpnOInSHskUqy4LOlCOSUnXFJf8F
 fZ40rWWE4OSC/zQ4CHj36SOt3drBK4XaVtwt/EXolviRWWdjE8c/E+P/d+wIyf2p1k/i
 57GHjLM/bUZ2ZDJym7JIKRkKpxxJbjoEY8PAq46pfkeYwLsrWQyNbR7MUZI5mtsocKiW
 77D4c9wRr5pNt2Upfp2Js5z2NFb+2Ma1xIyHSQezWPXBgxKGad0xI9ThzwjJAnNbnVKh
 UidQ==
X-Gm-Message-State: AGi0PuYe0jg97DA+MAQ0NVOT7NoM6A07akaWeaNP2RJ5Byy9bc0jWOYI
 xx3vTp3V2pCtzoE0lDE5kQzqWs3kBAhL8A==
X-Google-Smtp-Source: APiQypJiuj4/Moc+ZdnGr20f8ywVaxpL07DLoU1G63o29yOKqv1DzTPC6Q9Byzc8oEwFzO+7QFk4Ug==
X-Received: by 2002:a1c:7d90:: with SMTP id
 y138mr21637039wmc.121.1586811182101; 
 Mon, 13 Apr 2020 13:53:02 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b11sm16380603wrq.26.2020.04.13.13.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 13:53:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 5/7] hw/mips/boston: Add missing error-propagation
 code
Date: Mon, 13 Apr 2020 22:52:50 +0200
Message-Id: <20200413205250.687-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: 20200412224517.12869-1-f4bug@amsat.org
References: <20200413205250.687-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
 Paul Burton <pburton@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script produced:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --dir .
  HANDLING: ./hw/mips/boston.c
  [[manual check required: error_propagate() might be missing in object_property_set_int() ./hw/mips/boston.c:462:4]]
  [[manual check required: error_propagate() might be missing in object_property_set_str() ./hw/mips/boston.c:460:4]]

Since the uses are inside a MachineClass::init() function,
directly use &error_fatal instead of error_propagate().

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/boston.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 98ecd25e8e..2e821ca7d6 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -426,7 +426,6 @@ static void boston_mach_init(MachineState *machine)
 {
     DeviceState *dev;
     BostonState *s;
-    Error *err = NULL;
     MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
     MemoryRegion *sys_mem = get_system_memory();
     XilinxPCIEHost *pcie2;
@@ -458,19 +457,15 @@ static void boston_mach_init(MachineState *machine)
     sysbus_init_child_obj(OBJECT(machine), "cps", OBJECT(&s->cps),
                           sizeof(s->cps), TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-type",
-                            &err);
-    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp", &err);
-    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
-
-    if (err != NULL) {
-        error_report("%s", error_get_pretty(err));
-        exit(1);
-    }
-
+                            &error_fatal);
+    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp",
+                            &error_fatal);
+    object_property_set_bool(OBJECT(&s->cps), true, "realized", &error_fatal);
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
 
     flash =  g_new(MemoryRegion, 1);
-    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err);
+    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB,
+                           &error_fatal);
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
 
     memory_region_add_subregion_overlap(sys_mem, 0x80000000, machine->ram, 0);
-- 
2.21.1


