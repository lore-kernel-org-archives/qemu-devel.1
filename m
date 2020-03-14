Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B91C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689982073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689982073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2JH-000249-KK
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HD-0006cy-7D
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HC-0004fE-4q
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53342 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jD2HB-0004M0-P3; Sat, 14 Mar 2020 04:36:10 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 125627FA44D9298E9226;
 Sat, 14 Mar 2020 16:36:03 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 14 Mar 2020 16:35:54 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v5 3/4] hw/misc/macio: fix incorrect creation of mos6522's
 subclasses
Date: Sat, 14 Mar 2020 16:47:29 +0800
Message-ID: <20200314084730.25876-4-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200314084730.25876-1-pannengyuan@huawei.com>
References: <20200314084730.25876-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 Pan Nengyuan <pannengyuan@huawei.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 euler.robot@huawei.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are two other places where we create mos6522's subclasses but forgot to realize
it. This patch do the realize in these places to fix that.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
---
v5:
- Also fix incorrect creation of mos6522's subclasses on two other places.
  Not sure if there is a conversion plan, we still keep sysbus_init_child_obj in init()
  in this patch as it was.
---
 hw/misc/macio/cuda.c | 11 +++++++++--
 hw/misc/macio/pmu.c  | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index e0cc0aac5d..ee780a8288 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -36,6 +36,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "trace.h"
 
 /* Bits in B data register: all active low */
@@ -524,11 +525,17 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     CUDAState *s = CUDA(dev);
     SysBusDevice *sbd;
     MOS6522State *ms;
-    DeviceState *d;
+    DeviceState *d = DEVICE(&s->mos6522_cuda);
     struct tm tm;
+    Error *err = NULL;
+
+    object_property_set_bool(OBJECT(d), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
 
     /* Pass IRQ from 6522 */
-    d = DEVICE(&s->mos6522_cuda);
     ms = MOS6522(d);
     sbd = SYS_BUS_DEVICE(s);
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index b8466a4a3f..ae55992288 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -43,6 +43,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "trace.h"
 
 
@@ -741,11 +742,17 @@ static void pmu_realize(DeviceState *dev, Error **errp)
     PMUState *s = VIA_PMU(dev);
     SysBusDevice *sbd;
     MOS6522State *ms;
-    DeviceState *d;
+    DeviceState *d = DEVICE(&s->mos6522_pmu);;
     struct tm tm;
+    Error *err = NULL;
+
+    object_property_set_bool(OBJECT(d), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
 
     /* Pass IRQ from 6522 */
-    d = DEVICE(&s->mos6522_pmu);
     ms = MOS6522(d);
     sbd = SYS_BUS_DEVICE(s);
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
-- 
2.18.2


