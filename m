Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D68FC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 12:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDA02073A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOB6XfrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDA02073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2wWI-0007HE-0x
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 07:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2wUO-0004Hw-On
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 07:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2wUN-00010V-Nm
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 07:24:04 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2wUL-0000ya-H0; Sat, 15 Feb 2020 07:24:01 -0500
Received: by mail-pj1-x1041.google.com with SMTP id n96so5190983pjc.3;
 Sat, 15 Feb 2020 04:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=O0cfihfBXPUJpUAb56LetctuINQwtDaqA2jqE4YkZoQ=;
 b=fOB6XfrSnBCUB6djAPxhSxQ3U6thsntuTizr2sZ19MTV8huKjWvH/mgWXpiCIB5YFf
 4Ir6OLCwPAarwyKUQ75c17tI/17NwJERc7EDigN0AgrRfSE6PsuhlQ1kto0T58BfUXgB
 ENxznPRGk7JzKzrpTu6v7baSSMD67b6sxXZvykBnxIzdFjf0lI+cP/qtnZ8gsZQ9bMa/
 6PIlJ23tUyQqTlIYP+Gmjv0xQ09bBOM/RbZltUpQB6Olh4Yy90YfTDHBrEKTCgJvMRnj
 ZMShMPMmM4gHIwSed5qdQxXFuDlWk+R38jJRFtWVA6vXtvTCWdjyTEW0xeHxpblFB1oR
 h5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=O0cfihfBXPUJpUAb56LetctuINQwtDaqA2jqE4YkZoQ=;
 b=njHKGRmDwwg/GPfFjOLSgaAg1lIeirfw9WhHSORnMYebNFHTtpNDpgf8DdqiEZQwhN
 Njoa1k8adu/neZthW1IXT2siORREAyWwSeG5qd9DYiKRPaWTOfXREb5hZhi915f06EGy
 1WNyN2M1JlcPbGzRqse0QPfMsQkNlmMvsfs+mYTb0xJ8tpevnz/t1X9qiH/kuQKW/COM
 9HjQ2qNVr/qUipZhKOVkfsp+tlhjmVM2dMR9zxousQgOVXFsOLEB7HP5QQjYAU9QH88f
 wLNLoP8HWf2ZIk+qmx6sEzjVXsinObKehT7bhQW06nt5I9GFaSkmljI4NFb0KNIWFSB5
 TtzQ==
X-Gm-Message-State: APjAAAVk4ZYqyoRcGLsUEE8mfGvfuwvmKPcwShSFffhhhJVH91h7jH0n
 GdlFyOLvfvJF12bvOvmCyG8=
X-Google-Smtp-Source: APXvYqyq/+niIlI7LSvO2QdIzZc0nS9SQqtp1dZS/RNgwoPUDdHYlcG6nG1H78jHXgadejclVidilQ==
X-Received: by 2002:a17:902:8a8e:: with SMTP id
 p14mr7883798plo.28.1581769440482; 
 Sat, 15 Feb 2020 04:24:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id l26sm10975710pgn.46.2020.02.15.04.23.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 15 Feb 2020 04:24:00 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/2] hw/usb/hcd-ehci-sysbus: Remove obsolete xlnx,
 ps7-usb class
Date: Sat, 15 Feb 2020 04:23:54 -0800
Message-Id: <20200215122354.13706-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200215122354.13706-1-linux@roeck-us.net>
References: <20200215122354.13706-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
v2: No change

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


