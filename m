Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF082C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852CA20730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852CA20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isLKZ-00050h-JP
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 01:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1isLJg-00040O-76
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1isLJc-0003SZ-Co
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:41:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53562 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1isLJT-0003Ju-Iz; Fri, 17 Jan 2020 01:40:59 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A014D327BFE19E16D2E7;
 Fri, 17 Jan 2020 14:40:54 +0800 (CST)
Received: from linux-TFkxOR.huawei.com (10.175.104.212) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 17 Jan 2020 14:40:46 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2] hw/arm: Adjust some coding styles about memory hotplug
Date: Fri, 17 Jan 2020 14:38:22 +0800
Message-ID: <20200117063822.57918-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.19.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com,
 zhukeqian <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhukeqian <zhukeqian1@huawei.com>

There is extra indent in ACPI GED plug cb. And we can use
existing helper function to trigger hotplug handler plug.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---

v1->v2:
 - Add Igor's R-b

Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/acpi/generic_event_device.c | 2 +-
 hw/arm/virt.c                  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_devic=
e.c
index 9cee90cc70..55eb29d80a 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -175,7 +175,7 @@ static void acpi_ged_device_plug_cb(HotplugHandler *h=
otplug_dev,
     AcpiGedState *s =3D ACPI_GED(hotplug_dev);
=20
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp)=
;
+        acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
     } else {
         error_setg(errp, "virt: device plug request for unsupported devi=
ce"
                    " type: %s", object_get_typename(OBJECT(dev)));
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 39ab5f47e0..656b0081c2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1934,7 +1934,6 @@ static void virt_memory_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
 static void virt_memory_plug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    HotplugHandlerClass *hhc;
     VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
     Error *local_err =3D NULL;
=20
@@ -1943,8 +1942,9 @@ static void virt_memory_plug(HotplugHandler *hotplu=
g_dev,
         goto out;
     }
=20
-    hhc =3D HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
-    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &error_abort);
+    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
+                         dev, &error_abort);
+
 out:
     error_propagate(errp, local_err);
 }
--=20
2.19.1


