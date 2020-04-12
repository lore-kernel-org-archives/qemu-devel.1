Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEABC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCB520692
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L284uUWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCB520692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlT5-0004xF-Fw
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIm-0000dt-V4
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIl-0005md-Se
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlIl-0005lt-MX; Sun, 12 Apr 2020 18:42:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id x4so7944028wmj.1;
 Sun, 12 Apr 2020 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pmelmK+74hZzKF1Ju2OEtzPp85pYogzLjVOdCh3WjgU=;
 b=L284uUWQdVDPw2IQ2bd+/tlSTLI4vyVysyhHVO3o6dBMbjorw3dxS650t6mPU/Sl9+
 Ws4husx/2DpuH+8AomDjrRuDsjdSP5xXAa8LABnXECWRdMifV7lFadX2h+zhHVSjlPj6
 n1yD9LVt7g2SON6evL3IKLQ1YfyQkCD0PrS43BBWiP+VUosrFZBeIyvn+ahjdwrIs/5Q
 oSf476BWlPve0N04a2TgHt+/j77cFI1dgyZN84fBwhaCwZF0qwEaIM3Huqt4Ba+o7dJD
 5DCq4/PDwsFQsLVL9+9maOtXFE6tPfQxyp01ggprGh0ziE6muPUQjWR0jNGETD6iZPHi
 6opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pmelmK+74hZzKF1Ju2OEtzPp85pYogzLjVOdCh3WjgU=;
 b=qaipCUWVPclV7QlfYKH/36JhS1yJnENdmxDck6+8quq0CTXCxPxxOjQuHsZD/cWNba
 u5OFq8E6ztyQ8ONVYttYKj/qlHp1hni31QsPl+6WDIGyEBc9duWS+/KQ1rLBl/3QH72Q
 UbgVWteWW8vp/ujmmrL2CMV2m0dw5V15Q5m6KTMzg/Hy64TynqfFWEJgIPhi7PjLipBs
 QEBZswSvLDugDWNEQyqchbEehm5dG/b8+M9S20mpLCAh1fSzL68ZRFogosCHApgzafeC
 IdsEO5HFw2VBB2iBzfe9Sl14n/vn5KrvVgpoDmJgAaS/YuWJ+pgXG6nBRTfE/Fl+6Hh7
 ldLw==
X-Gm-Message-State: AGi0Pub4Z2000MaUB67UB9HRR2UEVYJtaDmWtvNmbuX53+bB+yUQw/HL
 unBJb/9Au0XZX8TLN3ojMn3d12NIugjZqQ==
X-Google-Smtp-Source: APiQypIepOoCeFLOezrWB1hJWJWNl5b3nBNXtg9LWUKUMKZGRFqtf9yO0rHqlas6fvwRt/hh49Nz7A==
X-Received: by 2002:a1c:544c:: with SMTP id p12mr15866438wmi.88.1586731326418; 
 Sun, 12 Apr 2020 15:42:06 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:42:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 05/23] hw/arm/allwinner-a10: Add missing
 error-propagation code
Date: Mon, 13 Apr 2020 00:41:26 +0200
Message-Id: <20200412224144.12205-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/allwinner-a10.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index f41395734a..db70aa2b88 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -158,14 +158,22 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 
         for (i = 0; i < AW_A10_NUM_USB; i++) {
             object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized",
-                                     &error_fatal);
+                                     &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                             AW_A10_EHCI_BASE + i * 0x8000);
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                                qdev_get_gpio_in(dev, 39 + i));
 
             object_property_set_bool(OBJECT(&s->ohci[i]), true, "realized",
-                                     &error_fatal);
+                                     &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
                             AW_A10_OHCI_BASE + i * 0x8000);
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
@@ -178,7 +186,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, AW_A10_MMC0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0, qdev_get_gpio_in(dev, 32));
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
-                              "sd-bus", &error_abort);
+                              "sd-bus", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
     /* RTC */
     qdev_init_nofail(DEVICE(&s->rtc));
-- 
2.21.1


