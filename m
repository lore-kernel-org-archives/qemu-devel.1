Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9EAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD4E206FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuT3Xgjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD4E206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbBXS-0007YR-DO
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 18:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbBVm-0006Bu-Lk
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 18:51:18 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbBVj-0004Xh-Es
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 18:51:18 -0500
Received: by mail-wm1-x344.google.com with SMTP id 23so1899033wmg.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5LIhaFgUhyoIXXqpYlZHKoo2I0ctX3FWm0zLqbLaZR8=;
 b=RuT3XgjfLsS3vn1uK/kYT3Xks3sM8n44z6hdvbmiHZC9SrEpIsCP5gXvBV7kMLpxZX
 u3RP9TiPqNtgnlbwr04eN10sYvsXb98fr/+4pjFT0uNtEc895XptLKbJR0VYe5PFbbK+
 CzwpGgbsZpJEVQXL8bQiov1WpiZC+0srwmHh8eJUgSEVQussX0MgvqbnCtKyJ+dmCSxg
 RkKJ3yxWX1dCimmZRIoaV4yEqC24Lp8ocEIThgXiogYd1r0BXbjA+TQbCuJ8GelnD4C9
 izjDQG7jF5ixlpJR+s8+9A3SjMKy/s0xTNs69cg7CtJkY7bvfKj0p6D16UJ+GfIWHSTs
 Jwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5LIhaFgUhyoIXXqpYlZHKoo2I0ctX3FWm0zLqbLaZR8=;
 b=HystVigNwo3BSrVdH16riAwbiTVAAf/hQHIpFUVi5ZYSXlV6sqVqhKAwh3N1I4UTAT
 l8Jmgu5M4jHcSwgZ1HOzp4kxAFiLYu81FHhYU7zZlvF6dJTwVHSTOyQZBJRhY6xUDoQu
 EleILOm9aeT0WEyNLBIeSVeVHh7dfnDVk1meP3BpOWWqX29w/MKo30rxxAYNC91mFrL6
 HqF9Ujqta4m9LRiBtROQUODXhRZz8SPVkPlvCGZYDwdDIxkkrIZcT8vvdgHKf6n32B0B
 PJY0BO1g7dIcaavRUG29kL2kzxctO2DjbQ/WqhtbbciYo1dyKkNf+mnt+p0wRQH8r9/6
 kT4Q==
X-Gm-Message-State: AOAM5323+JGnmUkleGmKsFtWpp9t8U0/V8SxKohjQKmcTRq0+F2ANua1
 T1b4xW02a5aJmVcIwkgkqCgLyOY39oQRaw==
X-Google-Smtp-Source: ABdhPJzLw7VYBko0GhT3rIMgrfZ0Y3mgq1Mq8DHKrepJtbWlhE0PmvSj+QzqKYdkG9b2zqR2MWYB7Q==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr1977752wmc.24.1604706673831; 
 Fri, 06 Nov 2020 15:51:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n8sm4025374wmc.11.2020.11.06.15.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 15:51:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/m68k/q800.c: Make the GLUE chip an actual QOM device
Date: Fri,  6 Nov 2020 23:51:09 +0000
Message-Id: <20201106235109.7066-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106235109.7066-1-peter.maydell@linaro.org>
References: <20201106235109.7066-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The handling of the GLUE (General Logic Unit) device is
currently open-coded. Make this into a proper QOM device.

This minor piece of modernisation gets rid of the free
floating qemu_irq array 'pic', which Coverity points out
is technically leaked when we exit the machine init function.
(The replacement glue device is not leaked because it gets
added to the sysbus, so it's accessible via that.)

Fixes: Coverity CID 1421883
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/m68k/q800.c | 82 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 12 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index dc13007aaf2..05bb372f958 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -47,6 +47,7 @@
 #include "sysemu/qtest.h"
 #include "sysemu/runstate.h"
 #include "sysemu/reset.h"
+#include "migration/vmstate.h"
 
 #define MACROM_ADDR     0x40800000
 #define MACROM_SIZE     0x00100000
@@ -94,10 +95,14 @@
  * CPU.
  */
 
-typedef struct {
+#define TYPE_GLUE "q800-glue"
+OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
+
+struct GLUEState {
+    SysBusDevice parent_obj;
     M68kCPU *cpu;
     uint8_t ipr;
-} GLUEState;
+};
 
 static void GLUE_set_irq(void *opaque, int irq, int level)
 {
@@ -119,6 +124,58 @@ static void GLUE_set_irq(void *opaque, int irq, int level)
     m68k_set_irq_level(s->cpu, 0, 0);
 }
 
+static void glue_reset(DeviceState *dev)
+{
+    GLUEState *s = GLUE(dev);
+
+    s->ipr = 0;
+}
+
+static const VMStateDescription vmstate_glue = {
+    .name = "q800-glue",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(ipr, GLUEState),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+/*
+ * If the m68k CPU implemented its inbound irq lines as GPIO lines
+ * rather than via the m68k_set_irq_level() function we would not need
+ * this cpu link property and could instead provide outbound IRQ lines
+ * that the board could wire up to the CPU.
+ */
+static Property glue_properties[] = {
+    DEFINE_PROP_LINK("cpu", GLUEState, cpu, TYPE_M68K_CPU, M68kCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void glue_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+
+    qdev_init_gpio_in(dev, GLUE_set_irq, 8);
+}
+
+static void glue_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_glue;
+    dc->reset = glue_reset;
+    device_class_set_props(dc, glue_properties);
+}
+
+static const TypeInfo glue_info = {
+    .name = TYPE_GLUE,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(GLUEState),
+    .instance_init = glue_init,
+    .class_init = glue_class_init,
+};
+
 static void main_cpu_reset(void *opaque)
 {
     M68kCPU *cpu = opaque;
@@ -178,8 +235,7 @@ static void q800_init(MachineState *machine)
     SysBusDevice *sysbus;
     BusState *adb_bus;
     NubusBus *nubus;
-    GLUEState *irq;
-    qemu_irq *pic;
+    DeviceState *glue;
     DriveInfo *dinfo;
 
     linux_boot = (kernel_filename != NULL);
@@ -213,10 +269,9 @@ static void q800_init(MachineState *machine)
     }
 
     /* IRQ Glue */
-
-    irq = g_new0(GLUEState, 1);
-    irq->cpu = cpu;
-    pic = qemu_allocate_irqs(GLUE_set_irq, irq, 8);
+    glue = qdev_new(TYPE_GLUE);
+    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
 
     /* VIA */
 
@@ -228,8 +283,10 @@ static void q800_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(via_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, VIA_BASE);
-    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0, pic[0]);
-    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1, pic[1]);
+    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0,
+                                qdev_get_gpio_in(glue, 0));
+    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1,
+                                qdev_get_gpio_in(glue, 1));
 
 
     adb_bus = qdev_get_child_bus(via_dev, "adb.0");
@@ -270,7 +327,7 @@ static void q800_init(MachineState *machine)
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, SONIC_BASE);
     sysbus_mmio_map(sysbus, 1, SONIC_PROM_BASE);
-    sysbus_connect_irq(sysbus, 0, pic[2]);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, 2));
 
     /* SCC */
 
@@ -292,7 +349,7 @@ static void q800_init(MachineState *machine)
     qdev_realize_and_unref(escc_orgate, NULL, &error_fatal);
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
     sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
-    qdev_connect_gpio_out(DEVICE(escc_orgate), 0, pic[3]);
+    qdev_connect_gpio_out(DEVICE(escc_orgate), 0, qdev_get_gpio_in(glue, 3));
     sysbus_mmio_map(sysbus, 0, SCC_BASE);
 
     /* SCSI */
@@ -457,6 +514,7 @@ static const TypeInfo q800_machine_typeinfo = {
 static void q800_machine_register_types(void)
 {
     type_register_static(&q800_machine_typeinfo);
+    type_register_static(&glue_info);
 }
 
 type_init(q800_machine_register_types)
-- 
2.20.1


