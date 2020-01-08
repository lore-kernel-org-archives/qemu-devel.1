Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54587C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A929206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A929206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9ed-0002y9-6x
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1ip9Zv-0005Kb-0x
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1ip9Zt-0002hu-7H
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:32:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2670 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1ip9Zp-0002bk-1H; Wed, 08 Jan 2020 06:32:41 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AF9E8A0369AD87D797C2;
 Wed,  8 Jan 2020 19:32:37 +0800 (CST)
Received: from localhost.localdomain (10.151.151.249) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 19:32:28 +0800
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <pbonzini@redhat.com>, <gengdongjiu@huawei.com>, <mst@redhat.com>,
 <imammedo@redhat.com>, <shannon.zhaosl@gmail.com>,
 <peter.maydell@linaro.org>, <fam@euphon.net>, <rth@twiddle.net>,
 <ehabkost@redhat.com>, <mtosatti@redhat.com>, <xuwei5@huawei.com>,
 <jonathan.cameron@huawei.com>, <james.morse@arm.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <qemu-arm@nongnu.org>
Subject: [PATCH v22 4/9] ACPI: Build Hardware Error Source Table
Date: Wed, 8 Jan 2020 19:32:18 +0800
Message-ID: <1578483143-14905-5-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: zhengxiang9@huawei.com, linuxarm@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch builds Hardware Error Source Table(HEST) via fw_cfg blobs.
Now it only supports ARMv8 SEA, a type of Generic Hardware Error
Source version 2(GHESv2) error source. Afterwards, we can extend
the supported types if needed. For the CPER section, currently it
is memory section because kernel mainly wants userspace to handle
the memory errors.

This patch follows the spec ACPI 6.2 to build the Hardware Error
Source table. For more detailed information, please refer to
document: docs/specs/acpi_hest_ghes.rst

build_append_ghes_notify() will help to add Hardware Error Notification
to ACPI tables without using packed C structures and avoid endianness
issues as API doesn't need explicit conversion.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 hw/acpi/ghes.c           | 118 ++++++++++++++++++++++++++++++++++++++++++++++-
 hw/arm/virt-acpi-build.c |   2 +
 include/hw/acpi/ghes.h   |  40 ++++++++++++++++
 3 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index b7fdbbb..9d37798 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -34,9 +34,42 @@
 
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH       0x400
-
 /* Now only support ARMv8 SEA notification type error source */
 #define ACPI_GHES_ERROR_SOURCE_COUNT        1
+/* Generic Hardware Error Source version 2 */
+#define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
+/* Address offset in Generic Address Structure(GAS) */
+#define GAS_ADDR_OFFSET 4
+
+/*
+ * Hardware Error Notification
+ * ACPI 4.0: 17.3.2.7 Hardware Error Notification
+ * Composes dummy Hardware Error Notification descriptor of specified type
+ */
+static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
+{
+    /* Type */
+    build_append_int_noprefix(table, type, 1);
+    /*
+     * Length:
+     * Total length of the structure in bytes
+     */
+    build_append_int_noprefix(table, 28, 1);
+    /* Configuration Write Enable */
+    build_append_int_noprefix(table, 0, 2);
+    /* Poll Interval */
+    build_append_int_noprefix(table, 0, 4);
+    /* Vector */
+    build_append_int_noprefix(table, 0, 4);
+    /* Switch To Polling Threshold Value */
+    build_append_int_noprefix(table, 0, 4);
+    /* Switch To Polling Threshold Window */
+    build_append_int_noprefix(table, 0, 4);
+    /* Error Threshold Value */
+    build_append_int_noprefix(table, 0, 4);
+    /* Error Threshold Window */
+    build_append_int_noprefix(table, 0, 4);
+}
 
 /*
  * Build table for the hardware error fw_cfg blob.
@@ -92,3 +125,86 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
     bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE,
         0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
 }
+
+/* Build Generic Hardware Error Source version 2 (GHESv2) */
+static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
+{
+    uint64_t address_offset;
+    /*
+     * Type:
+     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
+     */
+    build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
+    /* Source Id */
+    build_append_int_noprefix(table_data, source_id, 2);
+    /* Related Source Id */
+    build_append_int_noprefix(table_data, 0xffff, 2);
+    /* Flags */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Enabled */
+    build_append_int_noprefix(table_data, 1, 1);
+
+    /* Number of Records To Pre-allocate */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* Max Sections Per Record */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* Max Raw Data Length */
+    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
+
+    address_offset = table_data->len;
+    /* Error Status Address */
+    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
+                     4 /* QWord access */, 0);
+    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
+        address_offset + GAS_ADDR_OFFSET,
+        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
+
+    /*
+     * Notification Structure
+     * Now only enable ARMv8 SEA notification type
+     */
+    build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
+
+    /* Error Status Block Length */
+    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
+
+    /*
+     * Read Ack Register
+     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
+     * version 2 (GHESv2 - Type 10)
+     */
+    address_offset = table_data->len;
+    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
+                     4 /* QWord access */, 0);
+    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
+        address_offset + GAS_ADDR_OFFSET,
+        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t));
+
+    /*
+     * Read Ack Preserve
+     * We only provide the first bit in Read Ack Register to OSPM to write
+     * while the other bits are preserved.
+     */
+    build_append_int_noprefix(table_data, ~0x1ULL, 8);
+    /* Read Ack Write */
+    build_append_int_noprefix(table_data, 0x1, 8);
+}
+
+/* Build Hardware Error Source Table */
+void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
+                          BIOSLinker *linker)
+{
+    uint64_t hest_start = table_data->len;
+
+    /* Hardware Error Source Table header*/
+    acpi_data_push(table_data, sizeof(AcpiTableHeader));
+
+    /* Error Source Count */
+    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
+
+    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
+
+    build_header(linker, table_data, (void *)(table_data->data + hest_start),
+        "HEST", table_data->len - hest_start, 1, NULL, "");
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6819fcf..837bbf9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -834,6 +834,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (vms->ras) {
         acpi_add_table(table_offsets, tables_blob);
         build_ghes_error_table(tables->hardware_errors, tables->linker);
+        acpi_build_hest(tables_blob, tables->hardware_errors,
+                             tables->linker);
     }
 
     if (ms->numa_state->num_nodes > 0) {
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 3dbda3f..09a7f86 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -22,5 +22,45 @@
 #ifndef ACPI_GHES_H
 #define ACPI_GHES_H
 
+/*
+ * Values for Hardware Error Notification Type field
+ */
+enum AcpiGhesNotifyType {
+    /* Polled */
+    ACPI_GHES_NOTIFY_POLLED = 0,
+    /* External Interrupt */
+    ACPI_GHES_NOTIFY_EXTERNAL = 1,
+    /* Local Interrupt */
+    ACPI_GHES_NOTIFY_LOCAL = 2,
+    /* SCI */
+    ACPI_GHES_NOTIFY_SCI = 3,
+    /* NMI */
+    ACPI_GHES_NOTIFY_NMI = 4,
+    /* CMCI, ACPI 5.0: 18.3.2.7, Table 18-290 */
+    ACPI_GHES_NOTIFY_CMCI = 5,
+    /* MCE, ACPI 5.0: 18.3.2.7, Table 18-290 */
+    ACPI_GHES_NOTIFY_MCE = 6,
+    /* GPIO-Signal, ACPI 6.0: 18.3.2.7, Table 18-332 */
+    ACPI_GHES_NOTIFY_GPIO = 7,
+    /* ARMv8 SEA, ACPI 6.1: 18.3.2.9, Table 18-345 */
+    ACPI_GHES_NOTIFY_SEA = 8,
+    /* ARMv8 SEI, ACPI 6.1: 18.3.2.9, Table 18-345 */
+    ACPI_GHES_NOTIFY_SEI = 9,
+    /* External Interrupt - GSIV, ACPI 6.1: 18.3.2.9, Table 18-345 */
+    ACPI_GHES_NOTIFY_GSIV = 10,
+    /* Software Delegated Exception, ACPI 6.2: 18.3.2.9, Table 18-383 */
+    ACPI_GHES_NOTIFY_SDEI = 11,
+    /* 12 and greater are reserved */
+    ACPI_GHES_NOTIFY_RESERVED = 12
+};
+
+enum {
+    ACPI_HEST_SRC_ID_SEA = 0,
+    /* future ids go here */
+    ACPI_HEST_SRC_ID_RESERVED,
+};
+
 void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
+void acpi_build_hest(GArray *table_data, GArray *hardware_error,
+                          BIOSLinker *linker);
 #endif
-- 
1.8.3.1


