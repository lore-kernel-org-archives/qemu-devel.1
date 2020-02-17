Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269B2C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BD52072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/tyBbT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BD52072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3n9i-000067-20
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 15:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j3n9A-00088T-0L
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j3n98-0001WC-Rl
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:37:39 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1j3n98-0001Vb-Mg
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:37:38 -0500
Received: by mail-pf1-x441.google.com with SMTP id i6so9521003pfc.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 12:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=tBTTL++bZSE29e8jbSUcoTss7W/9u1GRNub7QQxS2ko=;
 b=l/tyBbT+wP7xyYejcxEmfwNfBzhJQ1DALJ8YD20m+5cpAP0rWDili+9SM4uU+FztCP
 O3ap4NyKQgfWtbuGYrwOvREAuxiG0NH1z+mf1CZ00GysmW1Q7cH6E+JXFm2LlFVnBelN
 2wjregoWXmESW36Brg4aGrF3MGbIT8zybfdJ+jw9Slhd+C6B2UN2OhI7DcGi8JQ/yhi7
 8c88e0PVsxFJYrxdsSwCxM+CveVAEMGo+Y+cjj6S4fWh0hdpHjldXNaVXat00hrAWnAu
 5jarEvZOuSWrzn/j2EsQnwg/8GGmDdUHtH5Q9CDOkPys+1B+726024wlowg/KsoiuMc+
 UfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=tBTTL++bZSE29e8jbSUcoTss7W/9u1GRNub7QQxS2ko=;
 b=Lp9TN/tSs3sGRPGFxyW17sq8LyP/8k5HHm+O40IPEPww3tYQnD3+cnckgFHSciz0Zt
 e5aLFBbbrGlPTxhSungOY3Y50aJXXhvOXCxZk05eHOCS2xchjZdNFfUbrJtRD4JK7Ajd
 ywzzoiDmDQgU9g9xTU3HLLmL/Mx/GYvhAlRh2IKQYGlkGqqg+CEwbamWzupXF4XSbb5x
 ZZFaPsEhvvR4ARllxCudNGv93+RKX//vt++Jje7vsA8gc+7xqqBGn/j9TfxA7KS9HxR3
 XxiRFpbWaYEngYnsoDra/dexZbPnXbIi5A2s0ok1jCP1RQIhRWdZrJml04HGnjjJf2PV
 7pvw==
X-Gm-Message-State: APjAAAWrVXWWWJFg1gnE1eSUq0bWW/B/+rUK+1ur6Tn8wdTK3LEwxUgX
 GJTa9rPNkj8QMSruXsVz/Ik=
X-Google-Smtp-Source: APXvYqy3GYCJ63+oMZDHC+PixdVoGTUPMbt0Z1VlO2s8Q1oIQQAn289oL1RlUNzpWWDFBR+X6ulabA==
X-Received: by 2002:a62:5547:: with SMTP id j68mr18706279pfb.6.1581971857332; 
 Mon, 17 Feb 2020 12:37:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id q13sm1347954pfn.162.2020.02.17.12.37.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Feb 2020 12:37:36 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] sh4: Remove bad memory alias 'sh_pci.isa'
Date: Mon, 17 Feb 2020 12:37:34 -0800
Message-Id: <20200217203734.18703-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory alias sh_pci.isa is located at address 0x0000 with
a length of 0x40000. This results in the following memory tree.

FlatView #1
 AS "memory", root: system
 AS "cpu-memory-0", root: system
 AS "sh_pci_host", root: bus master container
 Root memory region: system
  0000000000000000-000000000000ffff (prio 0, i/o): io
  0000000000010000-0000000000ffffff (prio 0, i/o): r2d.flash @0000000000010000

The alias overlaps with flash memory. As result, flash memory can
not be accessed. Removing the alias fixes the problem. With this patch,
the memory tree is as follows, and flash is detected as expected.

FlatView #1
 AS "memory", root: system
 AS "cpu-memory-0", root: system
 AS "sh_pci_host", root: bus master container
 Root memory region: system
  0000000000000000-0000000000ffffff (prio 0, i/o): r2d.flash

After this patch has been applied, access to PCI, ATA, and USB is still
working, and no negative impact has ben observed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/sh4/sh_pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 71afd23b67..4ced54f1a5 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -143,8 +143,6 @@ static void sh_pci_device_realize(DeviceState *dev, Error **errp)
                           "sh_pci", 0x224);
     memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",
                              &s->memconfig_p4, 0, 0x224);
-    memory_region_init_alias(&s->isa, OBJECT(s), "sh_pci.isa",
-                             get_system_io(), 0, 0x40000);
     sysbus_init_mmio(sbd, &s->memconfig_p4);
     sysbus_init_mmio(sbd, &s->memconfig_a7);
     s->iobr = 0xfe240000;
-- 
2.17.1


