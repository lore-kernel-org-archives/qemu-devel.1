Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B76C47404
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 00:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677412089F
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 00:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ou7M1bhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677412089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ4rZ-00031w-Jm
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 20:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iJ4qJ-0002Ox-41
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 20:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iJ4qF-0001du-Ry
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 20:01:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57719 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iJ4qE-0001Nn-Fv; Fri, 11 Oct 2019 20:01:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46qlMr5p55z9sP4; Sat, 12 Oct 2019 11:00:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570838456;
 bh=IfKZjYnFnjN4KP/ZCu28+kcwR+wK8aXGic+MYsn2x3k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ou7M1bhTE0+pYU96MgmcV0QfPnwReiVi5HAPCgJiBm2xtaH1o8zHleairzjYIPMHT
 5SlaNsQPhZa+U0Z2J0svoVBIxUOOwqeY7kv9u0bkQ/HarbWeF4RG49Dat4bJwWA6Nv
 xav71VdK2vq4yDnl3oF85FJpv46Ag+6DecSFfsfU=
Date: Sat, 12 Oct 2019 11:00:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191012000041.GE4080@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
 <20191009190215.7e05c017@bahia.lan>
 <20191010020209.GC28552@umbus.fritz.box>
 <20191010082958.12e17561@bahia.lan>
 <20191010223304.0cf7ccd3@bahia.lan>
 <20191011050758.GD4080@umbus.fritz.box>
 <20191011081333.7e483b95@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <20191011081333.7e483b95@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 08:13:33AM +0200, Greg Kurz wrote:
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

Oh, I see, a max cap index.  I think that sounds fragile if we ever
deprecate any caps, and it also might be problematic for downstream
where we've sometimes selectively backported caps.

> > I think what we need here is a custom migrate_needed function, like we
> > already have for cap_hpt_maxpagesize, to exclude it from the migration
> > stream for machine versions before 4.2.
> >=20
>=20
> No, VMState needed() hooks are for outgoing migration only.

Ah, yeah, right.  Essentially the problem is that in the absence of
caps, the new qemu assumes they're in the default state, but if an old
source had ic-mode set, then they effectively aren't.  Or looked at
another way, it's now trying to check that the ends match w.r.t. intc
selection, but doesn't have enough information supplied by old sources
to do so correctly.

Ugh, that's a bit trickier to work around.

> bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
> {
>     if (vmsd->needed && !vmsd->needed(opaque)) {
>         /* optional section not needed */
>         return false;
>     }
>     return true;
> }



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2hF6cACgkQbDjKyiDZ
s5KdMhAAi4qZ1RbJ7wkKD7tkGEMa1pZJ3wEtWkF404MavXgweqcsmr1nNtkXsQ1h
RpwSLBsI3V9drU8R3Uq32heaf0CkdEtbkMf6TOpFKgSTX+K9ff0q/yvtytvA/DdE
Naq4CRCM37V0DS52IYyecHjzSgwRuAvo15snqcL6rZBcczli171Znv/PkoUsoxd1
R4QmuPP/9qQP5lMnwhxznCxznLyjHdvykht8wBQMnR1NAT+GiP9SDInkMkx0Kj+a
MnlGrpe2ixWnRzDllLwBi9OMAySE4y9jUAUBVCcLA8P8AZFZz2B9znTtnZoe6TCq
7ZIo2/mWkqq+06TTpAAH4UGow3UczGGlUXcdjlqHBzbxhZfeg8aRucjgRhvgSqmL
ucDtNA23p4Ti4w9MTEXXO6t9geMtlJA2yHMYTuL2P22roTvNAxA2i+iDufKQJjBT
mabBYNuiZzTaoqKXPFW+te08h5fq456ukHa7Bh+OwtSMij3Jzao4vqDEfDN+xoMu
U7qfxN7MOUAVOg0XO32rQh1A8A+lXU9lE4BFRHd3+e5TTnEktCmCco14mrORTLYi
o7vJC7jWx0KPces8vS2qnSMPYy19fzIXycRPG/f/kzlZ1wYjlFe8DwiiLOrjet8w
DRd1vJILbA4WZF+PwYxwlejBAaRTAcM2CXCCxT1ugVidb8pccDM=
=5Mwj
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--

