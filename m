Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC1C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E67206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b22dpc9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E67206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWDk-0002DS-QI
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrF-0002HM-4g
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrD-0003FG-PW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrD-000384-Ij; Mon, 06 Apr 2020 13:48:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id j19so224074wmi.2;
 Mon, 06 Apr 2020 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LZt0wKgOcXbd9J2Y1x7+Xq5w37mnJzb6ovGxsczGG64=;
 b=b22dpc9P0WfFSNzqmIIOCXA5j3SBgFlX8kq3DgEjbyVRZ8ab+WAskuZKaX2KGJrDLi
 1ExUViGINuZ8wSAaG3bsdI4Qf2xLPYPAYtKbx2Ck8bI55nvlbpZFHWxggyqaEsc/B6Tx
 Az0ZZtZkK5shftM30BXtxoW3XJNu3kDjtdBv9uE0NZTpHwLXWM7hXbROSp1jTv1sFmY7
 Z+mQGb197/FlpeQAhw53ngaherhWtKlj6P1Q4JZij8cptwHc25grvofEODCHBALPRy74
 oiUSsvpP1JR2INFgYeHkNXldxDy8uwJftZN1sV5q42oQvzzAPAfzKndPrLkGSDp4lFLU
 bIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LZt0wKgOcXbd9J2Y1x7+Xq5w37mnJzb6ovGxsczGG64=;
 b=bw1LJ4z8TrGtW2cYShyN9C9NT+XoT2MnJ7NnBJeSH4tqT12ePb8HBRO87A4JVGIcWr
 ITN9iJS4jCtwxeGrZIKPIwXXL+TkaWl84AaHVYxbAu6RnQfOtD+3Kt5mQCwkcfT6oft7
 Ppxz2XZM2jX25hU++x2xmNfn/mPFl9CxildemH5VtD6FufMl6BybY9PGhy4kljJug3pj
 1d9wPlPHzauKWG5XRQs+LQFywptzgmwBhDWS8KXVYQ5CeP8tH+bEnlz5t9Baf7DretL0
 Zgsp0TtOS1k/8gznFphKvYo2ePOmQuTT3+Y/RZPMa3GPpBCMp0KT0CKDSYzLzQ/m0j5G
 kJzA==
X-Gm-Message-State: AGi0PuaeF3oKVjMnpsPw+LL1yjSI2PtoZXtDl9Wz8ojqU9ORDzcDZMK2
 6QHjLzh+C2igtimkMUu9/nWcHFEOd2s=
X-Google-Smtp-Source: APiQypKWa/QU3mBr8qNVtZoW8/hCd3u7++648Q6PPb0tFKLlkmydTq29R5+wTNf/fBkbcBiEf5iVkw==
X-Received: by 2002:a1c:e242:: with SMTP id z63mr205942wmg.72.1586195301541;
 Mon, 06 Apr 2020 10:48:21 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 26/54] hw/arm/fsl-imx: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:15 +0200
Message-Id: <20200406174743.16956-27-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:i.MX25 PDK" <qemu-arm@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/fsl-imx25.c |  6 +++++-
 hw/arm/fsl-imx6.c  | 18 +++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 6f1a82ce3d..3d87fe867e 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -295,7 +295,11 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
         };
 
         object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
-                                 &error_abort);
+                                 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
                            qdev_get_gpio_in(DEVICE(&s->avic),
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 6bf8aa0404..b3cef5bb57 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -359,7 +359,11 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     /* USB */
     for (i = 0; i < FSL_IMX6_NUM_USB_PHYS; i++) {
         object_property_set_bool(OBJECT(&s->usbphy[i]), true, "realized",
-                                 &error_abort);
+                                 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usbphy[i]), 0,
                         FSL_IMX6_USBPHY1_ADDR + i * 0x1000);
     }
@@ -372,7 +376,11 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         object_property_set_bool(OBJECT(&s->usb[i]), true, "realized",
-                                 &error_abort);
+                                 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX6_USBOH3_USB_ADDR + i * 0x200);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
@@ -430,7 +438,11 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
-                                 &error_abort);
+                                 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
     }
-- 
2.21.1


