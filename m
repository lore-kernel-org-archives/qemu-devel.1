Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197A6C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DED421707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VY3d0j4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DED421707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOGE-0003rG-4j
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNI2-0002bl-MC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNHu-0006FM-8j
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sloVRPETwUCBYkORpAu5wQoBRshr64vcAyJgldtMwJI=;
 b=VY3d0j4Skl5MH/xjL+VOjK3kHXW8giatAtOZjrkH48ZDti6kelXOWrERlcW7wOlIY8cp1n
 i3dM5/vHRI6hb7v/HmaWMObtPRrQrET1U/8exDdUQ24QHcUHMfbOiZnH7j6A/n+HJgL5P8
 VhirQYA4JAjkOUzdiYUZKr2BuKFPDYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-1H13snLzPxWc0m2G2rYCag-1; Fri, 18 Sep 2020 16:47:17 -0400
X-MC-Unique: 1H13snLzPxWc0m2G2rYCag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0F031084C94;
 Fri, 18 Sep 2020 20:47:16 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 726785DEC1;
 Fri, 18 Sep 2020 20:47:16 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 01/17] sifive_e: Rename memmap enum constants
Date: Fri, 18 Sep 2020 16:46:58 -0400
Message-Id: <20200918204714.27276-2-ehabkost@redhat.com>
In-Reply-To: <20200918204714.27276-1-ehabkost@redhat.com>
References: <20200918204714.27276-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the enum constant names conflict with a QOM type check
macro (SIFIVE_E_PRCI).  This needs to be addressed to allow us to
transform the QOM type check macros into functions generated by
OBJECT_DECLARE_TYPE().

Rename all the constants to SIFIVE_E_DEV_*, to avoid conflicts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200911173447.165713-2-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/riscv/sifive_e.h | 38 ++++++++---------
 hw/riscv/sifive_e.c         | 82 ++++++++++++++++++-------------------
 2 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index b1400843c2..83604da805 100644
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
index 40bbf530d4..759059cd7b 100644
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
@@ -195,12 +195,12 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
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
         (char *)SIFIVE_E_PLIC_HART_CONFIG, 0,
         SIFIVE_E_PLIC_NUM_SOURCES,
         SIFIVE_E_PLIC_NUM_PRIORITIES,
@@ -210,14 +210,14 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_E_PLIC_ENABLE_STRIDE,
         SIFIVE_E_PLIC_CONTEXT_BASE,
         SIFIVE_E_PLIC_CONTEXT_STRIDE,
-        memmap[SIFIVE_E_PLIC].size);
-    sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
-        memmap[SIFIVE_E_CLINT].size, 0, ms->smp.cpus,
+        memmap[SIFIVE_E_DEV_PLIC].size);
+    sifive_clint_create(memmap[SIFIVE_E_DEV_CLINT].base,
+        memmap[SIFIVE_E_DEV_CLINT].size, 0, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
         SIFIVE_CLINT_TIMEBASE_FREQ, false);
     create_unimplemented_device("riscv.sifive.e.aon",
-        memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
-    sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
+        memmap[SIFIVE_E_DEV_AON].base, memmap[SIFIVE_E_DEV_AON].size);
+    sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
 
     /* GPIO */
 
@@ -226,7 +226,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* Map GPIO registers */
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_E_GPIO0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_E_DEV_GPIO0].base);
 
     /* Pass all GPIOs to the SOC layer so they are available to the board */
     qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
@@ -238,27 +238,27 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
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


