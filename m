Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EFAC282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BC9217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BC9217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51861 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHMoP-0006M1-V2
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 02:15:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMma-00055c-M8
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMmZ-0004kP-7s
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMmY-0004jx-WA
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3ED9E368E6;
	Fri, 19 Apr 2019 06:13:54 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BC7B9600C1;
	Fri, 19 Apr 2019 06:13:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 03:13:33 -0300
Message-Id: <20190419061349.17094-2-ehabkost@redhat.com>
In-Reply-To: <20190419061349.17094-1-ehabkost@redhat.com>
References: <20190419061349.17094-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 19 Apr 2019 06:13:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 01/17] hw: add compat machines for 4.1
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
	Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419061333.mZ7ckmLYfnyE8sMJq2SNY5NuO4sYQIIRXNujHHo1Fxo@z>

From: Cornelia Huck <cohuck@redhat.com>

Add 4.1 machine types for arm/i440fx/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190411102025.22559-1-cohuck@redhat.com>
Acked-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 9 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index e231860666..fe1885cbff 100644
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
index ca65ef18af..43df7230a2 100644
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
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ce2664a30b..16ba67f7a7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1978,10 +1978,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_4_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(4, 1)
+
 static void virt_machine_4_0_options(MachineClass *mc)
 {
+    virt_machine_4_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(4, 0)
+DEFINE_VIRT_MACHINE(4, 0)
 
 static void virt_machine_3_1_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 743fef2898..5d046a43e3 100644
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
index f2c15bf1f2..d98b737b8f 100644
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
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8ad8e885c6..2a7700b564 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,13 +428,25 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
 
-static void pc_i440fx_4_0_machine_options(MachineClass *m)
+static void pc_i440fx_4_1_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
+                      pc_i440fx_4_1_machine_options);
+
+static void pc_i440fx_4_0_machine_options(MachineClass *m)
+{
+    pc_i440fx_4_1_machine_options(m);
+    m->alias = NULL;
+    m->is_default = 0;
+    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
+    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
+}
+
 DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
                       pc_i440fx_4_0_machine_options);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 372c6b73be..37dd350511 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -365,12 +365,23 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_4_0_machine_options(MachineClass *m)
+static void pc_q35_4_1_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
+                   pc_q35_4_1_machine_options);
+
+static void pc_q35_4_0_machine_options(MachineClass *m)
+{
+    pc_q35_4_1_machine_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
+    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
+}
+
 DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
                    pc_q35_4_0_machine_options);
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b52b82d298..8438741ec2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4344,15 +4344,26 @@ static const TypeInfo spapr_machine_info = {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-4.1
+ */
+static void spapr_machine_4_1_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(4_1, "4.1", true);
+
 /*
  * pseries-4.0
  */
 static void spapr_machine_4_0_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_4_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
+DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
 
 /*
  * pseries-3.1
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d11069b860..02470e78c7 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -646,14 +646,26 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+static void ccw_machine_4_1_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_4_1_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(4_1, "4.1", true);
+
 static void ccw_machine_4_0_instance_options(MachineState *machine)
 {
+    ccw_machine_4_1_instance_options(machine);
 }
 
 static void ccw_machine_4_0_class_options(MachineClass *mc)
 {
+    ccw_machine_4_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
-DEFINE_CCW_MACHINE(4_0, "4.0", true);
+DEFINE_CCW_MACHINE(4_0, "4.0", false);
 
 static void ccw_machine_3_1_instance_options(MachineState *machine)
 {
-- 
2.18.0.rc1.1.g3f1ff2140


