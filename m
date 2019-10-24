Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13ACCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A6A20663
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A6A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNh9q-0001y8-G8
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNgI0-0003gy-IA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNgHy-0000rh-PU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:48:44 -0400
Received: from 9.mo1.mail-out.ovh.net ([178.32.108.172]:59576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNgHy-0000qW-Jo
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:48:42 -0400
Received: from player687.ha.ovh.net (unknown [10.109.159.222])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 2A2B919595A
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 18:48:32 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 67ECCB55B014;
 Thu, 24 Oct 2019 16:48:24 +0000 (UTC)
Date: Thu, 24 Oct 2019 18:48:23 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v5 4/7] ppc/pnv: Add a PnvChip pointer to PnvCore
Message-ID: <20191024184823.522c02e6@bahia.lan>
In-Reply-To: <ed3b2931-7836-058d-6b93-d35eed3ff859@kaod.org>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-5-clg@kaod.org>
 <20191024023812.GO6439@umbus.fritz.box>
 <ed3b2931-7836-058d-6b93-d35eed3ff859@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 15411036452350368139
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledugddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.108.172
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 11:57:05 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 24/10/2019 04:38, David Gibson wrote:
> > On Tue, Oct 22, 2019 at 06:38:09PM +0200, C=C3=A9dric Le Goater wrote:
> >> We will use it to reset the interrupt presenter from the CPU reset
> >> handler.
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> Reviewed-by: Greg Kurz <groug@kaod.org>
> >> ---
> >>  include/hw/ppc/pnv_core.h | 3 +++
> >>  hw/ppc/pnv_core.c         | 3 ++-
> >>  2 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> >> index bfbd2ec42aa6..55eee95104da 100644
> >> --- a/include/hw/ppc/pnv_core.h
> >> +++ b/include/hw/ppc/pnv_core.h
> >> @@ -31,6 +31,8 @@
> >>  #define PNV_CORE_GET_CLASS(obj) \
> >>       OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
> >> =20
> >> +typedef struct PnvChip PnvChip;
> >> +
> >>  typedef struct PnvCore {
> >>      /*< private >*/
> >>      CPUCore parent_obj;
> >> @@ -38,6 +40,7 @@ typedef struct PnvCore {
> >>      /*< public >*/
> >>      PowerPCCPU **threads;
> >>      uint32_t pir;
> >> +    PnvChip *chip;
> >=20
> > I don't love having this as a redundant encoding of the information
> > already in the property, since it raises the possibility of confusing
> > bugs if they ever got out of sync.
>=20
> Indeed.
>=20
> > It's not a huge deal, but it would be nice to at least to at least
> > consider either a) grabbing the property everywhere you need it (if
> > there aren't too many places)=20
>=20
> We need the chip at core creation and core reset to call the=20
> interrupt chip handlers. These are not hot path but the pointer
> seemed practical.
>=20

FWIW this is also used at core destruction in this patch:

[1/3] ppc: Add intc_destroy() handlers to SpaprInterruptController/PnvChip
https://patchwork.ozlabs.org/patch/1183158/

> > or b) customizing the property
> > definition so it's written directly into that field.
>=20
> OK. That is better than just a link.
>=20

I think David is suggesting to use object_property_add_link()
instead of object_property_add_const_link() actually. Something
like that:

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 55eee95104da..fce6d8d9b31b 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -36,11 +36,11 @@ typedef struct PnvChip PnvChip;
 typedef struct PnvCore {
     /*< private >*/
     CPUCore parent_obj;
+    PnvChip *chip;
=20
     /*< public >*/
     PowerPCCPU **threads;
     uint32_t pir;
-    PnvChip *chip;
=20
     MemoryRegion xscom_regs;
 } PnvCore;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 68cc3c81aa75..90449d33e422 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1312,8 +1312,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Erro=
r **errp)
         object_property_set_int(OBJECT(pnv_core),
                                 pcc->core_pir(chip, core_hwid),
                                 "pir", &error_fatal);
-        object_property_add_const_link(OBJECT(pnv_core), "chip",
-                                       OBJECT(chip), &error_fatal);
+        object_property_set_link(OBJECT(pnv_core), OBJECT(chip), "chip",
+                                 &error_abort);
         object_property_set_bool(OBJECT(pnv_core), true, "realized",
                                  &error_fatal);
=20
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 61b3d3ce2250..8562a9961845 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -217,15 +217,6 @@ static void pnv_core_realize(DeviceState *dev, Error *=
*errp)
     void *obj;
     int i, j;
     char name[32];
-    Object *chip;
-
-    chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
-    if (!chip) {
-        error_propagate_prepend(errp, local_err,
-                                "required link 'chip' not found: ");
-        return;
-    }
-    pc->chip =3D PNV_CHIP(chip);
=20
     pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
@@ -323,6 +314,14 @@ static void pnv_core_class_init(ObjectClass *oc, void =
*data)
     dc->props =3D pnv_core_properties;
 }
=20
+static void pnv_core_instance_init(Object *obj)
+{
+    object_property_add_link(obj, "chip", TYPE_PNV_CHIP,
+                             (Object **) &PNV_CORE(obj)->chip,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, &error_abort);
+}
+
 #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
     {                                           \
         .parent =3D TYPE_PNV_CORE,                \
@@ -335,6 +334,7 @@ static const TypeInfo pnv_core_infos[] =3D {
         .name           =3D TYPE_PNV_CORE,
         .parent         =3D TYPE_CPU_CORE,
         .instance_size  =3D sizeof(PnvCore),
+        .instance_init  =3D pnv_core_instance_init,
         .class_size     =3D sizeof(PnvCoreClass),
         .class_init =3D pnv_core_class_init,
         .abstract       =3D true,
----

> C.=20
>=20
> >=20
> >> =20
> >>      MemoryRegion xscom_regs;
> >>  } PnvCore;
> >> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> >> index 9f981a4940e6..cc17bbfed829 100644
> >> --- a/hw/ppc/pnv_core.c
> >> +++ b/hw/ppc/pnv_core.c
> >> @@ -222,6 +222,7 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
> >>                                  "required link 'chip' not found: ");
> >>          return;
> >>      }
> >> +    pc->chip =3D PNV_CHIP(chip);
> >> =20
> >>      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
> >>      for (i =3D 0; i < cc->nr_threads; i++) {
> >> @@ -243,7 +244,7 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
> >>      }
> >> =20
> >>      for (j =3D 0; j < cc->nr_threads; j++) {
> >> -        pnv_realize_vcpu(pc->threads[j], PNV_CHIP(chip), &local_err);
> >> +        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
> >>          if (local_err) {
> >>              goto err;
> >>          }
> >=20
>=20


