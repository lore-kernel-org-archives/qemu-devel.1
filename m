Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845C2C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E59320692
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff51tXSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E59320692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlR7-0000cU-Fh
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIc-0000HI-SG
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIb-0005bL-R4
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:41:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIb-0005ag-LN; Sun, 12 Apr 2020 18:41:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id a201so8022464wme.1;
 Sun, 12 Apr 2020 15:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LZt0wKgOcXbd9J2Y1x7+Xq5w37mnJzb6ovGxsczGG64=;
 b=Ff51tXSFzMGTVB6OFe8osL8ONzouppYDRkA2PIv3gsEFbZbh7q8ABs7ytxaJIG5bbl
 SaeJtifskcrkTRvldi2nu7JOj/G4UcSLaf9/ndJ1pJfvdSERV6BQfA75byp+mF6y7ASz
 gCTdoWdE686ZrX05sirXkyRY3oos7DODVumfnk8QpvNUGUXQRLrb6NYO9McQKJXnymy2
 f52qr55WLRuifIiwUdlcd1pq7FwLSH15YMqbRtbBdqzlBN5fFhP2pTRiTGry+FUQVQEQ
 eef+vFNbz+swgk4Mz7sg/TXs4q+tKZ6oCpJ62G7WbY8Y1YDssqlqMgpZX9hd9tkLQ3Ja
 3GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LZt0wKgOcXbd9J2Y1x7+Xq5w37mnJzb6ovGxsczGG64=;
 b=Tk7Gm0L16z/EsYGQHEIEL66TYQg3iSFoOiXPwus5jKz+RcUuxYSw5FhDrt5ljcpjXe
 9jk1PDBwPq6jOaW2J/wT0URj1OaHg3P7pyj7QOU5hoWKEtzzLvhCAt61hzIE6oIh1lB9
 EXfi4+T3t9ZuzGt1NjKbu0H3r9EJjWb3k+7nW46BGgfJp3CaZ58z+004AyWI1QXph/rF
 prLbxFL3fhFjqCRwIt9QbI2N59AvIbf4IMlPRQYRL12VJHUd+sMasNEe0Uyd2t8AjOxH
 gDLMfbEte16aBSGoRRIzIuljmtkZE4ElN3H97INFFmydp/PuuqPojP0VGMs5hUyCFKbo
 TOXg==
X-Gm-Message-State: AGi0PubCiH1PKtgA6zKfIsgXXQcfFsWgd1CHrURFVTiNhOcpYImzfDDG
 i6XCNankBCAN/58+A1/wOT4vyyNJ/T5nSw==
X-Google-Smtp-Source: APiQypL/eTMuhBIW7cJJft81oZJNUAucSomY9Qu5NwW35Awp1q6yAaZ8cPQZMSNMkHpIPuRZhpyEJA==
X-Received: by 2002:a05:600c:224a:: with SMTP id
 a10mr16506355wmm.174.1586731316198; 
 Sun, 12 Apr 2020 15:41:56 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:41:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 02/23] hw/arm/fsl-imx: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 00:41:23 +0200
Message-Id: <20200412224144.12205-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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


