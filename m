Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A96C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25D320CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc+Ssh5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25D320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZKU-0000CD-0n
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl1-0001BX-Rf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008HY-Fh
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:11 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykz-00081o-1C
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id z12so2664189wmi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lnxo56F51J7EzgeqZR4DFFQlJvSN+QdQxsCFdch5LF8=;
 b=Vc+Ssh5h13f1pAqqmax1Js7lLXVTFWJVK1pPYag18qIwbRNDNb+JfoyxUZBe4sfeZP
 E1LsotxS0l4xGfWbqaDfdRDELQyFZ/OkRgCRf7egqWR6IjP6eNUVsVojakquiWhcB4Q0
 g5qvPVGUTvnmagaOPFCyrVK5TvSyk2diaV8XbB8f4EjaNLNuhLcGNes+ddP3ckJXtKvt
 pTUfcCoNTtYYa4STtz5NXSsUmix3hDUD90SKYoEFOFD+luNNKMfI4kdHpLoDyl7gqPHF
 u+e8TWYdYTmWyjeWu6dP6BTi1GRdTzrpQeeRsNIkNErbdHUdqKa3ejW9c6aZmfmNrMmo
 Ud4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lnxo56F51J7EzgeqZR4DFFQlJvSN+QdQxsCFdch5LF8=;
 b=MoF/T5LtMt/7XMsTzl+bY+laFM748hDS6IauJQk7X/icfpZgKnCIF63YOxHfpxmSbf
 QzVNjyHrxGMmRW9F48XZqrH3dfeP2tPPf9qdT2pOoH5HM5XmcH62iRkt/rL5bmtE1+Jc
 0wQ6m1+JSzQ66hVCCFamyzgLSqZCJDHv7ZWR+jM7SH9JOuU+lY0OnHa2Duoh03bMbIxY
 tg7TykNoQD01ISIcvFnIe5diGe+F81asfv1OLEDX/XP6vnrMDIN10jY6aZuB790UuKtE
 nsnkbN9Yrn1ttuNZpkLytCEVOETIoc6wjjGMcZXthnmpDwLfRipXfOChADvQ0hR8jOW2
 9l/w==
X-Gm-Message-State: APjAAAWhk7gaHwvtUEmCzGridDRJM+8kBlKZCB95KJbZnsYMnckYn+X4
 BZixd/SNljNGeYY2HpjPDOYN5YIC
X-Google-Smtp-Source: APXvYqz74FldemUif9h0emVedf3Nx80TN990gMnK0IsuTK1ddmdgcRMLuhfmaOu68qzHVroWDbr58w==
X-Received: by 2002:a05:600c:204f:: with SMTP id
 p15mr5146838wmg.6.1582631514571; 
 Tue, 25 Feb 2020 03:51:54 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 052/136] mips/mips_fulong2e: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:42 +0100
Message-Id: <1582631466-13880-52-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Message-Id: <20200219160953.13771-53-imammedo@redhat.com>
---
 hw/mips/mips_fulong2e.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index cf00211..c373ab0 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -294,7 +294,6 @@ static void mips_fulong2e_init(MachineState *machine)
     const char *initrd_filename = machine->initrd_filename;
     char *filename;
     MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     long bios_size;
     uint8_t *spd_data;
@@ -320,13 +319,11 @@ static void mips_fulong2e_init(MachineState *machine)
     }
 
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram",
-                                         machine->ram_size);
     memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(bios, true);
 
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
 
     /*
@@ -402,6 +399,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size = 256 * MiB;
+    mc->default_ram_id = "fulong2e.ram";
 }
 
 DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
-- 
1.8.3.1



