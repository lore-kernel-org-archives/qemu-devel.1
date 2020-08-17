Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8511AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA9B2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbjIVt2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA9B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hxo-00005I-9t
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hql-0002A6-2Y
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqj-00053Q-2u
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id 184so14399793wmb.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1//Tp8Y+FSKXFzMM84j0WYQQgWr3vCj2ITEnknuNnJU=;
 b=ZbjIVt2K3/Jg0Mg3/ZIFzG3Enje/uuhxjhp8kj6zL+yArd3KBt1Mxa5pOoL1BNBGeW
 plCbworw5CIzj3kqXCYX0h/uvLlo1m34JK1tNvxHDaFIFlQair7zApSglazw+Nb66QA+
 OKQqg3Ffibgl0glD6aHPxv6xwdmrXkFrpxW6zC3emmZZIVjDFR94TFZN2adrT+bkUl+E
 doIxiWw3uSPoC0nap4QDIXVpw9szWTa9/Weg4Pf5Z2rz9ZMn7uG3XKxfah8bKFQlJEbZ
 gPQkhHg0BTrRzvxlUS9yISZUsF1BZiwCuHss9t7fzjiOxWmjzI7Kz00oPoJM5x7XgNkx
 v53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1//Tp8Y+FSKXFzMM84j0WYQQgWr3vCj2ITEnknuNnJU=;
 b=U7qRNDptjwtT1qfMOOUCJA12qLJIsQgCHKkPGvmk4pucxBaURRL41ZI9dp2nSQM6gn
 VDLybBpNjByV0pgpGGrSwkbXuj7AQsZ4Xl2HYzNWel6ZrMHKHEN83QcHy2DiB58MiytG
 YTCclDBlfW7bJxDyh2IDS4Wy7yRHa1aKU+Wu34/NlMCAUeX/CWMo+EsCE0DhOv72VG4n
 Wl6DTmdattePgkVxdn7z+jTbT68AULXpFvq9BAuT9TroBhgTPc/9habl5NFoiekhHMUR
 9F4454FXxaw/Awsk1zjX3KdntyKNJbzOoKV9AaEGdd365a2jfhmkQmEynu9jM+muLRTJ
 B/ew==
X-Gm-Message-State: AOAM532z04bozRQSdxZoVDFKTdo2mUgESU2UYro/X9Tf+KLncVO3W8/O
 QZDwmeJAb0ceAoZS9GtnxZgDaQ9d28c=
X-Google-Smtp-Source: ABdhPJyKW8SGLXprNshLz2qI4S/+0lnCyY7LP8qfdWH3jP4BxZL+LDlxQ7o5CxoO/gFvvCND2e+VgA==
X-Received: by 2002:a1c:1d84:: with SMTP id
 d126mr15713545wmd.147.1597681142587; 
 Mon, 17 Aug 2020 09:19:02 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm29535472wro.1.2020.08.17.09.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 09:19:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 4/9] hw/misc: Add interleaver device to make interleaved
 memory accesses
Date: Mon, 17 Aug 2020 18:18:48 +0200
Message-Id: <20200817161853.593247-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
References: <20200817161853.593247-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some slow devices might be arranged in an interleaved setup to reduce
waiting for memory banks and improve memory throughput.  Classical
examples are NOR flashes.

Add an 'interleaver' device to allow making such interleaved memory
accesses. This device support using the 16x8, 32x8, 32x16, 64x8,
64x16 and 64x32 configurations.

Example of 32x16 interleaver accesses (32-bit bus, 2x 16-bit banks):

Each interleaved 32-bit access on the bus results in contiguous 16-bit
access on each banked device:

                   ____________________________________________________
 Bus accesses      |        1st 32-bit       |        2nd 32-bit       |
                   -----------------------------------------------------
                          |            |            |            |
                          v            |            v            |
                   ______________      |     ______________      |
 1st bank accesses | 1st 16-bit |      |     | 2nd 16-bit |      |
                   --------------      |     --------------      |
                                       v                         v
                                ______________            ______________
 2nd bank accesses              | 1st 16-bit |            | 2nd 16-bit |
                                --------------            --------------

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
How to simplify idx/addr initialization in the read/write handlers?
---
 include/hw/misc/interleaver.h |  40 ++++++
 hw/misc/interleaver.c         | 254 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                   |   6 +
 hw/misc/Kconfig               |   4 +
 hw/misc/Makefile.objs         |   1 +
 hw/misc/trace-events          |   6 +
 6 files changed, 311 insertions(+)
 create mode 100644 include/hw/misc/interleaver.h
 create mode 100644 hw/misc/interleaver.c

diff --git a/include/hw/misc/interleaver.h b/include/hw/misc/interleaver.h
new file mode 100644
index 0000000000..953d987556
--- /dev/null
+++ b/include/hw/misc/interleaver.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU Interleaver device
+ *
+ * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_INTERLEAVER_H
+#define HW_MISC_INTERLEAVER_H
+
+/*
+ * Example of 32x16 interleaver accesses (32-bit bus, 2x 16-bit banks):
+ *
+ * Each interleaved 32-bit access on the bus results in contiguous 16-bit
+ * access on each banked device:
+ *
+ *                      ____________________________________________________
+ *   Bus accesses       |        1st 32-bit       |        2nd 32-bit       |
+ *                      -----------------------------------------------------
+ *                             |            |            |            |
+ *                             v            |            v            |
+ *                      ______________      |     ______________      |
+ *   1st bank accesses  | 1st 16-bit |      |     | 2nd 16-bit |      |
+ *                      --------------      |     --------------      |
+ *                                          v                         v
+ *                                   ______________            ______________
+ *   2nd bank accesses               | 1st 16-bit |            | 2nd 16-bit |
+ *                                   --------------            --------------
+ */
+
+#define TYPE_INTERLEAVER_16X8_DEVICE    "interleaver-16x8-device"
+#define TYPE_INTERLEAVER_32X8_DEVICE    "interleaver-32x8-device"
+#define TYPE_INTERLEAVER_32X16_DEVICE   "interleaver-32x16-device"
+#define TYPE_INTERLEAVER_64X8_DEVICE    "interleaver-64x8-device"
+#define TYPE_INTERLEAVER_64X16_DEVICE   "interleaver-64x16-device"
+#define TYPE_INTERLEAVER_64X32_DEVICE   "interleaver-64x32-device"
+
+#endif
+
diff --git a/hw/misc/interleaver.c b/hw/misc/interleaver.c
new file mode 100644
index 0000000000..46099e9e11
--- /dev/null
+++ b/hw/misc/interleaver.c
@@ -0,0 +1,254 @@
+/*
+ * QEMU Interleaver device
+ *
+ * The interleaver device to allow making interleaved memory accesses.
+ *
+ * This device support using the following configurations (INPUT x OUTPUT):
+ * 16x8, 32x8, 32x16, 64x8, 64x16 and 64x32.
+ *
+ * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/interleaver.h"
+#include "trace.h"
+
+#define TYPE_INTERLEAVER_DEVICE "interleaver-device"
+
+typedef struct InterleaverDeviceClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    /*< public >*/
+    MemoryRegionOps ops;
+    unsigned input_access_size;
+    unsigned output_access_size;
+    MemOp output_memop;
+    unsigned mr_count;
+    char *name;
+} InterleaverDeviceClass;
+
+#define INTERLEAVER_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(InterleaverDeviceClass, (klass), TYPE_INTERLEAVER_DEVICE)
+#define INTERLEAVER_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(InterleaverDeviceClass, (obj), TYPE_INTERLEAVER_DEVICE)
+
+#define INTERLEAVER_REGIONS_MAX 8 /* 64x8 */
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    MemoryRegion iomem;
+    uint64_t size;
+    MemoryRegion *mr[INTERLEAVER_REGIONS_MAX];
+} InterleaverDeviceState;
+
+#define INTERLEAVER_DEVICE(obj) \
+    OBJECT_CHECK(InterleaverDeviceState, (obj), TYPE_INTERLEAVER_DEVICE)
+
+static const char *memresult_str[] = {"OK", "ERROR", "DECODE_ERROR"};
+
+static const char *emtpy_mr_name = "EMPTY";
+
+static MemTxResult interleaver_read(void *opaque,
+                                    hwaddr offset, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs)
+{
+    InterleaverDeviceState *s = INTERLEAVER_DEVICE(opaque);
+    InterleaverDeviceClass *idc = INTERLEAVER_DEVICE_GET_CLASS(s);
+    unsigned idx = (offset / idc->output_access_size) & (idc->mr_count - 1);
+    hwaddr addr = (offset & ~(idc->input_access_size - 1)) / idc->mr_count;
+    MemTxResult r = MEMTX_ERROR;
+
+    trace_interleaver_read_enter(idc->input_access_size,
+                                 idc->output_access_size, size,
+                                 idc->mr_count, idx,
+                                 s->mr[idx] ? memory_region_name(s->mr[idx])
+                                            : emtpy_mr_name,
+                                 offset, addr);
+    if (s->mr[idx]) {
+        r = memory_region_dispatch_read(s->mr[idx],
+                                        addr,
+                                        data,
+                                        idc->output_memop,
+                                        attrs);
+    }
+    trace_interleaver_read_exit(size, *data, memresult_str[r]);
+
+    return r;
+}
+
+static MemTxResult interleaver_write(void *opaque,
+                                     hwaddr offset, uint64_t data,
+                                     unsigned size, MemTxAttrs attrs)
+{
+    InterleaverDeviceState *s = INTERLEAVER_DEVICE(opaque);
+    InterleaverDeviceClass *idc = INTERLEAVER_DEVICE_GET_CLASS(s);
+    unsigned idx = (offset / idc->output_access_size) & (idc->mr_count - 1);
+    hwaddr addr = (offset & ~(idc->input_access_size - 1)) / idc->mr_count;
+    MemTxResult r = MEMTX_ERROR;
+
+    trace_interleaver_write_enter(idc->input_access_size,
+                                  idc->output_access_size, size,
+                                  idc->mr_count, idx,
+                                  s->mr[idx] ? memory_region_name(s->mr[idx])
+                                             : emtpy_mr_name,
+                                  offset, addr);
+    if (s->mr[idx]) {
+        r = memory_region_dispatch_write(s->mr[idx],
+                                         addr,
+                                         data,
+                                         idc->output_memop,
+                                         attrs);
+    }
+    trace_interleaver_write_exit(size, data, memresult_str[r]);
+
+    return r;
+}
+
+static void interleaver_realize(DeviceState *dev, Error **errp)
+{
+    InterleaverDeviceState *s = INTERLEAVER_DEVICE(dev);
+    InterleaverDeviceClass *idc = INTERLEAVER_DEVICE_GET_CLASS(dev);
+    uint64_t expected_mr_size;
+
+    if (s->size == 0) {
+        error_setg(errp, "property 'size' not specified or zero");
+        return;
+    }
+    if (!QEMU_IS_ALIGNED(s->size, idc->input_access_size)) {
+        error_setg(errp, "property 'size' must be multiple of %u",
+                   idc->input_access_size);
+        return;
+    }
+
+    expected_mr_size = s->size / idc->mr_count;
+    for (unsigned i = 0; i < idc->mr_count; i++) {
+        if (s->mr[i] && memory_region_size(s->mr[i]) != expected_mr_size) {
+            error_setg(errp,
+                       "memory region #%u (%s) size mismatches interleaver",
+                       i, memory_region_name(s->mr[i]));
+            return;
+        }
+    }
+    memory_region_init_io(&s->iomem, OBJECT(s), &idc->ops, s,
+                          idc->name, s->size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static Property interleaver_properties[] = {
+    DEFINE_PROP_UINT64("size", InterleaverDeviceState, size, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void interleaver_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = interleaver_realize;
+    device_class_set_props(dc, interleaver_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static void interleaver_class_add_properties(ObjectClass *oc,
+                                             unsigned input_bits,
+                                             unsigned output_bits)
+{
+    InterleaverDeviceClass *idc = INTERLEAVER_DEVICE_CLASS(oc);
+
+    idc->name = g_strdup_printf("interleaver-%ux%u", input_bits, output_bits);
+    idc->input_access_size = input_bits >> 3;
+    idc->output_access_size = output_bits >> 3;
+    idc->output_memop = size_memop(idc->output_access_size);
+    idc->mr_count = input_bits / output_bits;
+    idc->ops = (MemoryRegionOps){
+        .read_with_attrs = interleaver_read,
+        .write_with_attrs = interleaver_write,
+        .valid.min_access_size = 1,
+        .valid.max_access_size = idc->input_access_size,
+        .impl.min_access_size = idc->output_access_size,
+        .impl.max_access_size = idc->output_access_size,
+        .endianness = DEVICE_NATIVE_ENDIAN,
+    };
+
+    for (unsigned i = 0; i < idc->mr_count; i++) {
+        g_autofree char *name = g_strdup_printf("mr%u", i);
+        object_class_property_add_link(oc, name, TYPE_MEMORY_REGION,
+                                       offsetof(InterleaverDeviceState, mr[i]),
+                                       qdev_prop_allow_set_link_before_realize,
+                                       OBJ_PROP_LINK_STRONG);
+    }
+}
+
+static void interleaver_16x8_class_init(ObjectClass *oc, void *data)
+{
+    interleaver_class_add_properties(oc, 16, 8);
+};
+
+static void interleaver_32x8_class_init(ObjectClass *oc, void *data)
+{
+    interleaver_class_add_properties(oc, 32, 8);
+};
+
+static void interleaver_32x16_class_init(ObjectClass *oc, void *data)
+{
+    interleaver_class_add_properties(oc, 32, 16);
+};
+
+static void interleaver_64x8_class_init(ObjectClass *oc, void *data)
+{
+    interleaver_class_add_properties(oc, 64, 8);
+};
+
+static void interleaver_64x16_class_init(ObjectClass *oc, void *data)
+{
+    interleaver_class_add_properties(oc, 64, 16);
+};
+
+static void interleaver_64x32_class_init(ObjectClass *oc, void *data)
+{
+    interleaver_class_add_properties(oc, 64, 32);
+};
+
+static const TypeInfo interleaver_device_types[] = {
+    {
+        .name           = TYPE_INTERLEAVER_16X8_DEVICE,
+        .parent         = TYPE_INTERLEAVER_DEVICE,
+        .class_init     = interleaver_16x8_class_init,
+    }, {
+        .name           = TYPE_INTERLEAVER_32X8_DEVICE,
+        .parent         = TYPE_INTERLEAVER_DEVICE,
+        .class_init     = interleaver_32x8_class_init,
+    }, {
+        .name           = TYPE_INTERLEAVER_32X16_DEVICE,
+        .parent         = TYPE_INTERLEAVER_DEVICE,
+        .class_init     = interleaver_32x16_class_init,
+    }, {
+        .name           = TYPE_INTERLEAVER_64X8_DEVICE,
+        .parent         = TYPE_INTERLEAVER_DEVICE,
+        .class_init     = interleaver_64x8_class_init,
+    }, {
+        .name           = TYPE_INTERLEAVER_64X16_DEVICE,
+        .parent         = TYPE_INTERLEAVER_DEVICE,
+        .class_init     = interleaver_64x16_class_init,
+    }, {
+        .name           = TYPE_INTERLEAVER_64X32_DEVICE,
+        .parent         = TYPE_INTERLEAVER_DEVICE,
+        .class_init     = interleaver_64x32_class_init,
+    }, {
+        .name           = TYPE_INTERLEAVER_DEVICE,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(InterleaverDeviceState),
+        .class_size     = sizeof(InterleaverDeviceClass),
+        .class_init     = interleaver_class_init,
+        .abstract       = true,
+    }
+};
+
+DEFINE_TYPES(interleaver_device_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b..1efce3dd27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1961,6 +1961,12 @@ S: Maintained
 F: include/hw/misc/empty_slot.h
 F: hw/misc/empty_slot.c
 
+Interleaver device
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Maintained
+F: include/hw/misc/interleaver.h
+F: hw/misc/interleaver.c
+
 Standard VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 92c397ca07..7ed0f4ccc7 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -21,6 +21,10 @@ config SGA
     bool
     depends on ISA_BUS
 
+config INTERLEAVER
+    bool
+    default y
+
 config ISA_TESTDEV
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 6be3d255ab..aa753a847f 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -12,6 +12,7 @@ common-obj-$(CONFIG_PCA9552) += pca9552.o
 common-obj-$(CONFIG_UNIMP) += unimp.o
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
+common-obj-$(CONFIG_INTERLEAVER) += interleaver.o
 
 # ARM devices
 common-obj-$(CONFIG_PL310) += arm_l2x0.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 066752aa90..1b0db146b4 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -217,3 +217,9 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
 # pca9552.c
 pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
 pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
+
+# interleaver.c
+interleaver_read_enter(unsigned input_access_size, unsigned output_access_size, unsigned size, unsigned mr_count, unsigned index, const char *mr_name, uint64_t in_addr, uint64_t out_addr) "rd ixs:%u oxs:%u sz:%u mr_cnt:%u mr_idx:%u mr_name:'%s' iadr:0x%"PRIx64" oadr:0x%"PRIx64
+interleaver_read_exit(unsigned size, uint64_t value, const char *result) "rd size:%u value:0x%08"PRIx64" result: %s"
+interleaver_write_enter(unsigned input_access_size, unsigned output_access_size, unsigned size, unsigned mr_count, unsigned index, const char *mr_name, uint64_t in_addr, uint64_t out_addr) "wr ixs:%u oxs:%u sz:%u mr_cnt:%u mr_idx:%u mr_name:'%s' iadr:0x%"PRIx64" oadr:0x%"PRIx64
+interleaver_write_exit(unsigned size, uint64_t value, const char *result) "wr size:%u value:0x%08"PRIx64" result: %s"
-- 
2.26.2


