Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C5C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4DAF218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DAF218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EpJ-0008VW-Se
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j29GN-00029h-EE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j29GM-0000wD-Dz
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:50:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44310 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j29GM-0000pf-1Y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:50:18 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B2CD2914015217E4814B;
 Thu, 13 Feb 2020 15:50:06 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 15:50:00 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>
Subject: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under arm.
Date: Thu, 13 Feb 2020 15:49:52 +0800
Message-ID: <20200213074952.544-3-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200213074952.544-1-miaoyubo@huawei.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
X-Mailman-Approved-At: Thu, 13 Feb 2020 08:44:55 -0500
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
Cc: imammedo@redhat.com, miaoyubo@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

Since devices could not directly plugged into pxb-pcie, under arm, one
pcie-root port is plugged into pxb-pcie. Due to the bus for each pxb-pcie
is defined as 2 in acpi dsdt tables(one for pxb-pcie, one for pcie-root-p=
ort),
only one device could be plugged into one pxb-pcie.

Signed-off-by: miaoyubo <miaoyubo@huawei.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 9 +++++++++
 include/hw/pci/pcie_port.h          | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
index 47aaaf8fd1..3d896dd452 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -15,6 +15,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "qemu/range.h"
@@ -233,7 +234,15 @@ static void pxb_dev_realize_common(PCIDevice *dev, b=
ool pcie, Error **errp)
=20
     ds =3D qdev_create(NULL, TYPE_PXB_HOST);
     if (pcie) {
+#ifdef __aarch64__
+        bus =3D pci_root_bus_new(ds, "pxb-pcie-internal",
+                               NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
+        bds =3D qdev_create(BUS(bus), "pcie-root-port");
+        bds->id =3D dev_name;
+        qdev_prop_set_uint8(bds, PCIE_ROOT_PORT_PROP_CHASSIS, pxb->bus_n=
r);
+#else
         bus =3D pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_P=
CIE_BUS);
+#endif
     } else {
         bus =3D pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE=
_PXB_BUS);
         bds =3D qdev_create(BUS(bus), "pci-bridge");
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 4b3d254b08..b41d473220 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -64,6 +64,7 @@ int pcie_chassis_add_slot(struct PCIESlot *slot);
 void pcie_chassis_del_slot(PCIESlot *s);
=20
 #define TYPE_PCIE_ROOT_PORT         "pcie-root-port-base"
+#define PCIE_ROOT_PORT_PROP_CHASSIS "chassis"
 #define PCIE_ROOT_PORT_CLASS(klass) \
      OBJECT_CLASS_CHECK(PCIERootPortClass, (klass), TYPE_PCIE_ROOT_PORT)
 #define PCIE_ROOT_PORT_GET_CLASS(obj) \
--=20
2.19.1



