Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478FDC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602DE2080A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R973wmhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602DE2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHdO-0002iM-B8
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHbc-0001MB-Ng
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:08:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHba-0002MN-Jt
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:08:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id j7so3879920wrt.9
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C35h4gzeWKOzuL3ecpIsHo4GhJGpUZG/jcU7/ZLk4Mk=;
 b=R973wmhhQbg4UmllLtVHMBQH3UBvSaLkxbUY+vsJqU9RgTucL4bMHHbQ3WQBv06kLb
 Vy4mEWpmh6O1uTXeEe2+0xHqe6qnBvaj6IYJNjHSKIIiGh2vfkYR1BL+aRBBpATgCtfn
 UBPxdsabAtvOw55kM13j1zYOZ+O1IknRK/n/jUrsKZxNZsd/YEaVZBxwdJiuoHbOKPei
 lTAi+PWZzybjjBpb9PFsryCMKeO/FPO+DAnXWPiXt7/NA6D6UYkwPDJsDkAV1wd6dOvy
 xruswNbq8CC3CGuqTzxA6bFNQEDyVQswbtbJMLB0OCn749oHdaQHR+RXkWewGdtWXtly
 Whtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C35h4gzeWKOzuL3ecpIsHo4GhJGpUZG/jcU7/ZLk4Mk=;
 b=hD0BeBNmb6yppCB1Uz+y35xLEPWS6vPCHeaEFBPl7mXuMFTlv8cIaAW1Ak3b+ua8/K
 zNt9dg0SBvPa2xR2f0Mwg81ckGw2+nqpVdsAR+amLOOK3f91YhtyyFcXRyESRIodJJML
 F3DwL+V7MJBM2dHr6iMI8KoN4aDM3wapDyHpEHmfuJfjW2Ri17zYtb6HafiPwKbahc8j
 AzO66j5+36AopIZAq+apPudvSeVyd8MiM24uebz3uHQ3BwPTMD9TiqtFZoA0ePRpgcU+
 XzjUYpB/BaL30rYt2danbfgRRor/JuDZJOvVoW2WWDTHTje2dZ5NMDe8cWWv5/xwqlD4
 qXCA==
X-Gm-Message-State: AOAM532hFKWHXcDApJ8yKm8cctdYXYg42yafYzuWKPg6aegGzidQJK4w
 X8iuibjj5mnKAzaoXJ0L2fzuoA==
X-Google-Smtp-Source: ABdhPJwPT8NoVOWSQ8c0wVWJQkDPSFO8KkA/knF+CCSLG1465vbIMwS6akimQ9EYxtzX1JQJYKsRzg==
X-Received: by 2002:adf:f986:: with SMTP id f6mr6246868wrr.38.1603300132904;
 Wed, 21 Oct 2020 10:08:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x21sm9202767wmi.3.2020.10.21.10.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:08:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4E4641FF90;
 Wed, 21 Oct 2020 18:08:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/4] hw/core: implement a guest-loader to support static
 hypervisor guests
Date: Wed, 21 Oct 2020 18:08:42 +0100
Message-Id: <20201021170842.25762-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021170842.25762-1-alex.bennee@linaro.org>
References: <20201021170842.25762-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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


