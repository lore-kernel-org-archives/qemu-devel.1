Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C9EC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C352176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObB5ZqZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C352176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z8s-00020y-R1
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-00015p-UY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yky-0008FB-MO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:09 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00081O-A4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:07 -0500
Received: by mail-wr1-x42d.google.com with SMTP id t3so14352360wru.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P+/FlC3j7Lfy2SNrnDoWkd2WrZ5mGK36LS1XmlPHuLE=;
 b=ObB5ZqZ8DaTjBjmTqHW6+JxxkaApiCrJfu5PjnOuk39jWn0ZZUJOC0MrWnluFYDWLJ
 kP70JEHP3kSyFWwL+GEWXju1fickUGKGY1tOnV7uiqjA9L1ueOhDPNiQTfBqDQ4yI708
 gytR/fYgQamAHYm0irjW90sW2atQms0uPh1WF4N6mXel91fKiMtI9OGVQB9p5ZO7Vu5p
 6GiVWrNYfNuKej6XJGlGvbn2Rl548wEDT+qQN4xA+IeodMQZBjaRLCvOdQrgpKkC7RWI
 w9F3czatxdNRXCPXpAbhz8hXNvy/UJ6Agwhm8roI3VgeAxwpVzjZYRkCB/44VB4ZuBoO
 FarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=P+/FlC3j7Lfy2SNrnDoWkd2WrZ5mGK36LS1XmlPHuLE=;
 b=Bb104bJUULfXauYVeUKNOiXJanzmrdODUPVUaDebYrLPR6rV9cO2korXScPNS4z+4d
 v3tZL664STrd5dKi/+xNsuNUaQmom6mDvgbvhT2JRWyp+oMdDR03khzDJK94ToshkeTk
 4G0plMxDiarrCV4xR/gYmol0Is8iOwF9taSAFsC6cs8sUHVIIXCxABx5az7eDRN60SIU
 YJjt6pR+nQpEwOjHwXk1J7gnJFJ+w3Ikxu+mugBk06csuUZYWI3rBGXZdOvmlov4rgC2
 blfacR41bHNn8fgOvUmHhZ2nkVT+KxKkrEu09lDHA80hzU71Z31xUvkNjeX6+Mz9y7JO
 xjvA==
X-Gm-Message-State: APjAAAVOudEmG8Ny1hG5r7RZhPjjgSYkdGxg9LJQvkMpmbTf7Fpc+wB8
 uNC5tzfnZWCHas9t9Ai6etPL6SJA
X-Google-Smtp-Source: APXvYqxkfrCbkEFHs6ys8MVovWYm5kDAyAUl4ChJK8NhFtWoeGo9fOMepf3HfXP5QDLXM7Hk+U//ug==
X-Received: by 2002:adf:f586:: with SMTP id f6mr69865006wro.46.1582631512863; 
 Tue, 25 Feb 2020 03:51:52 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 050/136] mips/boston: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:40 +0100
Message-Id: <1582631466-13880-50-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Message-Id: <20200219160953.13771-51-imammedo@redhat.com>
---
 hw/mips/boston.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 0df3a77..98ecd25 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -427,7 +427,7 @@ static void boston_mach_init(MachineState *machine)
     DeviceState *dev;
     BostonState *s;
     Error *err = NULL;
-    MemoryRegion *flash, *ddr, *ddr_low_alias, *lcd, *platreg;
+    MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
     MemoryRegion *sys_mem = get_system_memory();
     XilinxPCIEHost *pcie2;
     PCIDevice *ahci;
@@ -473,14 +473,12 @@ static void boston_mach_init(MachineState *machine)
     memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err);
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
 
-    ddr = g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ddr, NULL, "boston.ddr",
-                                         machine->ram_size);
-    memory_region_add_subregion_overlap(sys_mem, 0x80000000, ddr, 0);
+    memory_region_add_subregion_overlap(sys_mem, 0x80000000, machine->ram, 0);
 
     ddr_low_alias = g_new(MemoryRegion, 1);
     memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
-                             ddr, 0, MIN(machine->ram_size, (256 * MiB)));
+                             machine->ram, 0,
+                             MIN(machine->ram_size, (256 * MiB)));
     memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
 
     xilinx_pcie_init(sys_mem, 0,
@@ -552,6 +550,7 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->init = boston_mach_init;
     mc->block_default_type = IF_IDE;
     mc->default_ram_size = 1 * GiB;
+    mc->default_ram_id = "boston.ddr";
     mc->max_cpus = 16;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("I6400");
 }
-- 
1.8.3.1



