Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26305C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E939B2073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGG4HmeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E939B2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQny-0006zU-8C
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQl6-0002oS-Ok; Fri, 03 Jul 2020 14:50:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQl5-0007dC-4r; Fri, 03 Jul 2020 14:50:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id s10so33695708wrw.12;
 Fri, 03 Jul 2020 11:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y9ApWH9gz4M4qZvGxoP6zo+vP+3Z0/10bVmtSoKgmDA=;
 b=WGG4HmeKWLz+kxxqc8rPXhCqT+QP+vqOXsU5ZHY/LfEs9GDrQGYtqRObnqqIy5D+Ds
 3BG5FVWk3TTLApEXgACm0rFLTDfJ8d+jjRCFmGjEcShsMriWW8b+aYMWn8rlhgwwNwsJ
 wfSmJ0WTVGjYiQZoylYvUQF+jRloEQQw1iFl9PLe9TESvpNTDtlJCvOURdruz5sXX+jd
 zw+l0OfkTT1/4bNuPuP1YAEAd3SlBoawtbBukiQDSyaYGOI0jxL4KgxLVZuH6kVGlXkG
 p56mtIGkJxObAymfysJexA6eg2xFrd3bGkrF6UAK2qxDkO6a54cNgXj2FI6NsoGWaOb4
 fkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=y9ApWH9gz4M4qZvGxoP6zo+vP+3Z0/10bVmtSoKgmDA=;
 b=HHbBgGxqdYCmkCV0gNAyuwCb/valDS2ZvJHAHilV3Gfdtkw9OoMZ3BT+QU6yecgzPq
 w4loAIRBmqsOE3vhhcwbRsQ9VYGYUzwaOkXk/OT5wu5bWxC6wWj9HcJDvBriILKCfqfb
 pCc78I6ttfB6f3B/Fj5eS7XLECgbsA0CTFEqmwJaEP9vwAbi0pEWjlWPtzZ8oCtrA0bS
 kGqGs4H9w10DTn5O+rcCSrhjMTU90iVq5mYC2wWXPdEwz52JePXx6rurwm3ok9ZUSW8e
 QRKCb28+bSJob30NsPjUUQwaCsUsfrOL8UBLbxvBunknHs6VCdqFSVHh/AbW42Xery/a
 NBGg==
X-Gm-Message-State: AOAM531eBHxrS5CYR02/2IXhdSsLETCfEQk2JUfL523bcTEjrhG0UIYo
 KX+cS39eCcZURoIHGPl4wd19fu3mwj0=
X-Google-Smtp-Source: ABdhPJzmjsXnWHN2++nWfTCBU5nNVneetlT9YQ4EefGjogysbLJLzzBYrEtz6UC01KQOi42GQIc7YA==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr37371559wro.214.1593802196812; 
 Fri, 03 Jul 2020 11:49:56 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x11sm13778369wmc.26.2020.07.03.11.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 11:49:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/ppc: Use TYPE_SYSBUS_OHCI instead of hardcoded string
Date: Fri,  3 Jul 2020 20:49:52 +0200
Message-Id: <20200703184952.4918-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703184952.4918-1-f4bug@amsat.org>
References: <20200703184952.4918-1-f4bug@amsat.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using the TYPE_* definitions for devices, we can:
- quickly find where devices are used with 'git-grep'
- easily rename a non-user-creatable device (one-line change).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/sm501.c | 3 ++-
 hw/ppc/sam460ex.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 9cccc68c35..c122a4eca5 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -36,6 +36,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/i2c/i2c.h"
 #include "hw/display/i2c-ddc.h"
+#include "hw/usb/hcd-ohci.h"
 #include "qemu/range.h"
 #include "ui/pixel_ops.h"
 #include "qemu/bswap.h"
@@ -1961,7 +1962,7 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->state.mmio_region);
 
     /* bridge to usb host emulation module */
-    usb_dev = qdev_new("sysbus-ohci");
+    usb_dev = qdev_new(TYPE_SYSBUS_OHCI);
     qdev_prop_set_uint32(usb_dev, "num-ports", 2);
     qdev_prop_set_uint64(usb_dev, "dma-offset", s->base);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(usb_dev), &error_fatal);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1a106a68de..593436937a 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -35,6 +35,7 @@
 #include "hw/char/serial.h"
 #include "hw/i2c/ppc4xx_i2c.h"
 #include "hw/i2c/smbus_eeprom.h"
+#include "hw/usb/hcd-ohci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/ppc/fdt.h"
 #include "hw/qdev-properties.h"
@@ -370,7 +371,7 @@ static void sam460ex_init(MachineState *machine)
 
     /* USB */
     sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400, uic[2][29]);
-    dev = qdev_new("sysbus-ohci");
+    dev = qdev_new(TYPE_SYSBUS_OHCI);
     qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
     qdev_prop_set_uint32(dev, "num-ports", 6);
     sbdev = SYS_BUS_DEVICE(dev);
-- 
2.21.3


