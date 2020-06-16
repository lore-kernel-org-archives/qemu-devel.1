Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F35C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D7D206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfM1zO0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D7D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5AV-0001FC-3p
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58h-0007ye-LB; Tue, 16 Jun 2020 02:32:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58f-0003Lu-Tm; Tue, 16 Jun 2020 02:32:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id x14so19470695wrp.2;
 Mon, 15 Jun 2020 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cOk8KAmRqbditcK3tUyn2RQFRwEFLc0t20rHeY/wkGk=;
 b=FfM1zO0D84sphPl8TX3M4U3jzZNT3EBhVaG810iD2iWv3LxtvkqKp9kB866cUqYucK
 ow7Bps+LGDYz6NCzbCVZBh7cRwAf2Pcn1FqU/tpg+Hoxr6YRCzu2xpSGozG8M49d3+GY
 RYEa8g59UHCUkih8KP47NfSMEpFwR4f5YQNgNDmgay20xqo2efZ59eTREGPGMZDJoiwh
 a7cT9u9jlgIc1NPixKmsJE0+wFqznKhJyNOFo33U9aG6UqbBQ3PzSydO9cEAteowPC0N
 u5ueFcqEUK91ofkGKCBO813BeMN4sZUhve26FO0ObIzd98TeuqQNJ+zn85sLIO+GMJ6h
 re8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cOk8KAmRqbditcK3tUyn2RQFRwEFLc0t20rHeY/wkGk=;
 b=nTLaIN+cgt8uQUizHZxzxf5NzVQ0q5yG9kvVOIdj9Zcro4IjBNm1ZYBW5BYET6LDyW
 34u7803stVPLYIyczDgWzYcAmC9yRdyMS9bCFbPF2F9GPNrfQd6XkNopjXVNXlag6UIH
 ohCtIPySPVIwbkzc7Wc3HA1cO1NXDMhTz/V9fbRa+wnYBEyp/IYpxjnqaL/1kqlBNSFz
 AmGR23vBgzgLHVtviIWDzpu2J4CJvIlw0HxfREuG/a45UTvAkl0SU70TU4Ty1VAAzKqg
 j3Tw2mJwMSY2Ckt9ABLFPZiTsNDbEW3JFSuU1/eihfp+2IkrIANWl4Rd0wbAOY/tEAPI
 IYzw==
X-Gm-Message-State: AOAM530BFPLHhcce4eE/ZizzR0hUVVY3UAXJ99eBTry7vJ8YlOX6QkFm
 jb1MzgTsD0nOTS8PMI3RN5znej7n
X-Google-Smtp-Source: ABdhPJwg2B8YQ+0WR7EXbmnTpSl73e2pMw/Uiv2fkojq6WF5Qzgy8X7Y08Sj9ax5773/MTG8PR8C8g==
X-Received: by 2002:adf:ecce:: with SMTP id s14mr1352042wro.154.1592289124048; 
 Mon, 15 Jun 2020 23:32:04 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t188sm2483250wmt.27.2020.06.15.23.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:32:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/arm/mps2: Add CMSDK AHB GPIO peripherals as
 unimplemented devices
Date: Tue, 16 Jun 2020 08:31:54 +0200
Message-Id: <20200616063157.16389-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616063157.16389-1-f4bug@amsat.org>
References: <20200616063157.16389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 570ec50aa8..4a49bfa9b9 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -111,6 +111,7 @@ static void mps2_common_init(MachineState *machine)
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
@@ -315,6 +314,12 @@ static void mps2_common_init(MachineState *machine)
                        qdev_get_gpio_in(armv7m, 10));
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
     create_unimplemented_device("cmsdk-apb-watchdog", 0x40008000, 0x1000);
+    for (i = 0; i < 4; i++) {
+        static const hwaddr gpiobase[] = {0x40010000, 0x40011000,
+                                          0x40012000, 0x40013000};
+
+        create_unimplemented_device("cmsdk-ahb-gpio", gpiobase[i], 0x1000);
+    }
 
     sysbus_init_child_obj(OBJECT(mms), "scc", &mms->scc,
                           sizeof(mms->scc), TYPE_MPS2_SCC);
-- 
2.21.3


