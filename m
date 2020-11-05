Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95799C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4DA20739
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uj941NUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4DA20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajYK-0005Wb-RY
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQl-00047M-Ds
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:15 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQh-0004pb-M4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:15 -0500
Received: by mail-wm1-x341.google.com with SMTP id h62so2451046wme.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rn0hUbcz35n6uIROHy212hfaK77GbH9OkiZ/hZAVCwc=;
 b=uj941NUrndN5VYOa79bbAM7aBjJjPG7/T6nruCQYrE+BOMY+XAW9RcRDaV0QdrQIk5
 r+BXydHiKzPlf39zCOl8gWe4ybF/+1gWOC6Af4ecfFXKe5boorT9sy9jalOMWXZDv0/j
 N3luJzW6tInEy43LCiyTlH/c0jK6U4oG9vs1t+2tE9a+elK+fE3+4kaCcAex/Ep4c+XX
 C4ZyU3ZT5ouJnNfMeBVNeG3ntDJW6hCUf2GGP3Fhbhewn1Va3NpwkS7i7K07ek1uF/ZC
 gY4TKv56UQlcM8SOFlQSwHtjiGFkgyIqbS7KJSnUVTwzYHBw6OSOftnw4Avn34kco3Sp
 NwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rn0hUbcz35n6uIROHy212hfaK77GbH9OkiZ/hZAVCwc=;
 b=feOqM+XEyciWlETUTYHvhdzEhwDWmu5U+OSQz7F2fxNlY/N5gX0EQpf4sI9460BZAf
 3WVZmD0pVMl4tcurt/75vRh59zyqLgx5rnlf+1yjpt0kilFb0XFR37y6qZsEtheYlFjT
 U0l6r9MFoKboUmkK+hlPfOZdVg1s9nMWn+ykolG/dfJGwN2cQXauQFUMITpTNd3Rb/qY
 W4cjagdvRazXv36XMp/t8GT1larcFY+4FNekVKnWqXFcH40ik8+rXuNYncuKk7WzTPUl
 KKQaZQmwisPPQ413+L7uY73NtoG2hgrp+phXsrSrLFUaAss5PgLysRUR9x/mHasJWPUW
 66fw==
X-Gm-Message-State: AOAM532AyLWGC9yd2pNlmWpkKuiINdnsuI5OymsSg1ziyxO0g+6p6T9b
 7zLjoDSa84LQ10cnDYuhb5FDIQ==
X-Google-Smtp-Source: ABdhPJyT87Nah9QvghVMiPknGnMnPuyShQdJ0FN+YNTdAFCCBOelVvLlNYQY4wNufHoIluuowbpz6A==
X-Received: by 2002:a05:600c:2c4c:: with SMTP id
 r12mr3814578wmg.157.1604598724129; 
 Thu, 05 Nov 2020 09:52:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y187sm3711917wmg.33.2020.11.05.09.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:51:58 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F44A1FF90;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 04/15] hw/core: implement a guest-loader to support static
 hypervisor guests
Date: Thu,  5 Nov 2020 17:51:42 +0000
Message-Id: <20201105175153.30489-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hypervisors, especially type-1 ones, need the firmware/bootcode to put
their initial guest somewhere in memory and pass the information to it
via platform data. The guest-loader is modelled after the generic
loader for exactly this sort of purpose:

  $QEMU $ARGS  -kernel ~/xen.git/xen/xen \
    -append "dom0_mem=1G,max:1G loglvl=all guest_loglvl=all" \
    -device guest-loader,addr=0x42000000,kernel=Image,bootargs="root=/dev/sda2 ro console=hvc0 earlyprintk=xen" \
    -device guest-loader,addr=0x47000000,initrd=rootfs.cpio

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20201021170842.25762-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/guest-loader.h |  34 ++++++++++
 hw/core/guest-loader.c | 140 +++++++++++++++++++++++++++++++++++++++++
 hw/core/meson.build    |   2 +
 3 files changed, 176 insertions(+)
 create mode 100644 hw/core/guest-loader.h
 create mode 100644 hw/core/guest-loader.c

diff --git a/hw/core/guest-loader.h b/hw/core/guest-loader.h
new file mode 100644
index 0000000000..07f4b4884b
--- /dev/null
+++ b/hw/core/guest-loader.h
@@ -0,0 +1,34 @@
+/*
+ * Guest Loader
+ *
+ * Copyright (C) 2020 Linaro
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ * (based on the generic-loader by Li Guang <lig.fnst@cn.fujitsu.com>)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef GUEST_LOADER_H
+#define GUEST_LOADER_H
+
+#include "hw/qdev-core.h"
+#include "qom/object.h"
+
+struct GuestLoaderState {
+    /* <private> */
+    DeviceState parent_obj;
+
+    /* <public> */
+    uint64_t addr;
+    char *kernel;
+    char *args;
+    char *initrd;
+};
+
+#define TYPE_GUEST_LOADER "guest-loader"
+OBJECT_DECLARE_SIMPLE_TYPE(GuestLoaderState, GUEST_LOADER)
+
+#endif
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
new file mode 100644
index 0000000000..1ce39842be
--- /dev/null
+++ b/hw/core/guest-loader.c
@@ -0,0 +1,140 @@
+/*
+ * Guest Loader
+ *
+ * Copyright (C) 2020 Linaro
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ * (based on the generic-loader by Li Guang <lig.fnst@cn.fujitsu.com>)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * Much like the generic-loader this is treated as a special device
+ * inside QEMU. However unlike the generic-loader this device is used
+ * to load guest images for hypervisors. As part of that process the
+ * hypervisor needs to have platform information passed to it by the
+ * lower levels of the stack (e.g. firmware/bootloader). If you boot
+ * the hypervisor directly you use the guest-loader to load the Dom0
+ * or equivalent guest images in the right place in the same way a
+ * boot loader would.
+ *
+ * This is only relevant for full system emulation.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+#include "hw/sysbus.h"
+#include "sysemu/dma.h"
+#include "hw/loader.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "guest-loader.h"
+#include "sysemu/device_tree.h"
+#include "hw/boards.h"
+
+/*
+ * Insert some FDT nodes for the loaded blob.
+ */
+static void loader_insert_platform_data(GuestLoaderState *s, int size, Error **errp)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    void *fdt = machine->fdt;
+    g_autofree char *node = g_strdup_printf("/chosen/module@%#08lx", s->addr);
+    uint64_t reg_attr[2] = {cpu_to_be64(s->addr), cpu_to_be64(size)};
+
+    if (!fdt) {
+        error_setg(errp, "Cannot modify FDT fields if the machine has none");
+        return;
+    }
+
+    qemu_fdt_add_subnode(fdt, node);
+    qemu_fdt_setprop(fdt, node, "reg", &reg_attr, sizeof(reg_attr));
+
+    if (s->kernel) {
+        const char *compat[2] = { "multiboot,module", "multiboot,kernel" };
+        if (qemu_fdt_setprop_string_array
+            (fdt, node, "compatible", (char **) &compat, ARRAY_SIZE(compat)) < 0) {
+            error_setg(errp, "couldn't set %s/compatible", node);
+            return;
+        }
+        if (s->args) {
+            if (qemu_fdt_setprop_string(fdt, node, "bootargs", s->args) < 0) {
+                error_setg(errp, "couldn't set %s/bootargs", node);
+            }
+        }
+    } else if (s->initrd) {
+        const char * compat[2] = { "multiboot,module", "multiboot,ramdisk" };
+        if (qemu_fdt_setprop_string_array
+            (fdt, node, "compatible", (char **) &compat, ARRAY_SIZE(compat)) < 0) {
+            error_setg(errp, "couldn't set %s/compatible", node);
+            return;
+        }
+    }
+}
+
+static void guest_loader_realize(DeviceState *dev, Error **errp)
+{
+    GuestLoaderState *s = GUEST_LOADER(dev);
+    char *file = s->kernel ? s->kernel : s->initrd;
+    int size = 0;
+
+    /* Perform some error checking on the user's options */
+    if (s->kernel && s->initrd) {
+        error_setg(errp, "Cannot specify a kernel and initrd in the same stanza");
+        return;
+    } else if (!s->kernel && !s->initrd)  {
+        error_setg(errp, "Need to specify a kernel or initrd image");
+        return;
+    } else if (!s->addr) {
+        error_setg(errp, "Need to specify the address of guest blob");
+        return;
+    } else if (s->args && !s->kernel) {
+        error_setg(errp, "Boot args only relevant to kernel blobs");
+    }
+
+    /* Default to the maximum size being the machine's ram size */
+    size = load_image_targphys_as(file, s->addr, ram_size, NULL);
+    if (size < 0) {
+        error_setg(errp, "Cannot load specified image %s", file);
+        return;
+    }
+
+    /* Now the image is loaded we need to update the platform data */
+    loader_insert_platform_data(s, size, errp);
+}
+
+static Property guest_loader_props[] = {
+    DEFINE_PROP_UINT64("addr", GuestLoaderState, addr, 0),
+    DEFINE_PROP_STRING("kernel", GuestLoaderState, kernel),
+    DEFINE_PROP_STRING("bootargs", GuestLoaderState, args),
+    DEFINE_PROP_STRING("initrd", GuestLoaderState, initrd),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void guest_loader_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = guest_loader_realize;
+    device_class_set_props(dc, guest_loader_props);
+    dc->desc = "Guest Loader";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static TypeInfo guest_loader_info = {
+    .name = TYPE_GUEST_LOADER,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(GuestLoaderState),
+    .class_init = guest_loader_class_init,
+};
+
+static void guest_loader_register_type(void)
+{
+    type_register_static(&guest_loader_info);
+}
+
+type_init(guest_loader_register_type)
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 4a744f3b5e..27a69fc578 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -37,6 +37,8 @@ softmmu_ss.add(files(
   'clock-vmstate.c',
 ))
 
+softmmu_ss.add(when: 'CONFIG_TCG', if_true: files('guest-loader.c'))
+
 specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
   'machine-qmp-cmds.c',
   'numa.c',
-- 
2.20.1


