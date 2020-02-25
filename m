Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F69C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C48620CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGvlDvA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C48620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZMb-0004xE-CW
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl3-0001FV-B2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008GH-4B
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00086Y-EK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: by mail-wr1-x434.google.com with SMTP id z15so6037767wrl.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mIoNz+eT/hMyD9ZxJzAVhJ/FNd4za+ru1feUPkgFaJc=;
 b=jGvlDvA6PW09/hFk1cwJBZnJSQQdSCa8IqW08yo3Q5ySqftbt3Cbrcfj3ekgRzoE63
 qmVXOLS3JzCkglzXuN9SlIDChlQLgoCRuZeoG/8GC2RQAWj0YI8ZImCSgyURm0s7Aqzt
 54x/N0DbWJjsPB0yM9CZ2hh+DJnQ0gTahcklb5oHLXnhthS3A+HbWy+Sjj9+GyVMKBaZ
 FWrQDP9Jzacedziafhbjn7ImYCY3VPvVGxKfw/MVojNnco+IHKARlRhYFNfkUQuDg+V+
 GxNuWtOLyG9FZVJIpkpE/+vEPvDZh2FnJD0tUEf+h1YCM1YbS9JF7/dsqkkI10MH1ctO
 99pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=mIoNz+eT/hMyD9ZxJzAVhJ/FNd4za+ru1feUPkgFaJc=;
 b=pcZg6LgcvKgPm02dcoPdWb7AtMPLrDu5PVWlTf+xgZS4axySUXFxrEmv/j+KJL5X7b
 W9xpfIQRYouzJhf4nKr6gPn+zw01JSQMckQ37cKMc9nTAIHfHT6gKO244MtYfKxNbT0T
 pFxejgNl0i7fKnOf02GlchPjiNB2Fi3oKwQdN1L8Dtf/MjIXWkkYarKslKch9uSbYH5r
 V6ttgyASNX3FJ7bD1UUaTvz88CBo8arvp7IS9I084aMgQJ9QKlGqZQPqIctOxzb2PS2S
 QogcVooVu2ZkosN+shZrzgb1wHbQVEZCZA4ctBBECR46ljl+fU0z+FBlgZbzLqQrvbGD
 zJ9Q==
X-Gm-Message-State: APjAAAUeDCU7FbM0wYQW53XG0Rtj4ZftKf0ageVnZqOuHRf2GqAGEQ6N
 MEYjLrQ/wpJKzfvQ/DHkq+iEesA/
X-Google-Smtp-Source: APXvYqxA+m8qeDfqqY/WCKadw+456xDGvFPPGyFaqi4zsV5DYxBkoahpY0qDH7IoztK9BTGwKMmReg==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr72627138wrs.365.1582631523887; 
 Tue, 25 Feb 2020 03:52:03 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 063/136] ppc/ppc405_boards: add RAM size checks
Date: Tue, 25 Feb 2020 12:49:53 +0100
Message-Id: <1582631466-13880-63-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

If user provided non-sense RAM size, board will ignore it
and continue running with fixed RAM size.

Also RAM is going to be allocated by generic code, so it
won't be possible for board to fix CLI.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

PS:
move fixed RAM size into mc->default_ram_size, so that
generic code will know how much to allocate.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-64-imammedo@redhat.com>
---
 hw/ppc/ppc405_boards.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 1f721fe..057882a 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -40,6 +40,7 @@
 #include "qemu/error-report.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
+#include "qemu/cutils.h"
 
 #define BIOS_FILENAME "ppc405_rom.bin"
 #define BIOS_SIZE (2 * MiB)
@@ -137,7 +138,7 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem, uint32_t base)
 
 static void ref405ep_init(MachineState *machine)
 {
-    ram_addr_t ram_size = machine->ram_size;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -161,15 +162,21 @@ static void ref405ep_init(MachineState *machine)
     DriveInfo *dinfo;
     MemoryRegion *sysmem = get_system_memory();
 
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     /* XXX: fix this */
     memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405ep.ram",
-                                         0x08000000);
+                                         machine->ram_size);
     ram_bases[0] = 0;
-    ram_sizes[0] = 0x08000000;
+    ram_sizes[0] = machine->ram_size;
     memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
     ram_bases[1] = 0x00000000;
     ram_sizes[1] = 0x00000000;
-    ram_size = 128 * MiB;
     env = ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
                         33333333, &pic, kernel_filename == NULL ? 0 : 1);
     /* allocate SRAM */
@@ -227,7 +234,7 @@ static void ref405ep_init(MachineState *machine)
     if (linux_boot) {
         memset(&bd, 0, sizeof(bd));
         bd.bi_memstart = 0x00000000;
-        bd.bi_memsize = ram_size;
+        bd.bi_memsize = machine->ram_size;
         bd.bi_flashstart = -bios_size;
         bd.bi_flashsize = -bios_size;
         bd.bi_flashoffset = 0;
@@ -255,7 +262,7 @@ static void ref405ep_init(MachineState *machine)
         kernel_base = KERNEL_LOAD_ADDR;
         /* now we can load the kernel */
         kernel_size = load_image_targphys(kernel_filename, kernel_base,
-                                          ram_size - kernel_base);
+                                          machine->ram_size - kernel_base);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
@@ -266,7 +273,7 @@ static void ref405ep_init(MachineState *machine)
         if (initrd_filename) {
             initrd_base = INITRD_LOAD_ADDR;
             initrd_size = load_image_targphys(initrd_filename, initrd_base,
-                                              ram_size - initrd_base);
+                                              machine->ram_size - initrd_base);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -304,6 +311,7 @@ static void ref405ep_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "ref405ep";
     mc->init = ref405ep_init;
+    mc->default_ram_size = 0x08000000;
 }
 
 static const TypeInfo ref405ep_type = {
@@ -408,7 +416,7 @@ static void taihu_cpld_init(MemoryRegion *sysmem, uint32_t base)
 
 static void taihu_405ep_init(MachineState *machine)
 {
-    ram_addr_t ram_size = machine->ram_size;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     char *filename;
@@ -425,10 +433,14 @@ static void taihu_405ep_init(MachineState *machine)
     int fl_idx;
     DriveInfo *dinfo;
 
-    /* RAM is soldered to the board so the size cannot be changed */
-    ram_size = 0x08000000;
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
     memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
-                                         ram_size);
+                                         machine->ram_size);
 
     ram_bases[0] = 0;
     ram_sizes[0] = 0x04000000;
@@ -500,7 +512,7 @@ static void taihu_405ep_init(MachineState *machine)
         kernel_base = KERNEL_LOAD_ADDR;
         /* now we can load the kernel */
         kernel_size = load_image_targphys(kernel_filename, kernel_base,
-                                          ram_size - kernel_base);
+                                          machine->ram_size - kernel_base);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
@@ -509,7 +521,7 @@ static void taihu_405ep_init(MachineState *machine)
         if (initrd_filename) {
             initrd_base = INITRD_LOAD_ADDR;
             initrd_size = load_image_targphys(initrd_filename, initrd_base,
-                                              ram_size - initrd_base);
+                                              machine->ram_size - initrd_base);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
                              initrd_filename);
@@ -533,6 +545,7 @@ static void taihu_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "taihu";
     mc->init = taihu_405ep_init;
+    mc->default_ram_size = 0x08000000;
 }
 
 static const TypeInfo taihu_type = {
-- 
1.8.3.1



