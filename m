Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA72ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502832168B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502832168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7y0w-0004sy-Hl
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xva-0007H6-Sq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvZ-0006LA-Pq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xvZ-0006L1-KI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so2325703wmi.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=zWVv+FnKPyvG+WsnOHKMyhnpYZDoazGS6r9S2S4QveY=;
 b=tS20nHus3wSCxtsTiiGfKzxuOkwrwogOr44IkiL5WTNdPrl/ZfZaCaNVZ0yUc7LN8/
 CmzrzHKQpvC15J+uEYHDuu/9uHgB+6vlJgHEHuGq46rZ3Mn5Bq691t/NmYbIK9Kwd1lz
 oSjRhBPrIZc7tiuh5i+v1tF1qF6LWTVYKyO1IiCb16PiapU3ScJ2PLp8rxQudFqNN8n4
 ePJ+HRtFVRY0lc8K3AEPS6r5cQqiuC3PyzXuWhK8jpg8sT9IRI6UCtEYlgGC7MYrb/oX
 +/QiF81utWGOhKOvLkYPblvTopDs9AuLfSWFW4aWkyQyepDnaURq0L2V5IMYGioYbN0h
 N4bA==
X-Gm-Message-State: APjAAAVAlx+B90sLIoi4ScAdAn3iJWKikr1+eYjPib2gN1/CkeG0IWdg
 1nPuv4ceJdkePG2MLemN9HHe9Q==
X-Google-Smtp-Source: APXvYqyvPPe8kEilSGxg/CqleuUCjQd9Y6GdhVqqdD96rOm0YdOCZLpLxNdrb2PGjGHI3pf6kCRODQ==
X-Received: by 2002:a1c:80c6:: with SMTP id b189mr3034042wmd.34.1568190276455; 
 Wed, 11 Sep 2019 01:24:36 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id d28sm24347828wrb.95.2019.09.11.01.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:24:35 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:27 -0700
Message-Id: <20190910190513.21160-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: [Qemu-devel] [PULL 01/47] riscv: sifive_u: Add support for loading
 initrd
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

Add support for loading initrd with "-initrd <filename>"
to the sifive_u machine. This lets us boot into Linux without
disk drive.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9910fa6708..32167d05a1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -67,7 +67,7 @@ static const struct MemmapEntry {
 
 #define GEM_REVISION        0x10070109
 
-static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
+static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
@@ -244,11 +244,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
     g_free(nodename);
+
+    return fdt;
 }
 
 static void riscv_sifive_u_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
+    void *fdt;
 
     SiFiveUState *s = g_new0(SiFiveUState, 1);
     MemoryRegion *system_memory = get_system_memory();
@@ -269,13 +272,24 @@ static void riscv_sifive_u_init(MachineState *machine)
                                 main_mem);
 
     /* create device tree */
-    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     riscv_find_and_load_firmware(machine, BIOS_FILENAME,
                                  memmap[SIFIVE_U_DRAM].base);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
+
+        if (machine->initrd_filename) {
+            hwaddr start;
+            hwaddr end = riscv_load_initrd(machine->initrd_filename,
+                                           machine->ram_size, kernel_entry,
+                                           &start);
+            qemu_fdt_setprop_cell(fdt, "/chosen",
+                                  "linux,initrd-start", start);
+            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                                  end);
+        }
     }
 
     /* reset vector */
-- 
2.21.0


