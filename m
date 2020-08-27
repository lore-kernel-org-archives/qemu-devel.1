Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E012177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E012177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHEC-0005qg-0G
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBV-00086e-4C
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:17 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:56311)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBO-0005wY-Np
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:16 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id BFCF72683A;
 Thu, 27 Aug 2020 21:39:09 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 783C81C0792;
 Thu, 27 Aug 2020 21:39:09 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/20] hw/rx: Add CQ-FRK-RX62N target
Date: Thu, 27 Aug 2020 21:38:58 +0900
Message-Id: <20200827123859.81793-20-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.14;
 envelope-from=ysato@users.sourceforge.jp; helo=mail02.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:39:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It most popular RX target board in Japan.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 default-configs/rx-softmmu.mak |  1 +
 hw/rx/cq-frk-rx62n.c           | 94 ++++++++++++++++++++++++++++++++++
 hw/rx/Kconfig                  |  3 ++
 hw/rx/meson.build              |  1 +
 4 files changed, 99 insertions(+)
 create mode 100644 hw/rx/cq-frk-rx62n.c

diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
index ea8731d67b..dbbaee8809 100644
--- a/default-configs/rx-softmmu.mak
+++ b/default-configs/rx-softmmu.mak
@@ -2,3 +2,4 @@
 
 CONFIG_RX_GDBSIM=y
 CONFIG_TKDN_RX62N=y
+CONFIG_FRK_RX62N=y
diff --git a/hw/rx/cq-frk-rx62n.c b/hw/rx/cq-frk-rx62n.c
new file mode 100644
index 0000000000..a1cd9cb2ad
--- /dev/null
+++ b/hw/rx/cq-frk-rx62n.c
@@ -0,0 +1,94 @@
+/*
+ * CQ publishing CQ-FRK-RX62N
+ *
+ * Copyright (c) 2020 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/loader.h"
+#include "hw/rx/loader.h"
+#include "hw/qdev-properties.h"
+#include "hw/rx/rx62n.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
+#include "sysemu/device_tree.h"
+#include "hw/boards.h"
+
+typedef struct {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
+    RX62NState mcu;
+} FRK_RX62NMachineState;
+
+#define TYPE_FRK_RX62N_MACHINE MACHINE_TYPE_NAME("cq-frk-rx62n")
+
+#define FRK_RX62N_MACHINE(obj) \
+    OBJECT_CHECK(FRK_RX62NMachineState, (obj), TYPE_FRK_RX62N_MACHINE)
+
+static void frk_rx62n_init(MachineState *machine)
+{
+    FRK_RX62NMachineState *s = FRK_RX62N_MACHINE(machine);
+    RX62NClass *rx62nc;
+    MemoryRegion *sysmem = get_system_memory();
+
+    /* Initialize MCU */
+    object_initialize_child(OBJECT(machine), "mcu",
+                            &s->mcu, TYPE_R5F562N7_MCU);
+    rx62nc = RX62N_MCU_GET_CLASS(&s->mcu);
+    object_property_set_link(OBJECT(&s->mcu), "main-bus", OBJECT(sysmem),
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->mcu), "xtal-frequency-hz",
+                             12 * 1000 * 1000, &error_abort);
+    if (bios_name) {
+        if (!load_bios(bios_name, rx62nc->rom_flash_size, &error_abort)) {
+            exit(0);
+        }
+    } else if (!qtest_enabled()) {
+        error_report("No bios specified");
+        exit(1);
+    }
+    qdev_realize(DEVICE(&s->mcu), NULL, &error_abort);
+}
+
+static void frk_rx62n_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "CQ publishing CQ-FRK-RX62N";
+    mc->init = frk_rx62n_init;
+    mc->is_default = 0;
+    mc->default_cpu_type = TYPE_RX62N_CPU;
+}
+
+static const TypeInfo frk_rx62n_type = {
+    .name = MACHINE_TYPE_NAME("cq-frk-rx62n"),
+    .parent = TYPE_MACHINE,
+    .instance_size  = sizeof(FRK_RX62NMachineState),
+    .class_init = frk_rx62n_class_init,
+};
+
+static void frk_rx62n_machine_init(void)
+{
+    type_register_static(&frk_rx62n_type);
+}
+
+type_init(frk_rx62n_machine_init)
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index 0ef20d0c3c..ab2c472510 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -17,3 +17,6 @@ config TKDN_RX62N
     select RX62N_MCU
     select FITLOADER
 
+config FRK_RX62N
+    bool
+    select RX62N_MCU
diff --git a/hw/rx/meson.build b/hw/rx/meson.build
index 0a741e091c..0f26f1fcb2 100644
--- a/hw/rx/meson.build
+++ b/hw/rx/meson.build
@@ -2,6 +2,7 @@ rx_ss = ss.source_set()
 rx_ss.add(files('loader.c'))
 rx_ss.add(when: 'CONFIG_RX_GDBSIM', if_true: files('rx-gdbsim.c'))
 rx_ss.add(when: 'CONFIG_TKDN_RX62N', if_true: files('tkdn-rx62n.c'))
+rx_ss.add(when: 'CONFIG_FRK_RX62N', if_true: files('cq-frk-rx62n.c'))
 rx_ss.add(when: 'CONFIG_RX62N_MCU', if_true: files('rx62n.c', 'rx62n-cpg.c'))
 
 hw_arch += {'rx': rx_ss}
-- 
2.20.1


