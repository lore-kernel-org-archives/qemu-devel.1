Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43798C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F074222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOuUTcsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F074222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2U8Y-0005rc-9r
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 01:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2U6z-0003bW-HB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2U6y-0002LK-It
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:06:01 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2U6s-0002Do-Ls; Fri, 14 Feb 2020 01:05:54 -0500
Received: by mail-pg1-x542.google.com with SMTP id j15so4395726pgm.6;
 Thu, 13 Feb 2020 22:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ysOKWfZ4i4647Q8qI4abt59kZ1u1hiLhVP6Ipj7ZhwE=;
 b=KOuUTcsPQtZPqCjfPT/HikcmFuRbV1PsjIIPr1UrmZKRzuFZsdp34/7vSmjUhDJuYD
 x63h45XpfPCeZZC587wR6eexuuVilHJGpKy4kiCbh73BpLTTjqtQGFvSUbS6lw4F16V+
 0Girlcre6mgkGzx99Kh+OpYQ4VNoglC5gLn5zPechIvfF+gfwKn1QFaJiRc8CyOFYfik
 ExMYwl9y+JVMOKQHXqb/Bgy2Gyvpe8RtKffAL0kB2ADIG45GmFwrFQmMAeEb0stZjLnO
 Cp4wI6XQQRstxJlj3xRzF0GBUntVyqyWr5DcroqE9ztxiMc2sfYFm5vK7RsdCOJ794Jp
 tdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ysOKWfZ4i4647Q8qI4abt59kZ1u1hiLhVP6Ipj7ZhwE=;
 b=aOagDiXAkHSJDNjP4U5WqLXWanz6yONf4Ye0dUVXaShdQDmZZWqo6FIs5qutiIn0Sp
 NcVibL3k5qpiugaL2kGhKjXlLR1Q95SgsSONHZ5pnjW3l4SjAvXGrWRBPQxJaG/3BEgl
 otjAo79awdFLixDKu8I55C9cZSuwBVeR2XwNN9e008ljBfRkEcgvZO9gk6JB5PRAg2Cb
 6egHivN/Swh/61ELNi9CMvy9W4qeowoxV3xEBEo4n7Ybs4atxGH4iR798W7QeWcqIMFo
 VkDOPKQ4D0zgW/jXXdfWggVwIClBwbiiQdiq8GPUQPCY0l7IxatVNd/GLAovdKNWh4Pr
 8usQ==
X-Gm-Message-State: APjAAAUvohRMtoWaHjHhoOOmvOLvsJ8fJmqoSGpE/oe9gTlhknKCuXxy
 DMUqZbDSWCztyxsqaziT9Ew=
X-Google-Smtp-Source: APXvYqyLWZi+VMssuTBvnobA8mg+9IZ1gPW+KQPSKVnwS7KvTbc41Lu0zlnD1ClAqcynMit2+dW1Hg==
X-Received: by 2002:a65:6405:: with SMTP id a5mr1764070pgv.284.1581660353721; 
 Thu, 13 Feb 2020 22:05:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id l21sm5294565pgo.33.2020.02.13.22.05.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Feb 2020 22:05:53 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] hw/usb/hcd-ehci-sysbus: Remove obsolete xlnx,
 ps7-usb class
Date: Thu, 13 Feb 2020 22:05:48 -0800
Message-Id: <20200214060548.24939-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214060548.24939-1-linux@roeck-us.net>
References: <20200214060548.24939-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xilinx USB devices are now instantiated through TYPE_CHIPIDEA,
and xlnx support in the EHCI code is no longer needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/usb/hcd-ehci-sysbus.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 62612c9f5b..b5a014f968 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -114,22 +114,6 @@ static const TypeInfo ehci_platform_type_info = {
     .class_init    = ehci_platform_class_init,
 };
 
-static void ehci_xlnx_class_init(ObjectClass *oc, void *data)
-{
-    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
-    DeviceClass *dc = DEVICE_CLASS(oc);
-
-    set_bit(DEVICE_CATEGORY_USB, dc->categories);
-    sec->capsbase = 0x100;
-    sec->opregbase = 0x140;
-}
-
-static const TypeInfo ehci_xlnx_type_info = {
-    .name          = "xlnx,ps7-usb",
-    .parent        = TYPE_SYS_BUS_EHCI,
-    .class_init    = ehci_xlnx_class_init,
-};
-
 static void ehci_exynos4210_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -266,7 +250,6 @@ static void ehci_sysbus_register_types(void)
 {
     type_register_static(&ehci_type_info);
     type_register_static(&ehci_platform_type_info);
-    type_register_static(&ehci_xlnx_type_info);
     type_register_static(&ehci_exynos4210_type_info);
     type_register_static(&ehci_tegra2_type_info);
     type_register_static(&ehci_ppc4xx_type_info);
-- 
2.17.1


