Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D288C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC3A20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l+dEYtKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC3A20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3yb-0000lj-Ko
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oa-0003rH-QJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oZ-0002hv-1x
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:32 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48187 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oY-0002db-LC; Wed, 08 Jan 2020 00:23:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMC0ZBcz9sSL; Wed,  8 Jan 2020 16:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460999;
 bh=/M+wuYlE/0AJhHE/VubrYWO2dOP6d45pWjNLeGuCaxg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l+dEYtKO+nwZOJO3Qz9ABRV2zuOy6+47P4CcnDV+XWKbEkyPVuhZ0K3q44HGtSoK3
 CMbhgIlkAKxMeaO7NdbNL2JKGxIQzrG8a0F53NBqTXsOBZV9Z0pg5A20u8kTKNRAe3
 +2L3DHDmavteTyRk+ugYXOqzbhugg3pg9xm8cdEM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 11/26] ppc/pnv: Drop "num-chips" machine property
Date: Wed,  8 Jan 2020 16:22:57 +1100
Message-Id: <20200108052312.238710-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The number of CPU chips of the powernv machine is configurable through a
"num-chips" property. This doesn't fit well with the CPU topology, eg.
some configurations can come up with more CPUs than the maximum of CPUs
set in the toplogy. This causes assertion to be hit with mttcg:

   -machine powernv,num-chips=3D2 -smp cores=3D2 -accel tcg,thread=3Dmult=
i

ERROR:
tcg/tcg.c:789:tcg_register_thread: assertion failed: (n < ms->smp.max_cpu=
s)
Aborted (core dumped)

Mttcg mandates the CPU topology to be dimensioned to the actual number
of CPUs, depending on the number of chips the user asked for. That is,
'-machine num-chips=3DN' should always have a '-smp' companion with a
topology that meats the resulting number of CPUs, typically
'-smp sockets=3DN'.

It thus seems that "num-chips" doesn't bring anything but forcing the use=
r
to specify the requested number of chips on the command line twice. Simpl=
ify
the command line by computing the number of chips based on the CPU topolo=
gy
exclusively. The powernv machine isn't a production thing ; it is mostly
used by developpers to prepare the bringup of real HW. Because of this an=
d
for simplicity, this deliberately ignores the official deprecation proces=
s
and dumps "num-chips" right away : '-smp sockets=3DN' is now the only way=
 to
control the number of CPU chips.

This is done at machine init because smp_parse() is called after instance
init.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157830658266.533764.2214183961444213947.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 62 ++++++++++------------------------------------------
 1 file changed, 12 insertions(+), 50 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 855254f282..6d7bf9280e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -768,6 +768,18 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
=20
+    pnv->num_chips =3D
+        machine->smp.max_cpus / (machine->smp.cores * machine->smp.threa=
ds);
+    /*
+     * TODO: should we decide on how many chips we can create based
+     * on #cores and Venice vs. Murano vs. Naples chip type etc...,
+     */
+    if (!is_power_of_2(pnv->num_chips) || pnv->num_chips > 4) {
+        error_report("invalid number of chips: '%d'", pnv->num_chips);
+        error_printf("Try '-smp sockets=3DN'. Valid values are : 1, 2 or=
 4.\n");
+        exit(1);
+    }
+
     pnv->chips =3D g_new0(PnvChip *, pnv->num_chips);
     for (i =3D 0; i < pnv->num_chips; i++) {
         char chip_name[32];
@@ -1696,53 +1708,6 @@ PnvChip *pnv_get_chip(uint32_t chip_id)
     return NULL;
 }
=20
-static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    visit_type_uint32(v, name, &PNV_MACHINE(obj)->num_chips, errp);
-}
-
-static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    PnvMachineState *pnv =3D PNV_MACHINE(obj);
-    uint32_t num_chips;
-    Error *local_err =3D NULL;
-
-    visit_type_uint32(v, name, &num_chips, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    /*
-     * TODO: should we decide on how many chips we can create based
-     * on #cores and Venice vs. Murano vs. Naples chip type etc...,
-     */
-    if (!is_power_of_2(num_chips) || num_chips > 4) {
-        error_setg(errp, "invalid number of chips: '%d'", num_chips);
-        return;
-    }
-
-    pnv->num_chips =3D num_chips;
-}
-
-static void pnv_machine_instance_init(Object *obj)
-{
-    PnvMachineState *pnv =3D PNV_MACHINE(obj);
-    pnv->num_chips =3D 1;
-}
-
-static void pnv_machine_class_props_init(ObjectClass *oc)
-{
-    object_class_property_add(oc, "num-chips", "uint32",
-                              pnv_get_num_chips, pnv_set_num_chips,
-                              NULL, NULL, NULL);
-    object_class_property_set_description(oc, "num-chips",
-                              "Specifies the number of processor chips",
-                              NULL);
-}
-
 static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -1812,8 +1777,6 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
      */
     mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
     ispc->print_info =3D pnv_pic_print_info;
-
-    pnv_machine_class_props_init(oc);
 }
=20
 #define DEFINE_PNV8_CHIP_TYPE(type, class_initfn) \
@@ -1866,7 +1829,6 @@ static const TypeInfo types[] =3D {
         .parent        =3D TYPE_MACHINE,
         .abstract       =3D true,
         .instance_size =3D sizeof(PnvMachineState),
-        .instance_init =3D pnv_machine_instance_init,
         .class_init    =3D pnv_machine_class_init,
         .class_size    =3D sizeof(PnvMachineClass),
         .interfaces =3D (InterfaceInfo[]) {
--=20
2.24.1


