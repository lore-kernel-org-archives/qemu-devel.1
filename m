Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E1FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40957204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TIupF7BC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40957204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3YC9-0002nt-NH
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 01:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3YBA-0001CI-IY; Thu, 06 Aug 2020 01:11:00 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3YB7-0001cn-IE; Thu, 06 Aug 2020 01:11:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BMc5N1pZHz9sTM; Thu,  6 Aug 2020 15:10:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596690648;
 bh=/y7WujPLDY1+dO9HAXuEz0GqjljGQITR4r5hB6JMqW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TIupF7BC5aIYPSFqLdGTmEvXxlJn155b4PbO72KXUe7OqXAgHQBqad+ey3S3au/Le
 euBBH9umpSN/sz7N1fUMQVytzysPfphQV6ZKEKuxQu40ZIWDaCmIl+7VMjO4kfS5Xs
 UJn6iuPYM6luxxrYZ3B2fYSmkxdN3NxNiyHNSu+o=
Date: Thu, 6 Aug 2020 15:10:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH for-5.2 5/5] spapr: Simplify error handling in
 spapr_phb_realize()
Message-ID: <20200806051042.GE100968@yekko.fritz.box>
References: <159664891296.638781.18417631893299150932.stgit@bahia.lan>
 <159664895189.638781.16853044840437361763.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
In-Reply-To: <159664895189.638781.16853044840437361763.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 07:35:51PM +0200, Greg Kurz wrote:
> The spapr_phb_realize() function has a local_err variable which
> is used to:
>=20
> 1) check failures of spapr_irq_findone() and spapr_irq_claim()
>=20
> 2) prepend extra information to the error message
>=20
> Recent work from Markus Armbruster highlighted we get better
> code when testing the return value of a function, rather than
> setting up all the local_err boiler plate. For similar reasons,
> it is now preferred to use ERRP_GUARD() and error_prepend()
> rather than error_propagate_prepend().
>=20
> Since spapr_irq_findone() and spapr_irq_claim() return negative
> values in case of failure, do both changes.
>=20
> This is just cleanup, no functional impact.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Note that the int32_t=3D>int followup change suggested by Markus was squa=
shed
> into this patch.
> ---
>  hw/ppc/spapr_pci.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 363cdb3f7b8d..0a418f1e6711 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1796,6 +1796,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
> =20
>  static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
>       * tries to add a sPAPR PHB to a non-pseries machine.
>       */
> @@ -1813,7 +1814,6 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      uint64_t msi_window_size =3D 4096;
>      SpaprTceTable *tcet;
>      const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
> -    Error *local_err =3D NULL;
> =20
>      if (!spapr) {
>          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries ma=
chine");
> @@ -1964,13 +1964,12 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> =20
>      /* Initialize the LSI table */
>      for (i =3D 0; i < PCI_NUM_PINS; i++) {
> -        uint32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS =
+ i;
> +        int irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
> =20
>          if (smc->legacy_irq_allocation) {
> -            irq =3D spapr_irq_findone(spapr, &local_err);
> -            if (local_err) {
> -                error_propagate_prepend(errp, local_err,
> -                                        "can't allocate LSIs: ");
> +            irq =3D spapr_irq_findone(spapr, errp);
> +            if (irq < 0) {
> +                error_prepend(errp, "can't allocate LSIs: ");
>                  /*
>                   * Older machines will never support PHB hotplug, ie, th=
is is an
>                   * init only path and QEMU will terminate. No need to ro=
llback.
> @@ -1979,9 +1978,8 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>              }
>          }
> =20
> -        spapr_irq_claim(spapr, irq, true, &local_err);
> -        if (local_err) {
> -            error_propagate_prepend(errp, local_err, "can't allocate LSI=
s: ");
> +        if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
> +            error_prepend(errp, "can't allocate LSIs: ");
>              goto unrealize;
>          }
> =20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8rkNIACgkQbDjKyiDZ
s5Krdw//Q+AzUCBU0bibV74P6q4T8oEw8cUTOBfSDzDGvU/9GvfvGBBHfenB3msO
KDIHc34uR3HzRK7hhoZSiqgCzzbcN8HTx5pWtrSwsiASzxEyrjAWUISJtF+eCYwP
pDIDk+k1JvCafCzBNcUXp+9AON2SU8RpROU7lvPWCW7LnXiP9uyYl3KJjS2Q7Cn4
jBRKoOwK8xTamAm2Sm4Gi7GxQFjT1kcGRABO6nNozV4yyiufZ2ouDOBk9HCFbV8c
xEr7meJPokjkNaq43sqc+XkzOIELRsWzkCRqQfrXLjJWGkEJNUr6GqByTB6wABQ/
WIxZw279lCOw+4pE4PJV594Ci3PsxLzvl3kuSyFFRpgeD8ReIM9R9GUMALL7TcuU
D4XkqxxGOJwP1a168Pd9UuwNO5S481s4kUzN+wRUgRodX842eL9F1tz2PFLvdsnv
HvgM50C89vuq6B1lVJRpYlHX7VzsxJNET0iLD5TDAT5Ra41fgGBDTCa91lw6rwnL
7DUu0KDs9eEuyTt1zma5s9IoB8XQ8IVymNgWH3juXTyc3L4SRcLyelbNMfXv7M70
dHUQ9V8GiqA10dSShcWoKEoo/MRZFI5ZomT8s/zFQnDuEKrZ1sOrFj0m06a5wior
v5rCxMdLoKQYsCM6+MoSFFVVWO9Ppr48A5SDQo6hdURjsw5FFlQ=
=FWKe
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--

