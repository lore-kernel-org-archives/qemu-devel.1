Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8083FC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C6420656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C6420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfjeQ-0008WH-EZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 07:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53616)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjd8-0006qi-PN
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjd7-000469-SE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:28:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2245 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jonathan.cameron@huawei.com>)
 id 1hfjd5-0003pz-DL; Tue, 25 Jun 2019 07:28:51 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 24C6874FDD6BAC980AD9;
 Tue, 25 Jun 2019 19:28:43 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Jun 2019 19:28:34 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Tue, 25 Jun 2019 19:27:47 +0800
Message-ID: <20190625112752.83188-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
References: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] [RFC PATCH 2/7] pci: Add Huawei vendor ID and Huawei
 Emulated CCIX Device IDs.
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jcm@redhat.com,
 linuxarm@huawei.com, Auger Eric <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These device IDs have been allocated for emulated only devices,
giving us more flexibility than would be possible by emulating
real devices.

They will be used for the CCIX PCIe configuration space emulation
modules that follow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci/pci_ids.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 0abe27a53a..f49be07328 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -220,6 +220,11 @@
 #define PCI_VENDOR_ID_FREESCALE          0x1957
 #define PCI_DEVICE_ID_MPC8533E           0x0030
=20
+#define PCI_VENDOR_ID_HUAWEI             0x19E5
+#define PCI_DEVICE_ID_HUAWEI_CCIX_UP     0xA260
+#define PCI_DEVICE_ID_HUAWEI_CCIX_DOWN   0xA261
+#define PCI_DEVICE_ID_HUAWEI_CCIX_EP     0xA262
+
 #define PCI_VENDOR_ID_INTEL              0x8086
 #define PCI_DEVICE_ID_INTEL_82378        0x0484
 #define PCI_DEVICE_ID_INTEL_82441        0x1237
--=20
2.20.1


