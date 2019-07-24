Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75DCC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 10:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A301A21743
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 10:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A301A21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqEck-00083W-T9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 06:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hqEcW-0007cu-C9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hqEcU-0002yk-Dw
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:35:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hqEcR-0002wh-3o; Wed, 24 Jul 2019 06:35:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 652347FDE9;
 Wed, 24 Jul 2019 10:35:33 +0000 (UTC)
Received: from localhost (dhcp-192-181.str.redhat.com [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EE3260BCE;
 Wed, 24 Jul 2019 10:35:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 24 Jul 2019 12:35:24 +0200
Message-Id: <20190724103524.20916-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 24 Jul 2019 10:35:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2] hw: add compat machines for 4.2
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
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add 4.2 machine types for arm/i440fx/q35/s390x/spapr.

For i440fx and q35, unversioned cpu models are still translated
to -v1, as 0788a56bd1ae ("i386: Make unversioned CPU models be
aliases") states this should only transition to the latest cpu
model version in 4.3 (or later).

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 9 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d9496c936342..64e3fc34401a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2046,10 +2046,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
=20
+static void virt_machine_4_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
+
 static void virt_machine_4_1_options(MachineClass *mc)
 {
+    virt_machine_4_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len)=
;
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(4, 1)
+DEFINE_VIRT_MACHINE(4, 1)
=20
 static void virt_machine_4_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c58a8e594efc..a79d4ad740a0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,6 +27,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
=20
+GlobalProperty hw_compat_4_1[] =3D {};
+const size_t hw_compat_4_1_len =3D G_N_ELEMENTS(hw_compat_4_1);
+
 GlobalProperty hw_compat_4_0[] =3D {
     { "VGA",            "edid", "false" },
     { "secondary-vga",  "edid", "false" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c43705096..2aa1c49701dd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -116,6 +116,9 @@ struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_=
MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
=20
+GlobalProperty pc_compat_4_1[] =3D {};
+const size_t pc_compat_4_1_len =3D G_N_ELEMENTS(pc_compat_4_1);
+
 GlobalProperty pc_compat_4_0[] =3D {};
 const size_t pc_compat_4_0_len =3D G_N_ELEMENTS(pc_compat_4_0);
=20
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c2280c72effb..24e71be1d218 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -433,7 +433,7 @@ static void pc_i440fx_machine_options(MachineClass *m=
)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
=20
-static void pc_i440fx_4_1_machine_options(MachineClass *m)
+static void pc_i440fx_4_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
@@ -442,6 +442,18 @@ static void pc_i440fx_4_1_machine_options(MachineCla=
ss *m)
     pcmc->default_cpu_version =3D 1;
 }
=20
+DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
+                      pc_i440fx_4_2_machine_options);
+
+static void pc_i440fx_4_1_machine_options(MachineClass *m)
+{
+    pc_i440fx_4_2_machine_options(m);
+    m->alias =3D NULL;
+    m->is_default =3D 0;
+    compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
+    compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
+}
+
 DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
                       pc_i440fx_4_1_machine_options);
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 397e1fdd2f37..e61260762cdc 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -365,7 +365,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus =3D 288;
 }
=20
-static void pc_q35_4_1_machine_options(MachineClass *m)
+static void pc_q35_4_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
@@ -373,6 +373,17 @@ static void pc_q35_4_1_machine_options(MachineClass =
*m)
     pcmc->default_cpu_version =3D 1;
 }
=20
+DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
+                   pc_q35_4_2_machine_options);
+
+static void pc_q35_4_1_machine_options(MachineClass *m)
+{
+    pc_q35_4_2_machine_options(m);
+    m->alias =3D NULL;
+    compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
+    compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
+}
+
 DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
                    pc_q35_4_1_machine_options);
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 821f0d4a49ff..6c8aa6054508 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4426,15 +4426,26 @@ static const TypeInfo spapr_machine_info =3D {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
=20
+/*
+ * pseries-4.2
+ */
+static void spapr_machine_4_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class *=
/
+}
+
+DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
+
 /*
  * pseries-4.1
  */
 static void spapr_machine_4_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class *=
/
+    spapr_machine_4_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len)=
;
 }
=20
-DEFINE_SPAPR_MACHINE(4_1, "4.1", true);
+DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
=20
 /*
  * pseries-4.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5b6a9a4e5574..593b34e0e201 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -660,14 +660,26 @@ bool css_migration_enabled(void)
     }                                                                   =
      \
     type_init(ccw_machine_register_##suffix)
=20
+static void ccw_machine_4_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_4_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(4_2, "4.2", true);
+
 static void ccw_machine_4_1_instance_options(MachineState *machine)
 {
+    ccw_machine_4_2_instance_options(machine);
 }
=20
 static void ccw_machine_4_1_class_options(MachineClass *mc)
 {
+    ccw_machine_4_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len)=
;
 }
-DEFINE_CCW_MACHINE(4_1, "4.1", true);
+DEFINE_CCW_MACHINE(4_1, "4.1", false);
=20
 static void ccw_machine_4_0_instance_options(MachineState *machine)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a71d1a53a5c0..d9ec37d80743 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -317,6 +317,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
=20
+extern GlobalProperty hw_compat_4_1[];
+extern const size_t hw_compat_4_1_len;
+
 extern GlobalProperty hw_compat_4_0[];
 extern const size_t hw_compat_4_0_len;
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 859b64c51d45..c840e392515b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -302,6 +302,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
=20
+extern GlobalProperty pc_compat_4_1[];
+extern const size_t pc_compat_4_1_len;
+
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
=20
--=20
2.20.1


