Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C17FC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E28206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kCFWq5Sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E28206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEnkk-000664-G2
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 01:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjm-00052x-QT
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjl-0004N9-Du
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:28:58 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56465)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jEnjl-0004C8-2N; Thu, 19 Mar 2020 01:28:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48jb6r0y6Tz9sSV; Thu, 19 Mar 2020 16:28:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584595732;
 bh=lQXZ+sLG1WYzYOcyMravQzuOKVlYHib9XF1fvjYxZkM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kCFWq5Srfc3BHKbUnTE40sBf9Y5SOzYLr2XN103utkHql2577xYkvxQUs/oimH68Y
 SQugXqDqctEDb/dDGDY6/0N3L6FHNbVkoMWkLYfJxCGh8CMuXoTiF0CYDI7vWlwnGU
 RcWCf4kPtyLyRJ1Z2rgzLlBszqJ7S0Z/a3Iqq38c=
Date: Thu, 19 Mar 2020 16:20:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/2] target/ppc: Fix slbia TLB invalidation gap
Message-ID: <20200319052051.GF628315@umbus.fritz.box>
References: <20200318044135.851716-1-npiggin@gmail.com>
 <20200318175232.37db1fd1@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
Content-Disposition: inline
In-Reply-To: <20200318175232.37db1fd1@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2020 at 05:52:32PM +0100, Greg Kurz wrote:
65;5803;1c> On Wed, 18 Mar 2020 14:41:34 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> > slbia must invalidate TLBs even if it does not remove a valid SLB
> > entry, because slbmte can overwrite valid entries without removing
> > their TLBs.
> >=20
> > As the architecture says, slbia invalidates all lookaside information,
> > not conditionally based on if it removed valid entries.
> >=20
> > It does not seem possible for POWER8 or earlier Linux kernels to hit
> > this bug because it never changes its kernel SLB translations, and it
> > should always have valid entries if any accesses are made to usespace
>=20
> s/usespace/userspace

Corrected in my tree, thanks.

>=20
> > regions. However other operating systems which may modify SLB entry 0
> > or do more fancy things with segments might be affected.
> >=20
> > When POWER9 slbia support is added in the next patch, this becomes a
> > real problem because some new slbia variants don't invalidate all
> > non-zero entries.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
>=20
> LGTM
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >  target/ppc/mmu-hash64.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index 34f6009b1e..373d44de74 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -100,20 +100,29 @@ void helper_slbia(CPUPPCState *env)
> >      PowerPCCPU *cpu =3D env_archcpu(env);
> >      int n;
> > =20
> > +    /*
> > +     * slbia must always flush all TLB (which is equivalent to ERAT in=
 ppc
> > +     * architecture). Matching on SLB_ESID_V is not good enough, becau=
se slbmte
> > +     * can overwrite a valid SLB without flushing its lookaside inform=
ation.
> > +     *
> > +     * It would be possible to keep the TLB in synch with the SLB by f=
lushing
> > +     * when a valid entry is overwritten by slbmte, and therefore slbi=
a would
> > +     * not have to flush unless it evicts a valid SLB entry. However i=
t is
> > +     * expected that slbmte is more common than slbia, and slbia is us=
ually
> > +     * going to evict valid SLB entries, so that tradeoff is unlikely =
to be a
> > +     * good one.
> > +     */
> > +
> >      /* XXX: Warning: slbia never invalidates the first segment */
> >      for (n =3D 1; n < cpu->hash64_opts->slb_size; n++) {
> >          ppc_slb_t *slb =3D &env->slb[n];
> > =20
> >          if (slb->esid & SLB_ESID_V) {
> >              slb->esid &=3D ~SLB_ESID_V;
> > -            /*
> > -             * XXX: given the fact that segment size is 256 MB or 1TB,
> > -             *      and we still don't have a tlb_flush_mask(env, n, m=
ask)
> > -             *      in QEMU, we just invalidate all TLBs
> > -             */
> > -            env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
> >          }
> >      }
> > +
> > +    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
> >  }
> > =20
> >  static void __helper_slbie(CPUPPCState *env, target_ulong addr,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5zATMACgkQbDjKyiDZ
s5Ls1w//bNp1Cyh3b3KMllrDIkagU6PD9G0wJbjGNWfKrVN9dAPrLXXJL9lLEmfa
S+9x7tdPnQi+ETSd5/pVfO39kSUK+AqQmmpu46WSogPvIpG5AaZ7alEL98tLsoNl
HhFL+lcHRJj/CqHwqjwBKjG1kmC62T4+4W8TsNbW/FrweG/vC8WSIWtuCh57cZCa
AdPW09wYICKApL+fPS1H97YWCcz2ui0QXcCaJW6g/Zo72IjWvttpuIAnY9zdOla5
o3F1bMzl+e/8SlrAlWZ/D9JWG1sCwJLGwHCYidPLmSvdjm2seacwhX8KUwZjpnqz
ugcdtnajYpNtFL3MUjMc5yg4qM46f+N4b5Now6fqiW/c4VG0Y9EhYLkfD35958zr
q4LezjwmQ9Kz0hGXMZKaPD0Y9jUzVgRsK0fp67rrjIXsav7j3cNYFpwWzXtzvHsH
sTU89HILgyvzvy5E82UTzrIdm6QieUeaYyZufUw/G/qZpRe4uAH2uiJLhAA6FmNM
1ts8jjD4FYkSgKNPJRutwP45wfR+di79mO2NCSSVV5Zgqao7MYaSt8DD0/VR1ZK3
JDV7OU3swbghs5w3GAJ40cV72HtKw/bCYkXxP99QYS/QsIUjB0KxGKT+Bjleg3Su
4/P1nAWhCBymf4m3fUpyN9vLZH4uies8LuBXcuhc/HBtQwkZmEg=
=2QZc
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--

