Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22EBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7A72071F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="e1FuiWGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7A72071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXGuU-00006p-Sl
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 22:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXGsG-00063B-0R
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXGsE-00021K-NC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:41:47 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38463 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXGsD-0001v8-QQ; Tue, 19 Nov 2019 22:41:46 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HpQV1B6lz9sPc; Wed, 20 Nov 2019 14:41:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574221298;
 bh=U9r94QcT51aPkfy/98WTED2MeDyzd757wj9exxH8b7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e1FuiWGxeqaubP8souy6Gy1nBmsWfgjJiIIb88vh9vlHOl6bS3p+Md98e3LPBwss6
 0M330pHFRUt3ChXoEEEPhejSBhyOLOfaq1/tWP6V39z3uzCcC/SNzldi47BwXFe5uN
 ZXeDRh+l/HG0w46mvGghyxuaZLnI4JlfeRWA0xq4=
Date: Wed, 20 Nov 2019 14:24:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 06/23] ppc/xive: Introduce OS CAM line helpers
Message-ID: <20191120032452.GA5582@umbus.fritz.box>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Tg5qL4DubmxJEzuM"
Content-Disposition: inline
In-Reply-To: <20191115162436.30548-7-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Tg5qL4DubmxJEzuM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 05:24:19PM +0100, C=E9dric Le Goater wrote:
> The OS CAM line has a special encoding exploited by the HW. Provide
> helper routines to hide the details to the TIMA command handlers. This
> also clarifies the endianness of different variables : 'qw1w2' is
> big-endian and 'cam' is native.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xive.c | 41 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 177663d2b43e..42e9a11ef731 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -337,14 +337,49 @@ static void xive_tm_set_os_pending(XiveTCTX *tctx, =
hwaddr offset,
>      xive_tctx_notify(tctx, TM_QW1_OS);
>  }
> =20
> +static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> +                               uint32_t *nvt_idx, bool *vo)
> +{
> +    if (nvt_blk) {
> +        *nvt_blk =3D xive_nvt_blk(cam);
> +    }
> +    if (nvt_idx) {
> +        *nvt_idx =3D xive_nvt_idx(cam);
> +    }
> +    if (vo) {
> +        *vo =3D !!(cam & TM_QW1W2_VO);
> +    }
> +}
> +
> +static uint32_t xive_tctx_get_os_cam(XiveTCTX *tctx, uint8_t *nvt_blk,
> +                                     uint32_t *nvt_idx, bool *vo)
> +{
> +    uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
> +    uint32_t cam =3D be32_to_cpu(qw1w2);
> +
> +    xive_os_cam_decode(cam, nvt_blk, nvt_idx, vo);
> +    return qw1w2;
> +}
> +
> +static void xive_tctx_set_os_cam(XiveTCTX *tctx, uint32_t qw1w2)
> +{
> +    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
> +}
> +
>  static uint64_t xive_tm_pull_os_ctx(XiveTCTX *tctx, hwaddr offset,
>                                      unsigned size)
>  {
> -    uint32_t qw1w2_prev =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>      uint32_t qw1w2;
> +    uint32_t qw1w2_new;
> +    uint8_t nvt_blk;
> +    uint32_t nvt_idx;
> +    bool vo;
> =20
> -    qw1w2 =3D xive_set_field32(TM_QW1W2_VO, qw1w2_prev, 0);
> -    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
> +    qw1w2 =3D xive_tctx_get_os_cam(tctx, &nvt_blk, &nvt_idx, &vo);
> +
> +    /* Invalidate CAM line */
> +    qw1w2_new =3D xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
> +    xive_tctx_set_os_cam(tctx, qw1w2_new);
>      return qw1w2;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Tg5qL4DubmxJEzuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UsgIACgkQbDjKyiDZ
s5JCGxAAzIHGsmZm6u0XndjdzfzBBopioqSkMyYxy6aaCctG0UVJczQTsfKFlJnW
kPMGGlrYfptngvvBHlPm4laaQQyIYRC0IIM0y767jJJn4LQqMDf404EPoaSeZWVB
HJZPdl9b4EAApqHE8ML0InDnZ/3qw+rLtQifbEQJQoiB0YZDFlAOQbv35WNx1eo0
wcWEZynkKUVIyQDc1tSIS75iO7PENM+AfCM9A9cUZ+B+o4IuVuKbs4XZwUXljAO0
s1Cmz4LsCCgopO0+y4MaEKtl5rXFfVkx873wyIr1+ibPOojaPnc1ZOYLA07mEKJf
zkuF7b9xSvrcRKPx6Cfm73A0FDEqM09nqQGVxTK5fNu72k/aIgk5K0E7zEcz3xv5
aDFnJJtpvxjhL92ReoYyuLDN2jXXuVEjafY3Au01VGE5BX0QdaQNtJnQpuWjFJ5K
66CDBOQJTt2NBxYN8dlxVHbSUIMqf7p1Go34Pi+hUfNAb2AbuHTA5kGyXyse5ine
qjaJZ4CM59R0CtffB9Fn44VX29mGV71TynRL6dnZGRn0AL6Lm+b0mPwswsOdmzCI
yDVh5lMKynQZEPsOj/liPUlLjR6Pg9gcoSmWZEvaaT5PrmTeDGk2dFEmsGpEoh+Q
5CMYXc4E0ZkG3MOguglllcP2pgDu6KpibO9AVzkrwrpj5Ti39cQ=
=dt4r
-----END PGP SIGNATURE-----

--Tg5qL4DubmxJEzuM--

