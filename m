Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F6C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D083E206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iEUHAumv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D083E206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSgH-0004Lb-L8
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDSct-0008EX-Om
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDScr-0001aA-5j
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:03 -0400
Received: from ozlabs.org ([203.11.71.1]:49357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDSco-0001JP-Ks; Thu, 26 Sep 2019 08:12:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fDLY34dzz9sNk; Thu, 26 Sep 2019 22:11:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569499909;
 bh=Q7JOQyz0IBV3fpuY7oKlOREzm2yR2Dr1jGvdBA/m/VI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iEUHAumvlXiZcMbIBNgH5YFrltd2qgDs/c9DuU3RUuKAPWDMHt3HiJbeDnKLsiEgW
 4pcCYXpjFes3k+RsKdMiQg/Bp4LgsoN9Ah4QVQtwkZkntGb6i/xHvV1dmDbCbsBkBz
 7Z8WNDVxIWn1wgwLh6vxmh3+PzRz4w7qcb+e+lV4=
Date: Thu, 26 Sep 2019 21:21:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr/irq: Fix migration of older machine types with XIVE
Message-ID: <20190926112155.GX17405@umbus>
References: <156942766014.1274533.10792048853177121231.stgit@bahia.lan>
 <20190926013808.GV17405@umbus> <20190926101300.6fa73adc@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YvxfeT9y/1FRS2+9"
Content-Disposition: inline
In-Reply-To: <20190926101300.6fa73adc@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YvxfeT9y/1FRS2+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 10:13:00AM +0200, Greg Kurz wrote:
65;5603;1c> On Thu, 26 Sep 2019 11:38:08 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Sep 25, 2019 at 06:07:40PM +0200, Greg Kurz wrote:
> > > Recent patch "spapr/irq: Only claim VALID interrupts at the KVM level"
> > > broke migration of older machine types started with ic-mode=3Dxive:
> > >=20
> > > qemu-system-ppc64: KVM_SET_DEVICE_ATTR failed: Group 3 attr 0x0000000=
000001300: Invalid argument
> > > qemu-system-ppc64: error while loading state for instance 0x0 of devi=
ce 'spapr'
> > > qemu-system-ppc64: load of migration failed: Operation not permitted
> > >=20
> > > This is because we should set the interrupt source in KVM at post loa=
d,
> > > since we no longer do it unconditionaly at reset time for all interru=
pts.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >=20
> > > David,
> > >=20
> > > I guess you should probably fold this fix directly into Cedric's
> > > patch (currently SHA1 966d526cdfd9 in ppc-for-4.2) to avoid
> > > bisection breakage.
> >=20
> > Done.
> >=20
>=20
> Ok, I see it in ppc-for-4.2. Just one cosmetic nit, missing ']' in
> the updated changelog:
>=20
> [dwg: Folded in fix up from Greg Kurz

Fixed, thanks.
>=20
> > > ---
> > >  hw/intc/spapr_xive_kvm.c |   11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > > index 71b88d7797bc..2006f96aece1 100644
> > > --- a/hw/intc/spapr_xive_kvm.c
> > > +++ b/hw/intc/spapr_xive_kvm.c
> > > @@ -678,6 +678,17 @@ int kvmppc_xive_post_load(SpaprXive *xive, int v=
ersion_id)
> > >              continue;
> > >          }
> > > =20
> > > +        /*
> > > +         * We can only restore the source config if the source has b=
een
> > > +         * previously set in KVM. Since we don't do that for all int=
errupts
> > > +         * at reset time anymore, let's do it now.
> > > +         */
> > > +        kvmppc_xive_source_reset_one(&xive->source, i, &local_err);
> > > +        if (local_err) {
> > > +            error_report_err(local_err);
> > > +            return -1;
> > > +        }
> > > +
> > >          kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local=
_err);
> > >          if (local_err) {
> > >              error_report_err(local_err);
> > >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YvxfeT9y/1FRS2+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2Mn1EACgkQbDjKyiDZ
s5InLQ//WZT1bx14/Dqzuk7XI6HxfieRi5t9K6+owkQUFVzm3yToWf33MFq7uHM6
mRB0CVuPqsPJurxJrYMISDnd+n502PFhIfMAT096aXuzfNbBleFzHiYRn3+xsZvO
JyR72wenDa4M7QD+zlYdTzdFuPNN9dpoj6jbz25cogwOX0imQ5eFbDnpf1ytv+VZ
LxlaSO2VrfAsTs9gcz5LygEn5pa7P2IGCEeXGHTQy8Gtkk/GUy7tOzGhKkV63ZCk
cSa7nVoyM0Wr7wNhXZ3XX1Vf4eapyv1xs0JcPOg77dwJEg4yQBFjrh0wPbB9bYfp
A37kK6YMHyQTjHBD8XjTP40Oh08MbRiisCpDBGy6eCIcxH7YPfS99/WWBlx0JPau
F/4pkmusYj5a7ibCVq1PJcjfHTpB3NOWGtC2nxisKoJuTScC9wBktnWnnBvPNuRl
5QTbiFDGxPhLNQGahm6JmFjjpAHYrbglV14x1q1pH4Ty65JFb5slTGpNHR1RZfgI
hzONb6O0qe00Pmu0cFxYRNCKoAPH0yI/9SmCDHzq7S3ln3/5s/4OFKUwn7X1bUdB
CdJJ0gMdZRY5BdVT01bSl0hhc238yJTmIT0sh4hKe9ciTCoFXx32VaTXnCmX0mN3
ucHgLuOB1U/YnxksH/7hNhIN3YGatfnoeqqKrtAPgp6PdduzIFs=
=pFdn
-----END PGP SIGNATURE-----

--YvxfeT9y/1FRS2+9--

