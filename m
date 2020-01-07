Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89868C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456D52080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i16E63jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456D52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iortP-0000tg-US
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorlA-0007zp-L3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorl8-0005Sd-HH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20660
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorkg-0005Ej-6p
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcK7WigJMJDie4qherce/SQbHzZxCxCRnKQYLmv9Zf4=;
 b=i16E63jf7USDea/mhN4Ecfgmb6tkEtE8jUOY3EWLdY0v6bbdLk8x7g7Ldbw+Ly3hKchn4w
 qqFNyGYiMCsg6IZiAOg8uI7rcTTmSU5vwVHuaT2u8HBEij33z7czQpQRyyW0h3TId30ps9
 A+FuZ8eFlEzejc+x2IxJDtskn0yaK8c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-ondbbsQZPCS0n5WSjZVc6g-1; Tue, 07 Jan 2020 11:30:39 -0500
Received: by mail-qt1-f197.google.com with SMTP id m30so144233qtb.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OKLjdvfCJDfY6fGqKWe65+lk7+R2Zab8RzeVnW/XRtE=;
 b=HuxmiYEDmaftqVS8TgUvdmAX3Ko9cKKXL5qq+Z/n3Dl7cklhMUObmTidyjdwswMQ9T
 rjapbRgrt3WMj7OiqYORaswNHkP4HbF4pd1S9hG2XscSaN11LHS0XV6216gm1F/YbztI
 Xn2/ZqkSdr/JRLRy8sMZofb5Hyir53EHbN7+6yHWH6IyAyCm7f408oAG3ySWdsBCIgHp
 pp6B8eqAxGSZdnzqv1v0WIKV8q7BwZ6sFouuOKCUxoZbqaB2PuyL92vc613NvQWnFPfx
 4USZZudPtgSFHN6yK80iosEG1Hyz11l+Pksjd52bOUo61pzPz72egLVw43OCec4C6PIG
 My6w==
X-Gm-Message-State: APjAAAXyO5nqdlLMuu0O6TwQipijdwPRzTNA6rEWH+M0uQFZvOO06Boy
 4R/a7LxzIK24BH6K9GRKKiCEPCLEPckZQfL0Rf9NdfYl16nFI7OLHH0i8TmJDXAjs0jxtlXsuI+
 lwuYsLYp3cV+9yj4=
X-Received: by 2002:ac8:43c1:: with SMTP id w1mr67899051qtn.156.1578414638788; 
 Tue, 07 Jan 2020 08:30:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9GFa3d8UuqmbFRYwgQ2QkMrhQxU7Y9SBz60spN42uQcDAdYbq45MROqzx37IWSa+gYb/ZHQ==
X-Received: by 2002:ac8:43c1:: with SMTP id w1mr67899017qtn.156.1578414638413; 
 Tue, 07 Jan 2020 08:30:38 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id n4sm98629qti.55.2020.01.07.08.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:30:37 -0800 (PST)
Date: Tue, 7 Jan 2020 11:30:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 14/32] hmat acpi: Build Memory Proximity Domain Attributes
 Structure(s)
Message-ID: <20200107162850.411448-15-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: ondbbsQZPCS0n5WSjZVc6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Eduardo Habkost <ehabkost@redhat.com>, Liu Jingqi <jingqi.liu@intel.com>,
 Tao Xu <tao3.xu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel Black <daniel@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

HMAT is defined in ACPI 6.3: 5.2.27 Heterogeneous Memory Attribute Table
(HMAT). The specification references below link:
http://www.uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf

It describes the memory attributes, such as memory side cache
attributes and bandwidth and latency details, related to the
Memory Proximity Domain. The software is
expected to use this information as hint for optimization.

This structure describes Memory Proximity Domain Attributes by memory
subsystem and its associativity with processor proximity domain as well as
hint for memory usage.

In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
the platform's HMAT tables.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Daniel Black <daniel@linux.ibm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20191213011929.2520-5-tao3.xu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/hmat.h        | 42 ++++++++++++++++++
 hw/acpi/hmat.c        | 99 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |  5 +++
 hw/acpi/Kconfig       |  7 ++-
 hw/acpi/Makefile.objs |  1 +
 5 files changed, 152 insertions(+), 2 deletions(-)
 create mode 100644 hw/acpi/hmat.h
 create mode 100644 hw/acpi/hmat.c

diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
new file mode 100644
index 0000000000..437dbc6872
--- /dev/null
+++ b/hw/acpi/hmat.h
@@ -0,0 +1,42 @@
+/*
+ * HMAT ACPI Implementation Header
+ *
+ * Copyright(C) 2019 Intel Corporation.
+ *
+ * Author:
+ *  Liu jingqi <jingqi.liu@linux.intel.com>
+ *  Tao Xu <tao3.xu@intel.com>
+ *
+ * HMAT is defined in ACPI 6.3: 5.2.27 Heterogeneous Memory Attribute Tabl=
e
+ * (HMAT)
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>
+ */
+
+#ifndef HMAT_H
+#define HMAT_H
+
+#include "hw/acpi/aml-build.h"
+
+/*
+ * ACPI 6.3: 5.2.27.3 Memory Proximity Domain Attributes Structure,
+ * Table 5-145, Field "flag", Bit [0]: set to 1 to indicate that data in
+ * the Proximity Domain for the Attached Initiator field is valid.
+ * Other bits reserved.
+ */
+#define HMAT_PROXIMITY_INITIATOR_VALID  0x1
+
+void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_st=
ate);
+
+#endif
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
new file mode 100644
index 0000000000..9ff79308a4
--- /dev/null
+++ b/hw/acpi/hmat.c
@@ -0,0 +1,99 @@
+/*
+ * HMAT ACPI Implementation
+ *
+ * Copyright(C) 2019 Intel Corporation.
+ *
+ * Author:
+ *  Liu jingqi <jingqi.liu@linux.intel.com>
+ *  Tao Xu <tao3.xu@intel.com>
+ *
+ * HMAT is defined in ACPI 6.3: 5.2.27 Heterogeneous Memory Attribute Tabl=
e
+ * (HMAT)
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/numa.h"
+#include "hw/acpi/hmat.h"
+
+/*
+ * ACPI 6.3:
+ * 5.2.27.3 Memory Proximity Domain Attributes Structure: Table 5-145
+ */
+static void build_hmat_mpda(GArray *table_data, uint16_t flags,
+                            uint32_t initiator, uint32_t mem_node)
+{
+
+    /* Memory Proximity Domain Attributes Structure */
+    /* Type */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Length */
+    build_append_int_noprefix(table_data, 40, 4);
+    /* Flags */
+    build_append_int_noprefix(table_data, flags, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Proximity Domain for the Attached Initiator */
+    build_append_int_noprefix(table_data, initiator, 4);
+    /* Proximity Domain for the Memory */
+    build_append_int_noprefix(table_data, mem_node, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /*
+     * Reserved:
+     * Previously defined as the Start Address of the System Physical
+     * Address Range. Deprecated since ACPI Spec 6.3.
+     */
+    build_append_int_noprefix(table_data, 0, 8);
+    /*
+     * Reserved:
+     * Previously defined as the Range Length of the region in bytes.
+     * Deprecated since ACPI Spec 6.3.
+     */
+    build_append_int_noprefix(table_data, 0, 8);
+}
+
+/* Build HMAT sub table structures */
+static void hmat_build_table_structs(GArray *table_data, NumaState *numa_s=
tate)
+{
+    uint16_t flags;
+    int i;
+
+    for (i =3D 0; i < numa_state->num_nodes; i++) {
+        flags =3D 0;
+
+        if (numa_state->nodes[i].initiator < MAX_NODES) {
+            flags |=3D HMAT_PROXIMITY_INITIATOR_VALID;
+        }
+
+        build_hmat_mpda(table_data, flags, numa_state->nodes[i].initiator,=
 i);
+    }
+}
+
+void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_st=
ate)
+{
+    int hmat_start =3D table_data->len;
+
+    /* reserve space for HMAT header  */
+    acpi_data_push(table_data, 40);
+
+    hmat_build_table_structs(table_data, numa_state);
+
+    build_header(linker, table_data,
+                 (void *)(table_data->data + hmat_start),
+                 "HMAT", table_data->len - hmat_start, 2, NULL, NULL);
+}
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7b8da62d41..e25df838f0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -68,6 +68,7 @@
 #include "hw/i386/intel_iommu.h"
=20
 #include "hw/acpi/ipmi.h"
+#include "hw/acpi/hmat.h"
=20
 /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
  * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
@@ -2835,6 +2836,10 @@ void acpi_build(AcpiBuildTables *tables, MachineStat=
e *machine)
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, machine);
         }
+        if (machine->numa_state->hmat_enabled) {
+            acpi_add_table(table_offsets, tables_blob);
+            build_hmat(tables_blob, tables->linker, machine->numa_state);
+        }
     }
     if (acpi_get_mcfg(&mcfg)) {
         acpi_add_table(table_offsets, tables_blob);
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 12e3f1e86e..54209c6f2f 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -7,6 +7,7 @@ config ACPI_X86
     select ACPI_NVDIMM
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
+    select ACPI_HMAT
=20
 config ACPI_X86_ICH
     bool
@@ -23,6 +24,10 @@ config ACPI_NVDIMM
     bool
     depends on ACPI
=20
+config ACPI_HMAT
+    bool
+    depends on ACPI
+
 config ACPI_PCI
     bool
     depends on ACPI && PCI
@@ -33,5 +38,3 @@ config ACPI_VMGENID
     depends on PC
=20
 config ACPI_HW_REDUCED
-    bool
-    depends on ACPI
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 99253057e1..777da07f4d 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -7,6 +7,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
 common-obj-$(CONFIG_ACPI_HW_REDUCED) +=3D generic_event_device.o
+common-obj-$(CONFIG_ACPI_HMAT) +=3D hmat.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
 common-obj-$(call lnot,$(CONFIG_PC)) +=3D acpi-x86-stub.o
=20
--=20
MST


