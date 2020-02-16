Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD554C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 10:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7D320857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 10:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7D320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3H7F-0007At-P4
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 05:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1j3H3v-00018l-8L
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 05:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1j3H3t-00008s-Rq
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 05:22:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41254 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1j3H3q-0008Tp-BZ; Sun, 16 Feb 2020 05:22:02 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2DCF687C460E281133E6;
 Sun, 16 Feb 2020 18:21:57 +0800 (CST)
Received: from huawei.com (10.151.151.243) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Sun, 16 Feb 2020
 18:21:50 +0800
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <mst@redhat.com>, <imammedo@redhat.com>, <xiaoguangrong.eric@gmail.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <fam@euphon.net>,
 <rth@twiddle.net>, <ehabkost@redhat.com>, <mtosatti@redhat.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <pbonzini@redhat.com>, <james.morse@arm.com>, <lersek@redhat.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v23 5/9] ACPI: Record the Generic Error Status Block address
Date: Sun, 16 Feb 2020 18:24:04 +0800
Message-ID: <20200216102408.22987-7-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20200216102408.22987-1-gengdongjiu@huawei.com>
References: <20200216102408.22987-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.243]
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
Cc: zhengxiang9@huawei.com, gengdongjiu@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Record the GHEB address via fw_cfg file, when recording
a error to CPER, it will use this address to find out
Generic Error Data Entries and write the error.

In order to avoid migration failure, make hardware
error table address to a part of GED device instead
of global variable, then this address will be migrated
to target QEMU.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Acked-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 hw/acpi/generic_event_device.c         | 18 ++++++++++++++++++
 hw/acpi/ghes.c                         | 17 +++++++++++++++++
 hw/arm/virt-acpi-build.c               | 10 ++++++++++
 include/hw/acpi/generic_event_device.h |  2 ++
 include/hw/acpi/ghes.h                 |  6 ++++++
 5 files changed, 53 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 021ed2b..d59607c 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -234,6 +234,23 @@ static const VMStateDescription vmstate_ged_state = {
     }
 };
 
+static bool ghes_needed(void *opaque)
+{
+    return object_property_get_bool(qdev_get_machine(), "ras", NULL);
+}
+
+static const VMStateDescription vmstate_ghes_state = {
+    .name = "acpi-ged/ghes",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ghes_needed,
+    .fields      = (VMStateField[]) {
+        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
+                       vmstate_ghes_state, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_acpi_ged = {
     .name = "acpi-ged",
     .version_id = 1,
@@ -244,6 +261,7 @@ static const VMStateDescription vmstate_acpi_ged = {
     },
     .subsections = (const VMStateDescription * []) {
         &vmstate_memhp_state,
+        &vmstate_ghes_state,
         NULL
     }
 };
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 7a7381d..cea2bff 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -24,6 +24,8 @@
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/aml-build.h"
 #include "qemu/error-report.h"
+#include "hw/acpi/generic_event_device.h"
+#include "hw/nvram/fw_cfg.h"
 
 #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
 #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
@@ -213,3 +215,18 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker)
     build_header(linker, table_data, (void *)(table_data->data + hest_start),
         "HEST", table_data->len - hest_start, 1, NULL, "");
 }
+
+void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
+                          GArray *hardware_error)
+{
+    size_t size = 2 * sizeof(uint64_t) + ACPI_GHES_MAX_RAW_DATA_LENGTH;
+    size_t request_block_size = ACPI_GHES_ERROR_SOURCE_COUNT * size;
+
+    /* Create a read-only fw_cfg file for GHES */
+    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
+                    request_block_size);
+
+    /* Create a read-write fw_cfg file for Address */
+    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
+        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 12a9a78..d6e7521 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -832,6 +832,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_spcr(tables_blob, tables->linker, vms);
 
     if (vms->ras) {
+        assert(vms->acpi_dev);
         acpi_add_table(table_offsets, tables_blob);
         build_ghes_error_table(tables->hardware_errors, tables->linker);
         acpi_build_hest(tables_blob, tables->linker);
@@ -924,6 +925,7 @@ void virt_acpi_setup(VirtMachineState *vms)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
+    AcpiGedState *acpi_ged_state;
 
     if (!vms->fw_cfg) {
         trace_virt_acpi_setup();
@@ -954,6 +956,14 @@ void virt_acpi_setup(VirtMachineState *vms)
     fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
                     acpi_data_len(tables.tcpalog));
 
+    if (vms->ras) {
+        assert(vms->acpi_dev);
+        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                                           NULL));
+        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
+                             vms->fw_cfg, tables.hardware_errors);
+    }
+
     build_state->rsdp_mr = acpi_add_rom_blob(virt_acpi_build_update,
                                              build_state, tables.rsdp,
                                              ACPI_BUILD_RSDP_FILE, 0);
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d157eac..037d2b5 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -61,6 +61,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/acpi/memory_hotplug.h"
+#include "hw/acpi/ghes.h"
 
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
 
@@ -95,6 +96,7 @@ typedef struct AcpiGedState {
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;
+    AcpiGhesState ghes_state;
 } AcpiGedState;
 
 void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 18debd8..a3420fc 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -62,6 +62,12 @@ enum {
     ACPI_HEST_SRC_ID_RESERVED,
 };
 
+typedef struct AcpiGhesState {
+    uint64_t ghes_addr_le;
+} AcpiGhesState;
+
 void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
 void acpi_build_hest(GArray *table_data, BIOSLinker *linker);
+void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
+                          GArray *hardware_errors);
 #endif
-- 
1.8.3.1


