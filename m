Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C16C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770F22078D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB9ikbhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770F22078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK3gR-0006wt-Jr
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 14:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3bd-0001tb-Of; Sun, 20 Sep 2020 13:58:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3bc-00030I-5W; Sun, 20 Sep 2020 13:58:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so10431944wrp.8;
 Sun, 20 Sep 2020 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=exASe8riCxZfialHMwQ4chenzKGKS91MOy7C7us9oAE=;
 b=aB9ikbhA1WxIY00RVeYkATZZwVwF9rr9FdbyV+XjSVrBSII4FeZQMvyiR71cSphkTN
 4XTo1rQ9aWcQMkKOLpbfWtkaGk4097Y0Kaq8nCPZ1VYVyGX3zgzUjlZtfZhBZZZ/PGpQ
 6swYwb9453TbiwzYvfRHh0ZTszsM/J7m9TXuryI3apcRAsSHuZvMrd9kCzVbMXC953wZ
 L/WslWDk2Gk7KB7s8Yo3SE7l8z+UwaP+Dkg1KBDNv+Xhfu2OZGujqLfqhQAfVk0l98ct
 GsZ8XGyaTOcpetncJGKpxAnqV0drPkSej3ksFUHoPx0Cc7xaWepK2tOHNPEt0gdq42AD
 HDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=exASe8riCxZfialHMwQ4chenzKGKS91MOy7C7us9oAE=;
 b=iJziOsc4KD9k3ZJvw+XFovNeSDF1OTdChMwO+5uQxJY5VKdNzej6ybTEOP/VfS3ejf
 voKzERXQn5gRcZTPvRpUAN0ldvkvr8x4ZSkEGDhoY+nOPgFrFJrs6FWhJtOjUSgABXRM
 8sP3C1/3sIi4K0l2kPatiH25TJHLxN0gzhaNzlijdtvQV3Rowwz7rQ1v/yneVCVqDZUs
 oI2mhDj+EFlPlaIYZat9MjnkgRSzZkzCap93fm7hMFvUQQP5lgXqxO4iCoy2q34ngvTL
 SbF+pdxMJ5F6PeKItCd3NLwHGsCa+u1JUd7eaPRwx2+/yqAifXMco0XMjfuJ0Bc5W7Hp
 WPoA==
X-Gm-Message-State: AOAM5334MS7JxBEAhHj5PvZJLv66hOJFsu1GrZpnbOtiaOMqApyvg4BA
 RRsdxMlbIwK5f01HyRRj2mhZEJoE8ys=
X-Google-Smtp-Source: ABdhPJy9tRbHrwObNDOH1LtPq7s+jobQcrpZ1objkviac8YBiukYpRQ0FDZZ9TO21sdJMAvEYFPqVQ==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr46406039wrm.97.1600624710298; 
 Sun, 20 Sep 2020 10:58:30 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm15675781wme.12.2020.09.20.10.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 10:58:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] hw/arm/bcm2835: Add more unimplemented peripherals
Date: Sun, 20 Sep 2020 19:58:20 +0200
Message-Id: <20200920175825.417680-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200920175825.417680-1-f4bug@amsat.org>
References: <20200920175825.417680-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bcm2835-v3d is used since Linux 4.7, see commit
49ac67e0c39c ("ARM: bcm2835: Add VC4 to the device tree"),
and the bcm2835-txp since Linux 4.19, see commit
b7dd29b401f5 ("ARM: dts: bcm283x: Add Transposer block").

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2835_peripherals.h | 2 ++
 hw/arm/bcm2835_peripherals.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index b4d3ae121ac..8af8e78f67a 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -47,6 +47,7 @@ struct BCM2835PeripheralState {
 
     BCM2835SystemTimerState systmr;
     BCM2835MphiState mphi;
+    UnimplementedDeviceState tpx;
     UnimplementedDeviceState armtmr;
     UnimplementedDeviceState cprman;
     UnimplementedDeviceState a2w;
@@ -68,6 +69,7 @@ struct BCM2835PeripheralState {
     UnimplementedDeviceState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
+    UnimplementedDeviceState v3d;
     UnimplementedDeviceState bscsl;
     UnimplementedDeviceState smi;
     DWC2State dwc2;
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index a9d7f53f6e9..4e6c678aa99 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -343,6 +343,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_USB));
 
+    create_unimp(s, &s->tpx, "bcm2835-tpx", TPX_OFFSET, 0x1000);
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
     create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
     create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
@@ -356,6 +357,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
+    create_unimp(s, &s->v3d, "bcm2835-v3d", V3D_OFFSET, 0x1000);
     create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
 }
 
-- 
2.26.2


