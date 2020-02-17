Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB94BC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 21:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847F220725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 21:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfXdRVPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847F220725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ndj-0003cx-NZ
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 16:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j3nd2-0002FC-13
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 16:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j3nd1-00088i-3V
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 16:08:31 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j3ncy-00087J-Nx; Mon, 17 Feb 2020 16:08:28 -0500
Received: by mail-pf1-x442.google.com with SMTP id i6so9552213pfc.1;
 Mon, 17 Feb 2020 13:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=4W8ac1dYsXHMdhBg8YUpwrP/cAv1a4OAvhptQKJ56As=;
 b=BfXdRVPRawhRZquebRHNooYXxntVh8rTF5sB17PRyYahYualveqfXII9RDCBqcxdha
 OfyqxZcCzYDQg/uL/5csxoIfDq7m0KX7L4Q8SHNScqHlWJQFd1mkNpyio0t8Ks1Y665v
 KJbVlnwzl24+VPTp2QSSdJp84YdDiFzbSHiWPApgNUZtz0KM+F1b+QQjCJlK8UbtJYL8
 8s/E9xLMRjLZ0x53Fh2D/0pC7hJF7+I/hFGojFipSkQVIiwxM6O55VLqErzQ55Rkt0TD
 ZFa/HK8NJE+KOAqNXtlJgVYJJErDjftASR7z2/BEoOniNeCV76FVglrDNDkrwtGjiYT7
 pORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=4W8ac1dYsXHMdhBg8YUpwrP/cAv1a4OAvhptQKJ56As=;
 b=sV+yFJTQMCkmuKnoMpQ0uSl0xYRYMi2sJqouGNOzQp0bT8UHxbs3xQoRajLU/kP/TI
 +3yKeFxt4x96Kd2/uvfLQ+SyCNHgVSHU0ne3ygaa6P4SPet1Ke8mR34I0p9IE0SHh0Du
 pAlsWw1ZidDHHEgL0olAHwmgiInhv9kWGcjVrb9QDAD15qGUj2iAVbDz/F8vqBshwsBs
 DcbeXWNoTnoI6PeuetdsyWW0xVbnSpF1vRE8sC0e2gXwl11A899x8yv52A+PrI1yLwjw
 79e86dym81v9zuf0UI0EbkzzfR4DrE+Dcc0zv1Vrbo1g013o4jw0TAyvE97FaTqnrR4C
 iLoA==
X-Gm-Message-State: APjAAAXrvc/oN+N4xWeF9dOWtY88SIocdxrEilAj8LDWZNKvnEZ1o3GW
 z7kV2VUY0mTKp3DabMQrVuc=
X-Google-Smtp-Source: APXvYqxJ8kz78ZWc1Oc+foG66spTEE673+BrZZ3DJfTOtMY/vLSE2MQ+9I/nLEg/VdqGFedV2/zoxA==
X-Received: by 2002:aa7:84cd:: with SMTP id x13mr18955649pfn.130.1581973707334; 
 Mon, 17 Feb 2020 13:08:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id q187sm1292509pfq.185.2020.02.17.13.08.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Feb 2020 13:08:26 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] mainstone: Make providing flash images non-mandatory
Date: Mon, 17 Feb 2020 13:08:24 -0800
Message-Id: <20200217210824.18513-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Up to now, the mainstone machine only boots if two flash images are
provided. This is not really necessary; the machine can boot from initrd
or from SD without it. At the same time, having to provide dummy flash
images is a nuisance and does not add any real value. Make it optional.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/mainstone.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index b01ce3ce08..6e64dfab50 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -138,19 +138,10 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
     /* There are two 32MiB flash devices on the board */
     for (i = 0; i < 2; i ++) {
         dinfo = drive_get(IF_PFLASH, 0, i);
-        if (!dinfo) {
-            if (qtest_enabled()) {
-                break;
-            }
-            error_report("Two flash images must be given with the "
-                         "'pflash' parameter");
-            exit(1);
-        }
-
         if (!pflash_cfi01_register(mainstone_flash_base[i],
                                    i ? "mainstone.flash1" : "mainstone.flash0",
                                    MAINSTONE_FLASH,
-                                   blk_by_legacy_dinfo(dinfo),
+                                   dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                    sector_len, 4, 0, 0, 0, 0, be)) {
             error_report("Error registering flash memory");
             exit(1);
-- 
2.17.1


