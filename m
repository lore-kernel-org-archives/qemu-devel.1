Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F575C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA62204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aOZwnFJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA62204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Ake-0001QD-JV
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjW-00082k-Aw; Thu, 13 Aug 2020 06:45:18 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58937 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6AjT-0008Jr-KB; Thu, 13 Aug 2020 06:45:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS39y5clCz9sTd; Thu, 13 Aug 2020 20:45:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597315510;
 bh=xDVoWteu1SorGiIrnsU3+9yBjjFaryc9NzlChCfH7iY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aOZwnFJvI3Xi8D1zVCzckZ0w6hSUtlE1y2E4dZIu/fIxOmsJxFUVwcYVIIYje2K1I
 cgkwE+4ETHvgZ0HTnDG6jxT+/l3JSdlGF472ZO0LuER7DDp9ZQPO9a0Snzeb7g1sut
 1Y7gNhaLzN9n1rEiC+4kh2kUxnkrysWuc9HxutY8=
Date: Thu, 13 Aug 2020 20:24:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 07/14] spapr/xive: Rework error handling in
 kvmppc_xive_get_queues()
Message-ID: <20200813102427.GJ181791@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707848069.1489912.14879208798696134531.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tAmVnWIZ6lqEAvSf"
Content-Disposition: inline
In-Reply-To: <159707848069.1489912.14879208798696134531.stgit@bahia.lan>
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


--tAmVnWIZ6lqEAvSf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:54:40PM +0200, Greg Kurz wrote:
> Since kvmppc_xive_get_queue_config() has a return value, convert
> kvmppc_xive_get_queues() to use it for error checking. This allows
> to get rid of the local_err boiler plate.
>=20
> Propagate the return value so that callers may use it as well to check
> failures.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/intc/spapr_xive_kvm.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 696623f717b7..4142aaffff47 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -467,23 +467,24 @@ void kvmppc_xive_reset(SpaprXive *xive, Error **err=
p)
>                        NULL, true, errp);
>  }
> =20
> -static void kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
> +static int kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
>  {
> -    Error *local_err =3D NULL;
>      int i;
> +    int ret;
> =20
>      for (i =3D 0; i < xive->nr_ends; i++) {
>          if (!xive_end_is_valid(&xive->endt[i])) {
>              continue;
>          }
> =20
> -        kvmppc_xive_get_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
> -                                     &xive->endt[i], &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> +        ret =3D kvmppc_xive_get_queue_config(xive, SPAPR_XIVE_BLOCK_ID, =
i,
> +                                           &xive->endt[i], errp);
> +        if (ret < 0) {
> +            return ret;
>          }
>      }
> +
> +    return 0;
>  }
> =20
>  /*
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tAmVnWIZ6lqEAvSf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81FNsACgkQbDjKyiDZ
s5KKFxAAtDiv/iyCTYScNCAsF/ett+4VaaKn01cZDTwWY6jdomkO2W4vTkdn1aQN
VbBM8QaE4cPzTq7xlfCmqy3E1AaOsJiRsSedjr76vy3+nn/+2pwiqgNvODBnvsqq
HMj+wSNVGVl0W9pzI4GZsN8hrCxqjBTQfGGky/OMVHNs4rLoXQl4mAgiJzrLFMse
yehSCKecB+j3GKGQ3FiRmQQ+qDpG+vHqtwAfHMrvhTIABe5c6JmWTatVgxCvKkgf
89SZP0nWy7CV0XfV4dLCN0t+BVdeXZsu0+wCpjzEEtDGI6J158BsTUlGJycmBn/b
bgmtm0k0GJ9hDokvBw3V0yWpWLTjq3wqs4a24Yr7IZ+ciaF0LU3BsQusxVQs+MmW
k48JR1k/FYkdkxuOgqZmrxUjKfmVU5Iwj0SDmp/cJICzxWf0OcokSVHTNqGmEXfV
wEAwa71LALWZ8jJBHiYIwTFAFtsuiBXmThWlBXXPZ1EX+/xtqcpjwImVgU2g7i2a
E1MB4/ZAjBFeaK/968rQpya15l9WeQozlNmJLS+ibuYfog9xW9kv5k1u5KxngiXi
YqH4Mrrd/UeO56RGIL0nxUcN9Bag2mhfSuTL18JqMVxOu/OD/NGnwJ/0bz0k/hkp
ZpTfrnVWeXhYXDs2Ms/qx23hFeie8Cm2t9lRHmdupsiHbMFYD3c=
=hAbo
-----END PGP SIGNATURE-----

--tAmVnWIZ6lqEAvSf--

