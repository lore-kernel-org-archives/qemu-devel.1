Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1F0C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 22:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130A3206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 22:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130A3206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58785 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYHgT-0008AP-49
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 18:13:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hYHfX-0007o2-Jb
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 18:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hYHfW-0003Kx-53
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 18:12:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hYHfV-0003KC-TU; Tue, 04 Jun 2019 18:12:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3AD92F8BEA;
	Tue,  4 Jun 2019 22:12:32 +0000 (UTC)
Received: from gimli.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D06D81001DD9;
	Tue,  4 Jun 2019 22:12:24 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 04 Jun 2019 16:12:24 -0600
Message-ID: <155968619555.19319.478535697621079640.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 04 Jun 2019 22:12:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] [for 4.0.1] q35: Revert to kernel irqchip
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-stable@nongnu.org,
	peterx@redhat.com, mdroth@linux.vnet.ibm.com,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Backport of QEMU v4.1 commit for stable v4.0.1 release

commit c87759ce876a7a0b17c2bf4f0b964bd51f0ee871
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Tue May 14 14:14:41 2019 -0600

    q35: Revert to kernel irqchip

    Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
    the default for the pc-q35-4.0 machine type to use split irqchip, which
    turned out to have disasterous effects on vfio-pci INTx support.  KVM
    resampling irqfds are registered for handling these interrupts, but
    these are non-functional in split irqchip mode.  We can't simply test
    for split irqchip in QEMU as userspace handling of this interrupt is a
    significant performance regression versus KVM handling (GeForce GPUs
    assigned to Windows VMs are non-functional without forcing MSI mode or
    re-enabling kernel irqchip).

    The resolution is to revert the change in default irqchip mode in the
    pc-q35-4.1 machine and create a pc-q35-4.0.1 machine for the 4.0-stable
    branch.  The qemu-q35-4.0 machine type should not be used in vfio-pci
    configurations for devices requiring legacy INTx support without
    explicitly modifying the VM configuration to use kernel irqchip.

Link: https://bugs.launchpad.net/qemu/+bug/1826422
Fixes: b2fc91db8447 ("q35: set split kernel irqchip as default")
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Same code as v1, just updating the commit log as a formal backport of
the merged 4.1 commit.

 hw/core/machine.c    |    3 +++
 hw/i386/pc.c         |    3 +++
 hw/i386/pc_q35.c     |   16 ++++++++++++++--
 include/hw/boards.h  |    3 +++
 include/hw/i386/pc.h |    3 +++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 743fef28982c..5d046a43e3d2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,6 +24,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
+GlobalProperty hw_compat_4_0[] = {};
+const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
+
 GlobalProperty hw_compat_3_1[] = {
     { "pcie-root-port", "x-speed", "2_5" },
     { "pcie-root-port", "x-width", "1" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f2c15bf1f2c3..d98b737b8f3b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -115,6 +115,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
+GlobalProperty pc_compat_4_0[] = {};
+const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
+
 GlobalProperty pc_compat_3_1[] = {
     { "intel-iommu", "dma-drain", "off" },
     { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 372c6b73bebd..45cc29d1adb7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -357,7 +357,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->units_per_default_bus = 1;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
-    m->default_kernel_irqchip_split = true;
+    m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
@@ -365,12 +365,24 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_4_0_machine_options(MachineClass *m)
+static void pc_q35_4_0_1_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
+                   pc_q35_4_0_1_machine_options);
+
+static void pc_q35_4_0_machine_options(MachineClass *m)
+{
+    pc_q35_4_0_1_machine_options(m);
+    m->default_kernel_irqchip_split = true;
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
+    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
+}
+
 DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
                    pc_q35_4_0_machine_options);
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index e231860666a1..fe1885cbffa0 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -293,6 +293,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_4_0[];
+extern const size_t hw_compat_4_0_len;
+
 extern GlobalProperty hw_compat_3_1[];
 extern const size_t hw_compat_3_1_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ca65ef18afb4..43df7230a22b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -293,6 +293,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+extern GlobalProperty pc_compat_4_0[];
+extern const size_t pc_compat_4_0_len;
+
 extern GlobalProperty pc_compat_3_1[];
 extern const size_t pc_compat_3_1_len;
 


