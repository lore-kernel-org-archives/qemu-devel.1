Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4D8ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4038A20659
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4038A20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJwWi-0001cC-C0
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 05:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iJwS8-0005q7-G1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iJwS6-00025S-Po
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:15:44 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:41158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iJwS6-0001v2-K2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:15:42 -0400
Received: from player793.ha.ovh.net (unknown [10.108.54.87])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id B6BDE228E86
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 11:15:31 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 077E4AE83DD0;
 Mon, 14 Oct 2019 09:15:19 +0000 (UTC)
Date: Mon, 14 Oct 2019 11:15:16 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191014111516.15ca65a0@bahia.lan>
In-Reply-To: <20191012000041.GE4080@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
 <20191009190215.7e05c017@bahia.lan>
 <20191010020209.GC28552@umbus.fritz.box>
 <20191010082958.12e17561@bahia.lan>
 <20191010223304.0cf7ccd3@bahia.lan>
 <20191011050758.GD4080@umbus.fritz.box>
 <20191011081333.7e483b95@bahia.lan>
 <20191012000041.GE4080@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qnr30Q/VMAG6By9SzvCTwXY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 4373839663574850022
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjedugdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.165.232
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

--Sig_/qnr30Q/VMAG6By9SzvCTwXY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Oct 2019 11:00:41 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Oct 11, 2019 at 08:13:33AM +0200, Greg Kurz wrote:
> > On Fri, 11 Oct 2019 16:07:58 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Thu, Oct 10, 2019 at 10:33:04PM +0200, Greg Kurz wrote:
> > > > On Thu, 10 Oct 2019 08:29:58 +0200
> > > > Greg Kurz <groug@kaod.org> wrote:
> > > >=20
> > > > > On Thu, 10 Oct 2019 13:02:09 +1100
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >=20
> > > > > > On Wed, Oct 09, 2019 at 07:02:15PM +0200, Greg Kurz wrote:
> > > > > > > On Wed,  9 Oct 2019 17:08:16 +1100
> > > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > > >=20
> > > > > > > > The only thing remaining in this structure are the flags to=
 allow either
> > > > > > > > XICS or XIVE to be present.  These actually make more sense=
 as spapr
> > > > > > > > capabilities - that way they can take advantage of the exis=
ting
> > > > > > > > infrastructure to sanity check capability states across mig=
ration and so
> > > > > > > > forth.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > The user can now choose the interrupt controller mode either =
through
> > > > > > > ic-mode or through cap-xics/cap-xive. I guess it doesn't brea=
k anything
> > > > > > > to expose another API to do the same thing but it raises some=
 questions.
> > > > > > >=20
> > > > > > > We should at least document somewhere that ic-mode is an alia=
s to these
> > > > > > > caps, and maybe state which is the preferred method (I person=
ally vote
> > > > > > > for the caps).
> > > > > > >=20
> > > > > > > Also, we must keep ic-mode for the moment to stay compatible =
with the
> > > > > > > existing pseries-4.0 and pseries-4.1 machine types, but will =
we
> > > > > > > keep ic-mode forever ? If no, maybe start by not allowing it =
for
> > > > > > > pseries-4.2 ?
> > > > > >=20
> > > > > > I'm actually inclined to keep it for now, maybe even leave it a=
s the
> > > > > > suggested way to configure this.  The caps are nice from an int=
ernal
> > > > > > organization point of view, but ic-mode is arguably a more user
> > > > > > friendly way of configuring it.  The conversion of one to the o=
ther is
> > > > > > straightforward, isolated ans small, so I'm not especially both=
ered by
> > > > > > keeping it around.
> > > > > >=20
> > > > >=20
> > > > > Fair enough.
> > > > >=20
> > > > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > > >=20
> > > >=20
> > > > But unfortunately this still requires care :-\
> > > >=20
> > > > qemu-system-ppc64: cap-xive higher level (1) in incoming stream tha=
n on destination (0)
> > > > qemu-system-ppc64: error while loading state for instance 0x0 of de=
vice 'spapr'
> > > > qemu-system-ppc64: load of migration failed: Invalid argument
> > > >=20
> > > > or
> > > >=20
> > > > qemu-system-ppc64: cap-xics higher level (1) in incoming stream tha=
n on destination (0)
> > > > qemu-system-ppc64: error while loading state for instance 0x0 of de=
vice 'spapr'
> > > > qemu-system-ppc64: load of migration failed: Invalid argument
> > > >=20
> > > > when migrating from QEMU 4.1 with ic-mode=3Dxics and ic-mode=3Dxive=
 respectively.
> > > >=20
> > > > This happens because the existing pseries-4.1 machine type doesn't =
send the
> > > > new caps and the logic in spapr_caps_post_migration() wrongly assum=
es that
> > > > the source has both caps set:
> > > >=20
> > > >     srccaps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_ty=
pe);
> > > >     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > > >         /* If not default value then assume came in with the migrat=
ion */
> > > >         if (spapr->mig.caps[i] !=3D spapr->def.caps[i]) {
> > > >=20
> > > > spapr->mig.caps[SPAPR_CAP_XICS] =3D 0
> > > > spapr->mig.caps[SPAPR_CAP_XIVE] =3D 0
> > > >=20
> > > >             srccaps.caps[i] =3D spapr->mig.caps[i];
> > > >=20
> > > > srcaps.caps[SPAPR_CAP_XICS] =3D 1
> > > > srcaps.caps[SPAPR_CAP_XIVE] =3D 1
> > > >=20
> > > >         }
> > > >     }
> > > >=20
> > > > and breaks
> > > >=20
> > > >     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > > >         SpaprCapabilityInfo *info =3D &capability_table[i];
> > > >=20
> > > >         if (srccaps.caps[i] > dstcaps.caps[i]) {
> > > >=20
> > > > srcaps.caps[SPAPR_CAP_XICS] =3D 0 when ic-mode=3Dxive
> > > > srcaps.caps[SPAPR_CAP_XIVE] =3D 0 when ic-mode=3Dxics
> > > >=20
> > > >             error_report("cap-%s higher level (%d) in incoming stre=
am than on destination (%d)",
> > > >                          info->name, srccaps.caps[i], dstcaps.caps[=
i]);
> > > >             ok =3D false;
> > > >         }
> > >=20
> > > Ah.. right.  I thought there would be problems with backwards
> > > migration, but I didn't think of this problem even with forward
> > > migration.
> > >=20
> > > > Maybe we shouldn't check capabilities that we know the source
> > > > isn't supposed to send, eg. by having a smc->max_cap ?
> > >=20
> > > Uh.. I'm not really sure what exactly you're suggesting here.
> > >=20
> >=20
> > I'm suggesting to have a per-machine version smc->max_cap that
> > contains the highest supported cap index, to be used instead of
> > SPAPR_CAP_NUM in this functions, ie.
> >=20
> > for (i =3D 0; i <=3D smc->max_cap; i++) {
> >     ...
> > }
> >=20
> > where we would have
> >=20
> > smc->max_cap =3D SPAPR_CAP_CCF_ASSIST for pseries-4.1
> >=20
> > and
> >=20
> > smc->max_cap =3D SPAPR_CAP_XIVE for psereis-4.2
>=20
> Oh, I see, a max cap index.  I think that sounds fragile if we ever
> deprecate any caps,=20

Hmmm... I had the impression that capability numbers would stay
forever, even if at some point we may decide to not support some
of them for newer machine types... Can you elaborate on a
deprecating scenario that would break ?

> and it also might be problematic for downstream
> where we've sometimes selectively backported caps.
>=20

Do you mean that capability numbers defined in spapr.h differ
from the ones in upstream QEMU ?

> > > I think what we need here is a custom migrate_needed function, like we
> > > already have for cap_hpt_maxpagesize, to exclude it from the migration
> > > stream for machine versions before 4.2.
> > >=20
> >=20
> > No, VMState needed() hooks are for outgoing migration only.
>=20
> Ah, yeah, right.  Essentially the problem is that in the absence of
> caps, the new qemu assumes they're in the default state, but if an old
> source had ic-mode set, then they effectively aren't.  Or looked at
> another way, it's now trying to check that the ends match w.r.t. intc
> selection, but doesn't have enough information supplied by old sources
> to do so correctly.
>=20

Yes, but do we really need to perform strict checks on ic-mode in the first
place ? I mean that migrating the state of XICS and/or XIVE entities _only_
requires the destination to have instantiated them, ie:

SOURCE/DEST | xics | xive | dual
------------+------+------+-------
xics        | ok   | fail | ok (*)
xive        | fail | ok   | ok (*)
dual        | fail | fail | ok

(*) missing migrated state for xics/xive means that the corresponding
    objects will have reset state, like after CAS.

> Ugh, that's a bit trickier to work around.
>=20

Maybe have a migrate_needed() hook like this:

static bool cap_xics_xive_migrate_needed(void *opaque)
{
    return !SPAPR_MACHINE_GET_CLASS(opaque)->pre_4_2_migration;
}

and also use it in spapr_caps_post_migration() ?

> > bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
> > {
> >     if (vmsd->needed && !vmsd->needed(opaque)) {
> >         /* optional section not needed */
> >         return false;
> >     }
> >     return true;
> > }
>=20
>=20
>=20


--Sig_/qnr30Q/VMAG6By9SzvCTwXY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2kPKQACgkQcdTV5YIv
c9aknBAAnwNNVF7QA06qXK98rbkbW0Z1aqKMVMg+WLHtsRfpHDVRZ9yp9gQcYEXH
0MHwXVvczN/DgKsqdEe18o7VY6/EGfUyORgKzR8PbyQxy/+r+UhWdjF1pDui5pOu
hxd6bP5b2npxEqm+TY8PLZ0HsMiOcX2yr/1iexYvG7j6FaR9kRAGTmZiNQHPo2a6
z3YWoE5ai50Qmh7QTmCFYFnKY3NlqSf3bi1TY731T4kzCOxvGSI89fvjXo65ZZLy
a4XUNPEskzy8IHDm/TxpPmWU4XpSgNopztzS+1i7hy8o64x1Emyql1hp5MAlSjAK
FFY0RWDYj6dgDAABl5y2N+wBtnhKqYU+iFydw1FZFZrmgoKZ5PmytOVffPBqDaLQ
EYPWGld+/CU8bRuVA74bDDRdEnfNxSBg23S6LB1OMaYSQtssbSxmT/WJbzRbpzdM
ruQtaphop0avSeZY6Mti3L4cpPpqrK0dpt2vif6rvTzivHnsJDrPG45/muYsH9Db
05pAEeAZtHs6JqySHDhbPJ/qP4f1fSA2SOJONohhuE4VB75VBVhFjHjhOezrvdfz
OSNLm1W3mFTO0Aak67mqJ4ZuBK+azP1aVrdJ3mfR/B1+iPPU9xJMiVioIMpQVCsw
OhSr762AzecIi1o0rxzv0u+dJXJONrerQM2/gkQNU4ad35Ut9JI=
=LlA+
-----END PGP SIGNATURE-----

--Sig_/qnr30Q/VMAG6By9SzvCTwXY--

