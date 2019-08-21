Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6855DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C1A2332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z69Q38IE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C1A2332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0L7N-000359-KQ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0M-0004Tc-Bu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0K-0007zX-MZ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43563)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0J-0007sz-Qn; Wed, 21 Aug 2019 03:26:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Czj9109Rz9sNk; Wed, 21 Aug 2019 17:25:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372349;
 bh=sRXk7SNRvroQ2qFl7AEBNqbIUZ7MSRvgK0vwUkIjtnY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z69Q38IEtwqTqwKBbuh3qQ/2GsBw77JDb41a/mjzLfHB/pD3EkbyxyRNpveVhT9P4
 dU4gtEsD3iB8fMErSWEN+XYmxK2HQsbm8JnF6xjpAt14cFzdVMuWhE5yoW5ggc1JBs
 jaO5v4AmBeqWvo04WpOHrUHpWFAE7btWFygaZNZ4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:03 +1000
Message-Id: <20190821072542.23090-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 03/42] hw: add compat machines for 4.2
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
Cc: lvivier@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, aik@ozlabs.ru,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cornelia Huck <cohuck@redhat.com>

Add 4.2 machine types for arm/i440fx/q35/s390x/spapr.

For i440fx and q35, unversioned cpu models are still translated
to -v1, as 0788a56bd1ae ("i386: Make unversioned CPU models be
aliases") states this should only transition to the latest cpu
model version in 4.3 (or later).

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190724103524.20916-1-cohuck@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
index 02510acb81..0d1629ccb3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2050,10 +2050,17 @@ static void machvirt_machine_init(void)
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
index 32d1ca9abc..83cd1bfeec 100644
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
index 3ab4bcb3ca..95edbbfe9e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -119,6 +119,9 @@ struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_=
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
index 9e187f856a..a70cf0aafc 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -432,7 +432,7 @@ static void pc_i440fx_machine_options(MachineClass *m=
)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
=20
-static void pc_i440fx_4_1_machine_options(MachineClass *m)
+static void pc_i440fx_4_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
@@ -441,6 +441,18 @@ static void pc_i440fx_4_1_machine_options(MachineCla=
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
index be3464f485..d4e8a1cb9f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -364,7 +364,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus =3D 288;
 }
=20
-static void pc_q35_4_1_machine_options(MachineClass *m)
+static void pc_q35_4_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
@@ -372,6 +372,17 @@ static void pc_q35_4_1_machine_options(MachineClass =
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
index e09c67eb75..6587d9b559 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4430,15 +4430,26 @@ static const TypeInfo spapr_machine_info =3D {
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
index 434d933ec9..8bfb6684cb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -663,14 +663,26 @@ bool css_migration_enabled(void)
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
index 739d109fe1..aa35955f7f 100644
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
index 4bb9e29114..ec538df9b7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -301,6 +301,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
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
2.21.0


