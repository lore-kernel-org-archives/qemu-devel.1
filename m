Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97DFC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B499F20679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B499F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccxM-0006SE-1I
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccpM-0006rp-10
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccpE-0006xU-LY
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:35 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:33769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccpA-0006i9-4m
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:30 -0400
Received: by mail-qt1-f179.google.com with SMTP id x2so8616651qtr.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=fSB2UlWrSyZig6hn3AvAf9heqhkjtCbsjF21cXeZZpM=;
 b=ZpLNkvpCHElH2hUuIQyskotJ8YvGLs1kznAz6NvCLV3SAECVaS6xXRE10WXt8nhq85
 DwXg8okmCZWp9+Bk9WCmepXyezxOcrQe0ppzhtVy/S2SLlbV0a6VFnuCC41sBHgh43VO
 mZz//G4BBAJTimwZuE4vsypfyo5WWUatUsLsUdwCl4l9/aQ6mp4OlWX4S+O4D4S6qcRj
 mLcMdyv/eIQN8BEHK5w90wHPj501+q/tlfqertkSy7XYzwGGnc6dBMNZxIrnACpcG9Z3
 29ppSFuCxMUeIFb5Aoqq1zRMM70db5LjTEJTgLuvXliHwzTCN4Fup78cH+6/QNPmQ1KY
 gvrQ==
X-Gm-Message-State: APjAAAWS6hgvSZP6r48AcE7CUUZvCrjkFRscr1GLqw4Usb1iQCEiDxCj
 vd7oh7lYSEYmtErk8Y6UeiBobYNn7m0=
X-Google-Smtp-Source: APXvYqxUQACgwZcSR7oxw3ThjSlgs/NzBm4raMTucJgfO/QEqYWOJEwiOFmbNFFNOdR55M+xnNYq+Q==
X-Received: by 2002:ac8:3636:: with SMTP id m51mr90300380qtb.102.1560720981957; 
 Sun, 16 Jun 2019 14:36:21 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id g188sm5015365qkc.52.2019.06.16.14.36.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:21 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190607073429.3436-1-kraxel@redhat.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.179
Subject: [Qemu-devel] [PULL 09/11] q35: fix mmconfig and PCI0._CRS
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190616213620.bZiURjlIMyBo_kyCzC1aXxPlKYszmd6TTaoWq_3OEHo@z>

From: Gerd Hoffmann <kraxel@redhat.com>

This patch changes the handling of the mmconfig area.  Thanks to the
pci(e) expander devices we already have the logic to exclude address
ranges from PCI0._CRS.  We can simply add the mmconfig address range
to the list get it excluded as well.

With that in place we can go with a fixed pci hole which covers the
whole area from the end of (low) ram to the ioapic.

This will make the whole logic alot less fragile.  No matter where the
firmware places the mmconfig xbar, things should work correctly.  The
guest also gets a bit more PCI address space (seabios boot):

    # cat /proc/iomem
    [ ... ]
    7ffdd000-7fffffff : reserved
    80000000-afffffff : PCI Bus 0000:00            <<-- this is new
    b0000000-bfffffff : PCI MMCONFIG 0000 [bus 00-ff]
      b0000000-bfffffff : reserved
    c0000000-febfffff : PCI Bus 0000:00
      f8000000-fbffffff : 0000:00:01.0
    [ ... ]

So this is a guest visible change.

Cc: László Érsek <lersek@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190607073429.3436-1-kraxel@redhat.com>
---
 tests/bios-tables-test-allowed-diff.h |  8 +++++++
 hw/i386/acpi-build.c                  | 14 ++++++++++++
 hw/pci-host/q35.c                     | 31 +++++++--------------------
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
index dfb8523c8b..3bbd22c62a 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1 +1,9 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.mmio64",
+"tests/data/acpi/q35/DSDT.ipmibt",
+"tests/data/acpi/q35/DSDT.cphp",
+"tests/data/acpi/q35/DSDT.memhp",
+"tests/data/acpi/q35/DSDT.numamem",
+"tests/data/acpi/q35/DSDT.dimmpxm",
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f2db7c1e22..31a1c1e3ad 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -121,6 +121,8 @@ typedef struct FwCfgTPMConfig {
     uint8_t tpmppi_version;
 } QEMU_PACKED FwCfgTPMConfig;
 
+static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
+
 static void init_common_fadt_data(Object *o, AcpiFadtData *data)
 {
     uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
@@ -1806,6 +1808,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     CrsRangeSet crs_range_set;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
+    AcpiMcfgInfo mcfg;
     uint32_t nr_mem = machine->ram_slots;
     int root_bus_limit = 0xFF;
     PCIBus *bus = NULL;
@@ -1920,6 +1923,17 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
     }
 
+    /*
+     * At this point crs_range_set has all the ranges used by pci
+     * busses *other* than PCI0.  These ranges will be excluded from
+     * the PCI0._CRS.  Add mmconfig to the set so it will be excluded
+     * too.
+     */
+    if (acpi_get_mcfg(&mcfg)) {
+        crs_range_insert(crs_range_set.mem_ranges,
+                         mcfg.base, mcfg.base + mcfg.size - 1);
+    }
+
     scope = aml_scope("\\_SB.PCI0");
     /* build PCI0._CRS */
     crs = aml_resource_template();
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 172b0bc435..0a010be4cf 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -260,15 +260,6 @@ static void q35_host_initfn(Object *obj)
     object_property_add_link(obj, MCH_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.address_space_io,
                              qdev_prop_allow_set_link_before_realize, 0, NULL);
-
-    /* Leave enough space for the biggest MCFG BAR */
-    /* TODO: this matches current bios behaviour, but
-     * it's not a power of two, which means an MTRR
-     * can't cover it exactly.
-     */
-    range_set_bounds(&s->mch.pci_hole,
-            MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT + MCH_HOST_BRIDGE_PCIEXBAR_MAX,
-            IO_APIC_DEFAULT_ADDRESS - 1);
 }
 
 static const TypeInfo q35_host_info = {
@@ -340,20 +331,6 @@ static void mch_update_pciexbar(MCHPCIState *mch)
     }
     addr = pciexbar & addr_mask;
     pcie_host_mmcfg_update(pehb, enable, addr, length);
-    /* Leave enough space for the MCFG BAR */
-    /*
-     * TODO: this matches current bios behaviour, but it's not a power of two,
-     * which means an MTRR can't cover it exactly.
-     */
-    if (enable) {
-        range_set_bounds(&mch->pci_hole,
-                         addr + length,
-                         IO_APIC_DEFAULT_ADDRESS - 1);
-    } else {
-        range_set_bounds(&mch->pci_hole,
-                         MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT,
-                         IO_APIC_DEFAULT_ADDRESS - 1);
-    }
 }
 
 /* PAM */
@@ -486,6 +463,14 @@ static void mch_update(MCHPCIState *mch)
     mch_update_pam(mch);
     mch_update_smram(mch);
     mch_update_ext_tseg_mbytes(mch);
+
+    /*
+     * pci hole goes from end-of-low-ram to io-apic.
+     * mmconfig will be excluded by the dsdt builder.
+     */
+    range_set_bounds(&mch->pci_hole,
+                     mch->below_4g_mem_size,
+                     IO_APIC_DEFAULT_ADDRESS - 1);
 }
 
 static int mch_post_load(void *opaque, int version_id)
-- 
MST


