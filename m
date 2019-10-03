Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B46C4360C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BAF21D81
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A4DqPz1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BAF21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFrBp-0005a0-NL
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5M-00007l-ID
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5K-0000xj-NQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:20 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37291)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5K-0000wu-6I; Wed, 02 Oct 2019 22:43:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHPB4DKWz9sPk; Thu,  3 Oct 2019 12:43:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070590;
 bh=GTYXh1L5k2UqdQaiMEgA0uDG+ovgdPLDLCqEA5+Bei4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A4DqPz1chwYmGkVVdNm4TjUVf3J+avWNpWMCOwgP2UByWWLBnqut1EllLygjP/EE4
 MF23pyfTfi4X94VIl9L9FSZ1x5quEnwHDq1rmfuuOUNSLJMFCcpBKPFV2MnlTZ26de
 8nki+reVUjaYuAGzmmXxwU6gTkNBP1MpzMLTNQAk=
Date: Thu, 3 Oct 2019 12:12:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 14/25] ppc/xive: Introduce helpers for the NVT id
Message-ID: <20191003021258.GL11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-15-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ibe32dcbQs37CEZO"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-15-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ibe32dcbQs37CEZO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:34PM +0200, C=E9dric Le Goater wrote:
> The NVT space is 19 bits wide, giving a maximum of 512K per chip. When
> dispatched on a HW thread, the NVT identifier of a vCPU is pushed/stored
> in the CAM line (word2) of the thread interrupt context.

Ok, that's interesting, but how does it lead to this patch?  Connect
the dots, please.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h      |  5 -----
>  include/hw/ppc/xive_regs.h | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index a461753f5da5..794dfcaae0f8 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -469,11 +469,6 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
r *mon);
>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
>  void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
> =20
> -static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
> -{
> -    return (nvt_blk << 19) | nvt_idx;
> -}
> -
>  /*
>   * KVM XIVE device helpers
>   */
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 08c8bf7172e2..3d7b6fd09664 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -251,4 +251,25 @@ typedef struct XiveNVT {
> =20
>  #define xive_nvt_is_valid(nvt)    (be32_to_cpu((nvt)->w0) & NVT_W0_VALID)
> =20
> +/*
> + * The VP number space in a block is defined by the END_W6_NVT_INDEX
> + * field of the XIVE END
> + */
> +#define XIVE_NVT_SHIFT                19
> +
> +static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
> +{
> +    return (nvt_blk << XIVE_NVT_SHIFT) | nvt_idx;
> +}
> +
> +static inline uint32_t xive_nvt_idx(uint32_t cam_line)
> +{
> +    return cam_line & ((1 << XIVE_NVT_SHIFT) - 1);
> +}
> +
> +static inline uint32_t xive_nvt_blk(uint32_t cam_line)
> +{
> +    return (cam_line >> XIVE_NVT_SHIFT) & 0xf;
> +}
> +
>  #endif /* PPC_XIVE_REGS_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ibe32dcbQs37CEZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VWSoACgkQbDjKyiDZ
s5JYcA//Uf2R68G++EtHjUHOmB7i1sjdKzalJD+byNiFzYEZuryiiBM70nqm63Lu
CF+0UTwv3lZ8CibKLqrYMd+l+31nUwN1HNjqwHi/ohgfMDoyACE36Rg4ovuVD/AD
Mqkrct32/SQlKCPoaazM7bQkyipVOLf9HGPrhzvtJVYn3kPoKGVQKOWzbb7efcXF
8/hX5NWW8bPBaUGpZ8x8QW44sKOuB9VNVCPBBQnv+EyJKTGv0/cgJeHbd2QKMsW8
mnapf9KZPfvEvXuZ69T1GRzXjBlousCDUqiEVPs3mBMF/blx0WJNjL9An6fDa4hY
ao2p6tM6JmwVbgLvxyTJGBhbU7F4sKQH056SKwo7Gb1Av8YYHLxsFgVSDKlG/Tfp
efqGTrre0sDZtRekriHCpsuuTHtQ0yyFm/NTCLyus+is9DnBzMKDAK0FjQuGjISG
HCPmvvhP6IhNbv3GPBXDKrLsMm/P0Wa4kvauPfT4jBbyzmZx2cGOb0zZKEgJfYxI
g/oQxMLN+buXjt0+Plv+BRLuLhvvwx69I/6WLDeuSyQ5gRYxOd4ON3+tHZW2D0Mj
09zoQuIjuIROqdYP+0xcPdNx07jh1cj59k7xGYZFDU45QWHg7zWVzT+VaBPUD8UU
e61vtwNOjUrN9PQYZ4d7MfQ5Bg93hdxXdDOUbg7i2Teg8wQonUw=
=r9RE
-----END PGP SIGNATURE-----

--ibe32dcbQs37CEZO--

