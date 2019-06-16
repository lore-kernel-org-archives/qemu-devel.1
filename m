Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A32C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5FC20679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5FC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccub-0003hh-Fo
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccpC-0006k7-6w
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccp3-0006fq-5m
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccp3-0006ea-0t
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so8596324qtl.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yqabo49ASCkz0Rxm1TwWtb2+h3VISXZtAT6XKMHEHeo=;
 b=foMAvHjYex6ZejJS+ZOk1sjI65moGMIY6u0jMRXMfYfOgOu25UuB0B7xCyhSOqM0I0
 L2PjIsQTSwQIAgpD7RdEjWyFhZ/WnRfKcr+XiBRWjthO2N8ifMZhoIyAPOa/E/6q4xts
 bsqT8QVfOwLR1IZzwnIswFmMfc3Bl/O48sc6SjfE/sqy3Mu7fYOOjPiqpcf0ejbcDH/l
 YofDSH9VNPuHn1xO7BaZjryY8JlW2437YWtUuwxXQbp3evAB/1/0U8SOOMlvgnYqLD8W
 1Za+sQz2N4mG7acci0fQg2ZW+0WsQzqXoBVAcTv4vx8Bk/aW6KcARB/fWgKhzLDqOSaS
 KEJw==
X-Gm-Message-State: APjAAAXi1BDFC+0m8MfsaFvNjZh2JcWvLrIIgCH6OQPL0a6+LUTeJRuC
 ZyY2Oai9w1jnFvR9/cW2wh/uxw22awE=
X-Google-Smtp-Source: APXvYqxlqGbVEiPUvhJwEUXCzblF9VwNrseDMWn8SUUp/cC92x0lB9Peq3AB/Oxk81wf5xthaMxiBQ==
X-Received: by 2002:aed:3e0f:: with SMTP id l15mr93133756qtf.251.1560720979975; 
 Sun, 16 Jun 2019 14:36:19 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id g53sm5547274qtk.65.2019.06.16.14.36.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:19 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190610011830.28398-1-richardw.yang@linux.intel.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.196
Subject: [Qemu-devel] [PULL 08/11] hw/acpi: extract acpi_add_rom_blob()
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
 Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190616213618.HoWNSxKLvQfyAZLI93wXCM2hfZyMiwmRp_m4cMyyatw@z>

From: Wei Yang <richardw.yang@linux.intel.com>

arm and i386 has almost the same function acpi_add_rom_blob(), except
giving different FWCfgCallback function.

This patch moves acpi_add_rom_blob() to utils.c by passing
FWCfgCallback to it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

v7:
  * rebase on top of current master because of conflict
v6:
  * change author from Igor to Michael
v5:
  * remove unnecessary header glib/gprintf.h
  * rearrange include header to make it more suitable
v4:
  * extract -> moves
  * adjust comment in source to make checkpatch happy
v3:
  * put acpi_add_rom_blob() to hw/acpi/utils.c
v2:
  * remove unused header in original source file
Message-Id: <20190610011830.28398-1-richardw.yang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/utils.h  |  9 +++++++++
 hw/acpi/utils.c          | 35 +++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c | 26 ++++++++++----------------
 hw/i386/acpi-build.c     | 26 ++++++++++----------------
 hw/acpi/Makefile.objs    |  2 +-
 5 files changed, 65 insertions(+), 33 deletions(-)
 create mode 100644 include/hw/acpi/utils.h
 create mode 100644 hw/acpi/utils.c

diff --git a/include/hw/acpi/utils.h b/include/hw/acpi/utils.h
new file mode 100644
index 0000000000..140b4de603
--- /dev/null
+++ b/include/hw/acpi/utils.h
@@ -0,0 +1,9 @@
+#ifndef HW_ACPI_UTILS_H
+#define HW_ACPI_UTILS_H
+
+#include "hw/nvram/fw_cfg.h"
+
+MemoryRegion *acpi_add_rom_blob(FWCfgCallback update, void *opaque,
+                                GArray *blob, const char *name,
+                                uint64_t max_size);
+#endif
diff --git a/hw/acpi/utils.c b/hw/acpi/utils.c
new file mode 100644
index 0000000000..a134a4d554
--- /dev/null
+++ b/hw/acpi/utils.c
@@ -0,0 +1,35 @@
+/*
+ * Utilities for generating ACPI tables and passing them to Guests
+ *
+ * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019 Red Hat Inc
+ *
+ * Author: Wei Yang <richardw.yang@linux.intel.com>
+ * Author: Michael S. Tsirkin <mst@redhat.com>
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
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/utils.h"
+#include "hw/loader.h"
+
+MemoryRegion *acpi_add_rom_blob(FWCfgCallback update, void *opaque,
+                                GArray *blob, const char *name,
+                                uint64_t max_size)
+{
+    return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
+                        name, update, opaque, NULL, true);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9e8b84988d..0afb372769 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -36,9 +36,9 @@
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
-#include "hw/loader.h"
 #include "hw/hw.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
@@ -865,14 +865,6 @@ static void virt_acpi_build_reset(void *build_opaque)
     build_state->patched = false;
 }
 
-static MemoryRegion *acpi_add_rom_blob(AcpiBuildState *build_state,
-                                       GArray *blob, const char *name,
-                                       uint64_t max_size)
-{
-    return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
-                        name, virt_acpi_build_update, build_state, NULL, true);
-}
-
 static const VMStateDescription vmstate_virt_acpi_build = {
     .name = "virt_acpi_build",
     .version_id = 1,
@@ -904,20 +896,22 @@ void virt_acpi_setup(VirtMachineState *vms)
     virt_acpi_build(vms, &tables);
 
     /* Now expose it all to Guest */
-    build_state->table_mr = acpi_add_rom_blob(build_state, tables.table_data,
-                                               ACPI_BUILD_TABLE_FILE,
-                                               ACPI_BUILD_TABLE_MAX_SIZE);
+    build_state->table_mr = acpi_add_rom_blob(virt_acpi_build_update,
+                                              build_state, tables.table_data,
+                                              ACPI_BUILD_TABLE_FILE,
+                                              ACPI_BUILD_TABLE_MAX_SIZE);
     assert(build_state->table_mr != NULL);
 
     build_state->linker_mr =
-        acpi_add_rom_blob(build_state, tables.linker->cmd_blob,
-                          "etc/table-loader", 0);
+        acpi_add_rom_blob(virt_acpi_build_update, build_state,
+                          tables.linker->cmd_blob, "etc/table-loader", 0);
 
     fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
                     acpi_data_len(tables.tcpalog));
 
-    build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
-                                              ACPI_BUILD_RSDP_FILE, 0);
+    build_state->rsdp_mr = acpi_add_rom_blob(virt_acpi_build_update,
+                                             build_state, tables.rsdp,
+                                             ACPI_BUILD_RSDP_FILE, 0);
 
     qemu_register_reset(virt_acpi_build_reset, build_state);
     virt_acpi_build_reset(build_state);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 45c369c923..f2db7c1e22 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -37,7 +37,6 @@
 #include "hw/acpi/piix4.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
-#include "hw/loader.h"
 #include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
 #include "hw/acpi/memory_hotplug.h"
@@ -58,6 +57,7 @@
 #include "hw/i386/x86-iommu.h"
 
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 
 #include "qom/qom-qobject.h"
@@ -2823,14 +2823,6 @@ static void acpi_build_reset(void *build_opaque)
     build_state->patched = 0;
 }
 
-static MemoryRegion *acpi_add_rom_blob(AcpiBuildState *build_state,
-                                       GArray *blob, const char *name,
-                                       uint64_t max_size)
-{
-    return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
-                        name, acpi_build_update, build_state, NULL, true);
-}
-
 static const VMStateDescription vmstate_acpi_build = {
     .name = "acpi_build",
     .version_id = 1,
@@ -2872,14 +2864,15 @@ void acpi_setup(void)
     acpi_build(&tables, MACHINE(pcms));
 
     /* Now expose it all to Guest */
-    build_state->table_mr = acpi_add_rom_blob(build_state, tables.table_data,
-                                               ACPI_BUILD_TABLE_FILE,
-                                               ACPI_BUILD_TABLE_MAX_SIZE);
+    build_state->table_mr = acpi_add_rom_blob(acpi_build_update,
+                                              build_state, tables.table_data,
+                                              ACPI_BUILD_TABLE_FILE,
+                                              ACPI_BUILD_TABLE_MAX_SIZE);
     assert(build_state->table_mr != NULL);
 
     build_state->linker_mr =
-        acpi_add_rom_blob(build_state, tables.linker->cmd_blob,
-                          "etc/table-loader", 0);
+        acpi_add_rom_blob(acpi_build_update, build_state,
+                          tables.linker->cmd_blob, "etc/table-loader", 0);
 
     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
@@ -2916,8 +2909,9 @@ void acpi_setup(void)
         build_state->rsdp_mr = NULL;
     } else {
         build_state->rsdp = NULL;
-        build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
-                                                  ACPI_BUILD_RSDP_FILE, 0);
+        build_state->rsdp_mr = acpi_add_rom_blob(acpi_build_update,
+                                                 build_state, tables.rsdp,
+                                                 ACPI_BUILD_RSDP_FILE, 0);
     }
 
     qemu_register_reset(acpi_build_reset, build_state);
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 661a9b8c2f..9bb2101e3b 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -10,7 +10,7 @@ common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 
 common-obj-y += acpi_interface.o
 common-obj-y += bios-linker-loader.o
-common-obj-y += aml-build.o
+common-obj-y += aml-build.o utils.o
 common-obj-$(CONFIG_ACPI_PCI) += pci.o
 common-obj-$(CONFIG_TPM) += tpm.o
 
-- 
MST


