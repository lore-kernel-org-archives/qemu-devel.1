Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D32EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDE5207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="l3xl0wwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDE5207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAMha-0001iL-M1
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 20:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3olhEXwsKCmUKVNLQQHPRHQJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--hskinnemoen.bounces.google.com>)
 id 1kAMel-0004PE-6b
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:17:44 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:44295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3olhEXwsKCmUKVNLQQHPRHQJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--hskinnemoen.bounces.google.com>)
 id 1kAMei-00068q-4h
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:17:42 -0400
Received: by mail-pg1-x549.google.com with SMTP id 130so6390113pga.11
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc:content-transfer-encoding;
 bh=EjZpIuq+eVTSZ1GsEJOqpPj5iZwCnZXTRJVF6pR0tIM=;
 b=l3xl0wwEINXdhet4BFyHtkdecAb/TJZrtYNoZtvy07CtiXy6WHDMvTqNfb1VQJqw2t
 bDlxjvD82e1dzYN1oJFmJD7EQErqsx6IW+HwP0yZ8473YnKwfE0JAsj5jZhI9TguoaM/
 bYtVXjsk4+NZUWHriBrPYkc+zNVNZKs79is7fX/cTQeT7MmTEn8U64bUmxGtGT8wZ8Qg
 lWziRN7VGqB8SWTSNMZmjJRanV+AJH/QZ3ONnZt48Ex42YZqINHJr1KVk46wxRvP+MLu
 QZaqJHs1BQFixmxiHvniD46Zdty6urxwldnzAOgCSxnvevCyOnnSdzG9iJat5swdP3y5
 YHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=EjZpIuq+eVTSZ1GsEJOqpPj5iZwCnZXTRJVF6pR0tIM=;
 b=YKZLBVX7WpysR5iAnt2rs9cqw6Exz8q2s18lAuod+bEIhmKxjgP0X7GkLVknKmUldV
 srS9fxCnHJ8DFxaKxodhKEoKWQ+LWLr2X7dBC9sMiqItljSGwdfpv5oBg1dl24RCzry8
 hdcY6c2DSSVLV0MkMYnA10mqxUc27vw/J7LiijWhirKqao0z7P6amzOGFr+JKhMgMr0m
 4yW0zIYBaUiwsYv1bF5NKBSDvRDey1hO9mEaxw7c3lnrOruhZk9AhIf+oRp0HCY1VrL2
 oLTnP+NUqGSVdRKPHyvmg/+9xGomkgujQjw2v8QoLAw3TuQEvjaBu+SpGlMOGUwwcWig
 Py9A==
X-Gm-Message-State: AOAM531csFIkfkl4wFbk6sMRXKRsvVPkrSgq2R02aJlYbR771gPRpw0x
 uwS6RicaNwdl8enwOnOdezl2mAlKUpU2YgJfZg==
X-Google-Smtp-Source: ABdhPJz9orohdTYyuMwWORjpdxAnGiC1rAZsY4uMT1vLYM1PT1qHiRJ5iuso/HqGXubegTCsOXDXdAhe82+TPPuZZQ==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a63:d907:: with SMTP id
 r7mr4914299pgg.160.1598314658166; Mon, 24 Aug 2020 17:17:38 -0700 (PDT)
Date: Mon, 24 Aug 2020 17:17:06 -0700
In-Reply-To: <20200825001711.1340443-1-hskinnemoen@google.com>
Message-Id: <20200825001711.1340443-10-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200825001711.1340443-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v8 09/14] hw/mem: Stubbed out NPCM7xx Memory Controller model
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3olhEXwsKCmUKVNLQQHPRHQJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--hskinnemoen.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This just implements the bare minimum to cause the boot block to skip
memory initialization.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 include/hw/arm/npcm7xx.h    |  2 +
 include/hw/mem/npcm7xx_mc.h | 36 ++++++++++++++++
 hw/arm/npcm7xx.c            |  6 +++
 hw/mem/npcm7xx_mc.c         | 84 +++++++++++++++++++++++++++++++++++++
 hw/mem/meson.build          |  1 +
 5 files changed, 129 insertions(+)
 create mode 100644 include/hw/mem/npcm7xx_mc.h
 create mode 100644 hw/mem/npcm7xx_mc.c

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 5816a07a72..9fa84a0702 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -18,6 +18,7 @@
=20
 #include "hw/boards.h"
 #include "hw/cpu/a9mpcore.h"
+#include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
 #include "hw/nvram/npcm7xx_otp.h"
@@ -71,6 +72,7 @@ typedef struct NPCM7xxState {
     NPCM7xxTimerCtrlState tim[3];
     NPCM7xxOTPState     key_storage;
     NPCM7xxOTPState     fuse_array;
+    NPCM7xxMCState      mc;
 } NPCM7xxState;
=20
 #define TYPE_NPCM7XX    "npcm7xx"
diff --git a/include/hw/mem/npcm7xx_mc.h b/include/hw/mem/npcm7xx_mc.h
new file mode 100644
index 0000000000..7ed38be243
--- /dev/null
+++ b/include/hw/mem/npcm7xx_mc.h
@@ -0,0 +1,36 @@
+/*
+ * Nuvoton NPCM7xx Memory Controller stub
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+#ifndef NPCM7XX_MC_H
+#define NPCM7XX_MC_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+/**
+ * struct NPCM7xxMCState - Device state for the memory controller.
+ * @parent: System bus device.
+ * @mmio: Memory region through which registers are accessed.
+ */
+typedef struct NPCM7xxMCState {
+    SysBusDevice parent;
+
+    MemoryRegion mmio;
+} NPCM7xxMCState;
+
+#define TYPE_NPCM7XX_MC "npcm7xx-mc"
+#define NPCM7XX_MC(obj) OBJECT_CHECK(NPCM7xxMCState, (obj), TYPE_NPCM7XX_M=
C)
+
+#endif /* NPCM7XX_MC_H */
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 9166002598..6bb1693833 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -43,6 +43,7 @@
 #define NPCM7XX_CPUP_BA         (0xf03fe000)
 #define NPCM7XX_GCR_BA          (0xf0800000)
 #define NPCM7XX_CLK_BA          (0xf0801000)
+#define NPCM7XX_MC_BA           (0xf0824000)
=20
 /* Internal AHB SRAM */
 #define NPCM7XX_RAM3_BA         (0xc0008000)
@@ -186,6 +187,7 @@ static void npcm7xx_init(Object *obj)
                             TYPE_NPCM7XX_KEY_STORAGE);
     object_initialize_child(obj, "otp2", &s->fuse_array,
                             TYPE_NPCM7XX_FUSE_ARRAY);
+    object_initialize_child(obj, "mc", &s->mc, TYPE_NPCM7XX_MC);
=20
     for (i =3D 0; i < ARRAY_SIZE(s->tim); i++) {
         object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TI=
MER);
@@ -261,6 +263,10 @@ static void npcm7xx_realize(DeviceState *dev, Error **=
errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fuse_array), 0, NPCM7XX_OTP2_BA);
     npcm7xx_init_fuses(s);
=20
+    /* Fake Memory Controller (MC). Cannot fail. */
+    sysbus_realize(SYS_BUS_DEVICE(&s->mc), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mc), 0, NPCM7XX_MC_BA);
+
     /* Timer Modules (TIM). Cannot fail. */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) !=3D ARRAY_SIZE(s->tim)=
);
     for (i =3D 0; i < ARRAY_SIZE(s->tim); i++) {
diff --git a/hw/mem/npcm7xx_mc.c b/hw/mem/npcm7xx_mc.c
new file mode 100644
index 0000000000..0435d06ab4
--- /dev/null
+++ b/hw/mem/npcm7xx_mc.c
@@ -0,0 +1,84 @@
+/*
+ * Nuvoton NPCM7xx Memory Controller stub
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/mem/npcm7xx_mc.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#define NPCM7XX_MC_REGS_SIZE (4 * KiB)
+
+static uint64_t npcm7xx_mc_read(void *opaque, hwaddr addr, unsigned int si=
ze)
+{
+    /*
+     * If bits 8..11 @ offset 0 are not zero, the boot block thinks the me=
mory
+     * controller has already been initialized and will skip DDR training.
+     */
+    if (addr =3D=3D 0) {
+        return 0x100;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: mostly unimplemented\n", __func__);
+
+    return 0;
+}
+
+static void npcm7xx_mc_write(void *opaque, hwaddr addr, uint64_t v,
+                             unsigned int size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: mostly unimplemented\n", __func__);
+}
+
+static const MemoryRegionOps npcm7xx_mc_ops =3D {
+    .read =3D npcm7xx_mc_read,
+    .write =3D npcm7xx_mc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+        .unaligned =3D false,
+    },
+};
+
+static void npcm7xx_mc_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxMCState *s =3D NPCM7XX_MC(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &npcm7xx_mc_ops, s, "regs",
+                          NPCM7XX_MC_REGS_SIZE);
+    sysbus_init_mmio(&s->parent, &s->mmio);
+}
+
+static void npcm7xx_mc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->desc =3D "NPCM7xx Memory Controller stub";
+    dc->realize =3D npcm7xx_mc_realize;
+}
+
+static const TypeInfo npcm7xx_mc_types[] =3D {
+    {
+        .name =3D TYPE_NPCM7XX_MC,
+        .parent =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size =3D sizeof(NPCM7xxMCState),
+        .class_init =3D npcm7xx_mc_class_init,
+    },
+};
+DEFINE_TYPES(npcm7xx_mc_types);
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index ba424622bb..0d22f2b572 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -1,6 +1,7 @@
 mem_ss =3D ss.source_set()
 mem_ss.add(files('memory-device.c'))
 mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
+mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
=20
 softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
--=20
2.28.0.297.g1956fa8f8d-goog


