Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A7EC49EAA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B09020717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B09020717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRv6L-0006QM-BZ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iRut4-0005Di-4c
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iRut3-0007vS-07
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46998 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iRusv-0007jH-EP; Tue, 05 Nov 2019 04:12:21 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5C10D599D2752F64CED6;
 Tue,  5 Nov 2019 17:12:18 +0800 (CST)
Received: from linux-OtBuvb.huawei.com (10.175.104.212) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 17:12:10 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 12/14] arm/sdei: add stub to fix build failure when SDEI is
 not enabled
Date: Tue, 5 Nov 2019 17:10:54 +0800
Message-ID: <20191105091056.9541-13-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191105091056.9541-1-guoheyi@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 James Morse <james.morse@arm.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 target/arm/Makefile.objs |  2 ++
 target/arm/sdei-stub.c   | 49 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 target/arm/sdei-stub.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 72e01d08dc..90235af8ec 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -12,6 +12,8 @@ obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) +=3D k=
vm64.o
 obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
=20
 obj-$(CONFIG_SDEI) +=3D sdei.o
+obj-$(call lnot,$(CONFIG_SDEI)) +=3D sdei-stub.o
+
=20
 DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
=20
diff --git a/target/arm/sdei-stub.c b/target/arm/sdei-stub.c
new file mode 100644
index 0000000000..4eaf365de7
--- /dev/null
+++ b/target/arm/sdei-stub.c
@@ -0,0 +1,49 @@
+/*
+ * QEMU ARM SDEI specific function stubs
+ *
+ * Copyright (c) Huawei Technologies Co., Ltd. 2019. All rights reserved=
.
+ *
+ * Author: Heyi Guo <guoheyi@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "sdei.h"
+
+bool sdei_enabled;
+
+void sdei_handle_request(CPUState *cs, struct kvm_run *run)
+{
+    run->hypercall.args[0] =3D SDEI_NOT_SUPPORTED;
+    return;
+}
+
+/*
+ * Trigger an SDEI event bound to an interrupt.
+ * Return true if event has been triggered successfully.
+ * Return false if event has not been triggered for some reason.
+ */
+bool trigger_sdei_by_irq(int cpu, int irq)
+{
+    return false;
+}
+
+/*
+ * Register a notify callback for a specific interrupt bind operation; t=
he
+ * client will be both notified by bind and unbind operation.
+ */
+void qemu_register_sdei_bind_notifier(QemuSDEIBindNotify *func,
+                                      void *opaque, int irq)
+{
+}
+
+/*
+ * Unregister a notify callback for a specific interrupt bind operation.
+ */
+void qemu_unregister_sdei_bind_notifier(QemuSDEIBindNotify *func,
+                                        void *opaque, int irq)
+{
+}
--=20
2.19.1


