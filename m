Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C91C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E2C22B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XReR5HJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E2C22B4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxTwT-00053o-49
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxTvr-0004XG-SR; Mon, 20 Jul 2020 07:26:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43635 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jxTvo-0003W0-78; Mon, 20 Jul 2020 07:26:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B9KD56tJHz9sRf; Mon, 20 Jul 2020 21:25:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595244357;
 bh=cXadi8ggnXTkGx7kvvgkf7phpqLH/qKyNQ/W3TJlC5A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XReR5HJ29P5VL3FvhW2Y0k+pFD4DW4QZ8SDAzoRA9PsKr55t/OV3fHgG2hxYH+SWW
 LMVCQe2xhPHGE7PbghiaIN5Dfn43qwB0LccMcOfoAFpfpuJGg1e+EVx3T2ql1pSNlK
 wEWXVyIK6eUO7NU84hsi1hfWx7m8aqnhqyJFli2I=
Date: Mon, 20 Jul 2020 21:25:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH for-5.2] spapr: Simplify error handling in
 spapr_phb_realize()
Message-ID: <20200720112551.GF215446@umbus.fritz.box>
References: <159500760539.383731.10928308889360009122.stgit@bahia.lan>
 <87lfjefsbh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lYetfuAxy9ic4HK3"
Content-Disposition: inline
In-Reply-To: <87lfjefsbh.fsf@dusky.pond.sub.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 07:25:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lYetfuAxy9ic4HK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 11:29:06AM +0200, Markus Armbruster wrote:
> Greg Kurz <groug@kaod.org> writes:
>=20
> > The spapr_phb_realize() function has a local_err variable which
> > is used to:
> >
> > 1) check failures of spapr_irq_findone() and spapr_irq_claim()
> >
> > 2) prepend extra information to the error message
> >
> > Recent work from Markus Armbruster highlighted we get better
> > code when testing the return value of a function, rather than
> > setting up all the local_err boiler plate. For similar reasons,
> > it is now preferred to use ERRP_GUARD() and error_prepend()
> > rather than error_propagate_prepend().
> >
> > Since spapr_irq_findone() and spapr_irq_claim() return negative
> > values in case of failure, do both changes.
> >
> > This is just cleanup, no functional impact.
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >
> > Since we add ERRP_GUARD(), we could theoretically check *errp
> > rather than the return value, and thus avoid the uint32_t to
> > int32_t change but I personally find it clearer the other way.
> > ---
> >  hw/ppc/spapr_pci.c |   16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 21681215d405..b1ce51327db4 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1796,6 +1796,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
> > =20
> >  static void spapr_phb_realize(DeviceState *dev, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the=
 user
> >       * tries to add a sPAPR PHB to a non-pseries machine.
> >       */
> > @@ -1813,7 +1814,6 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >      uint64_t msi_window_size =3D 4096;
> >      SpaprTceTable *tcet;
> >      const unsigned windows_supported =3D spapr_phb_windows_supported(s=
phb);
> > -    Error *local_err =3D NULL;
> > =20
> >      if (!spapr) {
> >          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries =
machine");
> > @@ -1964,13 +1964,12 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
> > =20
> >      /* Initialize the LSI table */
> >      for (i =3D 0; i < PCI_NUM_PINS; i++) {
> > -        uint32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PIN=
S + i;
> > +        int32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS=
 + i;
>=20
> (1)
>=20
> > =20
> >          if (smc->legacy_irq_allocation) {
> > -            irq =3D spapr_irq_findone(spapr, &local_err);
> > -            if (local_err) {
> > -                error_propagate_prepend(errp, local_err,
> > -                                        "can't allocate LSIs: ");
> > +            irq =3D spapr_irq_findone(spapr, errp);
>=20
> (2)
>=20
> > +            if (irq < 0) {
> > +                error_prepend(errp, "can't allocate LSIs: ");
> >                  /*
> >                   * Older machines will never support PHB hotplug, ie, =
this is an
> >                   * init only path and QEMU will terminate. No need to =
rollback.
> > @@ -1979,9 +1978,8 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >              }
> >          }
> > =20
> > -        spapr_irq_claim(spapr, irq, true, &local_err);
> > -        if (local_err) {
> > -            error_propagate_prepend(errp, local_err, "can't allocate L=
SIs: ");
> > +        if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
>=20
> (3)
>=20
> > +            error_prepend(errp, "can't allocate LSIs: ");
> >              goto unrealize;
> >          }
>=20
>            sphb->lsi_table[i].irq =3D irq;
>=20
> (4)
>=20
>        }
>=20
> The error propagation elimination looks good to me, but I wonder whether
> int32_t is the best choice for @irq.
>=20
> Before the patch:
>=20
> (1) The initialization converts unsigned (I think) to uint32_t.
>=20
> (2) Converts from int (value of spapr_irq_findone()) to uint32_t.
>=20
> (3) spapr_irq_claim() takes int, we convert back to int.
>=20
> (4) The assignment does not convert.
>=20
> After the patch:
>=20
> (1) The initialization converts unsigned (I think) to int32_t.
>=20
> (2) Converts from int (value of spapr_irq_findone()) to int32_t.
>=20
> (3) spapr_irq_claim() takes int, we convert back to int.
>=20
> (4) Converts from int32_t to uint32_t
>=20
> I assume the conversions are all safe before and after the patch
> (spapr_irq_claim() asserts @irq is between 0x1000 and 0x1000 + small
> change).  Still, too many conversions for my taste.  What about making
> irq plain int?  Then:
>=20
> (1) The initialization converts unsigned (I think) to int.
>=20
> (2) Does not convert.
>=20
> (3) Does not convert.
>=20
> (4) Converts from int to uint32_t.
>=20
> Feels neater to me.

Sounds like a good idea.  Greg, care to post a followup patch?
>=20
> Regardless:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lYetfuAxy9ic4HK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Vfz0ACgkQbDjKyiDZ
s5LadxAAyXijUgUMx0z7LKVPQ2SGn60Eihgxl66ChlgAzwWB3mk0tEB6gUOx4ak9
AvNR2G7vlI75DEGciuhcDG0aILonA+Za1xB2nr2dfLye+DBn/LdKxp+yRxrRXjlG
J+D+sJQcxT38+Ng3YyTddc+OGSZ2rFv5I8IStAiDeQxIYwI57Vyru8kvVL92KnKe
koV8ZKx2pbx9/AkuRrLvvZkEM91QfcFCm9TWYg3mhvR3BmFpSsuopmQ1feogLMMt
PhyLkszbQvOvbZu3ZcEkFlWyMik1DtSgT1y6mNpmX4NQXab1ps2cs+A/mWyRxZYc
LLqtB1BJ4gHexLa9v0lTKmoI/XVfEhUiFEiBl2BPXRQu1f6lOyhC2mJGSnc+iWAp
Rt1k362qOARGn+csBHCNV7bPY0Vsxesg9iamEMbL5GhUjZS8/E3sON8eEzdh+iPS
bO57xtt3rs9k9E6NwSpBd1elw3yOSXobNCLyCyd64bQfZCWuclxNmnWKlL4YHvmF
sxbjnY9doAyZlaax43/1hmote57kaDSPhAvaZCr0S8p9rbNTljAXULbqkPJ9N1P2
wKJQn0K0LROQ4rGYuNrAhCRdfzS5ry4I0T4iztCFy4nySB5WJklTsqDjBk2OOc8B
qkT2X9eYQta0XnYv81wVjuFlpUS0Xi7D2nDgIOSwHeLiC+Lc84k=
=AfTo
-----END PGP SIGNATURE-----

--lYetfuAxy9ic4HK3--

