Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6F5C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1532067B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1532067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKYB-0000ku-Ok
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSKX3-0007um-1o
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSKX1-0005Uy-1T
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:35:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSKX0-0005Ue-No
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:35:26 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4C4159445
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 12:35:25 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id a129so24541240qkg.22
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 04:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KCLzSOVUUewzW8if+qSqUXDFPbh6AktYDPGpM9xn7Ec=;
 b=UXVBH9YApB4y6UaFLv2YW5NUd7KbKWeDmybb4VvcOwbnSXFfuaNVQditHHj6tdWNIh
 4k5TIeSgjema8Y/3Rxacb/yZdh8jRswn70Z2gBNHCoLyiqARMuSX6z9JgpSx64VbbtX4
 DIRnVH+fpFGTgvDqI2hX7EZo9FIhtdcSOpPaJu1CVUQXRzNdvzztGw8Xe2AQ8j0L3NCr
 8cJe9m94tK/gw7cwKSRo2HEAXTMVrZ+yL1OR2TzvYrye5uf+D9BnKUKF6GVddO7SiI1k
 QCADWcb4niSSQkYGtdbDUOBQRRIr0GEi9Ug//VAtiZs0Vvq73nGR1hitxC3ze49OoxdU
 OSvQ==
X-Gm-Message-State: APjAAAVZkOLYUzyCgemVCrxFwG6oODk8IkEi9tMlQjNKf1Z4oqs64/SG
 aK5ka3Bk+y01f91ToutdPOzuPiqhY+skjzk4ZsJbyUn/P9KtyCQD8OnW8izNBCjiBCtmGeUEXXy
 gMp7NUU0XqD2UiPo=
X-Received: by 2002:a37:4350:: with SMTP id q77mr1806675qka.266.1573043724160; 
 Wed, 06 Nov 2019 04:35:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOnbB+Sb3lM5qBrbGQNjwe/WN/1rNhKdjS3kBLRuuIl1PsrDLNgR9JRAgqFNQ5VrpU3hI5iQ==
X-Received: by 2002:a37:4350:: with SMTP id q77mr1806626qka.266.1573043723639; 
 Wed, 06 Nov 2019 04:35:23 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id a3sm11387516qkf.76.2019.11.06.04.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 04:35:22 -0800 (PST)
Date: Wed, 6 Nov 2019 07:35:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] hw/i386: AMD-Vi IVRS DMA alias support
Message-ID: <20191106123407.20997-3-mst@redhat.com>
References: <20191106123407.20997-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106123407.20997-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Williamson <alex.williamson@redhat.com>

When we account for DMA aliases in the PCI address space, we can no
longer use a single IVHD entry in the IVRS covering all devices.  We
instead need to walk the PCI bus and create alias ranges when we find
a conventional bus.  These alias ranges cannot overlap with a "Select
All" range (as currently implemented), so we also need to enumerate
each device with IVHD entries.

Importantly, the IVHD entries used here include a Device ID, which is
simply the PCI BDF (Bus/Device/Function).  The guest firmware is
responsible for programming bus numbers, so the final revision of this
table depends on the update mechanism (acpi_build_update) to be called
after guest PCI enumeration.

For an example guest configuration of:

-+-[0000:40]---00.0-[41]----00.0  Intel Corporation 82574L Gigabit Network Connection
 \-[0000:00]-+-00.0  Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
             +-01.0  Device 1234:1111
             +-02.0-[01]----00.0  Intel Corporation 82574L Gigabit Network Connection
             +-02.1-[02]----00.0  Red Hat, Inc. QEMU XHCI Host Controller
             +-02.2-[03]--
             +-02.3-[04]--
             +-02.4-[05]--
             +-02.5-[06-09]----00.0-[07-09]--+-00.0-[08]--
             |                               \-01.0-[09]----00.0  Intel Corporation 82574L Gigabit Network Connection
             +-02.6-[0a-0c]----00.0-[0b-0c]--+-01.0-[0c]--
             |                               \-03.0  Intel Corporation 82540EM Gigabit Ethernet Controller
             +-02.7-[0d]----0e.0  Intel Corporation 82540EM Gigabit Ethernet Controller
             +-03.0  Red Hat, Inc. QEMU PCIe Expander bridge
             +-04.0  Advanced Micro Devices, Inc. [AMD] Device 0020
             +-1f.0  Intel Corporation 82801IB (ICH9) LPC Interface Controller
             +-1f.2  Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA Controller [AHCI mode]
             \-1f.3  Intel Corporation 82801I (ICH9 Family) SMBus Controller

Where we have:

00:02.7 PCI bridge: Intel Corporation 82801 PCI Bridge
 (dmi-to-pci-bridge)
00:03.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
 (pcie-expander-bus)
06:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch (Upstream)
 (pcie-switch-upstream-port)
07:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch (Downstream)
 (pcie-switch-downstream-port)
07:01.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch (Downstream)
 (pcie-switch-downstream-port)
0a:00.0 PCI bridge: Red Hat, Inc. Device 000e
 (pcie-to-pci-bridge)

The following IVRS table is produced:

AMD-Vi: Using IVHD type 0x10
AMD-Vi: device: 00:04.0 cap: 0040 seg: 0 flags: d1 info 0000
AMD-Vi:        mmio-addr: 00000000fed80000
AMD-Vi:   DEV_SELECT			 devid: 40:00.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 41:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 41:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:00.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:01.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:02.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 01:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 01:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:02.1 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 02:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 02:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:02.2 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 03:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 03:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:02.3 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 04:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 04:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:02.4 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 05:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 05:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:02.5 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 06:00.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 07:00.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 08:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 08:1f.7
AMD-Vi:   DEV_SELECT			 devid: 07:01.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 09:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 09:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:02.6 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 0a:00.0 flags: 00
AMD-Vi:   DEV_ALIAS_RANGE		 devid: 0b:00.0 flags: 00 devid_to: 0b:00.0
AMD-Vi:   DEV_RANGE_END		 devid: 0c:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:02.7 flags: 00
AMD-Vi:   DEV_ALIAS_RANGE		 devid: 0d:00.0 flags: 00 devid_to: 00:02.7
AMD-Vi:   DEV_RANGE_END		 devid: 0d:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:03.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:04.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:1f.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:1f.2 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:1f.3 flags: 00

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Message-Id: <157187084880.5439.16700585779699233836.stgit@gimli.home>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 127 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 120 insertions(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9dd3dbb16c..dbdbbf59b9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2518,12 +2518,105 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
  */
 #define IOAPIC_SB_DEVID   (uint64_t)PCI_BUILD_BDF(0, PCI_DEVFN(0x14, 0))
 
+/*
+ * Insert IVHD entry for device and recurse, insert alias, or insert range as
+ * necessary for the PCI topology.
+ */
+static void
+insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    GArray *table_data = opaque;
+    uint32_t entry;
+
+    /* "Select" IVHD entry, type 0x2 */
+    entry = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn) << 8 | 0x2;
+    build_append_int_noprefix(table_data, entry, 4);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
+        PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
+        uint8_t sec = pci_bus_num(sec_bus);
+        uint8_t sub = dev->config[PCI_SUBORDINATE_BUS];
+
+        if (pci_bus_is_express(sec_bus)) {
+            /*
+             * Walk the bus if there are subordinates, otherwise use a range
+             * to cover an entire leaf bus.  We could potentially also use a
+             * range for traversed buses, but we'd need to take care not to
+             * create both Select and Range entries covering the same device.
+             * This is easier and potentially more compact.
+             *
+             * An example bare metal system seems to use Select entries for
+             * root ports without a slot (ie. built-ins) and Range entries
+             * when there is a slot.  The same system also only hard-codes
+             * the alias range for an onboard PCIe-to-PCI bridge, apparently
+             * making no effort to support nested bridges.  We attempt to
+             * be more thorough here.
+             */
+            if (sec == sub) { /* leaf bus */
+                /* "Start of Range" IVHD entry, type 0x3 */
+                entry = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0)) << 8 | 0x3;
+                build_append_int_noprefix(table_data, entry, 4);
+                /* "End of Range" IVHD entry, type 0x4 */
+                entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
+                build_append_int_noprefix(table_data, entry, 4);
+            } else {
+                pci_for_each_device(sec_bus, sec, insert_ivhd, table_data);
+            }
+        } else {
+            /*
+             * If the secondary bus is conventional, then we need to create an
+             * Alias range for everything downstream.  The range covers the
+             * first devfn on the secondary bus to the last devfn on the
+             * subordinate bus.  The alias target depends on legacy versus
+             * express bridges, just as in pci_device_iommu_address_space().
+             * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
+             */
+            uint16_t dev_id_a, dev_id_b;
+
+            dev_id_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
+
+            if (pci_is_express(dev) &&
+                pcie_cap_get_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
+                dev_id_b = dev_id_a;
+            } else {
+                dev_id_b = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
+            }
+
+            /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
+            build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
+            build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
+
+            /* "End of Range" IVHD entry, type 0x4 */
+            entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
+            build_append_int_noprefix(table_data, entry, 4);
+        }
+    }
+}
+
+/* For all PCI host bridges, walk and insert IVHD entries */
+static int
+ivrs_host_bridges(Object *obj, void *opaque)
+{
+    GArray *ivhd_blob = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
+        PCIBus *bus = PCI_HOST_BRIDGE(obj)->bus;
+
+        if (bus) {
+            pci_for_each_device(bus, pci_bus_num(bus), insert_ivhd, ivhd_blob);
+        }
+    }
+
+    return 0;
+}
+
 static void
 build_amd_iommu(GArray *table_data, BIOSLinker *linker)
 {
-    int ivhd_table_len = 28;
+    int ivhd_table_len = 24;
     int iommu_start = table_data->len;
     AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
+    GArray *ivhd_blob = g_array_new(false, true, 1);
 
     /* IVRS header */
     acpi_data_push(table_data, sizeof(AcpiTableHeader));
@@ -2544,6 +2637,27 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                              (1UL << 7),  /* PPRSup       */
                              1);
 
+    /*
+     * A PCI bus walk, for each PCI host bridge, is necessary to create a
+     * complete set of IVHD entries.  Do this into a separate blob so that we
+     * can calculate the total IVRS table length here and then append the new
+     * blob further below.  Fall back to an entry covering all devices, which
+     * is sufficient when no aliases are present.
+     */
+    object_child_foreach_recursive(object_get_root(),
+                                   ivrs_host_bridges, ivhd_blob);
+
+    if (!ivhd_blob->len) {
+        /*
+         *   Type 1 device entry reporting all devices
+         *   These are 4-byte device entries currently reporting the range of
+         *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
+         */
+        build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
+    }
+
+    ivhd_table_len += ivhd_blob->len;
+
     /*
      * When interrupt remapping is supported, we add a special IVHD device
      * for type IO-APIC.
@@ -2551,6 +2665,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
     if (x86_iommu_ir_supported(x86_iommu_get_default())) {
         ivhd_table_len += 8;
     }
+
     /* IVHD length */
     build_append_int_noprefix(table_data, ivhd_table_len, 2);
     /* DeviceID */
@@ -2570,12 +2685,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                              (1UL << 2)   | /* GTSup  */
                              (1UL << 6),    /* GASup  */
                              4);
-    /*
-     *   Type 1 device entry reporting all devices
-     *   These are 4-byte device entries currently reporting the range of
-     *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
-     */
-    build_append_int_noprefix(table_data, 0x0000001, 4);
+
+    /* IVHD entries as found above */
+    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
+    g_array_free(ivhd_blob, TRUE);
 
     /*
      * Add a special IVHD device type.
-- 
MST


