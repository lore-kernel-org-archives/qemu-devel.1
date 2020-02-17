Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D6EC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DACA206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DACA206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b3t-00062p-HC
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2u-0004Gy-IZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2s-0000So-Tm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36470 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2q-0000JD-FD; Mon, 17 Feb 2020 02:42:20 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EAFCB999BEF12C43F04B;
 Mon, 17 Feb 2020 15:42:13 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:07 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 06/16] hw/arm/virt: split MSI related codes from create_gic
Date: Mon, 17 Feb 2020 02:51:18 -0500
Message-ID: <1581925888-103620-7-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
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
Cc: zhang.zhanghailiang@huawei.com, slp@redhat.com,
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GICv2m and GICits is not always needed.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/virt.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9031fd6757..32c3977e32 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -605,6 +605,15 @@ static void create_v2m(VirtMachineState *vms)
     fdt_add_v2m_gic_node(vms);
 }
 
+static void gic_set_msi_interrupt(VirtMachineState *vms)
+{
+    if (vms->gic_version == 3 && vms->its) {
+        create_its(vms);
+    } else if (vms->gic_version == 2) {
+        create_v2m(vms);
+    }
+}
+
 static void create_gic(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -719,12 +728,7 @@ static void create_gic(VirtMachineState *vms)
     }
 
     fdt_add_gic_node(vms);
-
-    if (type == 3 && vms->its) {
-        create_its(vms);
-    } else if (type == 2) {
-        create_v2m(vms);
-    }
+    gic_set_msi_interrupt(vms);
 }
 
 static void create_uart(const VirtMachineState *vms, int uart,
-- 
2.18.1


