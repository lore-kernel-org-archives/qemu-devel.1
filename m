Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B29C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E87D20774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAah6QgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E87D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Lje-000204-BA
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgP-0005FD-Cl
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40670
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgM-0002sW-Pt
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uJ92zRj9a4meXcYlHpFSNbmsAKdO0wNsqFL6QMwY6I=;
 b=ZAah6QgDKLA5fxrJItKM2GHWbjOEyBiJAGH5kHwL5AghuAsre/shK9N8+ShxIeuUXpgTmt
 /HKsOYsFKI43ZmsrqtBmGxNE9b3SZOr8KaKJ6fizIInw7CV9RH3x6tVEJ+6wiKJ2Pd/eUg
 VWsyr1C65Mq7KZzpV+qSdKwCr4j7lwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-mwiQ6ObXMZOca5TpIsh83Q-1; Thu, 13 Aug 2020 18:26:42 -0400
X-MC-Unique: mwiQ6ObXMZOca5TpIsh83Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15A19800688
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:26:37 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF92360C04;
 Thu, 13 Aug 2020 22:26:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/41] opentitan: Rename memmap enum constants
Date: Thu, 13 Aug 2020 18:25:52 -0400
Message-Id: <20200813222625.243136-9-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 18:26:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename all the constants to IBEX_DEV_*, to avoid conflicts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/riscv/opentitan.h | 38 ++++++++--------
 hw/riscv/opentitan.c         | 84 ++++++++++++++++++------------------
 2 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 8f29b9cbbf..835a80f896 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -49,25 +49,25 @@ typedef struct OpenTitanState {
 } OpenTitanState;
 
 enum {
-    IBEX_ROM,
-    IBEX_RAM,
-    IBEX_FLASH,
-    IBEX_UART,
-    IBEX_GPIO,
-    IBEX_SPI,
-    IBEX_FLASH_CTRL,
-    IBEX_RV_TIMER,
-    IBEX_AES,
-    IBEX_HMAC,
-    IBEX_PLIC,
-    IBEX_PWRMGR,
-    IBEX_RSTMGR,
-    IBEX_CLKMGR,
-    IBEX_PINMUX,
-    IBEX_ALERT_HANDLER,
-    IBEX_NMI_GEN,
-    IBEX_USBDEV,
-    IBEX_PADCTRL,
+    IBEX_DEV_ROM,
+    IBEX_DEV_RAM,
+    IBEX_DEV_FLASH,
+    IBEX_DEV_UART,
+    IBEX_DEV_GPIO,
+    IBEX_DEV_SPI,
+    IBEX_DEV_FLASH_CTRL,
+    IBEX_DEV_RV_TIMER,
+    IBEX_DEV_AES,
+    IBEX_DEV_HMAC,
+    IBEX_DEV_PLIC,
+    IBEX_DEV_PWRMGR,
+    IBEX_DEV_RSTMGR,
+    IBEX_DEV_CLKMGR,
+    IBEX_DEV_PINMUX,
+    IBEX_DEV_ALERT_HANDLER,
+    IBEX_DEV_NMI_GEN,
+    IBEX_DEV_USBDEV,
+    IBEX_DEV_PADCTRL,
 };
 
 enum {
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index a8f0039e51..23ba3b4bfc 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -32,25 +32,25 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } ibex_memmap[] = {
-    [IBEX_ROM] =            {  0x00008000, 16 * KiB },
-    [IBEX_RAM] =            {  0x10000000,  0x10000 },
-    [IBEX_FLASH] =          {  0x20000000,  0x80000 },
-    [IBEX_UART] =           {  0x40000000,  0x10000 },
-    [IBEX_GPIO] =           {  0x40010000,  0x10000 },
-    [IBEX_SPI] =            {  0x40020000,  0x10000 },
-    [IBEX_FLASH_CTRL] =     {  0x40030000,  0x10000 },
-    [IBEX_PINMUX] =         {  0x40070000,  0x10000 },
-    [IBEX_RV_TIMER] =       {  0x40080000,  0x10000 },
-    [IBEX_PLIC] =           {  0x40090000,  0x10000 },
-    [IBEX_PWRMGR] =         {  0x400A0000,  0x10000 },
-    [IBEX_RSTMGR] =         {  0x400B0000,  0x10000 },
-    [IBEX_CLKMGR] =         {  0x400C0000,  0x10000 },
-    [IBEX_AES] =            {  0x40110000,  0x10000 },
-    [IBEX_HMAC] =           {  0x40120000,  0x10000 },
-    [IBEX_ALERT_HANDLER] =  {  0x40130000,  0x10000 },
-    [IBEX_NMI_GEN] =        {  0x40140000,  0x10000 },
-    [IBEX_USBDEV] =         {  0x40150000,  0x10000 },
-    [IBEX_PADCTRL] =        {  0x40160000,  0x10000 }
+    [IBEX_DEV_ROM] =            {  0x00008000, 16 * KiB },
+    [IBEX_DEV_RAM] =            {  0x10000000,  0x10000 },
+    [IBEX_DEV_FLASH] =          {  0x20000000,  0x80000 },
+    [IBEX_DEV_UART] =           {  0x40000000,  0x10000 },
+    [IBEX_DEV_GPIO] =           {  0x40010000,  0x10000 },
+    [IBEX_DEV_SPI] =            {  0x40020000,  0x10000 },
+    [IBEX_DEV_FLASH_CTRL] =     {  0x40030000,  0x10000 },
+    [IBEX_DEV_PINMUX] =         {  0x40070000,  0x10000 },
+    [IBEX_DEV_RV_TIMER] =       {  0x40080000,  0x10000 },
+    [IBEX_DEV_PLIC] =           {  0x40090000,  0x10000 },
+    [IBEX_DEV_PWRMGR] =         {  0x400A0000,  0x10000 },
+    [IBEX_DEV_RSTMGR] =         {  0x400B0000,  0x10000 },
+    [IBEX_DEV_CLKMGR] =         {  0x400C0000,  0x10000 },
+    [IBEX_DEV_AES] =            {  0x40110000,  0x10000 },
+    [IBEX_DEV_HMAC] =           {  0x40120000,  0x10000 },
+    [IBEX_DEV_ALERT_HANDLER] =  {  0x40130000,  0x10000 },
+    [IBEX_DEV_NMI_GEN] =        {  0x40140000,  0x10000 },
+    [IBEX_DEV_USBDEV] =         {  0x40150000,  0x10000 },
+    [IBEX_DEV_PADCTRL] =        {  0x40160000,  0x10000 }
 };
 
 static void opentitan_board_init(MachineState *machine)
@@ -66,12 +66,12 @@ static void opentitan_board_init(MachineState *machine)
     qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
     memory_region_init_ram(main_mem, NULL, "riscv.lowrisc.ibex.ram",
-        memmap[IBEX_RAM].size, &error_fatal);
+        memmap[IBEX_DEV_RAM].size, &error_fatal);
     memory_region_add_subregion(sys_mem,
-        memmap[IBEX_RAM].base, main_mem);
+        memmap[IBEX_DEV_RAM].base, main_mem);
 
     if (machine->firmware) {
-        riscv_load_firmware(machine->firmware, memmap[IBEX_RAM].base, NULL);
+        riscv_load_firmware(machine->firmware, memmap[IBEX_DEV_RAM].base, NULL);
     }
 
     if (machine->kernel_filename) {
@@ -115,28 +115,28 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* Boot ROM */
     memory_region_init_rom(&s->rom, OBJECT(dev_soc), "riscv.lowrisc.ibex.rom",
-                           memmap[IBEX_ROM].size, &error_fatal);
+                           memmap[IBEX_DEV_ROM].size, &error_fatal);
     memory_region_add_subregion(sys_mem,
-        memmap[IBEX_ROM].base, &s->rom);
+        memmap[IBEX_DEV_ROM].base, &s->rom);
 
     /* Flash memory */
     memory_region_init_rom(&s->flash_mem, OBJECT(dev_soc), "riscv.lowrisc.ibex.flash",
-                           memmap[IBEX_FLASH].size, &error_fatal);
-    memory_region_add_subregion(sys_mem, memmap[IBEX_FLASH].base,
+                           memmap[IBEX_DEV_FLASH].size, &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[IBEX_DEV_FLASH].base,
                                 &s->flash_mem);
 
     /* PLIC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->plic), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->plic), 0, memmap[IBEX_PLIC].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->plic), 0, memmap[IBEX_DEV_PLIC].base);
 
     /* UART */
     qdev_prop_set_chr(DEVICE(&(s->uart)), "chardev", serial_hd(0));
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart), 0, memmap[IBEX_UART].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart), 0, memmap[IBEX_DEV_UART].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart),
                        0, qdev_get_gpio_in(DEVICE(&s->plic),
                        IBEX_UART_TX_WATERMARK_IRQ));
@@ -151,33 +151,33 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
                        IBEX_UART_RX_OVERFLOW_IRQ));
 
     create_unimplemented_device("riscv.lowrisc.ibex.gpio",
-        memmap[IBEX_GPIO].base, memmap[IBEX_GPIO].size);
+        memmap[IBEX_DEV_GPIO].base, memmap[IBEX_DEV_GPIO].size);
     create_unimplemented_device("riscv.lowrisc.ibex.spi",
-        memmap[IBEX_SPI].base, memmap[IBEX_SPI].size);
+        memmap[IBEX_DEV_SPI].base, memmap[IBEX_DEV_SPI].size);
     create_unimplemented_device("riscv.lowrisc.ibex.flash_ctrl",
-        memmap[IBEX_FLASH_CTRL].base, memmap[IBEX_FLASH_CTRL].size);
+        memmap[IBEX_DEV_FLASH_CTRL].base, memmap[IBEX_DEV_FLASH_CTRL].size);
     create_unimplemented_device("riscv.lowrisc.ibex.rv_timer",
-        memmap[IBEX_RV_TIMER].base, memmap[IBEX_RV_TIMER].size);
+        memmap[IBEX_DEV_RV_TIMER].base, memmap[IBEX_DEV_RV_TIMER].size);
     create_unimplemented_device("riscv.lowrisc.ibex.pwrmgr",
-        memmap[IBEX_PWRMGR].base, memmap[IBEX_PWRMGR].size);
+        memmap[IBEX_DEV_PWRMGR].base, memmap[IBEX_DEV_PWRMGR].size);
     create_unimplemented_device("riscv.lowrisc.ibex.rstmgr",
-        memmap[IBEX_RSTMGR].base, memmap[IBEX_RSTMGR].size);
+        memmap[IBEX_DEV_RSTMGR].base, memmap[IBEX_DEV_RSTMGR].size);
     create_unimplemented_device("riscv.lowrisc.ibex.clkmgr",
-        memmap[IBEX_CLKMGR].base, memmap[IBEX_CLKMGR].size);
+        memmap[IBEX_DEV_CLKMGR].base, memmap[IBEX_DEV_CLKMGR].size);
     create_unimplemented_device("riscv.lowrisc.ibex.aes",
-        memmap[IBEX_AES].base, memmap[IBEX_AES].size);
+        memmap[IBEX_DEV_AES].base, memmap[IBEX_DEV_AES].size);
     create_unimplemented_device("riscv.lowrisc.ibex.hmac",
-        memmap[IBEX_HMAC].base, memmap[IBEX_HMAC].size);
+        memmap[IBEX_DEV_HMAC].base, memmap[IBEX_DEV_HMAC].size);
     create_unimplemented_device("riscv.lowrisc.ibex.pinmux",
-        memmap[IBEX_PINMUX].base, memmap[IBEX_PINMUX].size);
+        memmap[IBEX_DEV_PINMUX].base, memmap[IBEX_DEV_PINMUX].size);
     create_unimplemented_device("riscv.lowrisc.ibex.alert_handler",
-        memmap[IBEX_ALERT_HANDLER].base, memmap[IBEX_ALERT_HANDLER].size);
+        memmap[IBEX_DEV_ALERT_HANDLER].base, memmap[IBEX_DEV_ALERT_HANDLER].size);
     create_unimplemented_device("riscv.lowrisc.ibex.nmi_gen",
-        memmap[IBEX_NMI_GEN].base, memmap[IBEX_NMI_GEN].size);
+        memmap[IBEX_DEV_NMI_GEN].base, memmap[IBEX_DEV_NMI_GEN].size);
     create_unimplemented_device("riscv.lowrisc.ibex.usbdev",
-        memmap[IBEX_USBDEV].base, memmap[IBEX_USBDEV].size);
+        memmap[IBEX_DEV_USBDEV].base, memmap[IBEX_DEV_USBDEV].size);
     create_unimplemented_device("riscv.lowrisc.ibex.padctrl",
-        memmap[IBEX_PADCTRL].base, memmap[IBEX_PADCTRL].size);
+        memmap[IBEX_DEV_PADCTRL].base, memmap[IBEX_DEV_PADCTRL].size);
 }
 
 static void lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
-- 
2.26.2


