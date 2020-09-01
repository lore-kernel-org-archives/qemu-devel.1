Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B1FC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D24206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hF4sftd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D24206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8fT-0001eI-J3
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD84D-0001Aq-8t
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:25 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD84B-0006Lh-C1
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id a9so1558643wmm.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=t+lM5dln5QeSS2yYj3HP1RzZbw3t/4bGgxiwxrpJaOg=;
 b=hF4sftd4+vRrnQrpswPoBibFsxFtlHRiju5p/WIDNIDHzZ69ynRo6PUgksA5bWvfDd
 5RoMwpcWDMkHR7NMVWE/6xH2/42eagW5Jt6G8bCRjmBSq2HjsPPmkN9WD6Rb9iksaWLA
 p4lokyIBeDA2HxM2mHVFtckHk3O2K8rsEYL4s6gpQjHn6f1cTNN2JN6awNT7Ouz4FCed
 o+uRwRAzEDB7wIQsthpDsql/4ZLLur4/hL0S+MT68RX/X9Fw1hTU0fznHfP/tW/0xrMM
 ZOdF9CmJQqLNnHtR/AYkax1r+3MpZydoyek/JLK5oEYYPeqlvirga52aL/2hKfeI2LCS
 LWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t+lM5dln5QeSS2yYj3HP1RzZbw3t/4bGgxiwxrpJaOg=;
 b=M6mbMtLcn7qhIl2uIYbOK52P3SPtnztZR4mst9gfxjSQ4HUO9LhOuN+nxFjlhaAWel
 qvEJWe/xDm6SV3VeBSS5SHUqw+SR+wVmU31hQgJzC5Ufn3MXMtokqy0grxbI5/EJqi05
 9hAUFlwMO1D+IWd99NAntHXQOfURZfQ9xfmy0OJJiinPboUztd5Lz5fVOgc4bEXDM+3R
 ejLYyRy0gH82FzNxdz7QXN5Te8DzuvQjSYG5xNTjI3MAVS7qt2SZ7mC5eXePLY7Nbz5x
 VwMqXA/5N3GV14kIJ329SKQY4UdI1AkYaiHtm3RDv3zNiWjlrRWvp9hKYaWZFRo21+a/
 Knqg==
X-Gm-Message-State: AOAM533ddgmULKG3gYLWVy44YDMfJPyuU5WdB5EzF7lCWdT7kB7eWT/O
 oN2cdXFhEMa93o0/aqgnY2oPAYwJs+BZYe/T
X-Google-Smtp-Source: ABdhPJz06gWBpVKtt/9i0Q4Eu1ptwGL6go5wyavv234OWqdB0zbYZ8l5ZcVBHXHGnexr1k0LvaVjSg==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr2276787wmk.86.1598973561682; 
 Tue, 01 Sep 2020 08:19:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/47] hw/misc/sbsa_ec : Add an embedded controller for sbsa-ref
Date: Tue,  1 Sep 2020 16:18:22 +0100
Message-Id: <20200901151823.29785-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Graeme Gregory <graeme@nuviainc.com>

A difference between sbsa platform and the virt platform is PSCI is
handled by ARM-TF in the sbsa platform. This means that the PSCI code
there needs to communicate some of the platform power changes down
to the qemu code for things like shutdown/reset control.

Space has been left to extend the EC if we find other use cases in
future where ARM-TF and qemu need to communicate.

Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
Reviewed-by: Leif Lindholm <leif@nuviainc.com>
Tested-by: Leif Lindholm <leif@nuviainc.com>
Message-id: 20200826141952.136164-2-graeme@nuviainc.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/sbsa_ec.c   | 98 +++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build |  2 +
 2 files changed, 100 insertions(+)
 create mode 100644 hw/misc/sbsa_ec.c

diff --git a/hw/misc/sbsa_ec.c b/hw/misc/sbsa_ec.c
new file mode 100644
index 00000000000..9a7d7f914a9
--- /dev/null
+++ b/hw/misc/sbsa_ec.c
@@ -0,0 +1,98 @@
+/*
+ * ARM SBSA Reference Platform Embedded Controller
+ *
+ * A device to allow PSCI running in the secure side of sbsa-ref machine
+ * to communicate platform power states to qemu.
+ *
+ * Copyright (c) 2020 Nuvia Inc
+ * Written by Graeme Gregory <graeme@nuviainc.com>
+ *
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "hw/sysbus.h"
+#include "sysemu/runstate.h"
+
+typedef struct {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+} SECUREECState;
+
+#define TYPE_SBSA_EC      "sbsa-ec"
+#define SECURE_EC(obj) OBJECT_CHECK(SECUREECState, (obj), TYPE_SBSA_EC)
+
+enum sbsa_ec_powerstates {
+    SBSA_EC_CMD_POWEROFF = 0x01,
+    SBSA_EC_CMD_REBOOT = 0x02,
+};
+
+static uint64_t sbsa_ec_read(void *opaque, hwaddr offset, unsigned size)
+{
+    /* No use for this currently */
+    qemu_log_mask(LOG_GUEST_ERROR, "sbsa-ec: no readable registers");
+    return 0;
+}
+
+static void sbsa_ec_write(void *opaque, hwaddr offset,
+                     uint64_t value, unsigned size)
+{
+    if (offset == 0) { /* PSCI machine power command register */
+        switch (value) {
+        case SBSA_EC_CMD_POWEROFF:
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+            break;
+        case SBSA_EC_CMD_REBOOT:
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "sbsa-ec: unknown power command");
+        }
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "sbsa-ec: unknown EC register");
+    }
+}
+
+static const MemoryRegionOps sbsa_ec_ops = {
+    .read = sbsa_ec_read,
+    .write = sbsa_ec_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void sbsa_ec_init(Object *obj)
+{
+    SECUREECState *s = SECURE_EC(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &sbsa_ec_ops, s, "sbsa-ec",
+                          0x1000);
+    sysbus_init_mmio(dev, &s->iomem);
+}
+
+static void sbsa_ec_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    /* No vmstate or reset required: device has no internal state */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo sbsa_ec_info = {
+    .name          = TYPE_SBSA_EC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SECUREECState),
+    .instance_init = sbsa_ec_init,
+    .class_init    = sbsa_ec_class_init,
+};
+
+static void sbsa_ec_register_type(void)
+{
+    type_register_static(&sbsa_ec_info);
+}
+
+type_init(sbsa_ec_register_type);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 84fed0494d2..e1576b81cf9 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -97,3 +97,5 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
+
+specific_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
-- 
2.20.1


