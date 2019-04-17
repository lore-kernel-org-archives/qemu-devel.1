Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE7DC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 13:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15550206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 13:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AJ0/SToq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15550206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGkjX-0001gH-1r
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 09:36:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGkiB-0000sl-Sp
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 09:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGkiA-00064H-JK
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 09:34:51 -0400
Received: from ozlabs.org ([203.11.71.1]:49121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hGki9-0005vA-Dz; Wed, 17 Apr 2019 09:34:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44kjrl4xvXz9s5c; Wed, 17 Apr 2019 23:34:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555508071;
	bh=sLA2tUl4+AYcGYGnD2y+zcR+uCmwJDVe832++001mM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJ0/SToqfK/DozhrcZqdiNSFxxfaPZEjGRGdC0KPYIvNVrA0ENOHoBwbR8qKEic/s
	eIdO5M9RZaWR9uTTl2DKAHahyMy13gsa201qTlrxUUbyyU/cGDyqLsWFPlkce2UwjS
	G/dPp1CzktC/4HqG1ai78EsGVHgeYOeS4u71tEX8=
Date: Wed, 17 Apr 2019 22:47:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190417124734.GT32705@umbus.fritz.box>
References: <20190416045552.24573-1-npiggin@gmail.com>
	<20190417015934.GH32705@umbus.fritz.box>
	<1555498879.055yucy998.astroid@bobo.none>
	<20190417140129.18980f0e@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wiiWofWi8Et/oezL"
Content-Disposition: inline
In-Reply-To: <20190417140129.18980f0e@bahia.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] spapr: add splpar hcalls
 H_PROD, H_CONFER
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417124734.QD-MUb-xaUBk1_Z7U-QMg4u4p0cch4UlBwBELDi56y8@z>


--wiiWofWi8Et/oezL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 02:01:29PM +0200, Greg Kurz wrote:
> On Wed, 17 Apr 2019 21:20:00 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> > [...]
> > >> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
> > >>      /* hcall-splpar */
> > >>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
> > >>      spapr_register_hypercall(H_CEDE, h_cede);
> > >> +    spapr_register_hypercall(H_CONFER, h_confer);
> > >> +    spapr_register_hypercall(H_PROD, h_prod);
> > >> +
> > >>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset=
); =20
> > >=20
> > > You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
> > > they enabled by default, or is that an intentional change? =20
> >=20
>=20
> AFAICT they seem to be enabled by default in HV KVM.
>=20
> > Oh, it was not intentional, I must not understand how this works. Why
> > is this no longer enabling the those hcalls?
> >=20
>=20
> Since linux commit 699a0ea0823d ("KVM: PPC: Book3S: Controls for in-kerne=
l=20
> sPAPR hypercall handling"), in-kernel hypercalls are disabled by default
> and must be explicitely enabled by userspace. QEMU does that for some
> hypercalls already (search kvmppc_enable_set_mode_hcall() in QEMU for an
> example).
>=20
> Since H_CONFER and H_PROD are listed in default_hcall_list[] in book3s_hv=
=2Ec,
> no need for QEMU to enable them in KVM.

Ah, ok.  Oops, that means the guest environment has been visibly
different for KVM and TCG all this time, which isn't great.

> Not sure about David's "no longer" wording though.


"no longer" meaning the previous patch version had some
kvmppc_enable_hcall(), but this version doesn't.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wiiWofWi8Et/oezL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly3IGYACgkQbDjKyiDZ
s5J9ExAAhk4I4m78I200L5iZYWcmEcORF15HA4UZIMla2IwDmwcJP5OXDP1FWFMf
dLRWFHGMl+DD0OXzM0qM/aCWDQR3PJ5rjX1IULfjI3P45kwebQlqrRwJF1CqXaIf
1cVxWNpbI+wVpePB406K9335ELLqyZ64hupWG0mkoHVSghhzLHEbndUzgfMQ/++C
qNIkTwZK/RqM8kX2KHQcmTiLDrZAhl6pEiixKiRHtkLJ7uYYKFtnO+DR+/sqOyFr
4KXIn6ZoTo4ORf/fzGWQI/ZOgwQnT7MjACceIv+WS+QG8zMA6n0zclBHcgpU9UcS
NKJzyF/eBeK7Q1qfRtnktFwtsVLx4QqxFe4EdnleFhBG+y4ue6NnsUwEugWM+8Sc
ZBWkZUl4IT9Iz7sgA1DOIGQmJUjpJ4KRwc/jFFxkTkJ+dNy+8pEYbvxM9KIDD1Od
OmEmvfKxaBc/7IJKyir2ZKUQIQvlSfg0u3EwTkbA7Lo11GDNGhGjnlyRs5yufISI
S0FDAh+uha2mKnLWFN89AStbKc/lRNq1grErLecm+F2+UQp9IzxmrUy9EN1ZpwVa
JGOnVUgpNOt4Laa3SC7WA9/WQLOeBfEzl2qObJv9TFFtVXvQHnRm60Bu/oS4de1A
DKL9eetnVi+KzYAJHUJsCr/dZEIG7W1u9a9cVveRzJkTAXGEWjY=
=6SwW
-----END PGP SIGNATURE-----

--wiiWofWi8Et/oezL--

