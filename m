Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C3C49EAA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4553920869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4553920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRuuw-0007bj-VT
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iRut0-00056M-BU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iRusy-0007pB-Ni
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52204 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iRusv-0007j9-6e; Tue, 05 Nov 2019 04:12:21 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3F328DAA120616D688B8;
 Tue,  5 Nov 2019 17:12:18 +0800 (CST)
Received: from linux-OtBuvb.huawei.com (10.175.104.212) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 17:12:11 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 14/14] virt/acpi: add SDEI table if SDEI is enabled
Date: Tue, 5 Nov 2019 17:10:56 +0800
Message-ID: <20191105091056.9541-15-guoheyi@huawei.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, James Morse <james.morse@arm.com>,
 Igor Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add SDEI table if SDEI is enabled, so that guest OS can get aware and
utilize the interfaces.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    v2:
    - Drop SDEI table definition and add comments

 hw/arm/virt-acpi-build.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4cd50175e0..73d3f8cd15 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 #include "hw/core/cpu.h"
 #include "target/arm/cpu.h"
+#include "target/arm/sdei.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
@@ -475,6 +476,26 @@ build_iort(GArray *table_data, BIOSLinker *linker, V=
irtMachineState *vms)
                  "IORT", table_data->len - iort_start, 0, NULL, NULL);
 }
=20
+/*
+ * ACPI spec 6.2 Software Delegated Exception Interface (SDEI).
+ * (Revision 1.0)
+ * "SDEI" was reserved in ACPI 6.2. See "Links to ACPI-Related Documents=
"
+ * (http://uefi.org/acpi) under the heading "Software
+ * Delegated Exceptions Interface." The definition is under
+ * "10 Appendix C: ACPI table definitions for SDEI" in the linked docume=
nt.
+ *
+ * This is a dummy table to expose platform SDEI capbility to OS.
+ */
+static void
+build_sdei(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms=
)
+{
+    int sdei_start =3D table_data->len;
+
+    (void)acpi_data_push(table_data, sizeof(AcpiTableHeader));
+    build_header(linker, table_data, (void *)(table_data->data + sdei_st=
art),
+                 "SDEI", table_data->len - sdei_start, 1, NULL, NULL);
+}
+
 static void
 build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms=
)
 {
@@ -825,6 +846,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuil=
dTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_spcr(tables_blob, tables->linker, vms);
=20
+    if (sdei_enabled) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_sdei(tables_blob, tables->linker, vms);
+    }
+
     if (ms->numa_state->num_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
--=20
2.19.1


