Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B13AC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232712176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2bdf3sU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232712176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZAd-0005gA-5S
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl0-00018M-QN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008FW-34
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:10 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00082e-Eu
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: by mail-wr1-x42e.google.com with SMTP id u6so14405659wrt.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wpeBDqm1mbqimPx7VSOh234xlVHfgBdHQ9PpJAIvLUw=;
 b=h2bdf3sUPY1iPtAug7HLOX3+2Q1ElA/MOhaukzawcXac46IWY3CWFTmrl/VQryRLkS
 93NETpQISRj9owsrHCH8OVgYXFIo4+vQBrrAMTK/nvMGC85/DQhsQK+ny4kYhe+CtEvD
 D14AeKxSkM3621l8r1zgWdo+XTsdql2sZmF1QB4kPGvX7TXderVCpEXwNe8JKn/VJRCI
 iwYl4OrxII7gVkT7vERe0FVKGf7MnBTimPn6lIRbP+f529y3ZQ79dbKUFA7CZ8tzzgME
 d1xVo8vw2i6QYjCjtd1LKy67aAZSVqjR12vZfkPL4YY445a3jf/h8eBn8cCG3W15cICD
 amdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wpeBDqm1mbqimPx7VSOh234xlVHfgBdHQ9PpJAIvLUw=;
 b=oIXLWudav61EdoW0s3Qst4wXlDs+dz9SstMN3AR56jxo77Ua4Mc/rCB1oL3owHI+lb
 9+8g4drHeppJ/m4le9x6BspffHCmIEyyDlSKOmNE15GMRPuBUZang/CVXNj6bJ8yqW9W
 OOe9i2EsInKNyJmejo9fnivv3h9/B0Ero/T0HzBV0bJrp0/heGDBIzP//l4WYQdqK40T
 baVDKx5fp5tY7J3TrEmHtHX3ALge/c3NP3XdxYG7mkpoMfvNvfYioH385oWH19GWnapG
 1C6zUads4g5SNm0FFBIf75EXFAeCC4NorSP7nUx8Mblay0cB9gT8bNSSKJRdzFpoztP2
 IJIg==
X-Gm-Message-State: APjAAAXMH3fN0pYjNI0MEq3/CpLPO60kgoDah3+vaSpti4kbASokkGYh
 cs9xTPIWmg35hXAfpm/siG+fqDW3
X-Google-Smtp-Source: APXvYqxREYLpCce/6USsD+d3+JF3d8noae7o4iz6qygv0JyvcyPPTsTkBZzmyw/+Oe8b7vJdr5xnbw==
X-Received: by 2002:adf:f349:: with SMTP id e9mr10194252wrp.56.1582631518006; 
 Tue, 25 Feb 2020 03:51:58 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 056/136] mips/mips_mipssim: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:46 +0100
Message-Id: <1582631466-13880-56-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-57-imammedo@redhat.com>
---
 hw/mips/mips_mipssim.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index b934ca9..b2555dd 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -143,14 +143,12 @@ static void mipsnet_init(int base, qemu_irq irq, NICInfo *nd)
 static void
 mips_mipssim_init(MachineState *machine)
 {
-    ram_addr_t ram_size = machine->ram_size;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
     char *filename;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *isa = g_new(MemoryRegion, 1);
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MIPSCPU *cpu;
     CPUMIPSState *env;
@@ -167,13 +165,11 @@ mips_mipssim_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* Allocate RAM. */
-    memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
-                                         ram_size);
     memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(bios, true);
 
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     /* Map the BIOS / boot exception handler. */
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
@@ -200,7 +196,7 @@ mips_mipssim_init(MachineState *machine)
     }
 
     if (kernel_filename) {
-        loaderparams.ram_size = ram_size;
+        loaderparams.ram_size = machine->ram_size;
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
@@ -245,6 +241,7 @@ static void mips_mipssim_machine_init(MachineClass *mc)
 #else
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
+    mc->default_ram_id = "mips_mipssim.ram";
 }
 
 DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
-- 
1.8.3.1



