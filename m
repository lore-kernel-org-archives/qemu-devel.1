Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016A2C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79D9213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OQIb3hcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79D9213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpCV-0002k7-4H
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAi-0000eJ-4o
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAg-0005rg-OY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:12 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36433 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhpAg-0005pC-15; Mon, 01 Jul 2019 01:48:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cbxt0Yq4z9sPH; Mon,  1 Jul 2019 15:48:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561960082;
 bh=7EdOJUg0Scbtbtdp85QSB/WgHParI/8unO+cqwv3FBs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OQIb3hcVeYRhFYi655LfDoHn6wXz7CPvcfK/EB1JEynHMXHhlsoJZ3c8QgprsmA54
 9wp+yfBReCF05LQZBQoaI/svVerGkV6ktOapSBp2/daUidgJwMK4Q+2gYdKrLKGwvh
 zdEccwHfkL8WEr7jBLQEurw25RWDQ0OHa/mSVKvE=
Date: Mon, 1 Jul 2019 15:32:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190701053234.GP2138@umbus.fritz.box>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190630204601.30574-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R3SAtXwgGp429mN7"
Content-Disposition: inline
In-Reply-To: <20190630204601.30574-5-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 04/10] ppc/xive: Fix TM_PULL_POOL_CTX
 special operation
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--R3SAtXwgGp429mN7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2019 at 10:45:55PM +0200, C=E9dric Le Goater wrote:
> When a CPU is reseted, the hypervisor (Linux or OPAL) invalidates the
> POOL interrupt context of a CPU with this special command. It returns
> the POOL CAM line value and resets the VP bit.
>=20
> Fixes: 4836b45510aa ("ppc/xive: activate HV support")
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.1.

> ---
>  hw/intc/xive.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 534f56f86bd5..cf77bdb7d34a 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -132,6 +132,11 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8=
_t ring, uint8_t cppr)
>      xive_tctx_notify(tctx, ring);
>  }
> =20
> +static inline uint32_t xive_tctx_word2(uint8_t *ring)
> +{
> +    return *((uint32_t *) &ring[TM_WORD2]);
> +}
> +
>  /*
>   * XIVE Thread Interrupt Management Area (TIMA)
>   */
> @@ -150,11 +155,12 @@ static uint64_t xive_tm_ack_hv_reg(XiveTCTX *tctx, =
hwaddr offset, unsigned size)
>  static uint64_t xive_tm_pull_pool_ctx(XiveTCTX *tctx, hwaddr offset,
>                                        unsigned size)
>  {
> -    uint64_t ret;
> +    uint32_t qw2w2_prev =3D xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
> +    uint32_t qw2w2;
> =20
> -    ret =3D tctx->regs[TM_QW2_HV_POOL + TM_WORD2] & TM_QW2W2_POOL_CAM;
> -    tctx->regs[TM_QW2_HV_POOL + TM_WORD2] &=3D ~TM_QW2W2_POOL_CAM;
> -    return ret;
> +    qw2w2 =3D xive_set_field32(TM_QW2W2_VP, qw2w2_prev, 0);
> +    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
> +    return qw2w2;
>  }
> =20
>  static void xive_tm_vt_push(XiveTCTX *tctx, hwaddr offset,
> @@ -484,11 +490,6 @@ const MemoryRegionOps xive_tm_ops =3D {
>      },
>  };
> =20
> -static inline uint32_t xive_tctx_word2(uint8_t *ring)
> -{
> -    return *((uint32_t *) &ring[TM_WORD2]);
> -}
> -
>  static char *xive_tctx_ring_print(uint8_t *ring)
>  {
>      uint32_t w2 =3D xive_tctx_word2(ring);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R3SAtXwgGp429mN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ZmvIACgkQbDjKyiDZ
s5Ib1RAAoZoYM26JgQAdunB3pBhtzDZKl7GGadn3Qtx4ilNSHYOSPje01e0r34SY
nzvZf9OS/rvj97r8K5TIFyH48rItHs7d5jJe6nhvZytokZOCaEgoQIIvq1rtDbU5
dHc93uBAq8fgTT9bCwiasgkkXCM8AStjaHmbgj3Xlk4A5e3ylJWUr9faTsbeeieJ
0qLQvZigv3DisCffTk0civiaUDToTrlVCQdH6TPEAR9xIwbg3Ep/OrmHWKa4Jjpq
JWOtB8Qt1NnFarOjwkr7L8cjdXwh2nG+fZ4odAhhwziWG3fSvakQMUvV4QCQx+Cd
Wg7O9995x993IQptNHLInivaO43lVuwhIF7RRtZXhQYkBROpp5Qaun3yVMm9qiQv
uM8gyQjihD3YDVYqctQ5Hz7hoNRu4Qq+jRVa3uSPdHrUggQA90MyOGJcUfkt4V6Z
ruEM6ACuZvboWI4lkrImb73CvVQI8stxAe7pPFbr5K3xXVxARBDUZsqwqcBevq74
nsRBvPeTufb8jThZiv1pGaUA+qYgwCQOW1S/z3T0end2N7gu0RTeDYW9MeWax+zo
zHa399ibmkrRRMa5VperGgocihVHuJ6v38xJkZUyRprnxqck18BSkfA4edF3NsEE
OUtUuzPTtl8kkxgM45+qGd54fWM/R6smAC9A4UNqnl6SIIsvPgA=
=GhNG
-----END PGP SIGNATURE-----

--R3SAtXwgGp429mN7--

