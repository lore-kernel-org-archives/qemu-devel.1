Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8C1C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 03:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F7F2182B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 03:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QbjCqFMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F7F2182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq7yD-000278-MW
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 23:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hq7y1-0001bB-Hc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 23:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hq7y0-0008Bu-9Z
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 23:29:25 -0400
Received: from ozlabs.org ([203.11.71.1]:39295)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hq7xz-00084y-LT; Tue, 23 Jul 2019 23:29:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45tgnB1Lmhz9s3l; Wed, 24 Jul 2019 13:29:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563938958;
 bh=jxMHOa5rLZwurq6zGi+jB5k4x+GRvBCBWSEocgF+BgY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QbjCqFMfjXGhTw/AIgCGEyx39tcu1JVASKVUgkKaQW4NHXJleLCX5hKDKR4kKOm//
 vUq4PJ5+/Fm/OBSIGmOO6NRFVnAA2hA98QITdXE0ym8e91rIYMxSb1eVWwDYnlRvb0
 WFceGktltVsqhl1kI1ZQ8D7lB6AsozyJhlaqeJyA=
Date: Wed, 24 Jul 2019 13:23:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190724032308.GV25073@umbus.fritz.box>
References: <20190723090138.30623-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Uzkapz4/HjIvV4VZ"
Content-Disposition: inline
In-Reply-To: <20190723090138.30623-1-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Generate phandle for the
 "interrupt-parent" property
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


--Uzkapz4/HjIvV4VZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 11:01:38AM +0200, C=E9dric Le Goater wrote:
> Devices such as the BT or serial devices require a valid
> "interrupt-parent" phandle in the device tree and it is currently
> empty (0x0). It was not a problem until now but since OpenFirmare
> started using a recent libdft (>=3D 1.4.7), petitboot fails to boot the
> system image with error :
>=20
>    dtc_resize: fdt_open_into returned FDT_ERR_BADMAGIC
>=20
> Provide a phandle for the LPC bus.
>=20
> Suggested-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I've applied this, since it looks to be correct.

But.. can you connect the dots for me in how this being missing
results in a BADMAGIC error??

> ---
>  hw/ppc/pnv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 36f57479a1f5..2deceecdccb5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -431,9 +431,14 @@ static void pnv_dt_isa(PnvMachineState *pnv, void *f=
dt)
>          .fdt =3D fdt,
>          .offset =3D isa_offset,
>      };
> +    uint32_t phandle;
> =20
>      _FDT((fdt_setprop(fdt, isa_offset, "primary", NULL, 0)));
> =20
> +    phandle =3D qemu_fdt_alloc_phandle(fdt);
> +    assert(phandle > 0);
> +    _FDT((fdt_setprop_cell(fdt, isa_offset, "phandle", phandle)));
> +
>      /* ISA devices are not necessarily parented to the ISA bus so we
>       * can not use object_child_foreach() */
>      qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NULL,=
 NULL,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uzkapz4/HjIvV4VZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl03zxwACgkQbDjKyiDZ
s5JI1BAAn5dk95K5UWyTA3YILOZLlFqQbKl77MTtXg247dKP4uLY8gF5PSA2fU8Q
M4GrtjOsN5AooivaG9j8xT/xW2g/dgOml2YDo3aBXk3S7o5Gr/pQIYociHTxB8Ee
3u8QjumH0znJmYayuFy90dPyK8UbLE5vTIkH+6i0Xz30V84ZpZONJ8ekkywRvALM
UNH5tnKRreN4DJPgJHV8eixb4w57DODIBQ6Sn2dhI4y1dMfqjezhlaN0pbNq66IX
a/snK5DwekokpRRvR3lG9RfZ7jU6b88eUmSFOE7AxzVbY1WoV56aSUrXowjjBpjW
5Kuap+cesPz98/hraLc370UeZb8OD1hcYdw154xiTsXjP57YQQZvWfKna64+UCND
NjO0D5q59xwarI9FVMqqx2E5UXqjCXhaQMhQtkIdCwnlJ4Cf13vcQ76gQCZJzi3+
iDTizf8A3lFl5AUcUys+zJAluwvmYUSyEFJe2qMNa6K6Dsqn2GCnEo/wvf0UqiR3
nvvNEspCzJEdP5xK4bGvbtjbayic2DiBtpkfUMROV5p1gAMxrAzZwH6fympGJ7iD
yHPiMsH8SlrmiiWAYOB8QAaXl2scrs+Wdy5dGxmyyEr8K7xPvJbbyi9waKRqNC+A
EPMoanrHGORPtq4nr3Z64cTcvbM36UheW6w5zNIhiS5nwd7IxPc=
=vuKu
-----END PGP SIGNATURE-----

--Uzkapz4/HjIvV4VZ--

