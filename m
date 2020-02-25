Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C0FC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4218D222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rINhlWsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4218D222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yx9-000608-DF
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkR-0000WL-Ap
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkM-0006Ia-5n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:34 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkL-0006DF-UK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:30 -0500
Received: by mail-wm1-x32a.google.com with SMTP id p9so2678901wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XJKoDouvuy15HLlMmWlJHtnGaWVw4HBogC02qHedvtM=;
 b=rINhlWsF7vUf1GUmbmsslwtDOkPAWBO/LnaEtAr8DKdBMb08Ww6w/2lu9pSfemsKtR
 b1iN2R4xfnPTYaVc4DGbhMJnQCUH1Ll/RU+fnQ4WW8ogykj5JElfJD18OYmxVVhFaWri
 us6H5vBTqWxJZ4YMS2tiapNKwGPKPrT9ZqeNLI8rWjsgQ1FsLMLvDXpUjBgobHX+Q5RT
 PJrxg/FjI2SD3/qCMIw8M130APye3NTBBhBsrLgDM83uxwl+P0R6mJ59UtlOA+eOu+as
 8hbxutzdNPLraPXb3dM9+NbtduS4K6ZmV8x6WSX8vT4eWlDWXmENi0CRAdumpJg0xnWC
 7hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XJKoDouvuy15HLlMmWlJHtnGaWVw4HBogC02qHedvtM=;
 b=HmzL3HMz+tAuCRvmS2rcPSMrQVL0FQkaQGTAEySp3ZtDun/2ni7O8IIV6Zoim8zcjK
 Jc+lTRxVh3T+dS1RuG5NT30NN1moY6FE1RsawxfXhaNkhZoRdap3ALczMQQ9tExjXkWh
 N3qQSsXsJdjThURuQZxxcPA9fjnrReOz3UkDKyF6gjWRXCgbQ/ZueIbm39LOC17NvVSV
 O5vbFdMUREsKj2PRgCQSYaSZZz6zNdDVARQU/7oBQVUPaUHeyocaRGZxJF3OgDzCcrO/
 DnMnCt4qH/eBKn+WvZ/VS1JzixQVGuh8gfbNQezYv1vw4hS89bKWTp0dkKzYxBCqFvRV
 /KWg==
X-Gm-Message-State: APjAAAXCMmWdoibuV4kKAuzEViQbFfWZdLwfR7pGp+MErDi3GpV9xscT
 IUyAcL6ZNcgX1UISz2G2NbYyIqaP
X-Google-Smtp-Source: APXvYqyhZTt5w8E/bvLoztzDsmNFEHrSvnrvySO0hBRls0sBprbjEtrKD4HubXBbZhi2t1UhSZM+qA==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr4918823wmf.60.1582631484864; 
 Tue, 25 Feb 2020 03:51:24 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 019/136] arm/kzm: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:09 +0100
Message-Id: <1582631466-13880-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-20-imammedo@redhat.com>
---
 hw/arm/kzm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 94cbac1..34f6bcb 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -52,7 +52,6 @@
 
 typedef struct IMX31KZM {
     FslIMX31State soc;
-    MemoryRegion ram;
     MemoryRegion ram_alias;
 } IMX31KZM;
 
@@ -85,10 +84,8 @@ static void kzm_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    memory_region_allocate_system_memory(&s->ram, NULL, "kzm.ram",
-                                         machine->ram_size);
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_SDRAM0_ADDR,
-                                &s->ram);
+                                machine->ram);
 
     /* initialize the alias memory if any */
     for (i = 0, ram_size = machine->ram_size, alias_offset = 0;
@@ -108,7 +105,8 @@ static void kzm_init(MachineState *machine)
 
         if (size < ram[i].size) {
             memory_region_init_alias(&s->ram_alias, NULL, "ram.alias",
-                                     &s->ram, alias_offset, ram[i].size - size);
+                                     machine->ram,
+                                     alias_offset, ram[i].size - size);
             memory_region_add_subregion(get_system_memory(),
                                         ram[i].addr + size, &s->ram_alias);
         }
@@ -140,6 +138,7 @@ static void kzm_machine_init(MachineClass *mc)
     mc->desc = "ARM KZM Emulation Baseboard (ARM1136)";
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_id = "kzm.ram";
 }
 
 DEFINE_MACHINE("kzm", kzm_machine_init)
-- 
1.8.3.1



