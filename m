Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46304C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116CA21848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jkdyfm+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116CA21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0b0C-0002x7-TY
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 20:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0ayY-00012g-5p
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0ayW-0008Se-SQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:29:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59939)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0ayW-0008Ng-0h; Wed, 21 Aug 2019 20:29:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46DQPp0G04z9s7T; Thu, 22 Aug 2019 10:29:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566433742;
 bh=dZRzxb3xj0eLBKOrSsKmIBQQddu84x0SntFJS8SaHXo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jkdyfm+1Gxa9k3Zys6DmUsIjXyi0vxTubQjWc47sZDMUvOi2oUp5erW915nU0lw6/
 NYWrNEPin+pwBtZ4i6NZtQv36Ins1jsbttusfZolYUSwpPal/xYAZcGWpqe9I1NGJ9
 HQJV+Mebc3g89Bi0rTdL4Co+3UHGIbyH9tUWruXU=
Date: Thu, 22 Aug 2019 09:00:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Paul A. Clarke" <pc@us.ibm.com>
Message-ID: <20190821230031.GH20890@umbus>
References: <1566321964-1447-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
Content-Disposition: inline
In-Reply-To: <1566321964-1447-1-git-send-email-pc@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix xscvdpspn for SNAN
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 12:26:04PM -0500, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>=20
> helper_xscvdpspn() uses float64_to_float32() to convert double-precision
> floating-point to single-precision.  Unfortunately, float64_to_float32()
> converts SNAN to QNAN, which should not happen with xscvdpspn.
>=20
> float64_to_float32() is also used by other instruction implementations
> for conversions which _should_ convert SNAN to QNAN.
>=20
> Rather than trying to wedge code to preserve SNAN in float64_to_float32()
> just for this this one case, I instead embed an embodiment of the
> conversion code outlined in the POWER ISA for xscvdpspn.
>=20
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Applied to ppc-for-4.2.  I used rth's description rather than the one
above, since I found it clearer.

> ---
>  target/ppc/fpu_helper.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 07bc905..c8e7192 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -2887,12 +2887,40 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t o=
pcode,
> =20
>  uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
>  {
> -    uint64_t result;
> +    uint64_t result, sign, exp, frac;
> =20
>      float_status tstat =3D env->fp_status;
>      set_float_exception_flags(0, &tstat);
> =20
> -    result =3D (uint64_t)float64_to_float32(xb, &tstat);
> +    sign =3D extract64(xb, 63,  1);
> +    exp  =3D extract64(xb, 52, 11);
> +    frac =3D extract64(xb,  0, 52) | 0x10000000000000ULL;
> +
> +    if (unlikely(exp =3D=3D 0 && extract64(frac, 0, 52) !=3D 0)) {
> +        /* DP denormal operand.  */
> +        /* Exponent override to DP min exp.  */
> +        exp =3D 1;
> +        /* Implicit bit override to 0.  */
> +        frac =3D deposit64(frac, 53, 1, 0);
> +    }
> +
> +    if (unlikely(exp < 897 && frac !=3D 0)) {
> +        /* SP tiny operand.  */
> +        if (897 - exp > 63) {
> +            frac =3D 0;
> +        } else {
> +            /* Denormalize until exp =3D SP min exp.  */
> +            frac >>=3D (897 - exp);
> +        }
> +        /* Exponent override to SP min exp - 1.  */
> +        exp =3D 896;
> +    }
> +
> +    result =3D sign << 31;
> +    result |=3D extract64(exp, 10, 1) << 30;
> +    result |=3D extract64(exp, 0, 7) << 23;
> +    result |=3D extract64(frac, 29, 23);
> +
>      /* hardware replicates result to both words of the doubleword result=
=2E  */
>      return (result << 32) | result;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1dzQ8ACgkQbDjKyiDZ
s5KwiBAAg4+tuOkIyU5FThMgsqSxoqeFqS967VZ/7nUnmYbJYHaL8jK6PzK7yxCx
SpIyMUcF8J1ICe1/YpNP1vLamUiqJ2bE6ozkhKhWD63UqO+saw3b945X8yKgk0ux
OyhS5mDDmk4TOKqTFDk7Ta0Y2CjHVzET/BGQ4VBF5UsqTQalq61P7caYiLFobkAx
eCDb2rbaApJgixvGK45RD7K42oOLSHqE03nRsZPufz9qDUfudZTfpAJEi3Gw9d7U
02podbMZNXhAmcHF/7DHmkyAiVBkQ4q+p/uFG8j/MzCCa8Sv77nyCZ/1lUaE9wKU
TX78Wqlh/7dG26XZYmG8cl8oepf5PmT2ZoB1//6IQutJIaiB909081Hq0+x6RHIW
/wMm0G9oJO2cDrRvyEpjtBg4CG5B/eIXiR+jU0dz3T7YavomUeproDAG4OQRnVnk
z/2oW7QQePXOfrW2hB3Z2OkarUq1IRNHD9EzDoWmkxCH6VzoRTisfMtnEwYO3Bba
HokRBiPgowPLVHwUljh+7CmoEtLAZAAev5jo6qWbrIjxAHFi8rNuH/rW2GIH5gPy
cwJgAletKbEWhz1bLq2ng5nGsnupws2rmEbMabFDGgx3vaR7hj44ODSwbltx2j66
+81tXi7bX/kMDiO8aBD2deLASOmcW2QYr66mc59HrdNn1GAANiw=
=oJOi
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--

