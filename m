Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C9BECE58F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA842086A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA842086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKZ6m-0002QU-Ir
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 22:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKZ4U-0000kt-Rz
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKZ4T-0004hH-7o
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:29:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKZ4S-0004hA-VO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:29:53 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B52712C9700
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 02:29:51 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id s24so13302485plp.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 19:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WsB6+GPp+fmFBmq7NgMarqLazoY9GUczfYpg6g7hXPI=;
 b=osc5N1PZ98AbC9SJbrASLsoulRWATIZ7g5aL3JZYcW1J7kQEKoZR8K2WPvqytQ40VT
 0DYGdaz2YlM/8surQsoeDIdBoGinsb4j9TQwybSk9+WSg6agZm4m2L21J+peibyNQPfL
 KdSPpR54YAa0S8e6nrwLMqelDeIidT9BEJjRm8cmq+Z35m4lhURkQGBph0uujNfERxIV
 lbZYQKrtnSxrqe9GqDwPhHkvr6+3Y2DWN6QwzA0XI5gbxE5fithlasfQe42rDMDWx68F
 VVW5i9X13Ld6/TJKZlQimthc8ZGvfcjs+hvNpu+LcINZgx143Sk6weD4qmiSS6ubkxjy
 oMaA==
X-Gm-Message-State: APjAAAUbTWgMgmA7OM3KddGnJguptRQa6EG+y4gGPHyZ8rwE6buABgXX
 bMDAvQtNvKme3aaCod8nDjgq1Ny6AU3FU/myoSCK/OJGdYpRbrV6aFuzdmec6NR6Mo+sKmGA18g
 ZcvSu0nha9wQfjr0=
X-Received: by 2002:a17:902:d891:: with SMTP id
 b17mr39173397plz.310.1571192990486; 
 Tue, 15 Oct 2019 19:29:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEtRPWlaxsx1N0MiSPhOHtnz5iVjmKOMf0zeDKW5ZspoDFtqflapK17LeBGXtEtzgKDPMvKA==
X-Received: by 2002:a17:902:d891:: with SMTP id
 b17mr39173362plz.310.1571192990058; 
 Tue, 15 Oct 2019 19:29:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b5sm26175722pfp.38.2019.10.15.19.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 19:29:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] migration: Define VMSTATE_INSTANCE_ID_ANY
Date: Wed, 16 Oct 2019 10:29:30 +0800
Message-Id: <20191016022933.7276-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016022933.7276-1-peterx@redhat.com>
References: <20191016022933.7276-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define the new macro VMSTATE_INSTANCE_ID_ANY for callers who wants to
auto-generate the vmstate instance ID.  Previously it was hard coded
as -1 instead of this macro.  It helps to change this default value in
the follow up patches.  No functional change.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/arm/stellaris.c          | 2 +-
 hw/core/qdev.c              | 3 ++-
 hw/display/ads7846.c        | 2 +-
 hw/i2c/core.c               | 2 +-
 hw/input/stellaris_input.c  | 3 ++-
 hw/intc/apic_common.c       | 2 +-
 hw/misc/max111x.c           | 2 +-
 hw/net/eepro100.c           | 2 +-
 hw/pci/pci.c                | 2 +-
 hw/ppc/spapr.c              | 2 +-
 hw/timer/arm_timer.c        | 2 +-
 hw/tpm/tpm_emulator.c       | 3 ++-
 include/migration/vmstate.h | 2 ++
 migration/savevm.c          | 8 ++++----
 14 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index b198066b54..bb025e0bd0 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -708,7 +708,7 @@ static int stellaris_sys_init(uint32_t base, qemu_irq=
 irq,
     memory_region_init_io(&s->iomem, NULL, &ssys_ops, s, "ssys", 0x00001=
000);
     memory_region_add_subregion(get_system_memory(), base, &s->iomem);
     ssys_reset(s);
-    vmstate_register(NULL, -1, &vmstate_stellaris_sys, s);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_stellaris_s=
ys, s);
     return 0;
 }
=20
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cbad6c1d55..86031f961d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -866,7 +866,8 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
         dev->canonical_path =3D object_get_canonical_path(OBJECT(dev));
=20
         if (qdev_get_vmsd(dev)) {
-            if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(de=
v), dev,
+            if (vmstate_register_with_alias_id(dev, VMSTATE_INSTANCE_ID_=
ANY,
+                                               qdev_get_vmsd(dev), dev,
                                                dev->instance_id_alias,
                                                dev->alias_required_for_v=
ersion,
                                                &local_err) < 0) {
diff --git a/hw/display/ads7846.c b/hw/display/ads7846.c
index c12272ae72..9228b40b1a 100644
--- a/hw/display/ads7846.c
+++ b/hw/display/ads7846.c
@@ -154,7 +154,7 @@ static void ads7846_realize(SSISlave *d, Error **errp=
)
=20
     ads7846_int_update(s);
=20
-    vmstate_register(NULL, -1, &vmstate_ads7846, s);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_ads7846, s)=
;
 }
=20
 static void ads7846_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 92cd489069..d770035ba0 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -61,7 +61,7 @@ I2CBus *i2c_init_bus(DeviceState *parent, const char *n=
ame)
=20
     bus =3D I2C_BUS(qbus_create(TYPE_I2C_BUS, parent, name));
     QLIST_INIT(&bus->current_devs);
-    vmstate_register(NULL, -1, &vmstate_i2c_bus, bus);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_i2c_bus, bu=
s);
     return bus;
 }
=20
diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
index 59892b07fc..e6ee5e11f1 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_input.c
@@ -88,5 +88,6 @@ void stellaris_gamepad_init(int n, qemu_irq *irq, const=
 int *keycode)
     }
     s->num_buttons =3D n;
     qemu_add_kbd_event_handler(stellaris_gamepad_put_key, s);
-    vmstate_register(NULL, -1, &vmstate_stellaris_gamepad, s);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
+                     &vmstate_stellaris_gamepad, s);
 }
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index aafd8e0e33..22da53ce8a 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -331,7 +331,7 @@ static void apic_common_realize(DeviceState *dev, Err=
or **errp)
     }
=20
     if (s->legacy_instance_id) {
-        instance_id =3D -1;
+        instance_id =3D VMSTATE_INSTANCE_ID_ANY;
     }
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_comm=
on,
                                    s, -1, 0, NULL);
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index a713149f16..81ee73e0da 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -146,7 +146,7 @@ static int max111x_init(SSISlave *d, int inputs)
     s->input[7] =3D 0x80;
     s->com =3D 0;
=20
-    vmstate_register(dev, -1, &vmstate_max111x, s);
+    vmstate_register(dev, VMSTATE_INSTANCE_ID_ANY, &vmstate_max111x, s);
     return 0;
 }
=20
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index cc2dd8b1c9..39920c6dc5 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1874,7 +1874,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, Er=
ror **errp)
=20
     s->vmstate =3D g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100))=
;
     s->vmstate->name =3D qemu_get_queue(s->nic)->model;
-    vmstate_register(&pci_dev->qdev, -1, s->vmstate, s);
+    vmstate_register(&pci_dev->qdev, VMSTATE_INSTANCE_ID_ANY, s->vmstate=
, s);
 }
=20
 static void eepro100_instance_init(Object *obj)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index aa05c2b9b2..708f66aac3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -122,7 +122,7 @@ static void pci_bus_realize(BusState *qbus, Error **e=
rrp)
     bus->machine_done.notify =3D pcibus_machine_done;
     qemu_add_machine_init_done_notifier(&bus->machine_done);
=20
-    vmstate_register(NULL, -1, &vmstate_pcibus, bus);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_pcibus, bus=
);
 }
=20
 static void pcie_bus_realize(BusState *qbus, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 514a17ae74..a316399ae9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3029,7 +3029,7 @@ static void spapr_machine_init(MachineState *machin=
e)
      * interface, this is a legacy from the sPAPREnvironment structure
      * which predated MachineState but had a similar function */
     vmstate_register(NULL, 0, &vmstate_spapr, spapr);
-    register_savevm_live("spapr/htab", -1, 1,
+    register_savevm_live("spapr/htab", VMSTATE_INSTANCE_ID_ANY, 1,
                          &savevm_htab_handlers, spapr);
=20
     qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index c2e6211188..1e9dea451a 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -174,7 +174,7 @@ static arm_timer_state *arm_timer_init(uint32_t freq)
=20
     bh =3D qemu_bh_new(arm_timer_tick, s);
     s->timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
-    vmstate_register(NULL, -1, &vmstate_arm_timer, s);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_arm_timer, =
s);
     return s;
 }
=20
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 22f9113432..da7b490489 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -914,7 +914,8 @@ static void tpm_emulator_inst_init(Object *obj)
     tpm_emu->cur_locty_number =3D ~0;
     qemu_mutex_init(&tpm_emu->mutex);
=20
-    vmstate_register(NULL, -1, &vmstate_tpm_emulator, obj);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
+                     &vmstate_tpm_emulator, obj);
 }
=20
 /*
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1fbfd099dd..c551470299 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1113,6 +1113,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMState=
Description *vmsd,
=20
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
=20
+#define  VMSTATE_INSTANCE_ID_ANY  -1
+
 /* Returns: 0 on success, -1 on failure */
 int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
                                    const VMStateDescription *vmsd,
diff --git a/migration/savevm.c b/migration/savevm.c
index bb9462a54d..0074572a52 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -750,7 +750,7 @@ int register_savevm_live(const char *idstr,
=20
     pstrcat(se->idstr, sizeof(se->idstr), idstr);
=20
-    if (instance_id =3D=3D -1) {
+    if (instance_id =3D=3D VMSTATE_INSTANCE_ID_ANY) {
         se->instance_id =3D calculate_new_instance_id(se->idstr);
     } else {
         se->instance_id =3D instance_id;
@@ -817,14 +817,14 @@ int vmstate_register_with_alias_id(DeviceState *dev=
, int instance_id,
=20
             se->compat =3D g_new0(CompatEntry, 1);
             pstrcpy(se->compat->idstr, sizeof(se->compat->idstr), vmsd->=
name);
-            se->compat->instance_id =3D instance_id =3D=3D -1 ?
+            se->compat->instance_id =3D instance_id =3D=3D VMSTATE_INSTA=
NCE_ID_ANY ?
                          calculate_compat_instance_id(vmsd->name) : inst=
ance_id;
-            instance_id =3D -1;
+            instance_id =3D VMSTATE_INSTANCE_ID_ANY;
         }
     }
     pstrcat(se->idstr, sizeof(se->idstr), vmsd->name);
=20
-    if (instance_id =3D=3D -1) {
+    if (instance_id =3D=3D VMSTATE_INSTANCE_ID_ANY) {
         se->instance_id =3D calculate_new_instance_id(se->idstr);
     } else {
         se->instance_id =3D instance_id;
--=20
2.21.0


