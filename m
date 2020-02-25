Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B9C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621AD20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie2z4kr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621AD20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZMV-0004km-DW
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl7-0001N3-0q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl3-0000Bt-6Y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:16 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl2-00008L-SQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id t3so14353510wru.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IGII3Nk2icHjTflqllSNqhaNAdwtDC35kp1OZRJUBJc=;
 b=Ie2z4kr4H35wj3dEhk5ePjS7HVVFaKKEnqFsQt2529B0VCr+G5Re1ARf87ce+YT4vH
 G0KNdjL2RgggT3XKPoA621TgPgmsOP9yKVntAqTiJ6VEbxwonsig9mKgY71fQevlHzVt
 bxwZiPnn8qMeWg65TrFeCQQCy/oZiQEH9yxSQurlIcXdSvjwuixvGbQxdZnD/k8IZNFD
 BjCHjm/XCyB24JcPnf37Emp2K0j/DWv0FZTi9qS/usoUS3wYEtk+fGrFuGNUjCliW/uv
 SZTkXhBL+f2OvY1quG0Fq5X6l6qgS5ujDta1ZYPXkwqq6tpo/+JowMS8A8pWPEo6jTg7
 F4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IGII3Nk2icHjTflqllSNqhaNAdwtDC35kp1OZRJUBJc=;
 b=b3eU6oC/7d2715FzsN6tPdfjr30z3yBI+iOuKNUl9EOpQ+lj+TBw1cKCEXozrk0+vY
 ZksD6+cPOkIDyOlIJZBoMLi/Yqn2ZEvIkn9i/EObyC8VblfACejHNkkXQlnDB/2pyN+k
 EDgl3dJw4PoqVAt/vjkrsgqnGnWCLaAugQtAe45GkmkVPk+GAZrratXrvi048uEVIawB
 pYn47JmfmT0SDqF39w3rYoJ/NXy4Umi8MRCjIBo30q/L1Lwq6HObpiktjEi1PWn4euqD
 2o/j63eT5e/onhw3DIqm0UDc+ZtP6OkwSxZUAMjWhGafTOp50v8hFcaqtMI6+ay3uRom
 /aMQ==
X-Gm-Message-State: APjAAAWHqCGnefAC7xYXSuouO64ymbkH1qUtHmt+FhhTBIc/fzH7KMS6
 yZaWAeLRSphJozYoy68hrA0h55QR
X-Google-Smtp-Source: APXvYqyrmlvAnulVtGsgpqx19cK4qFG1m6w+rU9uxmbXzZAAiGU9611UfpRXbU3Cls+6cWhcBUZzhQ==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr69526207wru.427.1582631531742; 
 Tue, 25 Feb 2020 03:52:11 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 071/136] sparc/niagara: use memdev for RAM
Date: Tue, 25 Feb 2020 12:50:01 +0100
Message-Id: <1582631466-13880-71-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-72-imammedo@redhat.com>
---
 hw/sparc64/niagara.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 5eb2d09..ab5ef8c 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -40,7 +40,6 @@
 
 typedef struct NiagaraBoardState {
     MemoryRegion hv_ram;
-    MemoryRegion partition_ram;
     MemoryRegion nvram;
     MemoryRegion md_rom;
     MemoryRegion hv_rom;
@@ -111,11 +110,8 @@ static void niagara_init(MachineState *machine)
                            NIAGARA_HV_RAM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram);
 
-    memory_region_allocate_system_memory(&s->partition_ram, NULL,
-                                         "sun4v-partition.ram",
-                                         machine->ram_size);
     memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
-                                &s->partition_ram);
+                                machine->ram);
 
     memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVRAM_SIZE,
                            &error_fatal);
@@ -173,6 +169,7 @@ static void niagara_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1; /* XXX for now */
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
+    mc->default_ram_id = "sun4v-partition.ram";
 }
 
 static const TypeInfo niagara_type = {
-- 
1.8.3.1



