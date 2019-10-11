Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20B3C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8D1206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8D1206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxi1-0001Wt-F9
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxQn-0005yA-3V
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxQk-0004Gl-VI
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:47862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQk-000461-Np
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:14 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQW-0003XG-Er; Fri, 11 Oct 2019 19:06:00 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v5 012/126] hw/i386/amd_iommu: rename Error ** parameter to more
 common errp
Date: Fri, 11 Oct 2019 19:03:58 +0300
Message-Id: <20191011160552.22907-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011160552.22907-1-vsementsov@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: vsementsov@virtuozzo.com, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/i386/amd_iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d3726361dd..c496a0679b 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1533,7 +1533,7 @@ static void amdvi_reset(DeviceState *dev)
     amdvi_init(s);
 }
 
-static void amdvi_realize(DeviceState *dev, Error **err)
+static void amdvi_realize(DeviceState *dev, Error **errp)
 {
     int ret = 0;
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
@@ -1548,21 +1548,21 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     /* This device should take care of IOMMU PCI properties */
     x86_iommu->type = TYPE_AMD;
     qdev_set_parent_bus(DEVICE(&s->pci), &bus->qbus);
-    object_property_set_bool(OBJECT(&s->pci), true, "realized", err);
+    object_property_set_bool(OBJECT(&s->pci), true, "realized", errp);
     ret = pci_add_capability(&s->pci.dev, AMDVI_CAPAB_ID_SEC, 0,
-                                         AMDVI_CAPAB_SIZE, err);
+                                         AMDVI_CAPAB_SIZE, errp);
     if (ret < 0) {
         return;
     }
     s->capab_offset = ret;
 
     ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_MSI, 0,
-                             AMDVI_CAPAB_REG_SIZE, err);
+                             AMDVI_CAPAB_REG_SIZE, errp);
     if (ret < 0) {
         return;
     }
     ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_HT, 0,
-                             AMDVI_CAPAB_REG_SIZE, err);
+                             AMDVI_CAPAB_REG_SIZE, errp);
     if (ret < 0) {
         return;
     }
@@ -1577,8 +1577,8 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
     pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
-    s->devid = object_property_get_int(OBJECT(&s->pci), "addr", err);
-    msi_init(&s->pci.dev, 0, 1, true, false, err);
+    s->devid = object_property_get_int(OBJECT(&s->pci), "addr", errp);
+    msi_init(&s->pci.dev, 0, 1, true, false, errp);
     amdvi_init(s);
 }
 
-- 
2.21.0


