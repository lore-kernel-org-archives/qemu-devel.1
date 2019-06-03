Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4E8C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFED274F4
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhK/GsRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFED274F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38467 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqie-0001rD-Ai
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:26:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUN-0007Io-Pw
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUL-0004Oi-Qs
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:15 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUK-000499-3g
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id f10so12032579wmb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=nDOwMOkDnVXsENoUAAn5Ob4O9fod7r3TV9e2Rzz+xfU=;
	b=vhK/GsRnS31jrG7xXOjtYj6LDJFjkbtF2VbilF3JsXx7DLFAjoPQNQ0xXJYZ/P/AAh
	3W1GrQAmrmtxaNcfnsLY3Vi+hhkimu0z2andbcCq5Z5zDVsWVjdIhQ/3raHOmsB39MIc
	bPDG665vign6jH/TTDDU46V0+/aq7NE+Br8+6VAjUx4G78n+nZx9uu5bKTjVnt667mVd
	GbhUFimtpGgEohkSCQcagQGjal+Ekg8OFGSFLXYQeMypRA9VC5G8rmSQkppX96hB30V2
	0PauX4NH46HMmmXjNUyl7cOx9QlCa9w/nRnzW2tg73sav9UiM/5ZKIxKN5o/lRH4QdKX
	AixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=nDOwMOkDnVXsENoUAAn5Ob4O9fod7r3TV9e2Rzz+xfU=;
	b=HA0OJgmnHSzeNpaXEgWUG29IZu+tB3xP32+7erm3JUpDxIV3sk/KMJBeKMJTgfGtbx
	XSIahoYq8tMSTFszBJVaRzMbFt8+Kx8xnqOY3+hrVEK1+cSLCcVJc8GbKeg0QUah1Zso
	WGwLhR8+F8J5pyCUWjXcoWF2BgyW8rnjwNIweHfljY969l112X8nj/o3G8zmlocmSQQ4
	HKGE0l0NkEZJkEu+VSTEvfWYXdtVBHgHCRJa+ta9q4NtQCzXmYzg+ekgi/6Pm9nxquP4
	RdWsVapfesN0QEw/iWnP7uDlUJUrhyUb1SYl2HXr3rnuA0SbOBreM1hKw7YQejU4wi7S
	I4/Q==
X-Gm-Message-State: APjAAAXO52HS/4U5dFORQNXBPmpIHzZ5e7ZraaSaUQHNTtWddywcwy1Y
	KnneZ/GXv62JvDem/N+r0B1ngGUv
X-Google-Smtp-Source: APXvYqx9PyUIgpRBp96MJJ2/WzSbrvuoHuKxCrZy9hD4Us3gjMSXCnk0g2onLsKXc2ESxNlECGd5Aw==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr15593528wmh.7.1559581863670; 
	Mon, 03 Jun 2019 10:11:03 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:36 +0200
Message-Id: <1559581843-3968-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 17/24] libqos: add ARM n800 machine object
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

This is used to test omap_i2c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include          |  1 +
 tests/libqos/arm-n800-machine.c | 92 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tests/libqos/arm-n800-machine.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 63f646a..03a6483 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -711,6 +711,7 @@ qos-test-obj-y += tests/libqos/virtio-serial.o
 
 # Machines
 qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
+qos-test-obj-y += tests/libqos/arm-n800-machine.o
 qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
 qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
 qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
diff --git a/tests/libqos/arm-n800-machine.c b/tests/libqos/arm-n800-machine.c
new file mode 100644
index 0000000..87279bd
--- /dev/null
+++ b/tests/libqos/arm-n800-machine.c
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
+#define N800_RAM_START      0x80000000
+#define N800_RAM_END        0x88000000
+
+typedef struct QN800Machine QN800Machine;
+
+struct QN800Machine {
+    QOSGraphObject obj;
+    QGuestAllocator alloc;
+    OMAPI2C i2c_1;
+};
+
+static void *n800_get_driver(void *object, const char *interface)
+{
+    QN800Machine *machine = object;
+    if (!g_strcmp0(interface, "memory")) {
+        return &machine->alloc;
+    }
+
+    fprintf(stderr, "%s not present in arm/n800\n", interface);
+    g_assert_not_reached();
+}
+
+static QOSGraphObject *n800_get_device(void *obj, const char *device)
+{
+    QN800Machine *machine = obj;
+    if (!g_strcmp0(device, "omap_i2c")) {
+        return &machine->i2c_1.obj;
+    }
+
+    fprintf(stderr, "%s not present in arm/n800\n", device);
+    g_assert_not_reached();
+}
+
+static void n800_destructor(QOSGraphObject *obj)
+{
+    QN800Machine *machine = (QN800Machine *) obj;
+    alloc_destroy(&machine->alloc);
+}
+
+static void *qos_create_machine_arm_n800(QTestState *qts)
+{
+    QN800Machine *machine = g_new0(QN800Machine, 1);
+
+    alloc_init(&machine->alloc, 0,
+               N800_RAM_START,
+               N800_RAM_END,
+               ARM_PAGE_SIZE);
+    machine->obj.get_device = n800_get_device;
+    machine->obj.get_driver = n800_get_driver;
+    machine->obj.destructor = n800_destructor;
+
+    omap_i2c_init(&machine->i2c_1, qts, 0x48070000);
+    return &machine->obj;
+}
+
+static void n800_register_nodes(void)
+{
+    QOSGraphEdgeOptions edge = {
+        .extra_device_opts = "bus=i2c-bus.0"
+    };
+    qos_node_create_machine("arm/n800", qos_create_machine_arm_n800);
+    qos_node_contains("arm/n800", "omap_i2c", &edge, NULL);
+}
+
+libqos_init(n800_register_nodes);
-- 
1.8.3.1



