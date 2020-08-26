Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C8CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A213C221E2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="yj5t2G+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A213C221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwJ8-0005aP-SC
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAwHT-0002jF-9C
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:20:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAwHQ-0003rV-Uq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:20:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id c19so1674670wmd.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7+36PnMQTCjkKChJLGXL0i7a9udhWvYuIUxgFCuMpx4=;
 b=yj5t2G+I8krhcX6LRNhdI/tM3NfECG/90ZZzaGmwUUaC8H1IIZVfMXOLqJduApaLPl
 wQP/seh6Bz9oL82ngg3YtpWueVRPy85NyrlmuDJlGK8BRpHnmxN+PPGH34j81RSwUetm
 Vxtbd1VFHo5Fkgz2u33bj7UVoXppx8UaE2D2UGJhfM1CMpl5OS7m7evhj/VLTW9hqn35
 e6KUdInNnaZe9illCjr9cDpo0uxdSh4xpNg8YYZ1SMo71NnmT+2/H0A6UHd47gpZMyOW
 J/kQoQte+Dk59TJghd4IdNN4g3fsdZpFUdUARz35+8OccgVfdo1E/gjRueuCwALoSPP6
 Aq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7+36PnMQTCjkKChJLGXL0i7a9udhWvYuIUxgFCuMpx4=;
 b=jFGTJO+nvyin3YYjJZ/j0JavofzD8MIlcMf6pcpfrqF9p0+E5iMJnbbn9KwBFux12K
 0CV6/hHJWKoap/eRCZLziQ4Kcbb49jhEpPABiB7v3KTTE1nOjfhShFkZcDbJh1O/xzO+
 X5SxDHhRGedECpDPauCIvrx4QfmPJCw7HV6I2WWGHAInIQBe6yE/3NNMugkhR3Objqnf
 eDUarzMQ6KwyNn1sbX5c0GOd/e04o81DU7q6ErKcoG/45n1Ka682VwuVLSXvottujsJA
 jQqlbrI5KBZhpimm+kg/L6LYHys7jfbjEvUcSjYax2h96Dv/OKjoP4hoiW3i/PK+qv8P
 R0vw==
X-Gm-Message-State: AOAM533uCQUexvzZO9yeDkePAaho88MAa7IHJn8cUhxOa87jm05GzSdE
 cTBRoW/i//kN8baxaHBTdTZhKQ==
X-Google-Smtp-Source: ABdhPJzSqGF23VtnPJe0sUOdSd9gnZekOYRvWzE++AnSPioIsIFet2T6OGp5PkfMD+qMq8Wh41NfiQ==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr7570848wmi.151.1598451599595; 
 Wed, 26 Aug 2020 07:19:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id n7sm6604411wrs.2.2020.08.26.07.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 07:19:58 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 1/2] hw/misc/sbsa_ec : Add an embedded controller for
 sbsa-ref
Date: Wed, 26 Aug 2020 15:19:51 +0100
Message-Id: <20200826141952.136164-2-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826141952.136164-1-graeme@nuviainc.com>
References: <20200826141952.136164-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Graeme Gregory <graeme@nuviainc.com>, peter.maydell@linaro.org,
 rad@semihalf.com, qemu-devel@nongnu.org, f4bug@amsat.org, leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A difference between sbsa platform and the virt platform is PSCI is
handled by ARM-TF in the sbsa platform. This means that the PSCI code
there needs to communicate some of the platform power changes down
to the qemu code for things like shutdown/reset control.

Space has been left to extend the EC if we find other use cases in
future where ARM-TF and qemu need to communicate.

Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
---
 hw/misc/meson.build |  2 +
 hw/misc/sbsa_ec.c   | 98 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 hw/misc/sbsa_ec.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 84fed0494d..e1576b81cf 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -97,3 +97,5 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
+
+specific_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
diff --git a/hw/misc/sbsa_ec.c b/hw/misc/sbsa_ec.c
new file mode 100644
index 0000000000..9a7d7f914a
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
-- 
2.25.1


