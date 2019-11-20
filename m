Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4EC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 05:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C717B2244A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 05:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="p+s9+zQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C717B2244A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXIjJ-0002Ok-Ty
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 00:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXIhe-0001T8-Cy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 00:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXIhc-0002N5-Bx
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 00:38:58 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41207 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXIhb-0002GR-7K; Wed, 20 Nov 2019 00:38:56 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Hs1k4Nj9z9sPW; Wed, 20 Nov 2019 16:38:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574228330;
 bh=H60WAZkIZpVRrrcuS7LZD1p++zPkQCuJWufFMxBsfv4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p+s9+zQD5QpDMqE9nhXVTxM8B5TfhERGwLXeXNjPozZ08Ty1G3xzagPfqHs1V4tAf
 i9rp2S0sAsTTxXnDzuA/ns8qQSA05gXW8yuCQe26SCvUpKC2MTstXTDcyv99kl5uDD
 549kLQeHicvRoAIkITEsioryUMN/9h+5vV3ZvTkI=
Date: Wed, 20 Nov 2019 16:38:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191120053837.GK5582@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
 <20191009190215.7e05c017@bahia.lan>
 <20191010020209.GC28552@umbus.fritz.box>
 <20191010082958.12e17561@bahia.lan>
 <20191010223304.0cf7ccd3@bahia.lan>
 <20191011050758.GD4080@umbus.fritz.box>
 <20191011081333.7e483b95@bahia.lan>
 <20191012000041.GE4080@umbus.fritz.box>
 <20191014111516.15ca65a0@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lA2zPjnDULdUXMNN"
Content-Disposition: inline
In-Reply-To: <20191014111516.15ca65a0@bahia.lan>
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


--lA2zPjnDULdUXMNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 11:15:16AM +0200, Greg Kurz wrote:
> On Sat, 12 Oct 2019 11:00:41 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Oct 11, 2019 at 08:13:33AM +0200, Greg Kurz wrote:
> > > On Fri, 11 Oct 2019 16:07:58 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > On Thu, Oct 10, 2019 at 10:33:04PM +0200, Greg Kurz wrote:
> > > > > On Thu, 10 Oct 2019 08:29:58 +0200
> > > > > Greg Kurz <groug@kaod.org> wrote:
> > > > >=20
> > > > > > On Thu, 10 Oct 2019 13:02:09 +1100
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >=20
> > > > > > > On Wed, Oct 09, 2019 at 07:02:15PM +0200, Greg Kurz wrote:
> > > > > > > > On Wed,  9 Oct 2019 17:08:16 +1100
> > > > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > > > >=20
> > > > > > > > > The only thing remaining in this structure are the flags =
to allow either
> > > > > > > > > XICS or XIVE to be present.  These actually make more sen=
se as spapr
> > > > > > > > > capabilities - that way they can take advantage of the ex=
isting
> > > > > > > > > infrastructure to sanity check capability states across m=
igration and so
> > > > > > > > > forth.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > The user can now choose the interrupt controller mode eithe=
r through
> > > > > > > > ic-mode or through cap-xics/cap-xive. I guess it doesn't br=
eak anything
> > > > > > > > to expose another API to do the same thing but it raises so=
me questions.
> > > > > > > >=20
> > > > > > > > We should at least document somewhere that ic-mode is an al=
ias to these
> > > > > > > > caps, and maybe state which is the preferred method (I pers=
onally vote
> > > > > > > > for the caps).
> > > > > > > >=20
> > > > > > > > Also, we must keep ic-mode for the moment to stay compatibl=
e with the
> > > > > > > > existing pseries-4.0 and pseries-4.1 machine types, but wil=
l we
> > > > > > > > keep ic-mode forever ? If no, maybe start by not allowing i=
t for
> > > > > > > > pseries-4.2 ?
> > > > > > >=20
> > > > > > > I'm actually inclined to keep it for now, maybe even leave it=
 as the
> > > > > > > suggested way to configure this.  The caps are nice from an i=
nternal
> > > > > > > organization point of view, but ic-mode is arguably a more us=
er
> > > > > > > friendly way of configuring it.  The conversion of one to the=
 other is
> > > > > > > straightforward, isolated ans small, so I'm not especially bo=
thered by
> > > > > > > keeping it around.
> > > > > > >=20
> > > > > >=20
> > > > > > Fair enough.
> > > > > >=20
> > > > > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > > > >=20
> > > > >=20
> > > > > But unfortunately this still requires care :-\
> > > > >=20
> > > > > qemu-system-ppc64: cap-xive higher level (1) in incoming stream t=
han on destination (0)
> > > > > qemu-system-ppc64: error while loading state for instance 0x0 of =
device 'spapr'
> > > > > qemu-system-ppc64: load of migration failed: Invalid argument
> > > > >=20
> > > > > or
> > > > >=20
> > > > > qemu-system-ppc64: cap-xics higher level (1) in incoming stream t=
han on destination (0)
> > > > > qemu-system-ppc64: error while loading state for instance 0x0 of =
device 'spapr'
> > > > > qemu-system-ppc64: load of migration failed: Invalid argument
> > > > >=20
> > > > > when migrating from QEMU 4.1 with ic-mode=3Dxics and ic-mode=3Dxi=
ve respectively.
> > > > >=20
> > > > > This happens because the existing pseries-4.1 machine type doesn'=
t send the
> > > > > new caps and the logic in spapr_caps_post_migration() wrongly ass=
umes that
> > > > > the source has both caps set:
> > > > >=20
> > > > >     srccaps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_=
type);
> > > > >     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > > > >         /* If not default value then assume came in with the migr=
ation */
> > > > >         if (spapr->mig.caps[i] !=3D spapr->def.caps[i]) {
> > > > >=20
> > > > > spapr->mig.caps[SPAPR_CAP_XICS] =3D 0
> > > > > spapr->mig.caps[SPAPR_CAP_XIVE] =3D 0
> > > > >=20
> > > > >             srccaps.caps[i] =3D spapr->mig.caps[i];
> > > > >=20
> > > > > srcaps.caps[SPAPR_CAP_XICS] =3D 1
> > > > > srcaps.caps[SPAPR_CAP_XIVE] =3D 1
> > > > >=20
> > > > >         }
> > > > >     }
> > > > >=20
> > > > > and breaks
> > > > >=20
> > > > >     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> > > > >         SpaprCapabilityInfo *info =3D &capability_table[i];
> > > > >=20
> > > > >         if (srccaps.caps[i] > dstcaps.caps[i]) {
> > > > >=20
> > > > > srcaps.caps[SPAPR_CAP_XICS] =3D 0 when ic-mode=3Dxive
> > > > > srcaps.caps[SPAPR_CAP_XIVE] =3D 0 when ic-mode=3Dxics
> > > > >=20
> > > > >             error_report("cap-%s higher level (%d) in incoming st=
ream than on destination (%d)",
> > > > >                          info->name, srccaps.caps[i], dstcaps.cap=
s[i]);
> > > > >             ok =3D false;
> > > > >         }
> > > >=20
> > > > Ah.. right.  I thought there would be problems with backwards
> > > > migration, but I didn't think of this problem even with forward
> > > > migration.
> > > >=20
> > > > > Maybe we shouldn't check capabilities that we know the source
> > > > > isn't supposed to send, eg. by having a smc->max_cap ?
> > > >=20
> > > > Uh.. I'm not really sure what exactly you're suggesting here.
> > > >=20
> > >=20
> > > I'm suggesting to have a per-machine version smc->max_cap that
> > > contains the highest supported cap index, to be used instead of
> > > SPAPR_CAP_NUM in this functions, ie.
> > >=20
> > > for (i =3D 0; i <=3D smc->max_cap; i++) {
> > >     ...
> > > }
> > >=20
> > > where we would have
> > >=20
> > > smc->max_cap =3D SPAPR_CAP_CCF_ASSIST for pseries-4.1
> > >=20
> > > and
> > >=20
> > > smc->max_cap =3D SPAPR_CAP_XIVE for psereis-4.2
> >=20
> > Oh, I see, a max cap index.  I think that sounds fragile if we ever
> > deprecate any caps,=20
>=20
> Hmmm... I had the impression that capability numbers would stay
> forever, even if at some point we may decide to not support some
> of them for newer machine types... Can you elaborate on a
> deprecating scenario that would break ?

Uhh... good point, I don't think that could break it.  Even if we
deprecated a capability we could still retain enough awareness of the
old number to sanity check this.

> > and it also might be problematic for downstream
> > where we've sometimes selectively backported caps.
>=20
> Do you mean that capability numbers defined in spapr.h differ
> from the ones in upstream QEMU ?

No, they don't but that's actually the problem.  The point is that we
might backport some later caps without necessarily backporting all the
earlier ones - that means that the "max cap index" no longer implies
that all the lower indexed caps are present.

>=20
> > > > I think what we need here is a custom migrate_needed function, like=
 we
> > > > already have for cap_hpt_maxpagesize, to exclude it from the migrat=
ion
> > > > stream for machine versions before 4.2.
> > > >=20
> > >=20
> > > No, VMState needed() hooks are for outgoing migration only.
> >=20
> > Ah, yeah, right.  Essentially the problem is that in the absence of
> > caps, the new qemu assumes they're in the default state, but if an old
> > source had ic-mode set, then they effectively aren't.  Or looked at
> > another way, it's now trying to check that the ends match w.r.t. intc
> > selection, but doesn't have enough information supplied by old sources
> > to do so correctly.
>=20
> Yes, but do we really need to perform strict checks on ic-mode in the fir=
st
> place ? I mean that migrating the state of XICS and/or XIVE entities _onl=
y_
> requires the destination to have instantiated them, ie:
>=20
> SOURCE/DEST | xics | xive | dual
> ------------+------+------+-------
> xics        | ok   | fail | ok (*)
> xive        | fail | ok   | ok (*)
> dual        | fail | fail | ok
>=20
> (*) missing migrated state for xics/xive means that the corresponding
>     objects will have reset state, like after CAS.

Yes... I don't really see where you're goig with that thought.

> > Ugh, that's a bit trickier to work around.
> >=20
>=20
> Maybe have a migrate_needed() hook like this:
>=20
> static bool cap_xics_xive_migrate_needed(void *opaque)
> {
>     return !SPAPR_MACHINE_GET_CLASS(opaque)->pre_4_2_migration;
> }
>=20
> and also use it in spapr_caps_post_migration() ?

Yeah, maybe.  I think we have a hack like this for one of the other
caps already.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lA2zPjnDULdUXMNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3U0V0ACgkQbDjKyiDZ
s5L84w/8DmdRj44rJ/gZGPFB3NDC26grLSelF32m9Dhru6XHC3kGq0KgyymdOsSL
NG9kASEK04qBH4ihyufoGqonNuBBeln3OXsUxooYH2tFS+KRbW11Wmlj5jVabbw4
8OcNAufhPLoIoPF+w2pzYJId+o0uK//y5Sd4rnBuiKdyn8gZBnZUPYltlpZoOpnn
Tm/j00JLBztqmTfzgRVB/1puQhEfhdCJj0v543vCO4rzocSTDd0BYHfYY+v+ChmQ
aIr9XLC+E5ZPdlcLc3yy3gqShcEbnmqrElmrAvpE+e3AjBuBQCKavHg+o6LddYq2
S8Hhtv1/nyNH2l4atrvg2MDTPYwa8Vb3xK54+c6M6UR0xqPodTlEaPrRyFbsPf1h
VZUokXPcJyqbAac3tgkqVJgfZKexlA/zjTV4/9G1ieK0i24e7UVosYYGyI6m9fWU
Rb+5JAUFFPuuWD0TSiHVSw/cK7XvF8XHDC9mwc8U7nQaXzxGzyLRbANrHp3NzNfE
UH1twcmCgyxg5GYc1wGyoqW/jmdsc7DNWhBRdTgUabzuuQpL9rhKsXbcoy3dvRGo
qcH/4x/EaWqVYJSKMQHUu5oNESVPB0wK/urpd3MgDqbCmRCoASVdJ1EQmOyfS6+y
yhmLcRvQsDO+nUNSO4PfZYdCp60Tb7p6lcnol4KTemEcgnZQUB0=
=E0ZQ
-----END PGP SIGNATURE-----

--lA2zPjnDULdUXMNN--

