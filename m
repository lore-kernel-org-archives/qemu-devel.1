Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C178C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 02:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEEF20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 02:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S5jNceTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEEF20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iINr8-0006Ek-QA
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 22:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iINpH-0004u9-Sp
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 22:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iINpG-0003p4-4J
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 22:05:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45733 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iINpF-0003nZ-AV; Wed, 09 Oct 2019 22:05:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46pZCw2190z9sPL; Thu, 10 Oct 2019 13:05:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570673100;
 bh=Jn+DbSPEtGDmHfeBWFVREADrVNH+3GtF8XVD4qBJRKw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S5jNceTem20/H/iWaS+FMSSUtffv8AslA7LDdW9vIAcI8f2kTgfqNAsQglHYo6mS7
 jpL01k94c8X9vMso5TLXlFGF2RCfVyusZJGcYV+Hxp1sP15mJp1zqXkLLWysMi6b7e
 rW7Wt7Zao5JPW1RdmslHFXLR3sEoGip6Jy3cW8hg=
Date: Thu, 10 Oct 2019 12:56:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 15/19] spapr: Remove SpaprIrq::nr_msis
Message-ID: <20191010015643.GA28552@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-16-david@gibson.dropbear.id.au>
 <cbf330ce-2f95-5af1-aff5-8bed120c7317@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <cbf330ce-2f95-5af1-aff5-8bed120c7317@kaod.org>
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
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 05:59:13PM +0200, C=E9dric Le Goater wrote:
> On 09/10/2019 08:08, David Gibson wrote:
> > The nr_msis value we use here has to line up with whether we're using
> > legacy or modern irq allocation.  Therefore it's safer to derive it bas=
ed
> > on legacy_irq_allocation rather than having SpaprIrq contain a canned
> > value.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> one minor typo below,
>=20
> > ---
> >  hw/ppc/spapr.c              |  5 ++---
> >  hw/ppc/spapr_irq.c          | 26 +++++++++++++++++---------
> >  hw/ppc/spapr_pci.c          |  7 ++++---
> >  include/hw/pci-host/spapr.h |  4 ++--
> >  include/hw/ppc/spapr_irq.h  |  4 +---
> >  5 files changed, 26 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index e880db5d38..153cc54354 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1275,7 +1275,7 @@ static void *spapr_build_fdt(SpaprMachineState *s=
papr)
> >      }
> > =20
> >      QLIST_FOREACH(phb, &spapr->phbs, list) {
> > -        ret =3D spapr_dt_phb(phb, PHANDLE_INTC, fdt, spapr->irq->nr_ms=
is, NULL);
> > +        ret =3D spapr_dt_phb(spapr, phb, PHANDLE_INTC, fdt, NULL);
> >          if (ret < 0) {
> >              error_report("couldn't setup PCI devices in fdt");
> >              exit(1);
> > @@ -3910,8 +3910,7 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMac=
hineState *spapr,
> >          return -1;
> >      }
> > =20
> > -    if (spapr_dt_phb(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
> > -                     fdt_start_offset)) {
> > +    if (spapr_dt_phb(spapr, sphb, intc_phandle, fdt, fdt_start_offset)=
) {
> >          error_setg(errp, "unable to create FDT node for PHB %d", sphb-=
>index);
> >          return -1;
> >      }
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index f3d18b1dad..076da31501 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -29,9 +29,14 @@ static const TypeInfo spapr_intc_info =3D {
> >      .class_size =3D sizeof(SpaprInterruptControllerClass),
> >  };
> > =20
> > -void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis)
> > +static void spapr_irq_msi_init(SpaprMachineState *spapr)
> >  {
> > -    spapr->irq_map_nr =3D nr_msis;
> > +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> > +        /* Legacy mode doesn't use this allocater */
>=20
> allocater -> allocator

Huh.  I had surprising difficulty trying to confirm what the correct
spelling really is here.  Actual dictionaries seem to thing that
neither "allocater" nor "allocator" are words.  Still "allocator"
seems to be by far the more common variant, so I've changed it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2ej9kACgkQbDjKyiDZ
s5J4mg//eeu2ys1MDeq7VHnUARbwC1w9yvvjelsWAu9aD2SclZjuywTJ8qnw2q/I
j3NekkKJViFzcWbgeIJcufM1jniDsbLrU9TXO9NiD+KRkjNG7/2xy0VpLHbUlj89
PoQXF7i8sIFYc0STSmZBy3j/oiLDY58z/StIVWBA4rTxlX8/jcHWX/vfBzJC0pGY
jNFdqHTrWkwmvcCQa4sn8eZIwK3BI+4BFb8GZpeBgdUJdgzA0YQsibXhCCWx/Z2w
iEwN52ijd+BiubgEysIFYtX7JpTcmRlfvft0a15tRdRM+z1eeD3XrHc9Ovwvz720
iEhyWBv3Qv2MWAeMy5MjTMivenin96cEkuDs+katteWcuOnlMKemqYblingDcmad
5mTDNwymgi95WENu8SAqVi6eKvUm4rTCUz2ekvy8CKQe/8QEbKVl6sQ75cLzIofW
HQq/Ifwa/o/IdJgMqOybmx6v6BHjO7G2H881PhUsDXGTGuClNj8fYFQRnJLKcCPu
kO3dGCOQT3q9Am7WUbm+naroqc1+X7n8hf5k63jip964OwI1sWHeRaHnECTx90uo
uDnAfi7+pGWk4SYfhW9xhqhhBI0NNeVy5NKRcnFgi7Wrt8LkyRxmiLYpOK7Qynvr
gujtRHHmAR9YMe9PkRNMDt23AgQBC+SWBcNfWYBWbDAXR1hlo+g=
=wnT+
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

