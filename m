Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8824CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE412070A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkWRF+/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE412070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEwS-0002Fm-CI
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkZ-0003Vr-JK
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkV-0005r6-H6
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id h17so4345402wrc.8
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HRStBj2KdNqO3b0sZtzQPcUBRHTt2G+LUu/l85hoZ6g=;
 b=CkWRF+/cxCoGjTws+5S488Mwqj4XlUk3hlx/MoInRSH1whfJVqoPlv4ENLhbcQWY3T
 Pfnhi+6bW1hM0GGkSUrsSpCMOpCmTlmKWCaWQH+NkqsnMQIWIdimUuRoMgJNBwkVKwvm
 lRDAPnMU3P0XWFh56P2ux+zqbVUi0xfw7jUgiEfyVCVEhfmtSZ/+d4g7A2RziTHTU/1f
 Dp2AuNbXQheKmV37fnLPZVwYKGlQZ6ZfCn+laQeduKxTMi6/td/qsoB4bD7znj9tVec0
 kr9lhUpNhLXMlHndFyX4n/wa0l1msR5Z+WvK4EC7A1+Bo+XjdJnmX/uroYDq4vAzxKnx
 bl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HRStBj2KdNqO3b0sZtzQPcUBRHTt2G+LUu/l85hoZ6g=;
 b=k46oKknSpTIvMwfa+4ySR17dO/0hyb8JIzoxWW3iFgK9gGyGy3dzmBaLJN0AyWcGNx
 GwKxjtYKv2Odn6xrc5IVDt7gxj6DXkkzf8GhEZuWLQKhDjOxMIWrkpPHWx54MTkKUJg9
 moLasp6lIgGRz8h99ZpiT3n4w91RfUxhadgC3H58k2B9ysQbhMxmVQyNg5KmgGji/MA1
 f91Xzz9d19Z039G/g1ze60oEC7lOuLS6961GEHPI/W8Ar3T6UDqopiZI4UCt2JJSw275
 TFqJ0tybAjRuhTx5m+Wj+QNsdP7d1C1NZMnk5e8r8jJ5+Y0Hl4gexPn0RN1b2BZI08Gk
 IrZw==
X-Gm-Message-State: AOAM531BEqi+IbMVcwZOHuSjkMignxQY0kbgX3YJ/TJ+TEBIdBXrsHCW
 IVxcMXKybIMLUHwvHUAqW8G/VghMxICM8A==
X-Google-Smtp-Source: ABdhPJys0bS8lZcn7AXINz97iWK+oVXoddseXubUCikcRHodVbAeMi3TVYSWFmsgqNIn/yZ4HXvy5g==
X-Received: by 2002:adf:e784:: with SMTP id n4mr6106967wrm.170.1589466129613; 
 Thu, 14 May 2020 07:22:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/45] ACPI: Build related register address fields via hardware
 error fw_cfg blob
Date: Thu, 14 May 2020 15:21:15 +0100
Message-Id: <20200514142138.20875-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

This patch builds error_block_address and read_ack_register fields
in hardware errors table , the error_block_address points to Generic
Error Status Block(GESB) via bios_linker. The max size for one GESB
is 1kb, For more detailed information, please refer to
document: docs/specs/acpi_hest_ghes.rst

Now we only support one Error source, if necessary, we can extend to
support more.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200512030609.19593-5-gengdongjiu@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 default-configs/arm-softmmu.mak |  1 +
 include/hw/acpi/aml-build.h     |  1 +
 include/hw/acpi/ghes.h          | 28 +++++++++++
 hw/acpi/aml-build.c             |  2 +
 hw/acpi/ghes.c                  | 89 +++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c        |  5 ++
 hw/acpi/Kconfig                 |  4 ++
 hw/acpi/Makefile.objs           |  1 +
 8 files changed, 131 insertions(+)
 create mode 100644 include/hw/acpi/ghes.h
 create mode 100644 hw/acpi/ghes.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 36a0e89daae..8fc09a4a510 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -42,3 +42,4 @@ CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ALLWINNER_H3=y
+CONFIG_ACPI_APEI=y
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 1539fe06671..ed7c89309ef 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -220,6 +220,7 @@ struct AcpiBuildTables {
     GArray *rsdp;
     GArray *tcpalog;
     GArray *vmgenid;
+    GArray *hardware_errors;
     BIOSLinker *linker;
 } AcpiBuildTables;
 
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
new file mode 100644
index 00000000000..50379b0d0ad
--- /dev/null
+++ b/include/hw/acpi/ghes.h
@@ -0,0 +1,28 @@
+/*
+ * Support for generating APEI tables and recording CPER for Guests
+ *
+ * Copyright (c) 2020 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Author: Dongjiu Geng <gengdongjiu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef ACPI_GHES_H
+#define ACPI_GHES_H
+
+#include "hw/acpi/bios-linker-loader.h"
+
+void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
+#endif
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2c3702b8825..3681ec6e3d8 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1578,6 +1578,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
     tables->table_data = g_array_new(false, true /* clear */, 1);
     tables->tcpalog = g_array_new(false, true /* clear */, 1);
     tables->vmgenid = g_array_new(false, true /* clear */, 1);
+    tables->hardware_errors = g_array_new(false, true /* clear */, 1);
     tables->linker = bios_linker_loader_init();
 }
 
@@ -1588,6 +1589,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->table_data, true);
     g_array_free(tables->tcpalog, mfre);
     g_array_free(tables->vmgenid, mfre);
+    g_array_free(tables->hardware_errors, mfre);
 }
 
 /*
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
new file mode 100644
index 00000000000..e1b3f8fcaa4
--- /dev/null
+++ b/hw/acpi/ghes.c
@@ -0,0 +1,89 @@
+/*
+ * Support for generating APEI tables and recording CPER for Guests
+ *
+ * Copyright (c) 2020 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Author: Dongjiu Geng <gengdongjiu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/acpi/ghes.h"
+#include "hw/acpi/aml-build.h"
+
+#define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
+#define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
+
+/* The max size in bytes for one error block */
+#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
+
+/* Now only support ARMv8 SEA notification type error source */
+#define ACPI_GHES_ERROR_SOURCE_COUNT        1
+
+/*
+ * Build table for the hardware error fw_cfg blob.
+ * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
+ * See docs/specs/acpi_hest_ghes.rst for blobs format.
+ */
+void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
+{
+    int i, error_status_block_offset;
+
+    /* Build error_block_address */
+    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+        build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
+    }
+
+    /* Build read_ack_register */
+    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+        /*
+         * Initialize the value of read_ack_register to 1, so GHES can be
+         * writeable after (re)boot.
+         * ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
+         * (GHESv2 - Type 10)
+         */
+        build_append_int_noprefix(hardware_errors, 1, sizeof(uint64_t));
+    }
+
+    /* Generic Error Status Block offset in the hardware error fw_cfg blob */
+    error_status_block_offset = hardware_errors->len;
+
+    /* Reserve space for Error Status Data Block */
+    acpi_data_push(hardware_errors,
+        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
+
+    /* Tell guest firmware to place hardware_errors blob into RAM */
+    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
+                             hardware_errors, sizeof(uint64_t), false);
+
+    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
+        /*
+         * Tell firmware to patch error_block_address entries to point to
+         * corresponding "Generic Error Status Block"
+         */
+        bios_linker_loader_add_pointer(linker,
+            ACPI_GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i,
+            sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
+            error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
+    }
+
+    /*
+     * tell firmware to write hardware_errors GPA into
+     * hardware_errors_addr fw_cfg, once the former has been initialized.
+     */
+    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE,
+        0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f22b1e60977..8397bda4248 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -49,6 +49,7 @@
 #include "sysemu/reset.h"
 #include "kvm_arm.h"
 #include "migration/vmstate.h"
+#include "hw/acpi/ghes.h"
 
 #define ARM_SPI_BASE 32
 
@@ -818,6 +819,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_spcr(tables_blob, tables->linker, vms);
 
+    if (vms->ras) {
+        build_ghes_error_table(tables->hardware_errors, tables->linker);
+    }
+
     if (ms->numa_state->num_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 54209c6f2f1..1932f66af8d 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -28,6 +28,10 @@ config ACPI_HMAT
     bool
     depends on ACPI
 
+config ACPI_APEI
+    bool
+    depends on ACPI
+
 config ACPI_PCI
     bool
     depends on ACPI && PCI
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index cab9bcd457d..72886c79657 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -8,6 +8,7 @@ common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
 common-obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device.o
 common-obj-$(CONFIG_ACPI_HMAT) += hmat.o
+common-obj-$(CONFIG_ACPI_APEI) += ghes.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 common-obj-$(call lnot,$(CONFIG_PC)) += acpi-x86-stub.o
 
-- 
2.20.1


