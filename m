Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1F7C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6734F21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4VAQ500"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YnR-0005tt-9u
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkG-0000Eq-AT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkB-0005jO-E2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:32858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkB-0005SW-2k
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:19 -0500
Received: by mail-wm1-x329.google.com with SMTP id m10so2051510wmc.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k0lJWq7Wuwhp8fp4WNPc7Xb1+avMNgYektyhtqNBVM0=;
 b=U4VAQ500Fqk9DVveAMV73iX6qNAH3bLLijXAY8lSq8dQT2sQdlCEMTMPPI1AvKGLCc
 opd7S4CYacYYhUCnYRYnMsPUj73rJjZ2Wga5gSlpcOJNC9k2OPSgoAisoI+q/gWM+x7Q
 VszyZ4fzMoVHPHQccrPEMv5dZGkEYjIR9wezFfjIgzxWFhBbO+QFQaNRksjiwjOwAjIn
 ewTw0JEcaa55XUWNqhGJDP2tyKViAP1soV+n5+TBmmGrJzlhh/wopJ+y6wsblt0lVpEn
 PmpPdk2enyluPF5xonj2DCn3qPwcrb6vXig9hu6Llfxg7yFawxtPg5xMZD+IPbmmibem
 iVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=k0lJWq7Wuwhp8fp4WNPc7Xb1+avMNgYektyhtqNBVM0=;
 b=XpjeTXRqdt5YmRrumgC3VLOrOPuy60B+DYxCUhqDLp2g5EMLy5PLfSkVMcgkb/0RSE
 loQfO8gECXu2cFfupT2au8EiqBgCQJx2u/OF10R/fI2lNVEohey+6Z90ib3JVz25RBmX
 Hdd8Ltk0iINbwvDXpLTUfcZPW5h8gCT/i9xPrGKRwsWEDF1osyHyrH6FNJCHber7giTN
 54kqjkCZ4nt3/YemMmmO3MLJzATRD+oaljbasTEmDZ562qHd0EYEI8wnxkvOtgU6vi6/
 bRPBoS0UgFjXvt4uuUhqMqQUfsKCht9toJc1I8ehjPGkHpGz3OzGiYb1vZy5r7RDDKWa
 lUZA==
X-Gm-Message-State: APjAAAUgJgsGvYqEUF6Jl0RiNuE/+paeM2NsB3UxfyiXHFcRmW9CF0cm
 maK3tWaVwHtakVvSpl4suFQS5pRb
X-Google-Smtp-Source: APXvYqxU7xMYJPcMQaX7t8q7CgiHIWbYB1JQUVzek8w7xFpgytok51b1EisuqMR2e/xoRvNPF3/B6w==
X-Received: by 2002:a05:600c:3d1:: with SMTP id
 z17mr5149100wmd.90.1582631473928; 
 Tue, 25 Feb 2020 03:51:13 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 008/136] alpha/dp264: use memdev for RAM
Date: Tue, 25 Feb 2020 12:48:58 +0100
Message-Id: <1582631466-13880-8-git-send-email-pbonzini@redhat.com>
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
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-9-imammedo@redhat.com>
---
 hw/alpha/alpha_sys.h | 2 +-
 hw/alpha/dp264.c     | 3 ++-
 hw/alpha/typhoon.c   | 8 ++------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 95033d7..bc0a286 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -11,7 +11,7 @@
 #include "hw/intc/i8259.h"
 
 
-PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *, AlphaCPU *[4],
+PCIBus *typhoon_init(MemoryRegion *, ISABus **, qemu_irq *, AlphaCPU *[4],
                      pci_map_irq_fn);
 
 /* alpha_pci.c.  */
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index a8f9a89..8d71a30 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -75,7 +75,7 @@ static void clipper_init(MachineState *machine)
     cpus[0]->env.trap_arg2 = smp_cpus;
 
     /* Init the chipset.  */
-    pci_bus = typhoon_init(ram_size, &isa_bus, &rtc_irq, cpus,
+    pci_bus = typhoon_init(machine->ram, &isa_bus, &rtc_irq, cpus,
                            clipper_pci_map_irq);
 
     /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
@@ -183,6 +183,7 @@ static void clipper_machine_init(MachineClass *mc)
     mc->max_cpus = 4;
     mc->is_default = 1;
     mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
+    mc->default_ram_id = "ram";
 }
 
 DEFINE_MACHINE("clipper", clipper_machine_init)
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 179e1f7..1795e2f 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -58,7 +58,6 @@ typedef struct TyphoonState {
     TyphoonCchip cchip;
     TyphoonPchip pchip;
     MemoryRegion dchip_region;
-    MemoryRegion ram_region;
 } TyphoonState;
 
 /* Called when one of DRIR or DIM changes.  */
@@ -817,8 +816,7 @@ static void typhoon_alarm_timer(void *opaque)
     cpu_interrupt(CPU(s->cchip.cpu[cpu]), CPU_INTERRUPT_TIMER);
 }
 
-PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
-                     qemu_irq *p_rtc_irq,
+PCIBus *typhoon_init(MemoryRegion *ram, ISABus **isa_bus, qemu_irq *p_rtc_irq,
                      AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq)
 {
     MemoryRegion *addr_space = get_system_memory();
@@ -851,9 +849,7 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
 
     /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
        but the address space hole reserved at this point is 8TB.  */
-    memory_region_allocate_system_memory(&s->ram_region, OBJECT(s), "ram",
-                                         ram_size);
-    memory_region_add_subregion(addr_space, 0, &s->ram_region);
+    memory_region_add_subregion(addr_space, 0, ram);
 
     /* TIGbus, 0x801.0000.0000, 1GB.  */
     /* ??? The TIGbus is used for delivering interrupts, and access to
-- 
1.8.3.1



