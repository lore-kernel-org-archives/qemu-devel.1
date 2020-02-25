Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321D9C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F294E20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIaC93fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F294E20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZJC-0006Dw-4X
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl4-0001JI-Jc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008IP-Ht
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:14 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykz-0008Av-2O
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:09 -0500
Received: by mail-wr1-x429.google.com with SMTP id g3so14326320wrs.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QSYz1cirhA+K+7KO0VldIrZ+oSK90drXd3aTnab8eKc=;
 b=aIaC93fsS6QiHNvTT90GugSs2AojHZgEqd+7XFYTQHRkMYCaoPdCwzuujX4Ozml1w5
 dQbUJTI4EjoSl1DkUU5dGnitsu9sG+1NaW4D8MVWD4NsYfET4lsSbB+a5MzoTa9NV+GY
 cU+aTw1GdcdCq30uys4f0jf8D1UYsz8QwknLukJZcqX0AYiLm1z2hNzxMGMIY7oEPjHB
 48FpMmAOP3ws+reIrMJtPYbqK4e0bm+9HB0jY+LWKz5U+izd/OL2hw05NvC4CN5zUKNN
 HfyIzrYzASGqGHZ3A6x6jvye/epGVxQktpUH0dMUSV/RwA8qIZJhKH6ZZh+V1ZuZc7cN
 wdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=QSYz1cirhA+K+7KO0VldIrZ+oSK90drXd3aTnab8eKc=;
 b=MaYZ2Bw3JFjEYtzH5ipJv7s+j/qM3PfpeQMR/4EtdD5HM4RnY/ASrUI4OM3ZQdP3/v
 0SNE6Hdy7/Syh1UUj8jQP1bCrrynjtKXgixEZ/wBIgmtIwJT9zqT2epoRGy/Rm7qITHV
 iJy5ZOzFtnDBovuEFZFQUJekjumGuuXTDPwVrQqp8QGXR6Q8iBNcIDGwDlam2XXzIHpF
 DBferDCHq6CDRiiufPROPJL791um+oE/Pok3+j3+CQP47J0GzwugQU1JlUHkgPZcLijy
 DmNy8PtiNs+GHx7IsjlSj1SxiZUzbwmLSBZ0iyQrFduOEgqIH0aLiRwzC2CUkzFkaKCY
 pNpQ==
X-Gm-Message-State: APjAAAW0YJ/fZxMucjErGlvJj02lRjksUHWakGy1W48/1A+zEs1wxheZ
 GwoPOe7rchxi5AMQ2rogH7LKZCfp
X-Google-Smtp-Source: APXvYqxrAF1r+9HT8twvT1Abm5024JdVXLjYSaGWB3HAX9/u6QaBCo2bRRuIjatijUpWW7NghzJCHQ==
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr76129928wrq.164.1582631526904; 
 Tue, 25 Feb 2020 03:52:06 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 066/136] ppc/{ppc440_bamboo, sam460ex}: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:56 +0100
Message-Id: <1582631466-13880-66-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200219160953.13771-67-imammedo@redhat.com>
---
 hw/ppc/ppc440_bamboo.c  |  3 ++-
 hw/ppc/ppc4xx_devs.c    | 29 ++++++++++++-----------------
 hw/ppc/sam460ex.c       |  3 ++-
 include/hw/ppc/ppc4xx.h |  2 +-
 4 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 7e3bc0e..4c5e9e4 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -202,7 +202,7 @@ static void bamboo_init(MachineState *machine)
     /* SDRAM controller */
     memset(ram_bases, 0, sizeof(ram_bases));
     memset(ram_sizes, 0, sizeof(ram_sizes));
-    ppc4xx_sdram_banks(machine->ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
+    ppc4xx_sdram_banks(machine->ram, PPC440EP_SDRAM_NR_BANKS, ram_memories,
                        ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0. */
     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
@@ -289,6 +289,7 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->desc = "bamboo";
     mc->init = bamboo_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
+    mc->default_ram_id = "ppc4xx.sdram";
 }
 
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index d89008a..3376c43 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -666,24 +666,24 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
         sdram_map_bcr(sdram);
 }
 
-/* Fill in consecutive SDRAM banks with 'ram_size' bytes of memory.
+/*
+ * Split RAM between SDRAM banks.
  *
  * sdram_bank_sizes[] must be in descending order, that is sizes[i] > sizes[i+1]
  * and must be 0-terminated.
  *
  * The 4xx SDRAM controller supports a small number of banks, and each bank
  * must be one of a small set of sizes. The number of banks and the supported
- * sizes varies by SoC. */
-void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
+ * sizes varies by SoC.
+ */
+void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
                         MemoryRegion ram_memories[],
                         hwaddr ram_bases[], hwaddr ram_sizes[],
                         const ram_addr_t sdram_bank_sizes[])
 {
-    MemoryRegion *ram = g_malloc0(sizeof(*ram));
-    ram_addr_t size_left = ram_size;
+    ram_addr_t size_left = memory_region_size(ram);
     ram_addr_t base = 0;
     ram_addr_t bank_size;
-    int last_bank = 0;
     int i;
     int j;
 
@@ -691,11 +691,15 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
         for (j = 0; sdram_bank_sizes[j] != 0; j++) {
             bank_size = sdram_bank_sizes[j];
             if (bank_size <= size_left) {
+                char name[32];
+
                 ram_bases[i] = base;
                 ram_sizes[i] = bank_size;
                 base += bank_size;
                 size_left -= bank_size;
-                last_bank = i;
+                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
+                memory_region_init_alias(&ram_memories[i], NULL, name, ram,
+                                         ram_bases[i], ram_sizes[i]);
                 break;
             }
         }
@@ -706,7 +710,7 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
     }
 
     if (size_left) {
-        ram_addr_t used_size = ram_size - size_left;
+        ram_addr_t used_size = memory_region_size(ram) - size_left;
         GString *s = g_string_new(NULL);
 
         for (i = 0; sdram_bank_sizes[i]; i++) {
@@ -722,15 +726,6 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
         g_string_free(s, true);
         exit(EXIT_FAILURE);
     }
-
-    memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_size);
-
-    for (i = 0; i <= last_bank; i++) {
-        char name[32];
-        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
-        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
-                                 ram_bases[i], ram_sizes[i]);
-    }
 }
 
 /*****************************************************************************/
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 17d40bd..898453c 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -324,7 +324,7 @@ static void sam460ex_init(MachineState *machine)
     /* SDRAM controller */
     /* put all RAM on first bank because board has one slot
      * and firmware only checks that */
-    ppc4xx_sdram_banks(machine->ram_size, 1, ram_memories, ram_bases, ram_sizes,
+    ppc4xx_sdram_banks(machine->ram, 1, ram_memories, ram_bases, ram_sizes,
                        ppc460ex_sdram_bank_sizes);
 
     /* FIXME: does 460EX have ECC interrupts? */
@@ -484,6 +484,7 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->init = sam460ex_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size = 512 * MiB;
+    mc->default_ram_id = "ppc4xx.sdram";
 }
 
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index b8c8f32..cc19c8d 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -42,7 +42,7 @@ enum {
 qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
                        uint32_t dcr_base, int has_ssr, int has_vr);
 
-void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
+void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
                         MemoryRegion ram_memories[],
                         hwaddr ram_bases[], hwaddr ram_sizes[],
                         const ram_addr_t sdram_bank_sizes[]);
-- 
1.8.3.1



