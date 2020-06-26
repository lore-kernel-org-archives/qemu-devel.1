Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A726C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 00:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1076C20706
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 00:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPFk7yQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1076C20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joyKn-0003U7-CT
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 20:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EYv2XgsKCv4nyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com>)
 id 1joyCT-000852-3D
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 19:56:05 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:55038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EYv2XgsKCv4nyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com>)
 id 1joyCQ-0002Ck-VG
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 19:56:04 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id p22so11458129ybg.21
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 16:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ezVubqNhatMt7jrAiju4ysHTsj0nXSxcDY5lBkuPaY4=;
 b=OPFk7yQqB+9SoEImTqqthAxB2z8l65HSKRl8qngEJMSYMB60nsVkSHg7Cam/P5S9z5
 0/Q6LhLSB4awcRg7ui5dRinxWSqsI4ZVy7lQXO6oFcaUq1buI+CdpNMUR1uMu9/dMFID
 gmpRPriI4hGuJ7RmQT5CT43LciohGil54lVMfxK5t40X5jIlu8ikb7m+E9zfiJgg51UR
 +OkZ1lhTvfaYXSB1fmiWPNw+oA8yJDfvbcrz9XphexOeqkSN7Aj+pL/EElKzfsqV8yRA
 xRZRKWLj4ECAtOADUklUMVGxquqmVhdPyPsKNND6oLCLbi+xt2UyZ25iOef2pYHmkX28
 UkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ezVubqNhatMt7jrAiju4ysHTsj0nXSxcDY5lBkuPaY4=;
 b=p9hBP+FvM3DPsv50/ZJ6RzJdjeV1QN1uXmnzjIYZdCOTb8RfeNGZivhAngemC7qJ0T
 8JPVymMPb+xoSpZcDo8JgPXLz8NLfVDKwZNQAPxqFR9p+u8/nXoc58kH+UiUwDd/rBi2
 MHTR0aaHko1llhSSq3y8Uiur41mpCllLNvFIFe2g5c6kJZf75ztuyrCMx2uqEfqEcZxo
 ZniIdHD7w7b5eU4OxNNnZdRupXTK7DmKHZLmo9G82OrYgzGmqZEXndG7YWve06PxqPOu
 9GV1rhuFsjk804p4JYvNI0fUI+a5sWMkNivBoW0VBBVk3OsbNRh9RRXdpE49g2Hvyn8v
 GfkA==
X-Gm-Message-State: AOAM531nlrQTZH3qf5atagKimrdF8dP9iTZnSlVf5afULvwDxOVIhKn3
 KkLaZBfWv/pob+qb4Avikk8Mvt1p2mss5irPZg==
X-Google-Smtp-Source: ABdhPJwMzPQv3kCJcTiPlZUjJdFjCkZhZreSoqTws4T7dyv0NMTyEyY1VDiLhii2CUa6XTzhhV7f7RZitPSG32SGLg==
X-Received: by 2002:a25:8404:: with SMTP id u4mr9403808ybk.515.1593215761503; 
 Fri, 26 Jun 2020 16:56:01 -0700 (PDT)
Date: Fri, 26 Jun 2020 16:55:18 -0700
In-Reply-To: <20200626235519.591734-1-hskinnemoen@google.com>
Message-Id: <20200626235519.591734-12-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 11/12] hw/arm: Wire up BMC boot flash for npcm750-evb and
 quanta-gsj
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3EYv2XgsKCv4nyqottksuktmuumrk.iuswks0-jk1krtutmt0.uxm@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows these NPCM7xx-based boards to boot from a flash image, e.g.
one built with OpenBMC. For example like this:

IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc
qemu-system-arm -machine quanta-gsj -nographic \
	-bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
	-drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index ca33262a59..12bf5a216f 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -19,6 +19,7 @@
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/units.h"
@@ -65,6 +66,21 @@ static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
     arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
 }
 
+static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
+                                  const char *flash_type, DriveInfo *dinfo) {
+    DeviceState *flash;
+    qemu_irq flash_cs;
+
+    flash = qdev_new(flash_type);
+    if (dinfo) {
+        qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+    }
+    qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
+
+    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    sysbus_connect_irq(SYS_BUS_DEVICE(fiu), cs_no, flash_cs);
+}
+
 static NPCM7xxState *npcm7xx_create_soc(MachineState *machine,
                                         uint32_t hw_straps)
 {
@@ -88,6 +104,7 @@ static void npcm750_evb_init(MachineState *machine)
 
     soc = npcm7xx_create_soc(machine, NPCM750_EVB_POWER_ON_STRAPS);
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -97,6 +114,8 @@ static void quanta_gsj_init(MachineState *machine)
 
     soc = npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
+                          drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
 
-- 
2.27.0.212.ge8ba1cc988-goog


