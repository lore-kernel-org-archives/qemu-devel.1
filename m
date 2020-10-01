Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7717AC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F18320780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOBdWnud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F18320780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO03f-0004Gp-3d
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsZ-00052Z-L7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsX-0002yQ-Mz
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so6109220wrp.8
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LdsF1p8GE52TqGxdvPUfjvasVxUb/DF5uSL01W4m9MM=;
 b=FOBdWnudi47dMkUnjuejoP0+G6qqcjBeRrTioihauwB+Q0PQSBeiZW24X19kxEx9tr
 8tOnfliLpwkkAV5e3C3UNgvHS3gIwIDegNC1yLOMpQ6pK1w7ky1yzttmHB9mhHda+F/q
 aVCWU8i36Z0CjbSM7pTCxtkpP1zYxH4OiIHMTo3S3o1j/JbOycc2IsbP+ICzXPsTKSsd
 bw8Qymti4439LMB43l7EuvTbDLCtmbFfZXPfVUMbMSMAOsvtnb+Sn9LL9Hjj4F2MZnYf
 eB1jRRdBmQgMWtsqvkLVEU2TSgTj1THOWIzJNaT8CP7E7l03RfP23+xWd7OGzqF9q/wK
 A3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LdsF1p8GE52TqGxdvPUfjvasVxUb/DF5uSL01W4m9MM=;
 b=IHUgn28hcJuU6mzfo570nRWuAM7GE8ty3SsGwnRv3yIgILx5PyJ2lykTdhjY6kJDiF
 Zn7eGElvAE93/5THbOoxhnkkCye9HSiU3wCiyWO6AB2rreHjcYtoi/HeeDY7l6fbNAFc
 Flpfwkt3WOA4LGasNFQe4jhrGWhl/o+By8LxjFxKlyP8UiZTfwNJAcEbjygtymBhnC5u
 w7cvIMQGX/MxmX7pz/WGKa+JXOGgnrS4QjMFmsnhrushdIHL84U9jQ31gGMuqV7jH1GP
 sUBK/1GmTlFTnorym7t1ygkiSyv9d/mhuWp91+WbIfRn6hzEbBne6YOAbbugorq/WXni
 WoYQ==
X-Gm-Message-State: AOAM5332E/ts6KXjuTAzZIFzNsNi0WgC9gAN9EwcvYNhBEkFFWLAkff7
 iorr0+0fzG31a60zB1pndVAQDNIw17bEEaE2
X-Google-Smtp-Source: ABdhPJx0/az8hgbL8CnoO3ZZ36ui7Q/UWseEl3vSiegkhnPXrlAmVhgd5qBRqOtzynVXenD9m0LG/g==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr8833337wrm.291.1601563696072; 
 Thu, 01 Oct 2020 07:48:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/18] hw/arm/bcm2835: Add more unimplemented peripherals
Date: Thu,  1 Oct 2020 15:47:50 +0100
Message-Id: <20201001144759.5964-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The bcm2835-v3d is used since Linux 4.7, see commit
49ac67e0c39c ("ARM: bcm2835: Add VC4 to the device tree"),
and the bcm2835-txp since Linux 4.19, see commit
b7dd29b401f5 ("ARM: dts: bcm283x: Add Transposer block").

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200921034729.432931-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h | 2 ++
 hw/arm/bcm2835_peripherals.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 13d7c4c5531..c9ac941a82c 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -45,6 +45,7 @@ struct BCM2835PeripheralState {
 
     BCM2835SystemTimerState systmr;
     BCM2835MphiState mphi;
+    UnimplementedDeviceState txp;
     UnimplementedDeviceState armtmr;
     UnimplementedDeviceState cprman;
     UnimplementedDeviceState a2w;
@@ -66,6 +67,7 @@ struct BCM2835PeripheralState {
     UnimplementedDeviceState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
+    UnimplementedDeviceState v3d;
     UnimplementedDeviceState bscsl;
     UnimplementedDeviceState smi;
     DWC2State dwc2;
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index a9d7f53f6e9..15c5c72e465 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -343,6 +343,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_USB));
 
+    create_unimp(s, &s->txp, "bcm2835-txp", TXP_OFFSET, 0x1000);
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
2.20.1


