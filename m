Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFAEC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2853E206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyUkp5c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2853E206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57565 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iguAM-0005Bb-KL
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFl-000604-6N
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFj-0000e8-GT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFi-0000aa-UH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:47 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so7387450wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=914j6MirFIAAslC9qwRboSB8yki3fnRLVnUJgjrXmO8=;
 b=lyUkp5c7Lne393/319qeAyhClO0cMXXmh55uXKCd4CEg25xzI06dOAl9skFL/YC8Ql
 hy6FInTfIeCRxcwAZ11+hwqJfeRB5e9w7i08GuMCvnquZGdqzQfa8K65WUCzNAvVNxlK
 otvTeFOTN8DYkGj53FkseZjhvMtsNBAKp1x7Ld9gqGVqmogcId/HmLe6JDk2NYNCQZ1e
 TSzGU2M7UT07eojbmYgKTqkzK1xLEPbEMHvgdfKDk1IwjV5puj27lzSMx0gI9OOKQobu
 f1tePfOvFFpRO5yaJkTnE2sAtRkVwWCx4RduvOdYkSMG4j3dXmcFQ92o5Z06xKxzfB9m
 eVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=914j6MirFIAAslC9qwRboSB8yki3fnRLVnUJgjrXmO8=;
 b=PDHuf6NOp2FvDQQ6GMWRjYV92k4AVPSMegB865lSItNB5sCparyWUeTmvMZc7ITyyM
 AecZpGGuJSmbEEddPkmxaL3Ej1922QQeaj6bu2lfvoZ9P1z7iXiHR+xmcXeUnOWS/DQz
 wNFqpkiyp0PJkNcB8cR/6f1CljdfO7LTEhKVk4EPE4mtnZtSl0caRjFPtlD5X1yG35sw
 5BZBdRV2gDU62Wa4c8Padu/52CAXsjU199+TDM/l4HVGPSY3jHBWjPqeWfIiNOmyopQr
 NyvZJAyoCHAWeRicYUxWXXfe9suodNqjah/kxtqUHkutgMU9hO+ZMfiUega893KxKmxf
 SUPw==
X-Gm-Message-State: APjAAAWBnlcVQUIvq5bsm5uTWQ5y7OCPz6UZ/R8fRSJGeCWFGoxS1xvC
 DZHmv22ftByIXdlRioYIRmlA0eGx
X-Google-Smtp-Source: APXvYqyCcJQuQgveclWALQ/xEVbHYjI3PKM9tS2jzXgxnRnd9WHKkpzQmNXtO/nGzsuNszUkBymDMA==
X-Received: by 2002:a1c:3c45:: with SMTP id j66mr12986410wma.2.1576513785675; 
 Mon, 16 Dec 2019 08:29:45 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 58/62] hw/i386/pc: Extract the port92 device
Date: Mon, 16 Dec 2019 17:28:42 +0100
Message-Id: <1576513726-53700-59-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

This device is only used by the PC machines. The pc.c file is
already big enough, with 2255 lines. By removing 113 lines of
it, we reduced it by 5%. It is now a bit easier to navigate
the file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Makefile.objs |   1 +
 hw/i386/pc.c          | 113 --------------------------------------------
 hw/i386/port92.c      | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/trace-events  |   2 +-
 include/hw/i386/pc.h  |   3 ++
 5 files changed, 131 insertions(+), 114 deletions(-)
 create mode 100644 hw/i386/port92.c

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 1236c3b..8ce1b26 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -13,6 +13,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
+obj-$(CONFIG_PC) += port92.o
 
 obj-y += kvmvapic.o
 obj-$(CONFIG_PC) += acpi-build.o
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 963eff4..298ab10 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -670,119 +670,6 @@ void pc_cmos_init(PCMachineState *pcms,
     qemu_register_reset(pc_cmos_init_late, &arg);
 }
 
-#define TYPE_PORT92 "port92"
-#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
-
-/* port 92 stuff: could be split off */
-typedef struct Port92State {
-    ISADevice parent_obj;
-
-    MemoryRegion io;
-    uint8_t outport;
-    qemu_irq a20_out;
-} Port92State;
-
-static void port92_write(void *opaque, hwaddr addr, uint64_t val,
-                         unsigned size)
-{
-    Port92State *s = opaque;
-    int oldval = s->outport;
-
-    trace_port92_write(val);
-    s->outport = val;
-    qemu_set_irq(s->a20_out, (val >> 1) & 1);
-    if ((val & 1) && !(oldval & 1)) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
-static uint64_t port92_read(void *opaque, hwaddr addr,
-                            unsigned size)
-{
-    Port92State *s = opaque;
-    uint32_t ret;
-
-    ret = s->outport;
-    trace_port92_read(ret);
-    return ret;
-}
-
-static const VMStateDescription vmstate_port92_isa = {
-    .name = "port92",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8(outport, Port92State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void port92_reset(DeviceState *d)
-{
-    Port92State *s = PORT92(d);
-
-    s->outport &= ~1;
-}
-
-static const MemoryRegionOps port92_ops = {
-    .read = port92_read,
-    .write = port92_write,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void port92_initfn(Object *obj)
-{
-    Port92State *s = PORT92(obj);
-
-    memory_region_init_io(&s->io, OBJECT(s), &port92_ops, s, "port92", 1);
-
-    s->outport = 0;
-
-    qdev_init_gpio_out_named(DEVICE(obj), &s->a20_out, PORT92_A20_LINE, 1);
-}
-
-static void port92_realizefn(DeviceState *dev, Error **errp)
-{
-    ISADevice *isadev = ISA_DEVICE(dev);
-    Port92State *s = PORT92(dev);
-
-    isa_register_ioport(isadev, &s->io, 0x92);
-}
-
-static void port92_class_initfn(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = port92_realizefn;
-    dc->reset = port92_reset;
-    dc->vmsd = &vmstate_port92_isa;
-    /*
-     * Reason: unlike ordinary ISA devices, this one needs additional
-     * wiring: its A20 output line needs to be wired up with
-     * qdev_connect_gpio_out_named().
-     */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo port92_info = {
-    .name          = TYPE_PORT92,
-    .parent        = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(Port92State),
-    .instance_init = port92_initfn,
-    .class_init    = port92_class_initfn,
-};
-
-static void port92_register_types(void)
-{
-    type_register_static(&port92_info);
-}
-
-type_init(port92_register_types)
-
 static void handle_a20_line_change(void *opaque, int irq, int level)
 {
     X86CPU *cpu = opaque;
diff --git a/hw/i386/port92.c b/hw/i386/port92.c
new file mode 100644
index 0000000..19866c4
--- /dev/null
+++ b/hw/i386/port92.c
@@ -0,0 +1,126 @@
+/*
+ * QEMU I/O port 0x92 (System Control Port A, to handle Fast Gate A20)
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/runstate.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/i386/pc.h"
+#include "trace.h"
+
+#define PORT92(obj) OBJECT_CHECK(Port92State, (obj), TYPE_PORT92)
+
+typedef struct Port92State {
+    ISADevice parent_obj;
+
+    MemoryRegion io;
+    uint8_t outport;
+    qemu_irq a20_out;
+} Port92State;
+
+static void port92_write(void *opaque, hwaddr addr, uint64_t val,
+                         unsigned size)
+{
+    Port92State *s = opaque;
+    int oldval = s->outport;
+
+    trace_port92_write(val);
+    s->outport = val;
+    qemu_set_irq(s->a20_out, (val >> 1) & 1);
+    if ((val & 1) && !(oldval & 1)) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+static uint64_t port92_read(void *opaque, hwaddr addr,
+                            unsigned size)
+{
+    Port92State *s = opaque;
+    uint32_t ret;
+
+    ret = s->outport;
+    trace_port92_read(ret);
+
+    return ret;
+}
+
+static const VMStateDescription vmstate_port92_isa = {
+    .name = "port92",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(outport, Port92State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void port92_reset(DeviceState *d)
+{
+    Port92State *s = PORT92(d);
+
+    s->outport &= ~1;
+}
+
+static const MemoryRegionOps port92_ops = {
+    .read = port92_read,
+    .write = port92_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void port92_initfn(Object *obj)
+{
+    Port92State *s = PORT92(obj);
+
+    memory_region_init_io(&s->io, OBJECT(s), &port92_ops, s, "port92", 1);
+
+    s->outport = 0;
+
+    qdev_init_gpio_out_named(DEVICE(obj), &s->a20_out, PORT92_A20_LINE, 1);
+}
+
+static void port92_realizefn(DeviceState *dev, Error **errp)
+{
+    ISADevice *isadev = ISA_DEVICE(dev);
+    Port92State *s = PORT92(dev);
+
+    isa_register_ioport(isadev, &s->io, 0x92);
+}
+
+static void port92_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = port92_realizefn;
+    dc->reset = port92_reset;
+    dc->vmsd = &vmstate_port92_isa;
+    /*
+     * Reason: unlike ordinary ISA devices, this one needs additional
+     * wiring: its A20 output line needs to be wired up with
+     * qdev_connect_gpio_out_named().
+     */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo port92_info = {
+    .name          = TYPE_PORT92,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(Port92State),
+    .instance_init = port92_initfn,
+    .class_init    = port92_class_initfn,
+};
+
+static void port92_register_types(void)
+{
+    type_register_static(&port92_info);
+}
+
+type_init(port92_register_types)
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index a9b6437..e48bef2 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -116,6 +116,6 @@ vmport_command(unsigned char command) "command: 0x%02x"
 x86_gsi_interrupt(int irqn, int level) "GSI interrupt #%d level:%d"
 x86_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
 
-# pc.c
+# port92.c
 port92_read(uint8_t val) "port92: read 0x%02x"
 port92_write(uint8_t val) "port92: write 0x%02x"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e512838..230e2c9 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -196,8 +196,11 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 ISADevice *pc_find_fdc0(void);
 int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
+/* port92.c */
 #define PORT92_A20_LINE "a20"
 
+#define TYPE_PORT92 "port92"
+
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
-- 
1.8.3.1



