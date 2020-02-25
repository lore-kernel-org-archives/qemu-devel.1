Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4235DC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D45E20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrwWi4UX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D45E20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZQC-0003Of-70
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl4-0001Iv-FU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008Ia-Iu
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:14 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:51576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykz-000879-34
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id t23so2681163wmi.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7HmcCPOMdMhr/kyGIt2JW8uV4wc8/OhGNTYl4tEX7pQ=;
 b=qrwWi4UXABWyEew6OXdwaDO1dxPLd+ET+u94sqPyL+gR3osz5gpPja11qF6EmN7a42
 iQn2HsKmxlJfNZ2H6LBFS1qEENkig/RuB6KCXhTSJPqtbGhCWv4aMSGEJ29XjSl8g6Oy
 v9KePMcouPADGWpHTtrhXA5SLAOzElNvEhWGB27pFt7fDofH/qfyPLgsfeKCgIR2Ia/0
 Bqb8a6G6BhXY5BdtvmGihonzNeWfXtosNzPihPts6BAZ0CWx9VbQk4qKM3lzuWk3wgOO
 SpPtZ/9BBRoPU3dr6mhbWBf/K7Mo4ZPYmnc7Z+GYCZ/nW0qUN4nJ51TdNysvMhLmuzcL
 cf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=7HmcCPOMdMhr/kyGIt2JW8uV4wc8/OhGNTYl4tEX7pQ=;
 b=IQ0oZlFgmwqhx1DDvagXzLx5NcAugPh0zXi+z92Robu4QGnf8SFcuM4Foss7JFBJxo
 Z+AhiqAgyeZS24w+5dubF+DrGrkSATrNDED2D3Irfp0G3NKE+ztd2waX86kwH4QFrhFl
 tX8Atx8WpdpjigqhoHwAqwzbAsB4Gwc/hfUExDNxNhBhmwkoDGFPiXmUi23qb8oFJpow
 h+JAxzHVPmk+4qYz1fnarqt7w880McV1B+EalTEdzcEV2mrftuK2PcKyrFiHUIb9Zg1u
 VmaXS5XQDUGBiQHc4Tg5ndwz9wEnrMC32XDZfeRZEo/CJKlOKgJPwTAuz1hLbv+xOK1o
 6a0g==
X-Gm-Message-State: APjAAAV4hUCIrZqRBzhZE5rfh9Y1EWSkVS66GIkKDn1otMFK316qtyzj
 HDY37iJvKH6py3m3pzLVSSOJhVuL
X-Google-Smtp-Source: APXvYqysaD/fIWTMwT2YjbY96Vtx23jCq4B1dpqkzc+C5sVI1UJZ6JQ2GHg4yw0eBk4hpFSIAAJ5Ng==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr4908727wmj.175.1582631524788; 
 Tue, 25 Feb 2020 03:52:04 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 064/136] ppc/ppc405_boards: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:54 +0100
Message-Id: <1582631466-13880-64-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

PS:
in ref405ep alias RAM into ram_memories[] to avoid re-factoring
its user ppc405ep_init(), which would be invasive and out of
scope this patch.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-65-imammedo@redhat.com>
---
 hw/ppc/ppc405_boards.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 057882a..de93c40 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -170,8 +170,8 @@ static void ref405ep_init(MachineState *machine)
     }
 
     /* XXX: fix this */
-    memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405ep.ram",
-                                         machine->ram_size);
+    memory_region_init_alias(&ram_memories[0], NULL, "ef405ep.ram.alias",
+                             machine->ram, 0, machine->ram_size);
     ram_bases[0] = 0;
     ram_sizes[0] = machine->ram_size;
     memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
@@ -312,6 +312,7 @@ static void ref405ep_class_init(ObjectClass *oc, void *data)
     mc->desc = "ref405ep";
     mc->init = ref405ep_init;
     mc->default_ram_size = 0x08000000;
+    mc->default_ram_id = "ef405ep.ram";
 }
 
 static const TypeInfo ref405ep_type = {
@@ -424,7 +425,6 @@ static void taihu_405ep_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *bios;
     MemoryRegion *ram_memories = g_new(MemoryRegion, 2);
-    MemoryRegion *ram = g_malloc0(sizeof(*ram));
     hwaddr ram_bases[2], ram_sizes[2];
     long bios_size;
     target_ulong kernel_base, initrd_base;
@@ -439,18 +439,16 @@ static void taihu_405ep_init(MachineState *machine)
         g_free(sz);
         exit(EXIT_FAILURE);
     }
-    memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
-                                         machine->ram_size);
 
     ram_bases[0] = 0;
     ram_sizes[0] = 0x04000000;
     memory_region_init_alias(&ram_memories[0], NULL,
-                             "taihu_405ep.ram-0", ram, ram_bases[0],
+                             "taihu_405ep.ram-0", machine->ram, ram_bases[0],
                              ram_sizes[0]);
     ram_bases[1] = 0x04000000;
     ram_sizes[1] = 0x04000000;
     memory_region_init_alias(&ram_memories[1], NULL,
-                             "taihu_405ep.ram-1", ram, ram_bases[1],
+                             "taihu_405ep.ram-1", machine->ram, ram_bases[1],
                              ram_sizes[1]);
     ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
                   33333333, &pic, kernel_filename == NULL ? 0 : 1);
@@ -546,6 +544,7 @@ static void taihu_class_init(ObjectClass *oc, void *data)
     mc->desc = "taihu";
     mc->init = taihu_405ep_init;
     mc->default_ram_size = 0x08000000;
+    mc->default_ram_id = "taihu_405ep.ram";
 }
 
 static const TypeInfo taihu_type = {
-- 
1.8.3.1



