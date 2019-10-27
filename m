Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D10CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C5821726
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="d+9dflgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C5821726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmMy-0003S0-CG
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJq-0004Gk-1P
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJo-0006hW-1D
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41259 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iOmJn-0006ad-Bi; Sun, 27 Oct 2019 13:27:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 471Psw2fgJz9sPZ; Mon, 28 Oct 2019 04:26:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572197220;
 bh=K2jkG/fRtukLjm2pMdgYnX+MoPCbjWnPhgbGInUz9q0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d+9dflgrwmzNsRuSX1UMiyz2/dtCFEofUZ/MpajnWZOPeEx0Gc3bT0k58ITl6K03n
 fbuqRuAkHb/hdTlCnxn2SgYsUiJWNRi/gQAsz9rWhVO+T5VTAx2TASBdTt0TTEo0Vb
 jgp9WenGM2ImhsXNB7h1Ji5r9UFeaL/cc7nrdP+U=
Date: Sun, 27 Oct 2019 17:57:16 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/6] ppc: Reparent presenter objects to the interrupt
 controller object
Message-ID: <20191027165716.GE3552@umbus.metropole.lan>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184233056.3053790.13073641279894392321.stgit@bahia.lan>
 <20191024025841.GT6439@umbus.fritz.box>
 <20191024110453.0b81b1b2@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20191024110453.0b81b1b2@bahia.lan>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 11:04:53AM +0200, Greg Kurz wrote:
> On Thu, 24 Oct 2019 13:58:41 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Oct 23, 2019 at 04:52:10PM +0200, Greg Kurz wrote:
> > > Each VCPU is associated to a presenter object within the interrupt
> > > controller, ie. TCTX for XIVE and ICP for XICS, but our current
> > > models put these objects below the VCPU, and we rely on CPU_FOREACH()
> > > to do anything that involves presenters.
> > >=20
> > > This recently bit us with the CAM line matching logic in XIVE because
> > > CPU_FOREACH() can race with CPU hotplug and we ended up considering a
> > > VCPU that wasn't associated to a TCTX object yet. Other users of
> > > CPU_FOREACH() are 'info pic' for both XICS and XIVE. It is again very
> > > easy to crash QEMU with concurrent VCPU hotplug/unplug and 'info pic'.
> > >=20
> > > Reparent the presenter objects to the corresponding interrupt control=
ler
> > > object, ie. XIVE router or ICS, to make it clear they are not some ex=
tra
> > > data hanging from the CPU but internal XIVE or XICS entities. The CPU
> > > object now needs to explicitely take a reference on the presenter to
> > > ensure its pointer remains valid until unrealize time.
> > >=20
> > > This will allow to get rid of CPU_FOREACH() and ease further improvem=
ents
> > > to the XIVE model.
> > >=20
> > > This change doesn't impact section ids and is thus transparent to
> > > migration.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> >=20
> > Urgh.  I see why we want something like this, but reparenting the
> > presenters to the source modules (particularly for XICS) makes me
> > uncomfortable.
> >=20
> > AFAICT the association here is *purely* about managing lifetimes, not
> > because those ICPs inherently have something to do with those ICSes.
> > Same with XIVE, although since they'll be on the same chip there's a
> > bit more logic to it.
> >=20
>=20
> I did it this way for XIVE because they are indeed on the same chip,
> but I agree it is questionable for XICS.
>=20
> > For spapr we kinda-sorta treat the (single) ICS or XiveRouter object
> > as the "master" of the interrupt controller.  But that's not really
>=20
> Agreed for XICS. On the other side, the XIVE controller chip really has
> a routing sub-engine (IVRE) and a presenter sub-engine (IVPE), and the
> TCTXs do reside in an SRAM within the IVPE. The XiveRouter type might
> be better named XiveController, and each instance to expose a XiveRouter
> and a XivePresenter interface. We have one per chip for PNV and only a
> single one for sPAPR.

Yes, that sounds like a reasonable approach for XIVE.

>=20
> > accurate to the hardware, so I don't really want to push that way of
> > looking at it any further than it already is.
> >=20
> > If we could make the presenters children of the machine (spapr) or
> > chip (pnv) that might make more sense?
> >=20
>=20
> It probably makes sense for XICS, not sure this makes things clearer
> for XIVE.
>=20
> > I'm also not totally convinced that having the presenter as a child of
> > the cpu is inherently bad.  Yes we have bugs now, but maybe the right
> > fix *is* actually to do the NULL check on every CPU_FOREACH().
> >=20
> > For comparison, the lapic on x86 machines is a child of the cpu, and I
> > believe they do have NULL checks on cpu->apic_state in various places
> > they use CPU_FOREACH().
> >=20
>=20
> I didn't want to go that way because I was finding CPU_FOREACH() to
> be fragile since all users are broken,

Hm, ok.  There aren't that many existing users though, right?

> but I can revisit that. Maybe
> worth consolidating the logic in a PRESENTER_FOREACH() macro in order
> to avoid future breakage with CPU_FOREACH() ?

That sounds worth considering at least, yes.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl21zGwACgkQbDjKyiDZ
s5JiexAAg5+jswTGdD2/Fm7IyIrWcztzQGh6h4TOyV6couz0YI2kOCgJ/cEtgtdr
L10UrJPEdMpnHmjzWukT3X6tbWm+ihG6L8v+aHrGhhziY5P+JClZwPRHDjsJ7s8U
ISuSf4bYVkNg6evvKIQBBTtl/jJPkq61LYcTooa/8GpHnOCeS0sXFYzT8WJmoc6K
B+gF3rELSklhPIvZC5SHHNhtoy8P5TTnV7KM+wzf8+luPtLLvJy5692SUYQvDEhx
JqUMC6btUX20BxnCLa7ArCPshyWWvZ4gwp9wEydKcZerGyvXv1FiauCc5sU6aih4
DstGv7MHH0MYc05hxsBLnfJapLMWdw1RfuP0Zg4JUJCIdU8QbC2DFTxDyro2nSz9
O2YYvx9ddJTiBXMjESZZDWtUbH6JBbfWjHU/b5En/1iZwTaM5xnv/VdHL+0x4w4a
Na+j8pWSbh+OWvdqa4OjIqsYqFfJhbI9VpvM4bfC0OvtHd0yxchlJmpifmWs/SD9
4a+Fb4R00fWlpg/7qpgPS6CTsYDWz+6EwyADp67dzb8qdXUZcQHvxOLE/MBluDn5
NTNjJf5m59LaIhLDcNl7dDEEjyWiX0aMGyLDn8mUip7DoCbE9cWSEgSjCde2nHkf
zIYfq3oiNemIi7A3hWqsRK7ZHco/Qq4G/rRZUyTQ0U4ZwyXjoRc=
=h1tE
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--

