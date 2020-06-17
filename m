Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9DF21531
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNUOnFOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9DF21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSeg-0004D4-B3
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSJ-0004lC-71; Wed, 17 Jun 2020 03:25:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSH-0002bQ-JE; Wed, 17 Jun 2020 03:25:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id g10so794784wmh.4;
 Wed, 17 Jun 2020 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=whMizvqXayFxbp1IF4VRvbw0c99w7Q6BaIOEKga3yHk=;
 b=tNUOnFOC0+7FZMi8/SXo/dzYWGB77bWRNEck3auxVLmP0mS0/3O4CuVLP7vb8lDwmb
 ZrFq1GNKO44sGjQ1ruzA3m7Ei7RmVWABUMUmmUadNCjbyJEhZ4laOKZEw+/HFFI5rkBa
 Mx4+7XpfBjovuae2wlDxmrAcT4UZjI0Tq3JQXUIJnYhL6kY9NvATPZKL+hVwnm1LpdDm
 OoZt37gOEs/+CGzbAmimifnMQCCTWAL+/pUheR2RJaPIJ4QyYpiU/gR3eJ3uy6fCcS/k
 dbNtf/M2Qm3PtgyCqj2TCwUstgk5+XA38SlHgXaBCuB73eb3Sb+roP58dlQvCRhE5TJT
 f69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=whMizvqXayFxbp1IF4VRvbw0c99w7Q6BaIOEKga3yHk=;
 b=ilhAnSnrVx8SWuwL0d3Svy7n6ij3ylpjVWoOxOOu5TbhaCnnwc4itaF3/6C6YEIzKt
 ghVfS7mpSXavjH4535HcOrBIDzZnxzu/bstCV+kdGzzFMp5ogWPvb3N4oHfW2dX7RMAr
 O8KhVgJPwT9L8N7Tm0LkNUTdXQwQJUliPqOI+1AqA1wEwlzbK9ItghzaJ1aNng7cGYDX
 wL/NQjX+efwuRr1OKYBC24wkZhZm9Nb33DT0FLQwissavQg9E8MPyxvg56twL/ZF8fYq
 UuU/X5sePF68qkSvIoQ4g65RJPnrcu2HMAT3sm0ktz9ym9uPdNlDk0ZHrBSOECZb3kDy
 f5Og==
X-Gm-Message-State: AOAM532H+w+fc4E3dw1yzv2YoSW2R/AtP4mvOVViQ26PFmFlevjwqINh
 CR+5M6yqBoyLg8+84vE6VdqcKfgh
X-Google-Smtp-Source: ABdhPJyrHw0a4VEyx+kmtCXkPXCFtnPRyydIR0r96RVGb6Mp4LPXmJNS3AFlj3YQYXBMaIHVPEIPmw==
X-Received: by 2002:a1c:dc44:: with SMTP id t65mr7544400wmg.128.1592378751734; 
 Wed, 17 Jun 2020 00:25:51 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/14] hw/arm/mps2: Add CMSDK AHB GPIO peripherals as
 unimplemented devices
Date: Wed, 17 Jun 2020 09:25:34 +0200
Message-Id: <20200617072539.32686-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Register the GPIO peripherals as unimplemented to better
follow their accesses, for example booting Zephyr:

  ----------------
  IN: arm_mps2_pinmux_init
  0x00001160:  f64f 0231  movw     r2, #0xf831
  0x00001164:  4b06       ldr      r3, [pc, #0x18]
  0x00001166:  2000       movs     r0, #0
  0x00001168:  619a       str      r2, [r3, #0x18]
  0x0000116a:  f24c 426f  movw     r2, #0xc46f
  0x0000116e:  f503 5380  add.w    r3, r3, #0x1000
  0x00001172:  619a       str      r2, [r3, #0x18]
  0x00001174:  f44f 529e  mov.w    r2, #0x13c0
  0x00001178:  f503 5380  add.w    r3, r3, #0x1000
  0x0000117c:  619a       str      r2, [r3, #0x18]
  0x0000117e:  4770       bx       lr
  cmsdk-ahb-gpio: unimplemented device write (size 4, value 0xf831, offset 0x18)
  cmsdk-ahb-gpio: unimplemented device write (size 4, value 0xc46f, offset 0x18)
  cmsdk-ahb-gpio: unimplemented device write (size 4, value 0x13c0, offset 0x18)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index f7bef20b40..c66c595d4a 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -113,6 +113,7 @@ static void mps2_common_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     DeviceState *armv7m, *sccdev;
+    int i;
 
     if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
         error_report("This board can only be used with CPU %s",
@@ -228,7 +229,6 @@ static void mps2_common_init(MachineState *machine)
          */
         Object *orgate;
         DeviceState *orgate_dev;
-        int i;
 
         orgate = object_new(TYPE_OR_IRQ);
         object_property_set_int(orgate, 6, "num-lines", &error_fatal);
@@ -265,7 +265,6 @@ static void mps2_common_init(MachineState *machine)
          */
         Object *orgate;
         DeviceState *orgate_dev;
-        int i;
 
         orgate = object_new(TYPE_OR_IRQ);
         object_property_set_int(orgate, 10, "num-lines", &error_fatal);
@@ -301,6 +300,11 @@ static void mps2_common_init(MachineState *machine)
     default:
         g_assert_not_reached();
     }
+    for (i = 0; i < 4; i++) {
+        static const hwaddr gpiobase[] = {0x40010000, 0x40011000,
+                                          0x40012000, 0x40013000};
+        create_unimplemented_device("cmsdk-ahb-gpio", gpiobase[i], 0x1000);
+    }
 
     /* CMSDK APB subsystem */
     cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
-- 
2.21.3


