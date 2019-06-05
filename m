Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7A9C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B73207E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B73207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYc78-0004Dk-H5
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:02:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5K-00031b-AM
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5I-0005Tg-9k
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc5H-0004pZ-9u
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id a132so5948999qkb.13
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=BMjQYyCdvFzPEzLYug8aCJTeB4WwbCrsrkhqi7chWAs=;
	b=evxYy03cIp057QhZ1jw6w31BF840isgFGhoo6DELQv2DQRtIazHrHs5p2uFfE8awg5
	RpjS8QR7+9PDAK5Mxd4nisxKv0Rxlgn3zlf92uihYrUYuRbgBk6zkcnMnie5Vju8n6gz
	nNeYjXBCmzx2dR9EtW/4MNT6tJc1PVaLV/VBi52fLlsWFYBk3YDe2LXfDfWCDxaWJOza
	cqE2Dhxjj7gBzotoOR8p6i0P6zdDaGqcgi4FiGstibVEkHaUSIC2ZIxe2yPnylZ8pVzI
	yHnnfyQFFcAs7iPqpWe+PLPdc2WDKgPJAelR+KDm6ea+9dsHvX6ovkkvEWWKXYs8f8b7
	sxjA==
X-Gm-Message-State: APjAAAW2jOMnz7avv5UuJZgn4JGBECzDj/1YVxme8Hd+FcNTGkrHfKQ1
	JghRem94bDHG4dU7ZXZKDrWk883Fe6o=
X-Google-Smtp-Source: APXvYqyHV3r0g71Ao6PgYNSptkDRyqLUAR7qYH9Bn655ri7F8X9slvLWdt+o9KPEBIL/zsv+xMi4SA==
X-Received: by 2002:a37:30c:: with SMTP id 12mr34362555qkd.175.1559764811326; 
	Wed, 05 Jun 2019 13:00:11 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	y129sm12117332qkc.63.2019.06.05.13.00.09
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:10 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190521062836.6541-3-richardw.yang@linux.intel.com>
References: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.193
Subject: [Qemu-devel] [PULL v3 02/17] acpi: pci: use build_append_foo() API
 to construct MCFG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190605200009.sXesnFeWlOjuMH8MZ5mH1Tkq3noE56vhpCDszZqlC18@z>

From: Wei Yang <richardw.yang@linux.intel.com>

build_append_foo() API doesn't need explicit endianness conversions
which eliminates a source of errors and it makes build_mcfg() look like
declarative definition of MCFG table in ACPI spec, which makes it easy
to review.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

v3:
   * add some comment on the Configuration Space base address allocation
     structure
v2:
   * miss the reserved[8] of MCFG in last version, add it back
   * drop SOBs and make sure bios-tables-test all OK
Message-Id: <20190521062836.6541-3-richardw.yang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi-defs.h | 18 ------------------
 hw/acpi/pci.c               | 33 ++++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index f9aa4bd398..57a3f58b0c 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -449,24 +449,6 @@ struct AcpiSratProcessorGiccAffinity {
 
 typedef struct AcpiSratProcessorGiccAffinity AcpiSratProcessorGiccAffinity;
 
-/* PCI fw r3.0 MCFG table. */
-/* Subtable */
-struct AcpiMcfgAllocation {
-    uint64_t address;                /* Base address, processor-relative */
-    uint16_t pci_segment;            /* PCI segment group number */
-    uint8_t start_bus_number;       /* Starting PCI Bus number */
-    uint8_t end_bus_number;         /* Final PCI Bus number */
-    uint32_t reserved;
-} QEMU_PACKED;
-typedef struct AcpiMcfgAllocation AcpiMcfgAllocation;
-
-struct AcpiTableMcfg {
-    ACPI_TABLE_HEADER_DEF;
-    uint8_t reserved[8];
-    AcpiMcfgAllocation allocation[0];
-} QEMU_PACKED;
-typedef struct AcpiTableMcfg AcpiTableMcfg;
-
 /*
  * TCPA Description Table
  *
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index fa0fa30bb9..9510597a19 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -30,17 +30,32 @@
 
 void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
 {
-    AcpiTableMcfg *mcfg;
-    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
+    int mcfg_start = table_data->len;
 
-    mcfg = acpi_data_push(table_data, len);
-    mcfg->allocation[0].address = cpu_to_le64(info->base);
+    /*
+     * PCI Firmware Specification, Revision 3.0
+     * 4.1.2 MCFG Table Description.
+     */
+    acpi_data_push(table_data, sizeof(AcpiTableHeader));
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 8);
 
-    /* Only a single allocation so no need to play with segments */
-    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
-    mcfg->allocation[0].start_bus_number = 0;
-    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
+    /*
+     * Memory Mapped Enhanced Configuration Space Base Address Allocation
+     * Structure
+     */
+    /* Base address, processor-relative */
+    build_append_int_noprefix(table_data, info->base, 8);
+    /* PCI segment group number */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Starting PCI Bus number */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Final PCI Bus number */
+    build_append_int_noprefix(table_data, PCIE_MMCFG_BUS(info->size - 1), 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
 
-    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
+    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
+                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
 }
 
-- 
MST


