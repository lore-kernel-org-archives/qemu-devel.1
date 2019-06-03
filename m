Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E18C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4F624C34
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdQq65K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4F624C34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38407 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqfT-0007fi-Ah
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:22:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUQ-0007LK-2I
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUN-0004SC-Rr
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUL-0004AR-RQ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id f10so12032624wmb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=WUPOWQby9NyOWCL8EdgXH+awKj5mu9CtF/Idmcmf/vA=;
	b=pdQq65K+tzU/Uopn7teSy9MFNofoQvVKbRYJaK9m4QdhKIuMBm+oSvfN1isfe125PN
	h6R5yNxSr2oupR6Nu8CP1qKSc9WkseXMaEoloEy7lvJsxo7g4lEGdl7Y/TpWJroVbkbl
	WPnPijoq/yDWUClB3cIBN30w14CHBSySOKBQdvYzvIYrbKl9mJPiocqDpWcJs5FBWAne
	wZujnzkp10VpEDKEgkLJCN8ffaQiVQAPsq+s5RJVwHeU6+YxDshjMcIHF3tNuEOGsdu6
	v5aB5xueHkF+cGrq1vYY1NiU213UE5xzm3N0R4vJKtzPZhaiJbktRmMgQiCQZrv3+5sE
	PXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=WUPOWQby9NyOWCL8EdgXH+awKj5mu9CtF/Idmcmf/vA=;
	b=G2IEfGs/mOGNYDsTO3A3xIWbZkBPnPBSHKemUDpktceMQe2t/Tnocq0PEew8vunXMw
	PyZJZcpFZCPz24UnH60sO0tyeQm4XqpRSR9eJWmXM8Jf+H7H+12r0hW0o56Qw+v0uip3
	NXdRqkMrYd18Lqkh22uOSzjjRLnCiAtWI6Wg7zTSZUp6OKNmw+/ArbVrb1W+raT5kzgO
	zhqN1MMJVUVehOqs7C6yl+WlTYi20vSJlUt8F65TPJLbwjqWs2AeEfRjLvZAtAba/ZLj
	knQt/aEeFL5X9VwmJZTfGm+5nNFj3lK2Dw1gXnrxAR+O9VGDg2ZIFDvY2/nVkkMhVJ5W
	ye4w==
X-Gm-Message-State: APjAAAVzeBav0S3y2jXxwTM2AEDigELIpV2hLv77xDwSbAmMpJffc8FA
	6gq+RIyjrbdLcbQEcAwZp+mpi8i2
X-Google-Smtp-Source: APXvYqy8K2jv9HSpzpY11JtpiAMoCkuViVJCwLY/E+dL9ry12eAEpxothmlo7j7Lq/FA3qOQAPQZww==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr15413787wma.78.1559581864650; 
	Mon, 03 Jun 2019 10:11:04 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:37 +0200
Message-Id: <1559581843-3968-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 18/24] libqos: add ARM imx25-pdk machine object
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is used to test imx_i2c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include               |  1 +
 tests/libqos/arm-imx25-pdk-machine.c | 92 ++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tests/libqos/arm-imx25-pdk-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03a6483..506181e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -711,6 +711,7 @@ qos-test-obj-y += tests/libqos/virtio-serial.o
 
 # Machines
 qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
+qos-test-obj-y += tests/libqos/arm-imx25-pdk-machine.o
 qos-test-obj-y += tests/libqos/arm-n800-machine.o
 qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
 qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
diff --git a/tests/libqos/arm-imx25-pdk-machine.c b/tests/libqos/arm-imx25-pdk-machine.c
new file mode 100644
index 0000000..25066fb
--- /dev/null
+++ b/tests/libqos/arm-imx25-pdk-machine.c
@@ -0,0 +1,92 @@
+/*
+ * libqos driver framework
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/malloc.h"
+#include "libqos/qgraph.h"
+#include "libqos/i2c.h"
+
+#define ARM_PAGE_SIZE            4096
+#define IMX25_PDK_RAM_START      0x80000000
+#define IMX25_PDK_RAM_END        0x88000000
+
+typedef struct QIMX25PDKMachine QIMX25PDKMachine;
+
+struct QIMX25PDKMachine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    IMXI2C i2c_1;
+};
+
+static void *imx25_pdk_get_driver(void *object, const char *interface)
+{
+    QIMX25PDKMachine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in arm/imx25_pdk\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *imx25_pdk_get_device(void *obj, const char *device)
+{
+    QIMX25PDKMachine *machine = obj;
+    if (!g_strcmp0(device, "imx.i2c")) {
+        return &machine->i2c_1.obj;
+    }
+
+    fprintf(stderr, "%s not present in arm/imx25_pdk\n", device);
+    g_assert_not_reached();
+}
+
+static void imx25_pdk_destructor(QOSGraphObject *obj)
+{
+    QIMX25PDKMachine *machine = (QIMX25PDKMachine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *qos_create_machine_arm_imx25_pdk(QTestState *qts)
+{
+    QIMX25PDKMachine *machine = g_new0(QIMX25PDKMachine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               IMX25_PDK_RAM_START,
+               IMX25_PDK_RAM_END,
+               ARM_PAGE_SIZE);
+    machine->obj.get_device = imx25_pdk_get_device;
+    machine->obj.get_driver = imx25_pdk_get_driver;
+    machine->obj.destructor = imx25_pdk_destructor;
+
+    imx_i2c_init(&machine->i2c_1, qts, 0x43f80000);
+    return &machine->obj;
+}
+
+static void imx25_pdk_register_nodes(void)
+{
+    QOSGraphEdgeOptions edge = {
+        .extra_device_opts = "bus=i2c-bus.0"
+    };
+    qos_node_create_machine("arm/imx25-pdk", qos_create_machine_arm_imx25_pdk);
+    qos_node_contains("arm/imx25-pdk", "imx.i2c", &edge, NULL);
+}
+
+libqos_init(imx25_pdk_register_nodes);
-- 
1.8.3.1



