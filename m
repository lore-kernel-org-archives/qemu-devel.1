Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF15C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C909206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zd+w4zmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C909206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssjd-0003qY-VJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XsMEXwsKCvUephfkkbjlbkdlldib.Zljnbjr-absbiklkdkr.lod@flex--hskinnemoen.bounces.google.com>)
 id 1jssdO-0000iT-Vl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:48:03 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a]:43354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XsMEXwsKCvUephfkkbjlbkdlldib.Zljnbjr-absbiklkdkr.lod@flex--hskinnemoen.bounces.google.com>)
 id 1jssdM-0007dv-OP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:48:02 -0400
Received: by mail-pf1-x44a.google.com with SMTP id o5so20102397pfg.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=D0SJdwFH202EMhnUik6WkVDFVC1hs3eXL7kJjIfJbhQ=;
 b=Zd+w4zmmpNvJv6y3Tr3ivt8yfZ0JbY8B7Dqlq8KzGgB9f3n85UrsH7PcGaxVehmeGi
 W/ma65MZWKCi4iMSa0cOOf4VFS3vT/0WQfOjcDgXqiyDeNgdFxTLpF3LG2tl1CZhqTRp
 +f/TgKZ+2CR7diT4I5geVIfUg2jqJH1SOI2Tw0767fRzY9URpFYh1ImawGAT2efo5nSK
 jZH53xsSqnRSVZHvAnFu7mWaf447DCeHc99vnqW03MpE3Fc9lsTOQSjgxoAtgROcTJKx
 0j4mJuyCshtpwDQ8RfoE0nB999kUMnOZTnj/QNuX5Uok6S9YdrU3A+5mHIUGrpt5+K3C
 WPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=D0SJdwFH202EMhnUik6WkVDFVC1hs3eXL7kJjIfJbhQ=;
 b=S6YROOkDCg+TUFfK4289oSEbqmmIxn7Q2f7QwcZppt10LPQW+G6GIrxckGaWckovb+
 PxgDlj0XicMz5sjXE9gQ97AG6UftnLAlzjn8THVY1pL2jKetpnxI9nk2u5mtP9X5MPgQ
 PeConjiLf2kRZ5K6KakCQaCUFl++/dI/I/bwUjmaJM+R/00h1mopSXgRBYfdt1kLFXTK
 b6W2ID2ypFNLtva9DQrSmsvuyU0sHwEgwz83A4j+PlRcZklAWaKvx2t7ZrsA8H+IXga1
 cG53XdsPV/EiyL+GohNS/FlRO39dqaMDXCN4b1DYZAXDFR/FHTx0QzDc0+NmElj36AMn
 Qzeg==
X-Gm-Message-State: AOAM530GQ+xA2qvV9/VcVAcUZawq192cn3Kp65rQsPJgmuguxgb+2/T2
 UGug6+can8HrUo7DqFVV+ktHcr4LpD2/GS+hSg==
X-Google-Smtp-Source: ABdhPJxDPyaV2N5lOBIY9NsDLqoaOhZk8XOjGqUT3+uh1zejsKiX3oddD6jsAavKpW5MOfSwu6zjVsGrCROVk7lIug==
X-Received: by 2002:a62:4e44:: with SMTP id c65mr14479177pfb.283.1594147678925; 
 Tue, 07 Jul 2020 11:47:58 -0700 (PDT)
Date: Tue,  7 Jul 2020 11:47:29 -0700
In-Reply-To: <20200707184730.3047754-1-hskinnemoen@google.com>
Message-Id: <20200707184730.3047754-12-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 11/12] hw/arm: Wire up BMC boot flash for npcm750-evb and
 quanta-gsj
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, philmd@redhat.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3XsMEXwsKCvUephfkkbjlbkdlldib.Zljnbjr-absbiklkdkr.lod@flex--hskinnemoen.bounces.google.com;
 helo=mail-pf1-x44a.google.com
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
index de2d2ca786..7de73594ed 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -20,6 +20,7 @@
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/units.h"
@@ -66,6 +67,21 @@ static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
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
@@ -89,6 +105,7 @@ static void npcm750_evb_init(MachineState *machine)
 
     soc = npcm7xx_create_soc(machine, NPCM750_EVB_POWER_ON_STRAPS);
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -98,6 +115,8 @@ static void quanta_gsj_init(MachineState *machine)
 
     soc = npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
     npcm7xx_load_bootrom(soc);
+    npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e",
+                          drive_get(IF_MTD, 0, 0));
     npcm7xx_load_kernel(machine, soc);
 }
 
-- 
2.27.0.212.ge8ba1cc988-goog


