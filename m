Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F2DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8639320650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK68BejZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8639320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfAj-0005mG-Cb
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjA-0008E7-O7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj5-0007oh-6k
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdj4-0007oD-W5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:31 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n15so15445328wrw.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=icQSYq8suoWhdg2fa8gVI133nwoWV8pjrk93eMBlBGA=;
 b=MK68BejZ3Z4nC9UHBcYRZ5UWNJLCX4Waik0vNKfwOyZxiQZPRYj7VUkyC4O1Xm38Fu
 F3OEdrkZrSFU/W5yQZ0QASkYXDchj2moAWCExsUOYmhvXBlHwR7FqO2N7XUU8kk4Cl9T
 M4lFN7Ew7cRermDhITObQRqXrANBIe8RV5034bmlm2rD2zomYmD7kMYTxF1qRxaBWRE4
 P09R5K79otV5hNVqlveA3tgTMsnh7qpwenLg3rclyjBsli74Rgd7D/ZctyKcADmxzyt9
 iY1oOu842ETnWp3lsMu1yj3fX7dfBrvL+4nfjPFNJo+ZrIVcusVQQlAAbSDbHbPgH/O2
 b1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=icQSYq8suoWhdg2fa8gVI133nwoWV8pjrk93eMBlBGA=;
 b=h5eYMQMWNjXbpAXJdgCSi4qrv5gxobbTSxkzLkTJO4ygkaQQK78UxqG07j1S2ZIiPO
 mpMdaOhXKWZMNP3TOv3ZOJStt4SaJvfknkShlr78mHkHonVpyKTdC5umbVgC7MG5w+Si
 Pdwp2EZP0kK7qNWAJuPU848iY4lBPVMZ1jEMXaQwOf5zRslmpguxnOaCGoDB7Zdf20RA
 FM7EwJwthO6Etong1n0pbKIOGQTykZiuCHiEyaEVBEnSec+CaXd2vs0XKDzlKuc8tEVX
 duRRRJ2+SOTRRIk965+m4Oq5/CxS4gMztnG4DrKSik2Or/ues/onYNXy7dmT7BHzM3kW
 JE/g==
X-Gm-Message-State: APjAAAV6YTz1FobCcjbSDE8cd9bCr2xd2rl2n04oytPW2AU6nL2a99Y4
 IB0TT00DtosmcR+3k728Mw6j9MyZ
X-Google-Smtp-Source: APXvYqz0P1zbGWLOsz0D0UkdH9BEmAQ9ZTHJSDdmJjDvQ0hSVxEa/dBbWCVK+NJbpElfZHqIVibzpw==
X-Received: by 2002:adf:afef:: with SMTP id y47mr2132655wrd.190.1571925869593; 
 Thu, 24 Oct 2019 07:04:29 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/39] hw/i386/pc: Extract pc_i8259_create()
Date: Thu, 24 Oct 2019 16:03:45 +0200
Message-Id: <1571925835-31930-30-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The i8259 creation code is common to all PC machines, extract the
common code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191018135910.24286-5-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 19 +++++++++++++++++++
 hw/i386/pc_piix.c    | 13 +------------
 hw/i386/pc_q35.c     | 14 +-------------
 include/hw/i386/pc.h |  1 +
 4 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e8a54ac..5fce60c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1474,6 +1474,25 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     rom_reset_order_override();
 }
 
+void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
+{
+    qemu_irq *i8259;
+
+    if (kvm_pic_in_kernel()) {
+        i8259 = kvm_i8259_init(isa_bus);
+    } else if (xen_enabled()) {
+        i8259 = xen_interrupt_controller_init();
+    } else {
+        i8259 = i8259_init(isa_bus, pc_allocate_cpu_irq());
+    }
+
+    for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
+        i8259_irqs[i] = i8259[i];
+    }
+
+    g_free(i8259);
+}
+
 void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
 {
     DeviceState *dev;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0cc951a..648dc9a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -82,7 +82,6 @@ static void pc_init1(MachineState *machine,
     ISABus *isa_bus;
     PCII440FXState *i440fx_state;
     int piix3_devfn = -1;
-    qemu_irq *i8259;
     qemu_irq smi_irq;
     GSIState *gsi_state;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
@@ -209,18 +208,8 @@ static void pc_init1(MachineState *machine,
     }
     isa_bus_irqs(isa_bus, x86ms->gsi);
 
-    if (kvm_pic_in_kernel()) {
-        i8259 = kvm_i8259_init(isa_bus);
-    } else if (xen_enabled()) {
-        i8259 = xen_interrupt_controller_init();
-    } else {
-        i8259 = i8259_init(isa_bus, pc_allocate_cpu_irq());
-    }
+    pc_i8259_create(isa_bus, gsi_state->i8259_irq);
 
-    for (i = 0; i < ISA_NUM_IRQS; i++) {
-        gsi_state->i8259_irq[i] = i8259[i];
-    }
-    g_free(i8259);
     if (pcmc->pci_enabled) {
         ioapic_init_gsi(gsi_state, "i440fx");
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6cf12b7..157d1da 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -130,7 +130,6 @@ static void pc_q35_init(MachineState *machine)
     MemoryRegion *ram_memory;
     GSIState *gsi_state;
     ISABus *isa_bus;
-    qemu_irq *i8259;
     int i;
     ICH9LPCState *ich9_lpc;
     PCIDevice *ahci;
@@ -257,18 +256,7 @@ static void pc_q35_init(MachineState *machine)
     pci_bus_set_route_irq_fn(host_bus, ich9_route_intx_pin_to_irq);
     isa_bus = ich9_lpc->isa_bus;
 
-    if (kvm_pic_in_kernel()) {
-        i8259 = kvm_i8259_init(isa_bus);
-    } else if (xen_enabled()) {
-        i8259 = xen_interrupt_controller_init();
-    } else {
-        i8259 = i8259_init(isa_bus, pc_allocate_cpu_irq());
-    }
-
-    for (i = 0; i < ISA_NUM_IRQS; i++) {
-        gsi_state->i8259_irq[i] = i8259[i];
-    }
-    g_free(i8259);
+    pc_i8259_create(isa_bus, gsi_state->i8259_irq);
 
     if (pcmc->pci_enabled) {
         ioapic_init_gsi(gsi_state, "q35");
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 8c5dc39..5923318 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -219,6 +219,7 @@ void pc_pci_device_init(PCIBus *pci_bus);
 
 typedef void (*cpu_set_smm_t)(int smm, void *arg);
 
+void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
 
 ISADevice *pc_find_fdc0(void);
-- 
1.8.3.1



