Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E2AC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4B82133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4B82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjWef-0008JU-Ap
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54819)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjWUX-0007CO-25
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjWUS-0003F4-Ts
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:15:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjWUP-0003DQ-7v
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:15:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7CE2A81F13;
 Fri,  5 Jul 2019 22:15:27 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02349189E3;
 Fri,  5 Jul 2019 22:15:26 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Fri,  5 Jul 2019 19:14:27 -0300
Message-Id: <20190705221504.25166-6-ehabkost@redhat.com>
In-Reply-To: <20190705221504.25166-1-ehabkost@redhat.com>
References: <20190705221504.25166-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 05 Jul 2019 22:15:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v6 05/42] hw/riscv: Replace global smp variables
 with machine smp properties
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
Cc: Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Like Xu <like.xu@linux.intel.com>

The global smp variables in riscv are replaced with smp machine properties.

A local variable of the same name would be introduced in the declaration
phase if it's used widely in the context OR replace it on the spot if it's
only used once. No semantic changes.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190518205428.90532-6-like.xu@linux.intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
[ehabkost: fix spike_board_init()]
[ehabkost: fix riscv_sifive_e_soc_init()]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/riscv/sifive_e.c    |  6 ++++--
 hw/riscv/sifive_plic.c |  3 +++
 hw/riscv/sifive_u.c    | 11 +++++++----
 hw/riscv/spike.c       |  3 +++
 hw/riscv/virt.c        |  1 +
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index d27f626529..2a499d8ed2 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -124,6 +124,7 @@ static void riscv_sifive_e_init(MachineState *machine)
 
 static void riscv_sifive_e_soc_init(Object *obj)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveESoCState *s = RISCV_E_SOC(obj);
 
     object_initialize_child(obj, "cpus", &s->cpus,
@@ -131,7 +132,7 @@ static void riscv_sifive_e_soc_init(Object *obj)
                             &error_abort, NULL);
     object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
                             &error_abort);
-    object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
     sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
                           &s->gpio, sizeof(s->gpio),
@@ -140,6 +141,7 @@ static void riscv_sifive_e_soc_init(Object *obj)
 
 static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     const struct MemmapEntry *memmap = sifive_e_memmap;
     Error *err = NULL;
 
@@ -168,7 +170,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_E_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_E_PLIC].size);
     sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
-        memmap[SIFIVE_E_CLINT].size, smp_cpus,
+        memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 70a4413599..0950e89e15 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -24,6 +24,7 @@
 #include "qemu/error-report.h"
 #include "hw/sysbus.h"
 #include "hw/pci/msi.h"
+#include "hw/boards.h"
 #include "target/riscv/cpu.h"
 #include "sysemu/sysemu.h"
 #include "hw/riscv/sifive_plic.h"
@@ -439,6 +440,8 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int smp_cpus = ms->smp.cpus;
     SiFivePLICState *plic = SIFIVE_PLIC(dev);
     int i;
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 4208671552..ca53a9290d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -315,13 +315,14 @@ static void riscv_sifive_u_init(MachineState *machine)
 
 static void riscv_sifive_u_soc_init(Object *obj)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
 
     object_initialize_child(obj, "cpus", &s->cpus, sizeof(s->cpus),
                             TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
     object_property_set_str(OBJECT(&s->cpus), SIFIVE_U_CPU, "cpu-type",
                             &error_abort);
-    object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
 
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
@@ -330,6 +331,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
 
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(dev);
     const struct MemmapEntry *memmap = sifive_u_memmap;
     MemoryRegion *system_memory = get_system_memory();
@@ -351,9 +353,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
                                 mask_rom);
 
     /* create PLIC hart topology configuration string */
-    plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) * smp_cpus;
+    plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
+                           ms->smp.cpus;
     plic_hart_config = g_malloc0(plic_hart_config_len);
-    for (i = 0; i < smp_cpus; i++) {
+    for (i = 0; i < ms->smp.cpus; i++) {
         if (i != 0) {
             strncat(plic_hart_config, ",", plic_hart_config_len);
         }
@@ -379,7 +382,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
-        memmap[SIFIVE_U_CLINT].size, smp_cpus,
+        memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
 
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index e68be00a5f..2991b341a2 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -159,6 +159,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     int i;
+    unsigned int smp_cpus = machine->smp.cpus;
 
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
@@ -241,6 +242,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     int i;
+    unsigned int smp_cpus = machine->smp.cpus;
 
     if (!qtest_enabled()) {
         info_report("The Spike v1.10.0 machine has been deprecated. "
@@ -329,6 +331,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     int i;
+    unsigned int smp_cpus = machine->smp.cpus;
 
     if (!qtest_enabled()) {
         info_report("The Spike v1.09.1 machine has been deprecated. "
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d8181a4ff1..ecdc77d728 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -371,6 +371,7 @@ static void riscv_virt_board_init(MachineState *machine)
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
+    unsigned int smp_cpus = machine->smp.cpus;
     void *fdt;
 
     /* Initialize SOC */
-- 
2.18.0.rc1.1.g3f1ff2140


