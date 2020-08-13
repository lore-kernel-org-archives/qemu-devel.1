Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24049C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9FB2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QGbIvE3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9FB2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k69gw-0007oO-2s
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 05:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k69fh-0006WM-V9; Thu, 13 Aug 2020 05:37:18 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k69ff-000075-Fs; Thu, 13 Aug 2020 05:37:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS1gT0hvfz9sTM; Thu, 13 Aug 2020 19:37:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597311429;
 bh=Hx4wcuxgCsvDbqutSg60YdmRps8Tss4yGWwtH7OUuek=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QGbIvE3Z+HMzJwAy5aqI+L42zDPORQ56erwDugQPvHJWxFo7rre5dG6/hStUU34fj
 8GozkNDy5wVDermthj3NMFsw4/GeiSR0NwSdW1OSKoCiBrtfzpOy8GcTWqNwBY0oWd
 EJGuh3AunbA2koe6OABYKpBJnoyRd0I2+FCGFRlI=
Date: Thu, 13 Aug 2020 17:12:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 01/14] spapr: Simplify error handling in
 spapr_phb_realize()
Message-ID: <20200813071236.GE17532@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707843851.1489912.6108405733810934642.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Content-Disposition: inline
In-Reply-To: <159707843851.1489912.6108405733810934642.stgit@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:53:58PM +0200, Greg Kurz wrote:
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
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to ppc-for-5.2.

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

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl805+QACgkQbDjKyiDZ
s5J2mBAAh6DqenOwhRCt+nJjWhR2/+UX6bBOFZw9rgQ/DZGuLkgFwl6OZ097CLdM
0oocP/IyncP7EDY8RW2g2xneCwMR6JynkwXG1et+/oj61/nJCSt3ekFY8n4yWGok
VgXP5IVmuQGg5soJLExcMB3rgtBIEJqSwIqKyvI7N+Q0Ax3aoWaHfzDxoUzxw851
zzJmLrQRK8Q5cizXSfOF1bMOLNzkxB+M2Vw8RoXkQ0U5vhuzAy8kersalN1pHktN
1Ce+WnwfaCmZdnlqKHH9hyO/699igj5U4d8Ig1eLOIJutlZuOa6JzHXEW9PKV2Ir
vGyWwmJ3VZV9gxzNfbXoicTVRlQOJB14o+X8RsMjZUdjU2u4jHHG/4LsRE2XBXMA
b/rdgiOFnLn1KL4H5V4BIIGDxCLgrSOvxqksNuU0jKjcwk0sj3LqfveaO3UfsmEQ
KoqtygqGS0v8VOTWiLj8Jd+WEfg10awHsW3+ttR/0Jq1RYzttO1L+bC2hjWBri8L
479QOxpljwEZvHLcL1nFYEyfDZvvCtWYhBCqFkSjYfB8Bg0PeKeev1muJKmtMEzr
tdViMXmqqieN342suIMTctKwL+lR6XbDoav0amKOr3gt//pnsRHqX1B+W7sH7/jR
ZOf8q42Y3++ZVykOIHrMana/CINyFG5hah5lXZpgAi6XvJNrHiA=
=HKV7
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--

