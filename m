Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ACEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB87207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKid9/Gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB87207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlR4W-0003Pa-MT
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzm-0002oG-EG; Wed, 17 Jun 2020 01:52:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzj-0004TC-PE; Wed, 17 Jun 2020 01:52:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id x6so883448wrm.13;
 Tue, 16 Jun 2020 22:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=whMizvqXayFxbp1IF4VRvbw0c99w7Q6BaIOEKga3yHk=;
 b=MKid9/GyKouaGElE0l78IKv5okkEDiqOBt2W8D3P1UN2dUzTAVEJnTnFBf71PlswyX
 H/K4ix7Q1p1PgzwKDBM4YqKPnVWNZ5YCHUZf4mvkeFLMUqiHXAIwEENcGcv33RFAQWaf
 CAN9RNC/03PzTfoQkcee9LLr2cEKjGyEwD120WEwB/6o4/w65a8bTiOvBUQcnEveqdGb
 qHt6UuB8MyJY6kC/SE1WFkEQCTkOwU+yoSVngfsFtpce2IQNbzlXEP+fDtNJObpDuB/L
 vG+Liwm0eo0fWITTrxVVENVtOIr7USFbTiUdPXHkFCATvStX5kHWa7Ey/64rhzM1gMZf
 ZnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=whMizvqXayFxbp1IF4VRvbw0c99w7Q6BaIOEKga3yHk=;
 b=YFoechiAcY48mrO4Gji3FvwLz5F6GSv4QOURafGufQyGqUcb0XQRpZpgkoh6+dofGn
 q1vchZiNF7u2F1ZehPU8z+vSz+RfhG5Y/TH4lZp39p4s3jj4jJl7gfEjQbqW6PwTm3vR
 cJjeVqngqzan1xV1W28+67zmShf42LcksLODb6Zs81e5ncxFbi5cbpnaMFf9UqoRLM2V
 Qoj8K8hDgbLGpyN5qGvTZeKZzgBzuTIzhJzEVx9GraTY/NVJVmLpkNw7coEYzkyQgASK
 Ztir6QUVoW48Smu+K5uF5bPDoLHyxvZSbopPCc6K1tNKOVlP8bmQBc+qMqbPg5VJ4wVe
 O6jw==
X-Gm-Message-State: AOAM5320kI10kMpgk44LR4fbqv1UUaqljK9Rx+8en04fgkj1XSuoq1hT
 O6LudszSuP4wf+FityPolM1Sqy8I
X-Google-Smtp-Source: ABdhPJxmN1AwbbLb6g3ADFz6JEyrezgWerbMGjrHBhnmNvnfioemseMST1jpgQ/F1AnoAleqcz1fmw==
X-Received: by 2002:adf:e285:: with SMTP id v5mr6420929wri.129.1592373137978; 
 Tue, 16 Jun 2020 22:52:17 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id d28sm3000809wrc.50.2020.06.16.22.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 22:52:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/14] hw/arm/mps2: Add CMSDK AHB GPIO peripherals as
 unimplemented devices
Date: Wed, 17 Jun 2020 07:52:00 +0200
Message-Id: <20200617055205.3576-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617055205.3576-1-f4bug@amsat.org>
References: <20200617055205.3576-1-f4bug@amsat.org>
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


