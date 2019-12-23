Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D4FC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 06:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C81420663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 06:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X+jLcU/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C81420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijGya-0000w8-2f
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 01:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijGxY-0008AK-7t
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 01:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijGxW-0007PM-ES
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 01:12:51 -0500
Received: from ozlabs.org ([203.11.71.1]:47089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijGxV-00078t-Co; Mon, 23 Dec 2019 01:12:50 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47h8Cd1NWHz9sR4; Mon, 23 Dec 2019 17:12:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577081565;
 bh=dpusexBASxYe2sEAZBAzOtRUBdBLdqkf/IRBuC3sRHo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X+jLcU/0jiR88m10TBifYf2RUrXgPn4JftR2n1AYY3r4RbBW7S5+KqtiSBxokAcKd
 e6+IjB8M+su754WM9+Ggz02ZpsDR4mzKKOWq5n4eQqPXq/+ZUfdW7v7LcYRWe8ejni
 NhyU21YmkPhLy2fAJvDZGvoAfEdoKs7ou9Q4MZh8=
Date: Mon, 23 Dec 2019 17:12:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 09/13] ppc/pnv: Add an "nr-threads" property to the
 base chip class
Message-ID: <20191223061239.GE38380@umbus.modem>
References: <20191219181155.32530-1-clg@kaod.org>
 <20191219181155.32530-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <20191219181155.32530-10-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 07:11:51PM +0100, C=E9dric Le Goater wrote:
> From: Greg Kurz <groug@kaod.org>
>=20
> Set it at chip creation and forward it to the cores. This allows to drop
> a call to qdev_get_machine().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

But will need rebase.

> ---
>  include/hw/ppc/pnv.h | 1 +
>  hw/ppc/pnv.c         | 8 +++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 8b957dfb5736..4c13d4394a11 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -48,6 +48,7 @@ typedef struct PnvChip {
>      uint64_t     ram_size;
> =20
>      uint32_t     nr_cores;
> +    uint32_t     nr_threads;
>      uint64_t     cores_mask;
>      PnvCore      **cores;
> =20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 915c80a24b3e..e638cdc93091 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -791,6 +791,8 @@ static void pnv_init(MachineState *machine)
>                                  &error_fatal);
>          object_property_set_int(chip, machine->smp.cores,
>                                  "nr-cores", &error_fatal);
> +        object_property_set_int(chip, machine->smp.threads,
> +                                "nr-threads", &error_fatal);
>          /*
>           * TODO: Only the MMIO range should be of interest for the
>           * controllers
> @@ -1529,7 +1531,6 @@ static void pnv_chip_core_sanitize(PnvChip *chip, E=
rror **errp)
> =20
>  static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
>  {
> -    MachineState *ms =3D MACHINE(qdev_get_machine());
>      Error *error =3D NULL;
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>      const char *typename =3D pnv_chip_core_typename(chip);
> @@ -1565,8 +1566,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
>          object_property_add_child(OBJECT(chip), core_name, OBJECT(pnv_co=
re),
>                                    &error_abort);
>          chip->cores[i] =3D pnv_core;
> -        object_property_set_int(OBJECT(pnv_core), ms->smp.threads, "nr-t=
hreads",
> -                                &error_fatal);
> +        object_property_set_int(OBJECT(pnv_core), chip->nr_threads,
> +                                "nr-threads", &error_fatal);
>          object_property_set_int(OBJECT(pnv_core), core_hwid,
>                                  CPU_CORE_PROP_CORE_ID, &error_fatal);
>          object_property_set_int(OBJECT(pnv_core),
> @@ -1609,6 +1610,7 @@ static Property pnv_chip_properties[] =3D {
>      DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
>      DEFINE_PROP_LINK("system-memory", PnvChip, system_memory,
>                       TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_UINT32("nr-threads", PnvChip, nr_threads, 1),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4AWtYACgkQbDjKyiDZ
s5I1XhAA5LN92fgiFAREHTDuIdQCqD95d1SjpNBbhLEt2mGFf9slmfSV4ae2W2qJ
zE1AYjTy3RyXqOEVCYvJC0nDZOC/YJwtEVETfLfx/9QC/8P58AuB286HcLV9xzxD
cLMNUXe8vHpFvKaCNkBdSuTve/gkUsI7Vv+uYvJVUEn2a0cMmmdixcvVbxjTqJFL
1HrdDT6fxtWj1E4umcL3NBYMs36sZ0BPuoMe3c6r22wNdu/Tj6b4utKHGr04Pri8
mX0HYnOKNZuIwWMXydzQqFVIDP2ypPaaOsO9gB1rSv1lDR+u6pODGK1TShg8EfNt
iVzBrl0uXxuqR+4hO9C4kAKKcxy1G6rYrNvT2ifoIRF+/WXYYnd4kOQQCwXDJnVu
6qnnhKG787nHdnjKhPBua1ohbDD086jzd3Mr2K+WPaBoK5S9lykQUjDvI8KIdvyY
QlMIZobW8XSaGO/SB5KLBdUEQ4tkxD7UCQ2pc9mDWwUwhwxnSLxsciJvE+GANBTK
3yeko1n0aamtqq56zSChAfewpqFLvui6vDYcGUdHGlUwiLG5YyEEkLfexvwQdjWw
ojKODLJxZ9m1oSxLip3wDvC8M1JovkbHx5yRhy70LUT+/A2te1EoMEHGgh04jf63
BIp2bKidzq7v0vpcbI3MiOYZyy3hGOl/VdYNlOf/GVun61EZH6k=
=U18E
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--

