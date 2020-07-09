Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E43EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A14206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2tFO5xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A14206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKdp-0005w0-Io
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lWYGXwsKCnofqigllckmclemmejc.amkocks-bctcjlmlels.mpe@flex--hskinnemoen.bounces.google.com>)
 id 1jtKYL-0006Xo-1I
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:36:41 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:54594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lWYGXwsKCnofqigllckmclemmejc.amkocks-bctcjlmlels.mpe@flex--hskinnemoen.bounces.google.com>)
 id 1jtKYJ-00012N-Ch
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:36:40 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id p22so738448ybg.21
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 17:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=eKgWkuM4GJmY6FctxrD+gBwcnEvk9udSz1JnbpjmKwI=;
 b=l2tFO5xAXT13KB64jcjFMa/PIoPH4gxP9fN0XyUA/KRNQflP8MMSRvjRCULDtB5k9k
 oZn+LDDyqLSmItjSb8eTK6/8kPIKQb3av6pOnYfj/rm/xcgVI+FkMPrH8qT6WP5B7Hwt
 kPTwPMJB9zDuR+PuX3lYlMmNxb3o2VB0toz6fVjeoyEmRIrOyOzFtaDH3wYK5Pi2G6/p
 31RkAxVb1wbDkYm/vGW+cvm6Gr5/9l4fTtXoICFD6/CyBEL0w8ZTjLp4syNk73TMsbTt
 BdLIn/d6NTB5VdXZ7aOnkmxA6dpDpg/x2evQcO8oAPutUNq8f4lOUipqjzBH58V170mJ
 0E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=eKgWkuM4GJmY6FctxrD+gBwcnEvk9udSz1JnbpjmKwI=;
 b=Ay2dIqousfPFLKUK5s7oOXZwtuDvXoPVrExdeWA8oBFDqzvJQjKkqEcLMXF3ff9hiH
 J7u+FYK9ldWxO6IzqT3y9r5FNJbIEfK6/k+n6jYhKXyyrobiyTsBfipdZLYYX9xQ5Jz9
 fS17lkth0xlGsDzcOca3REjWoTZ9/jsVvZPCY+ztfQ6ROH/BJcsmYawj7Z1eaHuMqsqd
 wFCzidn7PP60eKpioY27LlLoHoFtdKdfvAIyCvQGvdA7LNuDad/5XrvLmYpbdlXptPpA
 fgEzViY3+8zDcYnQu2XPKQW9mwUIC73P8N+HY45yulvIPgZZEXwZt/F8aE53escpgBzK
 aN+w==
X-Gm-Message-State: AOAM530XhOIM3/a6+GReWYqGiTUW6sdKLHZZ+it2Fa92b/eVce0K8/mI
 C3/G3aKwk5l3SWS9euUPNKx1mA2wKMBs15eh+Q==
X-Google-Smtp-Source: ABdhPJwavzoApTjzo0qmm5+olg6lYf04rb5LNbubrr7Mypxyzsor4gYMkUVDrK2kONtOkSznmnGcdlvlIdmpKrmPlg==
X-Received: by 2002:a25:aa4b:: with SMTP id s69mr31135660ybi.502.1594254997250; 
 Wed, 08 Jul 2020 17:36:37 -0700 (PDT)
Date: Wed,  8 Jul 2020 17:36:03 -0700
In-Reply-To: <20200709003608.3834629-1-hskinnemoen@google.com>
Message-Id: <20200709003608.3834629-7-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v5 06/11] hw/arm: Load -bios image as a boot ROM for npcm7xx
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3lWYGXwsKCnofqigllckmclemmejc.amkocks-bctcjlmlels.mpe@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

If a -bios option is specified on the command line, load the image into
the internal ROM memory region, which contains the first instructions
run by the CPU after reset.

A minimal Apache-2.0-licensed boot ROM can be found at

https://github.com/google/vbootrom

It is by no means feature complete, but it is enough to launch the
Nuvoton bootblock[1] from offset 0 in the flash, which in turn will
launch u-boot and finally the Linux kernel.

[1] https://github.com/Nuvoton-Israel/bootblock

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index d78d9f991b..80cf1535f1 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -19,8 +19,11 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
+#include "hw/loader.h"
 #include "qapi/error.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
+#include "sysemu/sysemu.h"
 
 #define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
 #define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
@@ -34,6 +37,25 @@ static struct arm_boot_info npcm7xx_binfo = {
     .board_id           = -1,
 };
 
+static void npcm7xx_load_bootrom(NPCM7xxState *soc)
+{
+    if (bios_name) {
+        g_autofree char *filename = NULL;
+        int ret;
+
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        if (!filename) {
+            error_report("Could not find ROM image '%s'", bios_name);
+            exit(1);
+        }
+        ret = load_image_mr(filename, &soc->irom);
+        if (ret < 0) {
+            error_report("Failed to load ROM image '%s'", filename);
+            exit(1);
+        }
+    }
+}
+
 static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
 {
     NPCM7xxClass *sc = NPCM7XX_GET_CLASS(soc);
@@ -73,6 +95,7 @@ static void npcm750_evb_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_abort);
 
+    npcm7xx_load_bootrom(soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -84,6 +107,7 @@ static void quanta_gsj_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_abort);
 
+    npcm7xx_load_bootrom(soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
-- 
2.27.0.383.g050319c2ae-goog


