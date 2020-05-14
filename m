Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CC1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4181220727
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMSsYG34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4181220727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF7y-0005S5-En
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkh-0003c5-5I
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkX-0005uO-C2
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id m24so21022844wml.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nirw5eXnHss9aqmtu3kOT19ZAFewAFaGGQNxyGUvTpA=;
 b=EMSsYG34Md65d3pwsP4trGEzCrMZPtPfjFDHdrRN8aKUVtzYEH+xtMAAX388E2HETY
 XCqxpiAkhtnrg1wue03RRc7IvEIg8EB1g0c8YfJxRMsoPOMJ/rS64HNRcyqRn4H5fo/V
 rthOw1sjxQmNktdvv8looiT7eqZFRWqnH+SUSg+cOLsy1O+H17sBHMCsC7uXkqvo7fXw
 AuNmzzCDVPmwdRkw4L5kWgkPtSWqVWygKF9ro/yCJiOwheyJDHKKRpMOryytsZDwvktV
 pO2D3zsuUWVlt+ee9X5uSk2MlDA8gDNGT8stYc/JX/tWFs+q/kBTvQXwlzHliTT7/zdU
 aDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nirw5eXnHss9aqmtu3kOT19ZAFewAFaGGQNxyGUvTpA=;
 b=ANx2h3I7hOBezKUlYH4VgfwKSL1Y/4zJ8Lxz9/aWpolXS3DuyHSMLWiSGHC/8wHGrW
 0+kmY4EtFrQo7Jzf4bH91ZqfJCO3DCAMoHDS5bwZOGnPUoXV+8z322RSiwpjFj5fV/mV
 ASjTtWsRFwySFIkASgQYYv1tT+PgXrCN6yHLn4jJsvJQoevrgbS/tMT1/ZaHvwixoTPW
 FaBz6GsS5BOB6JrTxqpW5efeND7fFO3GVF8n3e1npWOMKrOhs3D6DFf6Fyc+U5U4iHig
 s4h9k3FGscATyQbqG6o2i4fviWJMAeI33+hWZdgfaXZED+Z5KxaQiI7TgiFLtUsvVhls
 Irog==
X-Gm-Message-State: AGi0Pua07cmbY29dOYrU1rVzlcMMn8/0FOrCfDpy+7bY+Q2K9+wjyNZd
 h376lTcXztuIEEhgbX7ydlUyx/opwXXOvA==
X-Google-Smtp-Source: APiQypLzJcVzUqHgUXUwAQExu3KT+dkPSHLugJ1E4zw4uhcneWOlSO6Ve2t7xlxQ/INclI9vwCYBeQ==
X-Received: by 2002:a1c:208e:: with SMTP id g136mr36723099wmg.80.1589466130752; 
 Thu, 14 May 2020 07:22:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/45] ACPI: Build Hardware Error Source Table
Date: Thu, 14 May 2020 15:21:16 +0100
Message-Id: <20200514142138.20875-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dongjiu Geng <gengdongjiu@huawei.com>

This patch builds Hardware Error Source Table(HEST) via fw_cfg blobs.
Now it only supports ARMv8 SEA, a type of Generic Hardware Error
Source version 2(GHESv2) error source. Afterwards, we can extend
the supported types if needed. For the CPER section, currently it
is memory section because kernel mainly wants userspace to handle
the memory errors.

This patch follows the spec ACPI 6.2 to build the Hardware Error
Source table. For more detailed information, please refer to
document: docs/specs/acpi_hest_ghes.rst

build_ghes_hw_error_notification() helper will help to add Hardware
Error Notification to ACPI tables without using packed C structures
and avoid endianness issues as API doesn't need explicit conversion.

Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200512030609.19593-6-gengdongjiu@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/acpi/ghes.h   |  39 ++++++++++++
 hw/acpi/ghes.c           | 126 +++++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c |   2 +
 3 files changed, 167 insertions(+)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 50379b0d0ad..18debd8cf7c 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -24,5 +24,44 @@
 
 #include "hw/acpi/bios-linker-loader.h"
 
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
+void acpi_build_hest(GArray *table_data, BIOSLinker *linker);
 #endif
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e1b3f8fcaa4..091fd87094e 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -23,6 +23,7 @@
 #include "qemu/units.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/aml-build.h"
+#include "qemu/error-report.h"
 
 #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
 #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
@@ -33,6 +34,42 @@
 /* Now only support ARMv8 SEA notification type error source */
 #define ACPI_GHES_ERROR_SOURCE_COUNT        1
 
+/* Generic Hardware Error Source version 2 */
+#define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
+
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
+
 /*
  * Build table for the hardware error fw_cfg blob.
  * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
@@ -87,3 +124,92 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
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
+        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
+        ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
+
+    switch (source_id) {
+    case ACPI_HEST_SRC_ID_SEA:
+        /*
+         * Notification Structure
+         * Now only enable ARMv8 SEA notification type
+         */
+        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
+        break;
+    default:
+        error_report("Not support this error source");
+        abort();
+    }
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
+        (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t));
+
+    /*
+     * Read Ack Preserve field
+     * We only provide the first bit in Read Ack Register to OSPM to write
+     * while the other bits are preserved.
+     */
+    build_append_int_noprefix(table_data, ~0x1ULL, 8);
+    /* Read Ack Write */
+    build_append_int_noprefix(table_data, 0x1, 8);
+}
+
+/* Build Hardware Error Source Table */
+void acpi_build_hest(GArray *table_data, BIOSLinker *linker)
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
+        "HEST", table_data->len - hest_start, 1, NULL, NULL);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8397bda4248..ef94e034f6d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -821,6 +821,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     if (vms->ras) {
         build_ghes_error_table(tables->hardware_errors, tables->linker);
+        acpi_add_table(table_offsets, tables_blob);
+        acpi_build_hest(tables_blob, tables->linker);
     }
 
     if (ms->numa_state->num_nodes > 0) {
-- 
2.20.1


