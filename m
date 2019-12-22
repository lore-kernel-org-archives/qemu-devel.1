Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284AAC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 09:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73C62070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 09:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ewgJdBJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73C62070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iixiD-0007ol-3A
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 04:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iixhH-0007NW-Qk
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 04:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iixhC-0007aY-O8
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 04:38:47 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:46109)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iixhB-0006Zc-Id; Sun, 22 Dec 2019 04:38:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47gcqQ71mpz9sQp; Sun, 22 Dec 2019 20:38:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577007507;
 bh=/RFK1jYKNYbvrlmbr/elw+Xzlg5/B2KgRBd9XA8Z5xM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ewgJdBJpO3lUGzoqBuRdgcNAnEmJRtfgmGZfyLJ9NnOJm5SSmOOy+o1gPUOhynKGl
 MxCjLrmTBWOcVsQT6pGPVoGnYGEakGlVdtUONaeRavPDnHrExYHm9eTYX0BDqfEiCs
 fxb56aNp0XtJRuqs3FhgKm3/MhhHISK6zQBKrliM=
Date: Sun, 22 Dec 2019 20:33:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 03/13] ppc/pnv: Introduce a "xics" property alias
 under the PSI model
Message-ID: <20191222093331.GA21569@umbus.fritz.box>
References: <20191219181155.32530-1-clg@kaod.org>
 <20191219181155.32530-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20191219181155.32530-4-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 07:11:45PM +0100, C=E9dric Le Goater wrote:
> This removes the need of the intermediate link under PSI to pass the
> XICS link to the underlying ICSState object.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

LGTM, but will need a rebase if we're dropping the previous patch.

> ---
>  hw/ppc/pnv.c     |  4 ++--
>  hw/ppc/pnv_psi.c | 11 ++---------
>  2 files changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 1d8bfb164a32..163a658806e2 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -999,8 +999,6 @@ static void pnv_chip_power8_instance_init(Object *obj)
> =20
>      object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi),
>                              TYPE_PNV8_PSI, &error_abort, NULL);
> -    object_property_add_const_link(OBJECT(&chip8->psi), "xics",
> -                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
> =20
>      object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc),
>                              TYPE_PNV8_LPC, &error_abort, NULL);
> @@ -1069,6 +1067,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
>                              "bar", &error_fatal);
>      object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip->system_me=
mory),
>                               "system-memory", &error_abort);
> +    object_property_set_link(OBJECT(&chip8->psi), OBJECT(qdev_get_machin=
e()),
> +                             ICS_PROP_XICS, &error_abort);
>      object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 28d34e5c193a..d3124f673571 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -470,6 +470,8 @@ static void pnv_psi_power8_instance_init(Object *obj)
> =20
>      object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->ic=
s),
>                              TYPE_ICS, &error_abort, NULL);
> +    object_property_add_alias(obj, ICS_PROP_XICS, OBJECT(&psi8->ics),
> +                              ICS_PROP_XICS, &error_abort);
>  }
> =20
>  static const uint8_t irq_to_xivr[] =3D {
> @@ -485,21 +487,12 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
>  {
>      PnvPsi *psi =3D PNV_PSI(dev);
>      ICSState *ics =3D &PNV8_PSI(psi)->ics;
> -    Object *obj;
>      Error *err =3D NULL;
>      unsigned int i;
> =20
>      assert(psi->system_memory);
> =20
> -    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
> -    if (!obj) {
> -        error_setg(errp, "%s: required link 'xics' not found: %s",
> -                   __func__, error_get_pretty(err));
> -        return;
> -    }
> -
>      /* Create PSI interrupt control source */
> -    object_property_set_link(OBJECT(ics), obj, ICS_PROP_XICS, &error_abo=
rt);
>      object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs", =
&err);
>      if (err) {
>          error_propagate(errp, err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3/OGkACgkQbDjKyiDZ
s5J60A/+NLT08LXNwMNgkKUCnoa6FJ1ti2z09cXZz1KW/0NBMs5vT5JGIrwtYsmm
eQmR59oo85k8QKYkaWeVJG8hXJXy1UcX3Cr/0LJweeZrZHItzBUiPIUjPDA+wXVo
JYVmZQ6hIEiANa267mEaWftvrwLcmytxJY6gzfPQjKaERXFAPJ0tCtz0RLsi4jMb
t6Zs5ktu5eMSQLUzFrOXOzgoPTKwzlHzr4d8Ijo8FKX3V/cLqxCqOk4oauUpi9gi
fdApvo0YX8upmxWGNd1iHe45o+Rakr6H2hw1rAMMgkIp1AUfBagTYjvT/+a5I2JO
BhoH+P1koFR72ArCJ4KdGkU6nTgWCU2T1jm5CxFB8Gl249e7/vaST7FTPtQhaIiI
QGOpKNTkWuc7PECRc4J9u3UO8N7sCnKz8OFMKOjkQ9RPyZzih8BqS2FarmHWkB5k
Vq7wRXmH9zlS2raijPMhYrELJwbCxMxqOaEtEJvKo7lvaFYXZRWdutdtDGsDzmeJ
zl0Sqm5cJ8h+ZcZHG2o9t4CScnhJcQPq+Ilv3JXF+k07c2tX7Vuu4B7KaDL7qYRN
Uaz7pLPzENwNnr/+/wPkAlGdCB3gsA1XjxCJOe5uxY3PjifYIHtYn4VyWcmP0RnK
0X+YKBIGcT8tt34E0tUe5kvV3igCv2uNU3jmF46bUZapZ4dDigg=
=1zMf
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--

