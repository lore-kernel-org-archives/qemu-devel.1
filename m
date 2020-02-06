Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103CDC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE70A20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZesKS19e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE70A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVyF-0006Fo-0F
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoN-0000jd-6c
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoK-00033G-29
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:31 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoJ-0002xM-Rj; Wed, 05 Feb 2020 20:18:28 -0500
Received: by mail-wm1-x342.google.com with SMTP id g1so4472302wmh.4;
 Wed, 05 Feb 2020 17:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rQmOHgOI+RgkOPwFIK/xpNJ3XvDpycIgclU+wSqLCT0=;
 b=ZesKS19eWq5MK0nAAMdsUOfUNqjZHzfFpfmjMR45YQj+mMPwyHDRqfry+1LjCNZwkT
 LvGvT4FEVIMiKfHyDBUXvityBPd3/nrp1U+MaH3B7yRiNDDQOIfLZU7PgGafzZ5RfjSW
 YVlLv1IbX6dSbmwRFedrh/p4rDiAlvwaC11szo9e69DiO1+rfQi2jtSS2LEIKIxBdcc6
 cEXhNhO4b+N6p/AGUnnFp1tCAdKc+joep8M7RQub/taFfzthNxvsVnnIKHCJS88Rki53
 B/M3Pmck1ZJoPSmoKDR6xC88onL9dD4ZVOWdiV5RXeqBVDpDQYaTRBYGBQphAJmf5zpq
 OZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rQmOHgOI+RgkOPwFIK/xpNJ3XvDpycIgclU+wSqLCT0=;
 b=aujt+R2imGDdP+A///AZGbg9hEwFJtHXa85Hw4y/ywHr3B4MgY57jsSzvai0AFMrDR
 0O2hK2uNE1X2AXGZiESm0lE12uQq1lXhNqVDv3VY8kzWCYd9wWkEzlHg7soEBq1hsZYY
 WGb75cfKFsXybDRP0nKA/R4JlzN4+aI7ZYk1quSbHD3LFnL8iA2CN8zMTZ4vQkVckc6U
 iVq3SwUEmsJypzrXtCT/rwLzpE8/ndEy6kpLwqDKf638V9+/b3dSkYMJz9Ctha+Kndy1
 9VtkQJOfSbLFKqYMHoeYMAxQlK9VqBrq1RWJ8qmAHB7rQ+GUiPLu7jcerNtNSRtleB6H
 DxMg==
X-Gm-Message-State: APjAAAWcxbhfspng/WK6ul1JlQo5d//j8olOVFe+ypkJL/nySlhGX94n
 lvyicbkSs0rN5PNkCCRY/kICvjpR
X-Google-Smtp-Source: APXvYqxQFRbbfZrfALDcn5oCY5qhQDF2Q+lVoJE9RgvaU+pDWGJxF53k2Buc8ZrUKDSfBEffZWFn8g==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr630872wmi.14.1580951905661;
 Wed, 05 Feb 2020 17:18:25 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/30] hw/arm/raspi: Use a unique
 raspi_machine_class_init() method
Date: Thu,  6 Feb 2020 02:17:38 +0100
Message-Id: <20200206011756.2413-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the exception of the ignore_memory_transaction_failures
flag set for the raspi2, both machine_class_init() methods
are now identical. Merge them to keep a unique method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/raspi.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a104393cb2..8fe07db47a 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -293,7 +293,7 @@ static void raspi_machine_init(MachineState *machine)
     setup_boot(machine, version, machine->ram_size - vcram_size);
 }
 
-static void raspi2_machine_class_init(ObjectClass *oc, void *data)
+static void raspi_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
@@ -310,41 +310,22 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
     mc->default_ram_size = board_ram_size(board_rev);
-    mc->ignore_memory_transaction_failures = true;
+    if (board_version(board_rev) == 2) {
+        mc->ignore_memory_transaction_failures = true;
+    }
 };
 
-#ifdef TARGET_AARCH64
-static void raspi3_machine_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
-    uint32_t board_rev = (uint32_t)(uintptr_t)data;
-
-    rmc->board_rev = board_rev;
-    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
-    mc->init = raspi_machine_init;
-    mc->block_default_type = IF_SD;
-    mc->no_parallel = 1;
-    mc->no_floppy = 1;
-    mc->no_cdrom = 1;
-    mc->max_cpus = BCM283X_NCPUS;
-    mc->min_cpus = BCM283X_NCPUS;
-    mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = board_ram_size(board_rev);
-}
-#endif
-
 static const TypeInfo raspi_machine_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("raspi2"),
         .parent         = TYPE_RASPI_MACHINE,
-        .class_init     = raspi2_machine_class_init,
+        .class_init     = raspi_machine_class_init,
         .class_data     = (void *)0xa21041,
 #ifdef TARGET_AARCH64
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3"),
         .parent         = TYPE_RASPI_MACHINE,
-        .class_init     = raspi3_machine_class_init,
+        .class_init     = raspi_machine_class_init,
         .class_data     = (void *)0xa02082,
 #endif
     }, {
-- 
2.21.1


