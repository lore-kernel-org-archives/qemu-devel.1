Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E00E20707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2hlKuow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E00E20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCXE-00024L-6b
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTp-0005JT-5H
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTn-0002ri-QV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:45 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTn-0002qv-It
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:43 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so4712099wrl.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZWmtOIpfdmdXcrfzwoUW/vZybX7QtXbShko2WRx4PHw=;
 b=W2hlKuow0Pq4OuC0L4KTU6TjLvhiL+u7gym9QNc7UA/Jbj0oduCZ/2a+yklMW23rD8
 MRdzCPqNbNZ5fJsXq3Z6Ms5S+Xvv8wA+a/gs8FbbyL/iD1/tEkqi4Czb7TM/N5l9tfY/
 FxCtB6FgDLNpZcIKC0ymfN5dvygy0aXSxC9oIT6mT5CbrZ6/qNRGev2X9boSGYyb0/NH
 GMsjTvpvNhEU5hRCVqbVSCkQ9QHNDYSXDP71jD68f4ohaZprMeiK9o+uEz2E7jqgEGfC
 9s9fY1CvfbkHEFEOmgYfWO1YzK7aB5qO7Qv9ZTD5T+J1K61NqEkdIlgOepTnbXQOwr4H
 kqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZWmtOIpfdmdXcrfzwoUW/vZybX7QtXbShko2WRx4PHw=;
 b=A325niZFF6lAk5p0eiYdHK3WjSHaxrSg37saWRbfqFYbvVLC+B4Ewt6CArnSKVPPu6
 Q+bWrZLxa4gHj38tasxpV7kmgagrR9PDzfr6Fi8fsIoeUriUCMOsp+L9h/h8FeuTXL1+
 bPymNZ6Tvx8E3Lk/KFDmormcghgqaXrrSOAQdoZtlAzwvRFtBpSulZM8xWymJWQ0oRzj
 rb+PuiwprbyOnWoaScVxZii+48CCmkMSKs6hM3Ww29PxA6JzYGdBLk0wq9l49tr3d6Ul
 Nkt0PwNRvIFRZqx9a+75eB5iKr0VK54D5AgVwEFHY8OZEq01+GDug/dfPcNawINUwgr5
 W3tQ==
X-Gm-Message-State: APjAAAV661Om31d/wn5MAqw6AvRT2xulu4b4G4s5OpX/Q6Y0e7BMwK1m
 nHbYPZkLpNWZfRRvav8F0wUvQ6WOX5IoBw==
X-Google-Smtp-Source: APXvYqzsvymuBcAjsYEheDILVRzyQZ+0kJPpa5CaQo38t1GmvITPG7IQ5BXg74HlbXGsulZz5P9nbQ==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr6274055wrs.303.1580400942292; 
 Thu, 30 Jan 2020 08:15:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/26] hw/arm/aspeed: add a 'execute-in-place' property to boot
 directly from CE0
Date: Thu, 30 Jan 2020 16:15:13 +0000
Message-Id: <20200130161533.8180-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Cédric Le Goater <clg@kaod.org>

The overhead for the OpenBMC firmware images using the a custom U-Boot
is around 2 seconds, which is fine, but with a U-Boot from mainline,
it takes an extra 50 seconds or so to reach Linux. A quick survey on
the number of reads performed on the flash memory region gives the
following figures :

  OpenBMC U-Boot      922478 (~ 3.5 MBytes)
  Mainline U-Boot   20569977 (~ 80  MBytes)

QEMU must be trashing the TCG TBs and reloading text very often. Some
addresses are read more than 250.000 times. Until we find a solution
to improve boot time, execution from MMIO is not activated by default.

Setting this option also breaks migration compatibility.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200114103433.30534-5-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed.h |  2 ++
 hw/arm/aspeed.c         | 44 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 4423cd0cda7..18521484b90 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -19,6 +19,8 @@ typedef struct AspeedBoardState AspeedBoardState;
 
 typedef struct AspeedMachine {
     MachineState parent_obj;
+
+    bool mmio_exec;
 } AspeedMachine;
 
 #define ASPEED_MACHINE_CLASS(klass) \
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8702256af1b..a17843f0d3b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -261,11 +261,18 @@ static void aspeed_machine_init(MachineState *machine)
          * SoC and 128MB for the AST2500 SoC, which is twice as big as
          * needed by the flash modules of the Aspeed machines.
          */
-        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
-                               fl->size, &error_abort);
-        memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
-                                    boot_rom);
-        write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
+        if (ASPEED_MACHINE(machine)->mmio_exec) {
+            memory_region_init_alias(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
+                                     &fl->mmio, 0, fl->size);
+            memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
+                                        boot_rom);
+        } else {
+            memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
+                                   fl->size, &error_abort);
+            memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
+                                        boot_rom);
+            write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
+        }
     }
 
     aspeed_board_binfo.ram_size = ram_size;
@@ -399,6 +406,30 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
     /* Bus 11: TODO ucd90160@64 */
 }
 
+static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
+{
+    return ASPEED_MACHINE(obj)->mmio_exec;
+}
+
+static void aspeed_set_mmio_exec(Object *obj, bool value, Error **errp)
+{
+    ASPEED_MACHINE(obj)->mmio_exec = value;
+}
+
+static void aspeed_machine_instance_init(Object *obj)
+{
+    ASPEED_MACHINE(obj)->mmio_exec = false;
+}
+
+static void aspeed_machine_class_props_init(ObjectClass *oc)
+{
+    object_class_property_add_bool(oc, "execute-in-place",
+                                   aspeed_get_mmio_exec,
+                                   aspeed_set_mmio_exec, &error_abort);
+    object_class_property_set_description(oc, "execute-in-place",
+                           "boot directly from CE0 flash device", &error_abort);
+}
+
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -408,6 +439,8 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
+
+    aspeed_machine_class_props_init(oc);
 }
 
 static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
@@ -550,6 +583,7 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
         .instance_size = sizeof(AspeedMachine),
+        .instance_init = aspeed_machine_instance_init,
         .class_size    = sizeof(AspeedMachineClass),
         .class_init    = aspeed_machine_class_init,
         .abstract      = true,
-- 
2.20.1


