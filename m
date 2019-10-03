Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE838C47404
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB02222C2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lOUpiybl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB02222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFrF7-0000AZ-J3
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5P-00009k-4g
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5N-00010i-7O
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47103 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5M-0000xr-Kk; Wed, 02 Oct 2019 22:43:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHPB5ypqz9sPj; Thu,  3 Oct 2019 12:43:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070590;
 bh=gKfD0N75QStGIGd9tY1bg28lPN5C8s83GDqk/VptEkE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lOUpiybleYC1yxAiV8Wmc39FSjm87jAX+p1mWDWVVAdm3Wysq5AnszDWJOMVp2OKv
 JfyibVU8e/H9BnpHCQLLXQo4wSHSSTbLrU/e/7JD4pCAGgui0U8oPpELKaYotN/9uQ
 t6TJeQ0CHutqu2Vy5Shf8kLvDZqBNc2BAkGezLlQ=
Date: Thu, 3 Oct 2019 12:34:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 22/25] ppc/xive: Introduce a xive_os_cam_decode() helper
Message-ID: <20191003023451.GP11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-23-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OxpYUbrsx40GOZXC"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-23-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OxpYUbrsx40GOZXC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:42PM +0200, C=E9dric Le Goater wrote:
> The OS CAM line has a special encoding exploited by the HW. Provide a
> helper routine to hide the details to the TIMA command handlers. This
> also clarifies the endian ness of different variables : 'qw1w2' is
> big-endian and 'cam' is native.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xive.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index dfae584a319f..cdc4ea8b0e51 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -342,14 +342,29 @@ static void xive_tm_set_os_pending(XivePresenter *x=
ptr, XiveTCTX *tctx,
>      xive_tctx_ipb_update(tctx, TM_QW1_OS, priority_to_ipb(value & 0xff));
>  }
> =20
> +static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> +                               uint32_t *nvt_idx, bool *vo)
> +{
> +    *nvt_blk =3D xive_nvt_blk(cam);
> +    *nvt_idx =3D xive_nvt_idx(cam);
> +    *vo =3D !!(cam & TM_QW1W2_VO);
> +}
> +
>  static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                      hwaddr offset, unsigned size)
>  {
> -    uint32_t qw1w2_prev =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
> -    uint32_t qw1w2;
> +    uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
> +    uint32_t qw1w2_new;
> +    uint32_t cam =3D be32_to_cpu(qw1w2);
> +    uint8_t nvt_blk;
> +    uint32_t nvt_idx;
> +    bool vo;
> =20
> -    qw1w2 =3D xive_set_field32(TM_QW1W2_VO, qw1w2_prev, 0);
> -    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);

I'd kind of prefer to fold both the memcpy and the endian swizzle into
a read/write_register_word helper of some sort.

> +    xive_os_cam_decode(cam, &nvt_blk, &nvt_idx, &vo);
> +
> +    /* Invalidate CAM line */
> +    qw1w2_new =3D xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
> +    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
>      return qw1w2;
>  }
> =20
> @@ -387,13 +402,15 @@ static void xive_tctx_need_resend(XiveRouter *xrtr,=
 XiveTCTX *tctx,
>  static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                  hwaddr offset, uint64_t value, unsigned =
size)
>  {
> -    uint32_t qw1w2 =3D value;
> -    uint8_t nvt_blk =3D xive_nvt_blk(qw1w2);
> -    uint32_t nvt_idx =3D xive_nvt_idx(qw1w2);
> -    bool vo =3D !!(qw1w2 & TM_QW1W2_VO);
> +    uint32_t cam =3D value;
> +    uint32_t qw1w2 =3D cpu_to_be32(cam);
> +    uint8_t nvt_blk;
> +    uint32_t nvt_idx;
> +    bool vo;
> +
> +    xive_os_cam_decode(cam, &nvt_blk, &nvt_idx, &vo);
> =20
>      /* First update the registers */
> -    qw1w2 =3D cpu_to_be32(qw1w2);
>      memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
> =20
>      /* Check the interrupt pending bits */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OxpYUbrsx40GOZXC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VXksACgkQbDjKyiDZ
s5LKUA//Qjdv467c0mQfMkAk60LwcxIT18DnnNd28k8davoYPcn3m7Lf5w6G/aYI
VKQJwMFOwLWwzfFO3Izjx+sIfMst7tqimMG0GRU6tOl1YiSEjM0SnjUUJdNHC7WY
TfoCVSoc6FeTADOfTjF2EhEvxDJV65QjA2v7sZW9YdY+UiOZ+Vti/hHCXItZgjZ8
mUVXVX/ROqSnGQpflHUfuA4xtDdXVzmkNITOLvjVDrxnIo63gVoBGdrET5pvXdDy
1U61XEK98kNT9JNcjqKlAiisHT5GXy8UMPVfYqSRK3LVE6dOuGQv9aUOn58zGSuF
b+NakTxD67VEw/9qtWYWDQ3wTByMDKkkWT6mL4pvbkIKPvj4TJKyOjYeVxUAbFp/
KhXcJBmjyLWlWuym/Vh0HO7VJEy5VFhQJfFh6Njyo+1LrieTsyJUVwlSWWjjz51t
kM81eOCZuRNw0nVDUsZFlt7CPiicD04HbdyYQjAiF24Qa7I9mfgWiwdoYNpwDtZh
zmQgW1UgLgj00agtcrSKwfkXrVMqIlHfcjaFbRpsDT28SdWLZBwasN4uUHCsuOXT
XjmhDrw/Wp6h7KteZ5W9eOFoksaxDq22T0KGLKWhot9hGk/TiI9L8o9I2POp+QCx
7zPHafZApA7j1itH54uRMkgrJVeVK0WoIQRLViTqwSSGxElqMwU=
=r7+N
-----END PGP SIGNATURE-----

--OxpYUbrsx40GOZXC--

