Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23FDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B906D20774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsBlCEjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B906D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6LjT-0001io-Px
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgJ-00051l-Bg
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51186
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgH-0002qo-7i
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVD7+kGLthr8W/hX8sm8asqnL2c9WGxhll07LQUausE=;
 b=QsBlCEjIjZBhopmVkotu+eYv0jfYe5vmo04DUxUIvrbJHrZWfCVuTDUpZK7hhran0WfmXx
 QFM/vVRiun4+EUvJl0KAtp3EgmXc2Eac0hBWq0etxnLjZznCxOoWYdmiTxYYQjBuCvYtG5
 rOGfUb6/jA9CdvyEdoFP+tQ44qc9AT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-3hnE6lp5Mt-NdWkFxXO28Q-1; Thu, 13 Aug 2020 18:26:38 -0400
X-MC-Unique: 3hnE6lp5Mt-NdWkFxXO28Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07FF557083
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:26:38 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6DAD10021AA;
 Thu, 13 Aug 2020 22:26:37 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/41] sifive_e: Rename memmap enum constants
Date: Thu, 13 Aug 2020 18:25:53 -0400
Message-Id: <20200813222625.243136-10-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 18:26:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the enum constant names conflict with the QOM type check
macros.  This needs to be addressed to allow us to transform the
QOM type check macros into functions generated by
OBJECT_DECLARE_TYPE().

Rename all the constants to SIFIVE_E_DEV_*, to avoid conflicts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/riscv/sifive_e.h | 38 ++++++++---------
 hw/riscv/sifive_e.c         | 82 ++++++++++++++++++-------------------
 2 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 637414130b..7c2eb70189 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -53,25 +53,25 @@ typedef struct SiFiveEState {
     OBJECT_CHECK(SiFiveEState, (obj), TYPE_RISCV_E_MACHINE)
 
 enum {
-    SIFIVE_E_DEBUG,
-    SIFIVE_E_MROM,
-    SIFIVE_E_OTP,
-    SIFIVE_E_CLINT,
-    SIFIVE_E_PLIC,
-    SIFIVE_E_AON,
-    SIFIVE_E_PRCI,
-    SIFIVE_E_OTP_CTRL,
-    SIFIVE_E_GPIO0,
-    SIFIVE_E_UART0,
-    SIFIVE_E_QSPI0,
-    SIFIVE_E_PWM0,
-    SIFIVE_E_UART1,
-    SIFIVE_E_QSPI1,
-    SIFIVE_E_PWM1,
-    SIFIVE_E_QSPI2,
-    SIFIVE_E_PWM2,
-    SIFIVE_E_XIP,
-    SIFIVE_E_DTIM
+    SIFIVE_E_DEV_DEBUG,
+    SIFIVE_E_DEV_MROM,
+    SIFIVE_E_DEV_OTP,
+    SIFIVE_E_DEV_CLINT,
+    SIFIVE_E_DEV_PLIC,
+    SIFIVE_E_DEV_AON,
+    SIFIVE_E_DEV_PRCI,
+    SIFIVE_E_DEV_OTP_CTRL,
+    SIFIVE_E_DEV_GPIO0,
+    SIFIVE_E_DEV_UART0,
+    SIFIVE_E_DEV_QSPI0,
+    SIFIVE_E_DEV_PWM0,
+    SIFIVE_E_DEV_UART1,
+    SIFIVE_E_DEV_QSPI1,
+    SIFIVE_E_DEV_PWM1,
+    SIFIVE_E_DEV_QSPI2,
+    SIFIVE_E_DEV_PWM2,
+    SIFIVE_E_DEV_XIP,
+    SIFIVE_E_DEV_DTIM
 };
 
 enum {
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index c8b060486a..88b4524117 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -54,25 +54,25 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } sifive_e_memmap[] = {
-    [SIFIVE_E_DEBUG] =    {        0x0,     0x1000 },
-    [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
-    [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
-    [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
-    [SIFIVE_E_PLIC] =     {  0xc000000,  0x4000000 },
-    [SIFIVE_E_AON] =      { 0x10000000,     0x8000 },
-    [SIFIVE_E_PRCI] =     { 0x10008000,     0x8000 },
-    [SIFIVE_E_OTP_CTRL] = { 0x10010000,     0x1000 },
-    [SIFIVE_E_GPIO0] =    { 0x10012000,     0x1000 },
-    [SIFIVE_E_UART0] =    { 0x10013000,     0x1000 },
-    [SIFIVE_E_QSPI0] =    { 0x10014000,     0x1000 },
-    [SIFIVE_E_PWM0] =     { 0x10015000,     0x1000 },
-    [SIFIVE_E_UART1] =    { 0x10023000,     0x1000 },
-    [SIFIVE_E_QSPI1] =    { 0x10024000,     0x1000 },
-    [SIFIVE_E_PWM1] =     { 0x10025000,     0x1000 },
-    [SIFIVE_E_QSPI2] =    { 0x10034000,     0x1000 },
-    [SIFIVE_E_PWM2] =     { 0x10035000,     0x1000 },
-    [SIFIVE_E_XIP] =      { 0x20000000, 0x20000000 },
-    [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
+    [SIFIVE_E_DEV_DEBUG] =    {        0x0,     0x1000 },
+    [SIFIVE_E_DEV_MROM] =     {     0x1000,     0x2000 },
+    [SIFIVE_E_DEV_OTP] =      {    0x20000,     0x2000 },
+    [SIFIVE_E_DEV_CLINT] =    {  0x2000000,    0x10000 },
+    [SIFIVE_E_DEV_PLIC] =     {  0xc000000,  0x4000000 },
+    [SIFIVE_E_DEV_AON] =      { 0x10000000,     0x8000 },
+    [SIFIVE_E_DEV_PRCI] =     { 0x10008000,     0x8000 },
+    [SIFIVE_E_DEV_OTP_CTRL] = { 0x10010000,     0x1000 },
+    [SIFIVE_E_DEV_GPIO0] =    { 0x10012000,     0x1000 },
+    [SIFIVE_E_DEV_UART0] =    { 0x10013000,     0x1000 },
+    [SIFIVE_E_DEV_QSPI0] =    { 0x10014000,     0x1000 },
+    [SIFIVE_E_DEV_PWM0] =     { 0x10015000,     0x1000 },
+    [SIFIVE_E_DEV_UART1] =    { 0x10023000,     0x1000 },
+    [SIFIVE_E_DEV_QSPI1] =    { 0x10024000,     0x1000 },
+    [SIFIVE_E_DEV_PWM1] =     { 0x10025000,     0x1000 },
+    [SIFIVE_E_DEV_QSPI2] =    { 0x10034000,     0x1000 },
+    [SIFIVE_E_DEV_PWM2] =     { 0x10035000,     0x1000 },
+    [SIFIVE_E_DEV_XIP] =      { 0x20000000, 0x20000000 },
+    [SIFIVE_E_DEV_DTIM] =     { 0x80000000,     0x4000 }
 };
 
 static void sifive_e_machine_init(MachineState *machine)
@@ -90,9 +90,9 @@ static void sifive_e_machine_init(MachineState *machine)
 
     /* Data Tightly Integrated Memory */
     memory_region_init_ram(main_mem, NULL, "riscv.sifive.e.ram",
-        memmap[SIFIVE_E_DTIM].size, &error_fatal);
+        memmap[SIFIVE_E_DEV_DTIM].size, &error_fatal);
     memory_region_add_subregion(sys_mem,
-        memmap[SIFIVE_E_DTIM].base, main_mem);
+        memmap[SIFIVE_E_DEV_DTIM].base, main_mem);
 
     /* Mask ROM reset vector */
     uint32_t reset_vec[4];
@@ -111,7 +111,7 @@ static void sifive_e_machine_init(MachineState *machine)
         reset_vec[i] = cpu_to_le32(reset_vec[i]);
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[SIFIVE_E_MROM].base, &address_space_memory);
+                          memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
 
     if (machine->kernel_filename) {
         riscv_load_kernel(machine->kernel_filename, NULL);
@@ -194,12 +194,12 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     /* Mask ROM */
     memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.e.mrom",
-                           memmap[SIFIVE_E_MROM].size, &error_fatal);
+                           memmap[SIFIVE_E_DEV_MROM].size, &error_fatal);
     memory_region_add_subregion(sys_mem,
-        memmap[SIFIVE_E_MROM].base, &s->mask_rom);
+        memmap[SIFIVE_E_DEV_MROM].base, &s->mask_rom);
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
+    s->plic = sifive_plic_create(memmap[SIFIVE_E_DEV_PLIC].base,
         (char *)SIFIVE_E_PLIC_HART_CONFIG,
         SIFIVE_E_PLIC_NUM_SOURCES,
         SIFIVE_E_PLIC_NUM_PRIORITIES,
@@ -209,13 +209,13 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_E_PLIC_ENABLE_STRIDE,
         SIFIVE_E_PLIC_CONTEXT_BASE,
         SIFIVE_E_PLIC_CONTEXT_STRIDE,
-        memmap[SIFIVE_E_PLIC].size);
-    sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
-        memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
+        memmap[SIFIVE_E_DEV_PLIC].size);
+    sifive_clint_create(memmap[SIFIVE_E_DEV_CLINT].base,
+        memmap[SIFIVE_E_DEV_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
     create_unimplemented_device("riscv.sifive.e.aon",
-        memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
-    sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
+        memmap[SIFIVE_E_DEV_AON].base, memmap[SIFIVE_E_DEV_AON].size);
+    sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
 
     /* GPIO */
 
@@ -224,7 +224,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* Map GPIO registers */
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_E_GPIO0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_E_DEV_GPIO0].base);
 
     /* Pass all GPIOs to the SOC layer so they are available to the board */
     qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
@@ -236,27 +236,27 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
                                             SIFIVE_E_GPIO0_IRQ0 + i));
     }
 
-    sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART0].base,
+    sifive_uart_create(sys_mem, memmap[SIFIVE_E_DEV_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART0_IRQ));
     create_unimplemented_device("riscv.sifive.e.qspi0",
-        memmap[SIFIVE_E_QSPI0].base, memmap[SIFIVE_E_QSPI0].size);
+        memmap[SIFIVE_E_DEV_QSPI0].base, memmap[SIFIVE_E_DEV_QSPI0].size);
     create_unimplemented_device("riscv.sifive.e.pwm0",
-        memmap[SIFIVE_E_PWM0].base, memmap[SIFIVE_E_PWM0].size);
-    sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
+        memmap[SIFIVE_E_DEV_PWM0].base, memmap[SIFIVE_E_DEV_PWM0].size);
+    sifive_uart_create(sys_mem, memmap[SIFIVE_E_DEV_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART1_IRQ));
     create_unimplemented_device("riscv.sifive.e.qspi1",
-        memmap[SIFIVE_E_QSPI1].base, memmap[SIFIVE_E_QSPI1].size);
+        memmap[SIFIVE_E_DEV_QSPI1].base, memmap[SIFIVE_E_DEV_QSPI1].size);
     create_unimplemented_device("riscv.sifive.e.pwm1",
-        memmap[SIFIVE_E_PWM1].base, memmap[SIFIVE_E_PWM1].size);
+        memmap[SIFIVE_E_DEV_PWM1].base, memmap[SIFIVE_E_DEV_PWM1].size);
     create_unimplemented_device("riscv.sifive.e.qspi2",
-        memmap[SIFIVE_E_QSPI2].base, memmap[SIFIVE_E_QSPI2].size);
+        memmap[SIFIVE_E_DEV_QSPI2].base, memmap[SIFIVE_E_DEV_QSPI2].size);
     create_unimplemented_device("riscv.sifive.e.pwm2",
-        memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
+        memmap[SIFIVE_E_DEV_PWM2].base, memmap[SIFIVE_E_DEV_PWM2].size);
 
     /* Flash memory */
     memory_region_init_rom(&s->xip_mem, OBJECT(dev), "riscv.sifive.e.xip",
-                           memmap[SIFIVE_E_XIP].size, &error_fatal);
-    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
+                           memmap[SIFIVE_E_DEV_XIP].size, &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_DEV_XIP].base,
         &s->xip_mem);
 }
 
-- 
2.26.2


