Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADD3C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14212067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUwFEXbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14212067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipLQE-0001mZ-2k
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 19:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKO-0003RU-DE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKN-0007W8-9w
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:32 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKN-0007UT-2a
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:31 -0500
Received: by mail-wm1-x344.google.com with SMTP id m24so890995wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 16:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F4P/S+s15FJjyYtT27INL9ujLUrPm0+0HaDqwxBvR58=;
 b=sUwFEXbC1sqXuDZ8wWAiSerV80/6vJJJ1TApYYeE588P3i/QggUgEK+BaG9M0AcYnT
 zSylRTWPIJoPTkydnyOqyjR5E1lKZJX3phNy+l62qBB9j+6ZUAzCoKim8VwPWecMrVY8
 pl0PBuXj1VSmTBrmSR5xxIuhl5E2DORiyn8TPjQ1QZRKMv/uFacCKLlw3YergzWP2FD6
 8GymagH3IP4pV744NZX5uTD2XupZ0hSQUlsYXcVVvhISwOQk09tPUmvNQunJH/DZ8JGx
 VfEWUZmUl92D5xHp85ntVu8QQMVFn3iDxYHM14baH07kcOtET06wWrfgiqs1KfENiYH6
 nB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=F4P/S+s15FJjyYtT27INL9ujLUrPm0+0HaDqwxBvR58=;
 b=fo0rXZCEAc9DjpaEq8vyc0Nd3A9kCH/iFqUHIlh47UwYC1HxAMiqjBekEDr80wZPvb
 T42hdqmb/lk7DmjPL0AAZi+IgmYsb0RFGCPkzFGIgqSbsyXTKGRAd5EpF/kQeR8koHVo
 yAFIoAz2R2b+BbebABQMTrTHBulH71Wa5gwFbcfrymUTLnXPq0qYAjc85A17m4B8p9KJ
 I9t75lXAYBFx0c68YPVDSmFTeg8z6YjQrswhI2VWvAKcWUHm1MUAvvRrehRdK7UmwH83
 Km/IxXsVs6PyCu6Md3bn7KWy+VrPR9bFo0DUYxXwC+XUxPTSlsLuufLR3Ck2pTwuSSYE
 vWqg==
X-Gm-Message-State: APjAAAUwOh3KenvCRx4U+57iF1/o6FcIVRGzzEPu+tr0XiakKdlGryxA
 ekvfs+V18AzXjkveJz4naLE=
X-Google-Smtp-Source: APXvYqyZwiXwKc5Ny0ewnNaB3LCfjWCVcGmgVeYEUrExRjK1DyWsRyHYwvel8lbU8Pki6Z0g2jCSBg==
X-Received: by 2002:a05:600c:20f:: with SMTP id
 15mr1257826wmi.128.1578528330235; 
 Wed, 08 Jan 2020 16:05:30 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w13sm5947827wru.38.2020.01.08.16.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 16:05:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] hw/hppa/machine: Restrict the total memory size to 3GB
Date: Thu,  9 Jan 2020 01:05:24 +0100
Message-Id: <20200109000525.24744-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109000525.24744-1-f4bug@amsat.org>
References: <20200109000525.24744-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The hardware expects DIMM slots of 1 or 2 GB, allowing up to
4 GB of memory. We want to accept the same amount of memory the
hardware can deal with. DIMMs of 768MB are not available.

However we have to deal with a firmware limitation: currently
SeaBIOS only supports 32-bit, and expects the RAM size in a
32-bit register. When using a 4GB configuration, the 32-bit
register get truncated and we report a size of 0MB to SeaBIOS,
which ends halting the machine:

  $ qemu-system-hppa -m 4g -serial stdio

  SeaBIOS: Machine configured with too little memory (0 MB), minimum is 16 MB.

  SeaBIOS wants SYSTEM HALT.

The easiest way is to restrict the machine to 3GB of memory.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/machine.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 6775d879f8..119ae4d3c8 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -90,12 +90,11 @@ static void machine_hppa_init(MachineState *machine)
         g_free(name);
     }
 
-    /* Limit main memory. */
-    if (ram_size > FIRMWARE_START) {
-        machine->ram_size = ram_size = FIRMWARE_START;
-    }
-
     /* Main memory region. */
+    if (machine->ram_size > 3 * GiB) {
+        error_report("RAM size is currently restricted to 3GB");
+        exit(EXIT_FAILURE);
+    }
     ram_region = g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
-- 
2.21.1


