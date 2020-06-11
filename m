Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40BDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7E2206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 22:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQGSX1oB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7E2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjVrn-0002JD-RA
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 18:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3l7DiXgsKCoAlwomrriqsirksskpi.gsquiqy-hiziprsrkry.svk@flex--hskinnemoen.bounces.google.com>)
 id 1jjVj0-0004XA-Kn
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:31:06 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:44210)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3l7DiXgsKCoAlwomrriqsirksskpi.gsquiqy-hiziprsrkry.svk@flex--hskinnemoen.bounces.google.com>)
 id 1jjViz-0004Hy-4P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 18:31:06 -0400
Received: by mail-yb1-xb49.google.com with SMTP id b135so8212352yba.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=E/t7NCqU4xlcbST0JMpIAE4l1XlKmG5L/C+Lk5feEf8=;
 b=OQGSX1oBgM+amV109UBZs/Bd60eKPvh7a/6Dhp9nZ9sR7DJn25hfs2d4l4GtcqaAsF
 xVZju6mRreiX+Vo2eqZcBn630JAYc058IL+uqDMsPsgCTe4MTI42VGslhba+Vw2Sn3al
 S/0ITzCKdb26GW2tW0LJObDcDQ1yEVtLoZYPfW3mFCSnxs72lq+kpr4cOx9pAs/Lz0Jq
 Ud9D3JWrSQ2AfM6DLf5oQTQmREV0X/vnIZlY7tfdkTh6NTmqqfvJwJP8qHryWmDzdTl+
 r2lgV/4HUSf3wkbQC9Z4gE1CSr8Cs6yXlyFkPfEuLKxuuZ7jF9srxwvY3FiLigYV8RW2
 JJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=E/t7NCqU4xlcbST0JMpIAE4l1XlKmG5L/C+Lk5feEf8=;
 b=UtTqjcw1H8dmN17F//1me3KkOMq+wx0BF/dhi8v2+Fp2aa05TP9E+mpshU4boXymeo
 pzQAgeSP+KoW7+7LVuzsQYS8ih1XAyV7hGVqu50q1rNayqk3Ok7reDtA7roLTCanl/aj
 WOFYDdxI/Shf/qvfTuT8drHKxBKBQFcCZiDc63lk/bZc8Dfs15Vp7V06umym0DBjGDc9
 XT1FFRV/N7lVcU0O2y8MpS/Uf7tibIf7si5GbdjiRAirzVYzNVgUA+Sh1pemUSvDUVEK
 nWYjqnN+WCv9jcUiBUUBSKA+YdE6TwfyQTNP351fF7RPrqqwHYn//Y4nOy8IvBHeYm+I
 VCfg==
X-Gm-Message-State: AOAM533Jb9rleu7N08ucyJalK8ca4Az0RDv834+1X6fK+A/RKtjRE5ZI
 dhqNoQP+ooeBRzA3Nyia+8bJE4AltRT30yVW6A==
X-Google-Smtp-Source: ABdhPJw/5NDeBKdsUCIDwvQXbTXlnGE6RA0ZqRTwnXaejXYDzzTqVnoy1uGd/19I4qog35Wlj3A6pgHZdvn0TOGssQ==
X-Received: by 2002:a5b:4cd:: with SMTP id u13mr6632708ybp.323.1591914647790; 
 Thu, 11 Jun 2020 15:30:47 -0700 (PDT)
Date: Thu, 11 Jun 2020 15:30:15 -0700
In-Reply-To: <20200611223016.259837-1-hskinnemoen@google.com>
Message-Id: <20200611223016.259837-12-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200611223016.259837-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH v2 11/12] hw/arm: Wire up BMC boot flash for npcm750-evb and
 quanta-gsj
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3l7DiXgsKCoAlwomrriqsirksskpi.gsquiqy-hiziprsrkry.svk@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

Change-Id: I158a4d9952c0e90f2b1b7280443a7305b6ae57cf
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx_boards.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 86e18af2d7..1ec772fa59 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -18,6 +18,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/units.h"
 
@@ -40,6 +41,20 @@ static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
     arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
 }
 
+static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
+                                  const char *flash_type, DriveInfo *dinfo) {
+    DeviceState *flash;
+    qemu_irq flash_cs;
+
+    flash = ssi_create_slave_no_init(fiu->spi, flash_type);
+    qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo),
+                        &error_abort);
+    qdev_init_nofail(flash);
+
+    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
+    sysbus_connect_irq(SYS_BUS_DEVICE(fiu), cs_no, flash_cs);
+}
+
 static NPCM7xxState *npcm7xx_create_soc(MachineState *machine)
 {
     NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_GET_CLASS(machine);
@@ -57,18 +72,30 @@ static NPCM7xxState *npcm7xx_create_soc(MachineState *machine)
 static void npcm750_evb_init(MachineState *machine)
 {
     NPCM7xxState *soc;
+    DriveInfo *dinfo;
 
     soc = npcm7xx_create_soc(machine);
 
+    dinfo = drive_get(IF_MTD, 0, 0);
+    if (dinfo) {
+        npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", dinfo);
+    }
+
     npcm7xx_load_kernel(machine, soc);
 }
 
 static void quanta_gsj_init(MachineState *machine)
 {
     NPCM7xxState *soc;
+    DriveInfo *dinfo;
 
     soc = npcm7xx_create_soc(machine);
 
+    dinfo = drive_get(IF_MTD, 0, 0);
+    if (dinfo) {
+        npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e", dinfo);
+    }
+
     npcm7xx_load_kernel(machine, soc);
 }
 
-- 
2.27.0.290.gba653c62da-goog


