Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0382120771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnDF13pV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0382120771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhSv-0007JX-5M
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHJ-0003Z6-IF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHH-0003Pn-76
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id y20so2860209wmi.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vtipZwHLE7FZd0SmRZa3h9Pvrs5XAJQH6LUFGM7RN2g=;
 b=gnDF13pVM9olTGEY7FFJxtl1/R1yG9p7FIWHaYBcppvjyFEK7ectebjyoSvAm0agvQ
 Utd4xLcyhp4SOMI/h5KbO62NujccSQ1fzDZacWNCCb9g3bRI3soYig8ZBphi9TPKleEt
 dgHwDMSTSLbxYeTGrn2KmcwNtrgWScZInRdnWVatsogElyCHdxKhQC3qSGT+qJ8qQvfO
 fTiEtlfOajCw5YvulxevcynCvlNpAz3UqHrnjnbE5tNQnOq8mUXeiTZTh5qqksMxvO6j
 L747oOPp5uo0eyFSFMRjJvYDI8x0MZDJbS0OWDbIlMbrBbt1/Y4VKmiyImt2lAEjUyIP
 XwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vtipZwHLE7FZd0SmRZa3h9Pvrs5XAJQH6LUFGM7RN2g=;
 b=DnV0GZrIlBIsgo4Ens3CkC5Y7W9pfzFVJKuONwUZc3uj1Idxzix2+wCNgNexA8KxrD
 opV+TZDINVd6EfPob0iWRDPigPGYhm5r8zUxu2hFZUkp4qt2Yl6Sjg4742Fq522H+S23
 0+XpW3P/SUk3HWyEF0IzrgMiLbBfDIWvSeC3+bqBK/2Z0MLTZH+HwcwYHHthJ3CNmFMI
 1IPZKfCShFdvtT9v0nrOE+52e/BTXGpbLJ5t6hrBRZj0Pi0cakCkf4hvKV2y6nw4dHm6
 CnEIjBtRJ0yvSLgWwn1xXERb5E2dOwh5KWB84KN/7M+Rs1Z4hOlfUqJnJwaHPEveH/c0
 VBxw==
X-Gm-Message-State: AOAM533i3UP+3y6GFsW0eOzj1UdJg08pwD19s+li2iY/eHpw+hJkNZNP
 0DoHUQmJ/+m+5HyY+YLd6uT0+pW9UZzKLw==
X-Google-Smtp-Source: ABdhPJz/HDX8mu9eMm5hG2RttNJH1qBQOYEHGkTn27Uv5sD2bNpTOhhh51mA1gxwd+U0QRGN0rGaQQ==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr69213wmg.56.1592912385595;
 Tue, 23 Jun 2020 04:39:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/42] hw/arm/mps2: Add CMSDK AHB GPIO peripherals as
 unimplemented devices
Date: Tue, 23 Jun 2020 12:38:56 +0100
Message-Id: <20200623113904.28805-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Message-id: 20200617072539.32686-10-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index f7bef20b405..c66c595d4a0 100644
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
2.20.1


