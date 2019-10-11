Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4128C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9D820659
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9D820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqP4-0005ur-PL
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIqMh-0003NP-QH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIqMf-0007oA-HU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:33:35 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:36265)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIqMf-0007md-9U
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:33:33 -0400
Received: from player692.ha.ovh.net (unknown [10.108.42.174])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id EA70522AFB3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 10:33:30 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 206BEAB91CCC;
 Fri, 11 Oct 2019 08:33:18 +0000 (UTC)
Date: Fri, 11 Oct 2019 10:33:15 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191011103315.3b790ea1@bahia.lan>
In-Reply-To: <20191011081333.7e483b95@bahia.lan>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
 <20191009190215.7e05c017@bahia.lan>
 <20191010020209.GC28552@umbus.fritz.box>
 <20191010082958.12e17561@bahia.lan>
 <20191010223304.0cf7ccd3@bahia.lan>
 <20191011050758.GD4080@umbus.fritz.box>
 <20191011081333.7e483b95@bahia.lan>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B8sYyNEkGG=dqFCrX6v58hr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 4492903582431287782
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrieehgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.43.173
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/B8sYyNEkGG=dqFCrX6v58hr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2019 08:13:33 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 11 Oct 2019 16:07:58 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Oct 10, 2019 at 10:33:04PM +0200, Greg Kurz wrote:
> > > On Thu, 10 Oct 2019 08:29:58 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > >=20
> > > > On Thu, 10 Oct 2019 13:02:09 +1100
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >=20
> > > > > On Wed, Oct 09, 2019 at 07:02:15PM +0200, Greg Kurz wrote:
> > > > > > On Wed,  9 Oct 2019 17:08:16 +1100
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >=20
> > > > > > > The only thing remaining in this structure are the flags to a=
llow either
> > > > > > > XICS or XIVE to be present.  These actually make more sense a=
s spapr
> > > > > > > capabilities - that way they can take advantage of the existi=
ng
> > > > > > > infrastructure to sanity check capability states across migra=
tion and so
> > > > > > > forth.
> > > > > > >=20
> > > > > >=20
> > > > > > The user can now choose the interrupt controller mode either th=
rough
> > > > > > ic-mode or through cap-xics/cap-xive. I guess it doesn't break =
anything
> > > > > > to expose another API to do the same thing but it raises some q=
uestions.
> > > > > >=20
> > > > > > We should at least document somewhere that ic-mode is an alias =
to these
> > > > > > caps, and maybe state which is the preferred method (I personal=
ly vote
> > > > > > for the caps).
> > > > > >=20
> > > > > > Also, we must keep ic-mode for the moment to stay compatible wi=
th the
> > > > > > existing pseries-4.0 and pseries-4.1 machine types, but will we
> > > > > > keep ic-mode forever ? If no, maybe start by not allowing it for
> > > > > > pseries-4.2 ?
> > > > >=20
> > > > > I'm actually inclined to keep it for now, maybe even leave it as =
the
> > > > > suggested way to configure this.  The caps are nice from an inter=
nal
> > > > > organization point of view, but ic-mode is arguably a more user
> > > > > friendly way of configuring it.  The conversion of one to the oth=
er is
> > > > > straightforward, isolated ans small, so I'm not especially bother=
ed by
> > > > > keeping it around.
> > > > >=20
> > > >=20
> > > > Fair enough.
> > > >=20
> > > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > >=20
> > >=20
> > > But unfortunately this still requires care :-\
> > >=20
> > > qemu-system-ppc64: cap-xive higher level (1) in incoming stream than =
on destination (0)
> > > qemu-system-ppc64: error while loading state for instance 0x0 of devi=
ce 'spapr'
> > > qemu-system-ppc64: load of migration failed: Invalid argument
> > >=20
> > > or
> > >=20
> > > qemu-system-ppc64: cap-xics higher level (1) in incoming stream than =
on destination (0)
> > > qemu-system-ppc64: error while loading state for instance 0x0 of devi=
ce 'spapr'
> > > qemu-system-ppc64: load of migration failed: Invalid argument
> > >=20
> > > when migrating from QEMU 4.1 with ic-mode=3Dxics and ic-mode=3Dxive r=
espectively.
> > >=20
> > > This happens because the existing pseries-4.1 machine type doesn't se=
nd the
> > > new caps and the logic in spapr_caps_post_migration() wrongly assumes=
 that
> > > the source has both caps set:
> > >=20
> > >     srccaps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_type=
);
> > >     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > >         /* If not default value then assume came in with the migratio=
n */
> > >         if (spapr->mig.caps[i] !=3D spapr->def.caps[i]) {
> > >=20
> > > spapr->mig.caps[SPAPR_CAP_XICS] =3D 0
> > > spapr->mig.caps[SPAPR_CAP_XIVE] =3D 0
> > >=20
> > >             srccaps.caps[i] =3D spapr->mig.caps[i];
> > >=20
> > > srcaps.caps[SPAPR_CAP_XICS] =3D 1
> > > srcaps.caps[SPAPR_CAP_XIVE] =3D 1
> > >=20
> > >         }
> > >     }
> > >=20
> > > and breaks
> > >=20
> > >     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > >         SpaprCapabilityInfo *info =3D &capability_table[i];
> > >=20
> > >         if (srccaps.caps[i] > dstcaps.caps[i]) {
> > >=20
> > > srcaps.caps[SPAPR_CAP_XICS] =3D 0 when ic-mode=3Dxive
> > > srcaps.caps[SPAPR_CAP_XIVE] =3D 0 when ic-mode=3Dxics
> > >=20
> > >             error_report("cap-%s higher level (%d) in incoming stream=
 than on destination (%d)",
> > >                          info->name, srccaps.caps[i], dstcaps.caps[i]=
);
> > >             ok =3D false;
> > >         }
> >=20
> > Ah.. right.  I thought there would be problems with backwards
> > migration, but I didn't think of this problem even with forward
> > migration.
> >=20
> > > Maybe we shouldn't check capabilities that we know the source
> > > isn't supposed to send, eg. by having a smc->max_cap ?
> >=20
> > Uh.. I'm not really sure what exactly you're suggesting here.
> >=20
>=20
> I'm suggesting to have a per-machine version smc->max_cap that
> contains the highest supported cap index, to be used instead of
> SPAPR_CAP_NUM in this functions, ie.
>=20
> for (i =3D 0; i <=3D smc->max_cap; i++) {
>     ...
> }
>=20
> where we would have
>=20
> smc->max_cap =3D SPAPR_CAP_CCF_ASSIST for pseries-4.1
>=20
> and
>=20
> smc->max_cap =3D SPAPR_CAP_XIVE for psereis-4.2
>=20
> > I think what we need here is a custom migrate_needed function, like we
> > already have for cap_hpt_maxpagesize, to exclude it from the migration
> > stream for machine versions before 4.2.
> >=20
>=20
> No, VMState needed() hooks are for outgoing migration only.
>=20

Well we actually do need a needed() function to fix backward
migration, but it doesn't solve anything with forward migration.

I'm thinking about something like this to address both:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 66b68fdd5ef5..1342058c1aae 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -83,7 +83,12 @@ typedef enum {
 #define SPAPR_CAP_XICS                  0x0a
 /* XIVE interrupt controller */
 #define SPAPR_CAP_XIVE                  0x0b
-/* Num Caps */
+/*
+ * Num Caps.
+ *
+ * CAUTION: when new caps are being added, older machine types should
+ * set smc->mig_cap_num to the previous value of SPAPR_CAP_NUM.
+ */
 #define SPAPR_CAP_NUM                   (SPAPR_CAP_XIVE + 1)
=20
 /*
@@ -135,6 +140,7 @@ struct SpaprMachineClass {
                           hwaddr *nv2atsd, Error **errp);
     SpaprResizeHpt resize_hpt_default;
     SpaprCapabilities default_caps;
+    int mig_cap_num; /* don't migrate newer capabilities */
 };
=20
 /**
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bf9fdb169303..fa81cedfbcc5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4453,6 +4453,7 @@ static void spapr_machine_class_init(ObjectClass *oc,=
 void *data)
     smc->dr_phb_enabled =3D true;
     smc->linux_pci_probe =3D true;
     smc->nr_xirqs =3D SPAPR_NR_XIRQS;
+    smc->mig_cap_num =3D SPAPR_CAP_NUM;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
@@ -4520,6 +4521,7 @@ static void spapr_machine_4_1_class_options(MachineCl=
ass *mc)
=20
     spapr_machine_4_2_class_options(mc);
     smc->linux_pci_probe =3D false;
+    smc->mig_cap_num =3D SPAPR_CAP_CCF_ASSIST + 1;
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index e06fd386f6ac..ba079f46e084 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -532,6 +532,13 @@ static void cap_xive_apply(SpaprMachineState *spapr, u=
int8_t val, Error **errp)
     }
 }
=20
+static bool cap_xics_xive_migrate_needed(void *opaque)
+{
+    int mig_cap_num =3D SPAPR_MACHINE_GET_CLASS(opaque)->mig_cap_num;
+
+    return mig_cap_num > SPAPR_CAP_XIVE && mig_cap_num > SPAPR_CAP_XICS;
+}
+
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
     [SPAPR_CAP_HTM] =3D {
         .name =3D "htm",
@@ -639,6 +646,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D=
 {
         .set =3D spapr_cap_set_bool,
         .type =3D "bool",
         .apply =3D cap_xics_apply,
+        .migrate_needed =3D cap_xics_xive_migrate_needed,
     },
     [SPAPR_CAP_XIVE] =3D {
         .name =3D "xive",
@@ -648,6 +656,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D=
 {
         .set =3D spapr_cap_set_bool,
         .type =3D "bool",
         .apply =3D cap_xive_apply,
+        .migrate_needed =3D cap_xics_xive_migrate_needed,
     },
 };
=20
@@ -729,20 +738,21 @@ int spapr_caps_pre_save(void *opaque)
  * caps on the destination */
 int spapr_caps_post_migration(SpaprMachineState *spapr)
 {
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int i;
     bool ok =3D true;
     SpaprCapabilities dstcaps =3D spapr->eff;
     SpaprCapabilities srccaps;
=20
     srccaps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_type);
-    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
+    for (i =3D 0; i < smc->mig_cap_num; i++) {
         /* If not default value then assume came in with the migration */
         if (spapr->mig.caps[i] !=3D spapr->def.caps[i]) {
             srccaps.caps[i] =3D spapr->mig.caps[i];
         }
     }
=20
-    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
+    for (i =3D 0; i < smc->mig_cap_num; i++) {
         SpaprCapabilityInfo *info =3D &capability_table[i];
=20
         if (srccaps.caps[i] > dstcaps.caps[i]) {
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
> {
>     if (vmsd->needed && !vmsd->needed(opaque)) {
>         /* optional section not needed */
>         return false;
>     }
>     return true;
> }


--Sig_/B8sYyNEkGG=dqFCrX6v58hr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2gPksACgkQcdTV5YIv
c9Zw3xAAw/SgqMs8lHEW7ZYg3DHFh+7C18yWcYkfVLiLhf0IdtqVb2IKiOmruGm9
VNa81vLqRlDFAMgTeKCp3L51+f/Pa2uB43whrhDSGjSzTV3uu1ewtrAN06byuYdH
J04o1BQJI1KvL0Bo6dEJKThMPEOuKNXPmA39NjzYyL1OPnNaenBhxHpY3ESCUENR
7f7ImutYgdt/0sYCDugkbBR8Zc3F3d89fPB3TJi+LxTHGOVjF16yC1Oz15lylfb1
JxkL6Dz5ZmQs4FUKIF1+eo8xTygT5EpfYIgIXKEx1Ee1tmlPlOJZ3c1RUKkeh6g5
ag30jtKzAw2AI+34qi/tygpWzNPsut7raSDMkHcxLj1EIzFOj/kKWKxPwjifTL3V
7dATQP2OxkeZEJ0KfkPROmVuEvKkhwMNTSSXk8QLXLWCoM4fFJWlJvEHm17oRKbU
LZYuufjGpLwyAQmM6AJsEqM4zNQ8UsJNszQlIbIu1OWubjSNLwvnHLK5Gc6s1x1a
jZX7odBXtswynrqwOyiuuuAvYvRELSdywcDoL4V8NahK8nvk1WicA2m6iPK1HcPM
snntHzZLEwkG7eBt/oWGVYBWgO8l5C8JpHuOVeGvG8dXyMnhFEypF479yXqbHTtZ
fZKmQQIVqlZRC/TUn0srh+8lUriDeiJ59Y2JVF3PqZJrFAIyuNg=
=Bscc
-----END PGP SIGNATURE-----

--Sig_/B8sYyNEkGG=dqFCrX6v58hr--

