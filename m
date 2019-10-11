Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4818AC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 05:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E029214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 05:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LC1gc50n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E029214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iInB5-00045O-6R
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 01:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iInA9-0003Uj-FL
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 01:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iInA7-0004Tr-S7
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 01:08:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55793 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iInA6-0004SU-Hw; Fri, 11 Oct 2019 01:08:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46qGDm3xmKz9sP6; Fri, 11 Oct 2019 16:08:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570770488;
 bh=oAtSViwSTN3pUgfaMra2abWLzKuuP7wtF/1VfR6k1uY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LC1gc50nQCSl5Tv+om2YNxpxxNBwZtxi82wzrTTDB0M1v5DyOJRDiG4M6rXSgYkhi
 BZN/S+E/M2oudXt8apg5uBaQWfWJqAWr/A2Cc1eyYaOFWQr8kTBQecBXflgpf0972U
 TKXqJKioLw+Fv7fRiciMu6Vl9YturYO6myhO8pVc=
Date: Fri, 11 Oct 2019 16:07:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191011050758.GD4080@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
 <20191009190215.7e05c017@bahia.lan>
 <20191010020209.GC28552@umbus.fritz.box>
 <20191010082958.12e17561@bahia.lan>
 <20191010223304.0cf7ccd3@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20191010223304.0cf7ccd3@bahia.lan>
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
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 10:33:04PM +0200, Greg Kurz wrote:
> On Thu, 10 Oct 2019 08:29:58 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Thu, 10 Oct 2019 13:02:09 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Wed, Oct 09, 2019 at 07:02:15PM +0200, Greg Kurz wrote:
> > > > On Wed,  9 Oct 2019 17:08:16 +1100
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >=20
> > > > > The only thing remaining in this structure are the flags to allow=
 either
> > > > > XICS or XIVE to be present.  These actually make more sense as sp=
apr
> > > > > capabilities - that way they can take advantage of the existing
> > > > > infrastructure to sanity check capability states across migration=
 and so
> > > > > forth.
> > > > >=20
> > > >=20
> > > > The user can now choose the interrupt controller mode either through
> > > > ic-mode or through cap-xics/cap-xive. I guess it doesn't break anyt=
hing
> > > > to expose another API to do the same thing but it raises some quest=
ions.
> > > >=20
> > > > We should at least document somewhere that ic-mode is an alias to t=
hese
> > > > caps, and maybe state which is the preferred method (I personally v=
ote
> > > > for the caps).
> > > >=20
> > > > Also, we must keep ic-mode for the moment to stay compatible with t=
he
> > > > existing pseries-4.0 and pseries-4.1 machine types, but will we
> > > > keep ic-mode forever ? If no, maybe start by not allowing it for
> > > > pseries-4.2 ?
> > >=20
> > > I'm actually inclined to keep it for now, maybe even leave it as the
> > > suggested way to configure this.  The caps are nice from an internal
> > > organization point of view, but ic-mode is arguably a more user
> > > friendly way of configuring it.  The conversion of one to the other is
> > > straightforward, isolated ans small, so I'm not especially bothered by
> > > keeping it around.
> > >=20
> >=20
> > Fair enough.
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
>=20
> But unfortunately this still requires care :-\
>=20
> qemu-system-ppc64: cap-xive higher level (1) in incoming stream than on d=
estination (0)
> qemu-system-ppc64: error while loading state for instance 0x0 of device '=
spapr'
> qemu-system-ppc64: load of migration failed: Invalid argument
>=20
> or
>=20
> qemu-system-ppc64: cap-xics higher level (1) in incoming stream than on d=
estination (0)
> qemu-system-ppc64: error while loading state for instance 0x0 of device '=
spapr'
> qemu-system-ppc64: load of migration failed: Invalid argument
>=20
> when migrating from QEMU 4.1 with ic-mode=3Dxics and ic-mode=3Dxive respe=
ctively.
>=20
> This happens because the existing pseries-4.1 machine type doesn't send t=
he
> new caps and the logic in spapr_caps_post_migration() wrongly assumes that
> the source has both caps set:
>=20
>     srccaps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_type);
>     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
>         /* If not default value then assume came in with the migration */
>         if (spapr->mig.caps[i] !=3D spapr->def.caps[i]) {
>=20
> spapr->mig.caps[SPAPR_CAP_XICS] =3D 0
> spapr->mig.caps[SPAPR_CAP_XIVE] =3D 0
>=20
>             srccaps.caps[i] =3D spapr->mig.caps[i];
>=20
> srcaps.caps[SPAPR_CAP_XICS] =3D 1
> srcaps.caps[SPAPR_CAP_XIVE] =3D 1
>=20
>         }
>     }
>=20
> and breaks
>=20
>     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
>         SpaprCapabilityInfo *info =3D &capability_table[i];
>=20
>         if (srccaps.caps[i] > dstcaps.caps[i]) {
>=20
> srcaps.caps[SPAPR_CAP_XICS] =3D 0 when ic-mode=3Dxive
> srcaps.caps[SPAPR_CAP_XIVE] =3D 0 when ic-mode=3Dxics
>=20
>             error_report("cap-%s higher level (%d) in incoming stream tha=
n on destination (%d)",
>                          info->name, srccaps.caps[i], dstcaps.caps[i]);
>             ok =3D false;
>         }

Ah.. right.  I thought there would be problems with backwards
migration, but I didn't think of this problem even with forward
migration.

> Maybe we shouldn't check capabilities that we know the source
> isn't supposed to send, eg. by having a smc->max_cap ?

Uh.. I'm not really sure what exactly you're suggesting here.

I think what we need here is a custom migrate_needed function, like we
already have for cap_hpt_maxpagesize, to exclude it from the migration
stream for machine versions before 4.2.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2gDi4ACgkQbDjKyiDZ
s5IfyRAAnCPF8I53ZO0KJu+FLnq7GdON5SZTG/DokJq2DFd5JwNMvZBuM8pW+EZl
XGqkDT3lr94AintiXUZ3yF2TxNtSXdCypSt9CTTX4g7z88QZzX1x0XjC2JWpSGKw
NDTnjhSC9F9EDI4EbTfgcDQfmaJ/NzwToOMkq3jOVSpqLVDpmUbQv1O5GxKCjp11
C/L6NXjokJ5yhHBNOWBDCqrA0EToRnhdACAv+CjXd5WsxULR/yDrNeDXnwnoD4oD
fdNnbyJvT4xcaYgYES9bdzqUujV9xu03j78o4YeX8RGzL9uyVuD4kH/Z9+ffgk/0
4tGZu4O3oU3bU1yyaJQeaUBBdCFrCIE2A5Dpuuc6Y98HBvvx7epKPmfjmqmRbOt/
NLUq2+8JXJyAU1S8ENrBE9978ypt80dOH1tenml/8+RAJFhbeSZcErMVMbID09jF
3BWWfRPs4AKpyQnzuP4j8avgmDsSfF03D1YYrdhITGGSnBJp4mn5Vxc+yMlYz9nj
KgzeFgMJUTHM7XxLDA7Z3TMq6lln+aNAFIJUu9WmgELRkbLWl2GRjgKOvGjLYBIT
TKOK7DVVNDU8VNjSjcL10box2EWrkxZsZjJcMnLFrS6d7czw9s0kpCC3EV+DDvNz
KRrDHjugMyJb0Bi6uEX/TzJOzD3Ty0w55zSODWuf6yKrMI7hHc8=
=O4XY
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--

