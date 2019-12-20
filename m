Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FA3C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 00:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E282465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 00:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pEa+D1SM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E282465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii6BN-0000XE-UA
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 19:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ii6AJ-0008LU-EX
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 19:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ii6AG-0007dv-5R
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 19:29:11 -0500
Received: from ozlabs.org ([203.11.71.1]:40423)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ii6AF-0007MS-2Y; Thu, 19 Dec 2019 19:29:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47f8kR2cDQz9sPW; Fri, 20 Dec 2019 11:29:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576801743;
 bh=Tr3TC7IDOK5lSRhu3oDFcU8JlKCSygNgOHpIJ9/p2PA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pEa+D1SMwaQOy0b67ZZDBvWoPluKY+ZTkot/uUQ3G3EPHlcJGBa/0rS1q5XQT6MuT
 kOll66wn2ClGk5H793ugvC/rWaNQsdafgaiDHBSl+LJMAt9lTKIlDERaMunjO8V1nO
 BiV1UXn8fYrWnbwXu8TKGK362JTDXy/7RkPobRkE=
Date: Fri, 20 Dec 2019 11:26:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 01/13] ppc/pnv: Modify the powerdown notifier to get
 the PowerNV machine
Message-ID: <20191220002637.GK2321@umbus.fritz.box>
References: <20191219181155.32530-1-clg@kaod.org>
 <20191219181155.32530-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hl1kWnBARzJiTscN"
Content-Disposition: inline
In-Reply-To: <20191219181155.32530-2-clg@kaod.org>
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


--hl1kWnBARzJiTscN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 07:11:43PM +0100, C=E9dric Le Goater wrote:
> Use container_of() instead of qdev_get_machine()
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0.

> ---
>  hw/ppc/pnv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index f77e7ca84ede..855254f28263 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -561,7 +561,7 @@ static void *pnv_dt_create(MachineState *machine)
> =20
>  static void pnv_powerdown_notify(Notifier *n, void *opaque)
>  {
> -    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
> +    PnvMachineState *pnv =3D container_of(n, PnvMachineState, powerdown_=
notifier);
> =20
>      if (pnv->bmc) {
>          pnv_bmc_powerdown(pnv->bmc);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hl1kWnBARzJiTscN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl38FT0ACgkQbDjKyiDZ
s5Iu0A//ZwtM/8JrCk+S8CUs6SueG0wh/Yyf2f9/cXWbC2PoRzInImmhCOUi71td
+a0/Yp8w4myFcEsPdfHMlQLktHdldA2wsgElztq3ypvRl7B4+kGNG/zyRR2wWQrL
yCDokkw4jigg5IHwGcV55eOy6NLJ/5xkW+R00ActRR/sYbaZyoA8dCXvdMSCQJRP
qX1ZFIRN6Rvay+ESsWow3pIOGFRe5YqK9H8YSQBosBEnZx22le/qqoZ4xMcHMH6O
WgSENkI94aWGL6sB+A30fW3ZhlpIui7KA2ZwQ5vshk84iAXX0w6xGQheCV7mj1+4
66CqOgoioLTOpUuGQGs74JvRxPSLCZtymcsBFWanBuAx8wLeILSCS5Y2a0wohy0D
vgknORwbtYrkNvOUy3u3//wfe/t5WkzFU8g/bc+l4ZwHGYOqfb2znPBz56QLWkuo
13ZaekztrQ9fyXvweM9SehfZ/FI1ShcZw1ZChNdwIIJ/yVuIrxxR9cHXr0R1I4mU
tSE6PuFdG1K7lzkDZf+Cwxp83J2UTG6ZQOL9oTqskhkirggDL7SrWn8JzoEeMbTa
LTSW7bQAhXIYP/4/pgnZPgCHfJW/c7D+/9hUC9eWpwREZZsy5sQzN31YNYPIy0AP
icBtWsfE8gVPOyGwCjFcIL2FcMEP8qIVuKWm8YbbRV02UrE0tv4=
=c0Jp
-----END PGP SIGNATURE-----

--hl1kWnBARzJiTscN--

