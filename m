Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018D6C32771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66002072E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ihgriU9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66002072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iocQK-0007eI-V0
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 19:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iocJn-0007up-VE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iocJl-0005cO-LN
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:01:55 -0500
Received: from ozlabs.org ([203.11.71.1]:51583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iocJl-0005Xo-8S; Mon, 06 Jan 2020 19:01:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sCGf3jc3z9sRR; Tue,  7 Jan 2020 11:01:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578355306;
 bh=vbVkizeB2tlK42HOcxWWfy4YVs22gKlhuSp5KkgE7Ns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ihgriU9TaGgmJnMA0FNRH8uTUYGNW3nR/35rPFKKkzpWvd4s9R3Wl0eicWtA9F0BM
 VVVM2dMeP79fYoL0T9Koh2lbLZ45T/ha2jhUw16K/JN6SsOztBa6GRMmy6VKO1FzvV
 9P9iZfSXXWTtO+ynDb0weOl8he7nbVYAahWUlV6o=
Date: Tue, 7 Jan 2020 11:00:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] spapr/xive: remove redundant check in spapr_match_nvt()
Message-ID: <20200107000010.GB2098@umbus>
References: <20200106163207.4608-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZCk4OG7a+AFlaik7"
Content-Disposition: inline
In-Reply-To: <20200106163207.4608-1-clg@kaod.org>
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


--ZCk4OG7a+AFlaik7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 05:32:07PM +0100, C=E9dric Le Goater wrote:
> spapr_match_nvt() is a XIVE operation and it used by the machine to
> look for a matching target when an event notification is being
> delivered. An assert checks that spapr_match_nvt() is called only when
> the machine has selected the XIVE interrupt mode but it is redundant
> with the XIVE_PRESENTER() dynamic cast.
>=20
> Apply the cast to spapr->active_intc and remove the assert.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0.

> ---
>  hw/ppc/spapr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e62c89b3dd40..5008b7563173 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4198,19 +4198,19 @@ static void spapr_pic_print_info(InterruptStatsPr=
ovider *obj,
>                     kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
>  }
> =20
> +/*
> + * This is a XIVE only operation
> + */
>  static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
>                             uint8_t nvt_blk, uint32_t nvt_idx,
>                             bool cam_ignore, uint8_t priority,
>                             uint32_t logic_serv, XiveTCTXMatch *match)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
> -    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
> +    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->active_intc);
>      XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
>      int count;
> =20
> -    /* This is a XIVE only operation */
> -    assert(spapr->active_intc =3D=3D SPAPR_INTC(spapr->xive));
> -
>      count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
>                             priority, logic_serv, match);
>      if (count < 0) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZCk4OG7a+AFlaik7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4TygoACgkQbDjKyiDZ
s5IdvA/+OHwv3icFir9mPIITEnrk8Tut8HcKfAtxHx+9QlBdLZLMAwehlPUktJRw
3Mw/yB0f7kE8hrLlDsQxnp5KBec/h2cpLFSDKU05MT5cTEUvbA2vD9LB18/om2H8
1Tt7d/PfnOqPVKGASgop7joQBKb+40eUPBLK9WgepCEEqrbmtqPSUTqPqfkqAyg3
2eALpN0Es8nKK4XdTUXphoHncfWjD3u3GPLRaQH4gozWQFwpzS2IkKMFgYI+4O8m
KE9g5Xl0YLGWOBIy5Z/sAyWUmFgsmSvSA77lKXRaSNBaKlDDMJ362bscfSB6gZFx
ABGlipVk4lEJ63y9Fit0e5rZkeD4NplTr5ZSzFtbOunMREps7UVsCUFL7HcJqAC1
btXlbq4hEpvF/q3vONMKCLe9nX0jDN2wiGm5HkxHt23jEO5plzVbwiP6cWJUsDir
Mt436yf8uS2QfVvkqs1pvmCsN1q/Gf7Spddifq7w2rF2KPBQmO+JSHRx0T+AAfez
d8AUCrc5AxIrRBS8K0JBhPBQC9Q7J4P3mkxfswiw1AQQmBZNt1pktoWxGozZvhia
u3aa0exwtgZvLFLPOHOJJrCCIcxWKH4yGgT4nO2BhWUwlJdH4MetWMtF7EthWs6+
5cfT484BYurc+ai6Id/G65W1CcIIIg9Jl/OVY0Fg1vUu8+GNk8s=
=kXXs
-----END PGP SIGNATURE-----

--ZCk4OG7a+AFlaik7--

