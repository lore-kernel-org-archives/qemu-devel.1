Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BFFC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43022084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPUFux5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43022084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z6l-0006wr-NA
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykx-00011l-9B
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykv-000874-FG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:07 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yks-00082P-17
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id e8so14378466wrm.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DXcrkMulYBuIN9veoeEc1n9tUNB7/w0gJTwitHoD+/c=;
 b=OPUFux5cMxoYslarEUR8NsrhIl7VbXm3F1lA9vlBkvraHiPqha7lsDenxv5FsKYw2j
 jrxe1Wnpj5zB/Q+RnGCk1bQz6Q1BH0EihyGE000wSsLgL/+zKqgxKFu9xn1e1zoaXUyq
 JQ00UjQgId9HCnw6VC+jAdg9u4qxBbf8apS03tqmt30h2dbHwJ4MEWZcVS4VcJlnopqO
 okd8Ja5z5zYSLVgK5s66cvxFdz2FhFgRHIexdg3thWBwV0TbL7jQstxPkACROP1y7Foh
 8PgRQ5JUS1swv52eRTrckBh1lw1rQCp7UfBr+vXYZfKWrbjQmNK32z3bFQ81x4i/g8Ox
 bNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DXcrkMulYBuIN9veoeEc1n9tUNB7/w0gJTwitHoD+/c=;
 b=XFO8uL0l/xfWiR8ig5G0KZ2rr5kEwhH66g+d6jGcCsEJFcLXfdeZbLPTzVnju75Mfx
 IdeJ9cSdWyDUV4+Gbnhpd42uv9rhgtEdW88/lvfa405diGrcRuPuA32U+nU4GJgEkNXo
 tnS1r+c97J2sNZ+nPtnKNXPztz66jE+buuGAY2/Jd6K8+CLtgjapJhks9Q22xZcZiWhL
 01khCXiDTLZUq8xixUHLb959wAWtPRj9kvUPtgGzwQoC8yRn3u8DaSIciTwvH18Vntp6
 cStCteXnrgkWL/bIDH9OmlmPeBJsfMId2uxyIwx5kenFuZedI4QZw+U7voKH+jFdbKPu
 pUIQ==
X-Gm-Message-State: APjAAAUdijIQfv3OcVicxdawfhAmv5RvGIraGJH3nnvVm3KTYXrRkxXN
 2tYTAlqsbaagEPhU+FjuG4AVGMHA
X-Google-Smtp-Source: APXvYqxv8yWqD8R4BDhBYXHwVXhT/wKyuicBEM8sVMkButlgVSmeF1tb0iVlKuNR9PmY1z1jxAYCyw==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr73757441wrg.266.1582631517175; 
 Tue, 25 Feb 2020 03:51:57 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 055/136] mips/mips_malta: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:45 +0100
Message-Id: <1582631466-13880-55-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Message-Id: <20200219160953.13771-56-imammedo@redhat.com>
---
 hw/mips/mips_malta.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 34b76bb..6e7ba92 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1224,7 +1224,6 @@ void mips_malta_init(MachineState *machine)
     char *filename;
     PFlashCFI01 *fl;
     MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *ram_high = g_new(MemoryRegion, 1);
     MemoryRegion *ram_low_preio = g_new(MemoryRegion, 1);
     MemoryRegion *ram_low_postio;
     MemoryRegion *bios, *bios_copy = g_new(MemoryRegion, 1);
@@ -1262,13 +1261,11 @@ void mips_malta_init(MachineState *machine)
     }
 
     /* register RAM at high address where it is undisturbed by IO */
-    memory_region_allocate_system_memory(ram_high, NULL, "mips_malta.ram",
-                                         ram_size);
-    memory_region_add_subregion(system_memory, 0x80000000, ram_high);
+    memory_region_add_subregion(system_memory, 0x80000000, machine->ram);
 
     /* alias for pre IO hole access */
     memory_region_init_alias(ram_low_preio, NULL, "mips_malta_low_preio.ram",
-                             ram_high, 0, MIN(ram_size, 256 * MiB));
+                             machine->ram, 0, MIN(ram_size, 256 * MiB));
     memory_region_add_subregion(system_memory, 0, ram_low_preio);
 
     /* alias for post IO hole access, if there is enough RAM */
@@ -1276,7 +1273,7 @@ void mips_malta_init(MachineState *machine)
         ram_low_postio = g_new(MemoryRegion, 1);
         memory_region_init_alias(ram_low_postio, NULL,
                                  "mips_malta_low_postio.ram",
-                                 ram_high, 512 * MiB,
+                                 machine->ram, 512 * MiB,
                                  ram_size - 512 * MiB);
         memory_region_add_subregion(system_memory, 512 * MiB,
                                     ram_low_postio);
@@ -1448,6 +1445,7 @@ static void mips_malta_machine_init(MachineClass *mc)
 #else
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
+    mc->default_ram_id = "mips_malta.ram";
 }
 
 DEFINE_MACHINE("malta", mips_malta_machine_init)
-- 
1.8.3.1



