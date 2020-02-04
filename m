Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100FFC3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C344A20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lv3cvY70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C344A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywRR-0001Dr-Qv
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQG-0008KA-0I
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQB-0000AA-Nq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51779)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQB-0008WF-Du
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:11 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204113110euoutp0202991455384ff549a8866ce6ceef5cb4~wL6iaV5i93205332053euoutp02E
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:31:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204113110euoutp0202991455384ff549a8866ce6ceef5cb4~wL6iaV5i93205332053euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580815870;
 bh=bRn11VpBM9t5t50jTYwBxqf13Abw0bNM2mE3Nrju/WU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lv3cvY7006Vgj+xZYXg+PLBqYTIOUtKIPE1ELOKXnBZcm+3nEpOs57aQha0aDz5D7
 mxA8thckjVa/I0gptYyBcRqe7w9uynk3Nfbz/9KzpMtpAwn356k8uk4MsEmIwXR8E4
 m2JKGmaFq3Ma1vO7XDn/ERaYvfkuuynX3Knrq+RE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204113110eucas1p2c6e71cbf8619eba68d4dc5cb5010db54~wL6iMoqTH0683106831eucas1p29;
 Tue,  4 Feb 2020 11:31:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.FE.61286.EF5593E5; Tue,  4
 Feb 2020 11:31:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204113109eucas1p18527bb78c3d930d56e6ae9c205f64ba3~wL6hzdy9B0252702527eucas1p10;
 Tue,  4 Feb 2020 11:31:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204113109eusmtrp1cbb2b2fdf04277c44eec670e4777b97a~wL6hy_UCD2134721347eusmtrp1W;
 Tue,  4 Feb 2020 11:31:09 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-95-5e3955fe3de2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id AA.0A.07950.DF5593E5; Tue,  4
 Feb 2020 11:31:09 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113109eusmtip20a5a255bb8b1cee1e2a4a810a2bb3455~wL6hcxiTr1203512035eusmtip29;
 Tue,  4 Feb 2020 11:31:09 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC 7/9] hw/misc/memexpose: Add memexpose memory region device
Date: Tue,  4 Feb 2020 12:30:49 +0100
Message-Id: <1580815851-28887-8-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djP87r/Qi3jDCbOZbPYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBl/P94
 hLVgtmXFnCNXmBoY2/W6GDk5JARMJH5dWMbUxcjFISSwglHi9N8TjBDOF0aJdVfusUI4nxkl
 Xuw7zQjTcu34XDaIxHJGiYsnzjPDtbQt/sYOUsUmoCax88hnsA4RAUmJ312nmUFsZoEMieez
 usFsYQEPiSP//rGA2CwCqhIP9t8H6+UVCJB4u2YrC8Q2OYmb5zrB6jkFAiXe75kEdqyEwGU2
 iXOLz7JDFLlILH27nBnCFpZ4dXwLVFxG4vTkHqhB9RItd3ZANXcwSvStnM4GkbCW+LJhKVAR
 B9B1mhLrd+lDhB0lzjX8YwMJSwjwSdx4KwhxP5/EpG3TmSHCvBIdbUIQ1XoS3U9uMsFsXdb4
 CGqrh8TU6yfZIeGzBBhYfTcYJzDKz0JYtoCRcRWjeGppcW56arFhXmq5XnFibnFpXrpecn7u
 JkZgAjj97/inHYxfLyUdYhTgYFTi4b1gZxEnxJpYVlyZe4hRgoNZSYT3vL5lnBBvSmJlVWpR
 fnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MTdPVDiZVng1dxmGfefXw
 a8VHhw7ZCC3cW1TEaLhh1t2M9yLJ8lVh9+c+fh72dUK6zRcBJmm17zxHPBWLPuksTkretbZ4
 u9Gf/5fl4iuYFV9N1/3z/0cE96+15lIN56MC7jzkOsOy1m2ZptjRd1PPh6y4LXmboy7VIvC8
 6N8Dj7mUH3jIMDNeV2Ipzkg01GIuKk4EAFQfaSL8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xe7p/Qy3jDF7+UbfYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl/P94hLVgtmXFnCNXmBoY2/W6GDk5
 JARMJK4dn8vWxcjFISSwlFGicfkMRoiEjMSP02vYIGxhiT/XuqCKPjFK9O2/ywqSYBNQk9h5
 5DNYg4iApMTvrtPMIDazQJbEztn3mUBsYQEPiSP//rGA2CwCqhIP9t9nB7F5BQIk3q7ZygKx
 QE7i5rlOsF5OgUCJ93smgfUKAdVc2DWLfQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5
 mxiB4bjt2M8tOxi73gUfYhTgYFTi4dVwtIgTYk0sK67MPcQowcGsJMJ7Xt8yTog3JbGyKrUo
 P76oNCe1+BCjKdBRE5mlRJPzgbGSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUg
 tQimj4mDU6qB0SO6+VyN/uWJ7r/KOU/N2F/FpezPxPSHUS/+f9nmCddXFr+z9VnX0bY6wvmV
 WjjXxEupCh7fNeflPWRdblndcWqZzIddGldmOLdmzvqk92RW90O769Jn4jgUGYxKs2czS+67
 rGlX77/h0N7m8x3Zbvd2cL/Te6J3Y3XX38J5z59E2Z1elibLocRSnJFoqMVcVJwIACC6XuVd
 AgAA
X-CMS-MailID: 20200204113109eucas1p18527bb78c3d930d56e6ae9c205f64ba3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113109eucas1p18527bb78c3d930d56e6ae9c205f64ba3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113109eucas1p18527bb78c3d930d56e6ae9c205f64ba3
References: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200204113109eucas1p18527bb78c3d930d56e6ae9c205f64ba3@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 MAINTAINERS                             |   2 +
 hw/misc/memexpose/Makefile.objs         |   1 +
 hw/misc/memexpose/memexpose-memregion.c | 142 ++++++++++++++++++++++++++++++++
 hw/misc/memexpose/memexpose-memregion.h |  41 +++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 hw/misc/memexpose/memexpose-memregion.c
 create mode 100644 hw/misc/memexpose/memexpose-memregion.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 50628e4..2142c07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1647,6 +1647,8 @@ F: hw/misc/memexpose/memexpose-core.c
 F: hw/misc/memexpose/memexpose-msg.h
 F: hw/misc/memexpose/memexpose-msg.c
 F: hw/misc/memexpose/memexpose-pci.c
+F: hw/misc/memexpose/memexpose-memregion.h
+F: hw/misc/memexpose/memexpose-memregion.c
 
 nvme
 M: Keith Busch <keith.busch@intel.com>
diff --git a/hw/misc/memexpose/Makefile.objs b/hw/misc/memexpose/Makefile.objs
index 05a2395..056bff3 100644
--- a/hw/misc/memexpose/Makefile.objs
+++ b/hw/misc/memexpose/Makefile.objs
@@ -1,3 +1,4 @@
 common-obj-y += memexpose-msg.o
 common-obj-y += memexpose-core.o
 common-obj-$(CONFIG_PCI) += memexpose-pci.o
+common-obj-y += memexpose-memregion.o
diff --git a/hw/misc/memexpose/memexpose-memregion.c b/hw/misc/memexpose/memexpose-memregion.c
new file mode 100644
index 0000000..fbdd966
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-memregion.c
@@ -0,0 +1,142 @@
+/*
+ *  Memexpose ARM device
+ *
+ *  Copyright (C) 2020 Samsung Electronics Co Ltd.
+ *    Igor Kotrasinski, <i.kotrasinsk@partner.samsung.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "memexpose-core.h"
+#include "memexpose-memregion.h"
+
+static void memexpose_memdev_intr(void *opaque, int dir)
+{
+    MemexposeMemdev *dev = opaque;
+    if (dir) {
+        qemu_set_irq(dev->irq, 1);
+    } else {
+        qemu_set_irq(dev->irq, 0);
+    }
+}
+
+static int memexpose_memdev_enable(void *opaque)
+{
+    int ret;
+    MemexposeMemdev *s = opaque;
+
+    ret = memexpose_intr_enable(&s->intr);
+    if (ret) {
+        return ret;
+    }
+
+    ret = memexpose_mem_enable(&s->mem);
+    if (ret) {
+        memexpose_intr_disable(&s->intr);
+        return ret;
+    }
+
+    return 0;
+}
+
+static void memexpose_memdev_disable(void *opaque)
+{
+    MemexposeMemdev *s = opaque;
+
+    memexpose_intr_disable(&s->intr);
+    memexpose_mem_disable(&s->mem);
+}
+
+static void memexpose_memdev_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    MemexposeMemdev *mdev = MEMEXPOSE_MEMDEV(obj);
+    sysbus_init_mmio(sbd, &mdev->intr.shmem);
+    sysbus_init_irq(sbd, &mdev->irq);
+}
+
+static void memexpose_memdev_finalize(Object *obj)
+{
+}
+
+static void memexpose_memdev_realize(DeviceState *dev, Error **errp)
+{
+    MemexposeMemdev *mdev = MEMEXPOSE_MEMDEV(dev);
+    struct memexpose_intr_ops ops = {
+        .parent = dev,
+        .intr = memexpose_memdev_intr,
+        .enable = memexpose_memdev_enable,
+        .disable = memexpose_memdev_disable,
+    };
+
+    memexpose_intr_init(&mdev->intr, &ops, OBJECT(dev), &mdev->intr_chr, errp);
+    if (*errp) {
+        return;
+    }
+    memexpose_mem_init(&mdev->mem, OBJECT(dev),
+                       get_system_memory(),
+                       &mdev->mem_chr, 1, errp);
+    if (*errp) {
+        goto free_intr;
+    }
+    return;
+
+free_intr:
+    memexpose_intr_destroy(&mdev->intr);
+}
+
+static void memexpose_memdev_unrealize(DeviceState *dev, Error **errp)
+{
+    MemexposeMemdev *mdev = MEMEXPOSE_MEMDEV(dev);
+    memexpose_mem_destroy(&mdev->mem);
+    memexpose_intr_destroy(&mdev->intr);
+}
+
+static Property memexpose_memdev_properties[] = {
+    DEFINE_PROP_CHR("intr_chardev", MemexposeMemdev, intr_chr),
+    DEFINE_PROP_CHR("mem_chardev", MemexposeMemdev, mem_chr),
+    DEFINE_PROP_UINT64("shm_size", MemexposeMemdev, mem.shmem_size, 4096),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void memexpose_memdev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = memexpose_memdev_realize;
+    dc->unrealize = memexpose_memdev_unrealize;
+    device_class_set_props(dc, memexpose_memdev_properties);
+}
+
+static const TypeInfo memexpose_memdev_info = {
+    .name = TYPE_MEMEXPOSE_MEMDEV,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MemexposeMemdev),
+    .instance_init = memexpose_memdev_init,
+    .instance_finalize = memexpose_memdev_finalize,
+    .class_init = memexpose_memdev_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&memexpose_memdev_info);
+}
+
+type_init(register_types);
diff --git a/hw/misc/memexpose/memexpose-memregion.h b/hw/misc/memexpose/memexpose-memregion.h
new file mode 100644
index 0000000..7eddcbe
--- /dev/null
+++ b/hw/misc/memexpose/memexpose-memregion.h
@@ -0,0 +1,41 @@
+/*
+ *  Memexpose ARM device
+ *
+ *  Copyright (C) 2020 Samsung Electronics Co Ltd.
+ *    Igor Kotrasinski, <i.kotrasinsk@partner.samsung.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef _MEMEXPOSE_MEMDEV_H_
+#define _MEMEXPOSE_MEMDEV_H_
+
+#include "memexpose-core.h"
+#include "hw/sysbus.h"
+
+#define TYPE_MEMEXPOSE_MEMDEV "memexpose-memdev"
+#define MEMEXPOSE_MEMDEV(obj) \
+    OBJECT_CHECK(MemexposeMemdev, (obj), TYPE_MEMEXPOSE_MEMDEV)
+
+typedef struct MemexposeMemdev {
+    SysBusDevice dev;
+    MemexposeIntr intr;
+    MemexposeMem mem;
+    CharBackend intr_chr;
+    CharBackend mem_chr;
+    qemu_irq irq;
+} MemexposeMemdev;
+
+#endif /* _MEMEXPOSE_MEMDEV_H_ */
-- 
2.7.4


