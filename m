Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D948C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 12:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179DC20656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 12:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f7uuQW87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179DC20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt9bY-0001Rc-8m
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 08:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jt9ac-0000r5-6X; Wed, 08 Jul 2020 08:54:19 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jt9aY-0006bn-9h; Wed, 08 Jul 2020 08:54:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B1zlN3Rfxz9sRK; Wed,  8 Jul 2020 22:54:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594212848;
 bh=iYQmoCWDIVnJDYsb3hVPQMlqmB9cMM7lbOgmj5jH4cI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f7uuQW87WaHMX6Wb/WmerWkvtEiD9Ch/X7+ThTrYekCVGG5gG1bPt3Bi7DCMN6Vqr
 4VkswRIcqMKa3eQl6noI9TuG/aNibWYFPWJZ5Eon/iki8PZy8tFaHVTtx2aGt5kDpe
 MCNfJiKZH/1jhOXaqmH0pGaicZZpuFvTJ1xl2cW8=
Date: Wed, 8 Jul 2020 22:22:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lijun Pan <ljp@linux.ibm.com>
Subject: Re: [PATCH v4 04/11] target/ppc: convert vmuluwm to tcg_gen_gvec_mul
Message-ID: <20200708122212.GK18595@umbus.fritz.box>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200701234344.91843-5-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline
In-Reply-To: <20200701234344.91843-5-ljp@linux.ibm.com>
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 06:43:39PM -0500, Lijun Pan wrote:
> Convert the original implementation of vmuluwm to the more generic
> tcg_gen_gvec_mul.
>=20
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>

Applied to ppc-for-5.2.

> ---
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> v3: newly introduced
>=20
>  target/ppc/helper.h                 |  1 -
>  target/ppc/int_helper.c             | 13 -------------
>  target/ppc/translate/vmx-impl.inc.c |  2 +-
>  3 files changed, 1 insertion(+), 15 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 2dfa1c6942..69416b6d7c 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -184,7 +184,6 @@ DEF_HELPER_3(vmulosw, void, avr, avr, avr)
>  DEF_HELPER_3(vmuloub, void, avr, avr, avr)
>  DEF_HELPER_3(vmulouh, void, avr, avr, avr)
>  DEF_HELPER_3(vmulouw, void, avr, avr, avr)
> -DEF_HELPER_3(vmuluwm, void, avr, avr, avr)
>  DEF_HELPER_3(vslo, void, avr, avr, avr)
>  DEF_HELPER_3(vsro, void, avr, avr, avr)
>  DEF_HELPER_3(vsrv, void, avr, avr, avr)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index be53cd6f68..bd3e6d7cc7 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -523,19 +523,6 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
>      r->VsrD(0) =3D 0;
>  }
> =20
> -#define VARITH_DO(name, op, element)                                    \
> -    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
> -    {                                                                   \
> -        int i;                                                          \
> -                                                                        \
> -        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                =
  \
> -            r->element[i] =3D a->element[i] op b->element[i];           =
  \
> -        }                                                               \
> -    }
> -VARITH_DO(muluwm, *, u32)
> -#undef VARITH_DO
> -#undef VARITH
> -
>  #define VARITHFP(suffix, func)                                          \
>      void helper_v##suffix(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, \
>                            ppc_avr_t *b)                                 \
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 403ed3a01c..6e79ffa650 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -801,7 +801,7 @@ static void trans_vclzd(DisasContext *ctx)
>  GEN_VXFORM(vmuloub, 4, 0);
>  GEN_VXFORM(vmulouh, 4, 1);
>  GEN_VXFORM(vmulouw, 4, 2);
> -GEN_VXFORM(vmuluwm, 4, 2);
> +GEN_VXFORM_V(vmuluwm, MO_32, tcg_gen_gvec_mul, 4, 2);
>  GEN_VXFORM_DUAL(vmulouw, PPC_ALTIVEC, PPC_NONE,
>                  vmuluwm, PPC_NONE, PPC2_ALTIVEC_207)
>  GEN_VXFORM(vmulosb, 4, 4);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6CXocAQn8Xbegyxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8FunEACgkQbDjKyiDZ
s5K9zBAAvXoc40jg6/hkqMyhL7k2gk7fvjH88f6/VmRkOoRxsYRKaw6RVhdGiOpD
kuo5sDUYcCVcG7FZFtLNaU8h9di/zRKk4kfin+A5iFUErrbXwOMBioTpykVv75r9
OdQzVfNzi7N+omb0atlB/05Fn/R8k8N889FpWa1s7TeqFeLZHaoWIUTD/cJlZx8L
2DRROtmBHboYt2LGSjZGc4a3Y4EZMW9CDcdCdShwXUptFOutzWAqSyLJBlhbgVta
Uv30BjJxjB2t2bZ7BdAZxpKn0rE8oigCEzFGuEBBY//dm3cvGbZdM8FPpOBy6Bpm
qggQA09LDlvwYXG6brKCNSeUCpTJZN6kdW1QbiIfYrtjXRqu04xSn6hHIhoQuziz
F9tVnsEagFFVhH2WEU9EhoRKnde6nj665K/HEP3bPyygdAXqJKPcv2F8jOfHOdwI
FRXx8PIwWmuB6AiMSplzudDozz4uvMoOoe/W0CeRpz+aMgS1CQmVooOc6kElHTW+
4W4/249qZS3YCprkOWENYd/T82wCHdosOC4Lc8e1DlvMd8Jox+4pT7Jjv33TgTj5
EU5/uZiHZJFLvpaX0O+kAgKs+Vww/fV6vRg74JFFdZcVCWpydzzRMyApTrBwqOaH
rGy/nu9yFAHKyG54GnEGlMDBrje2XK2xQMWfxj+4vzn8josYgm0=
=C+Jn
-----END PGP SIGNATURE-----

--6CXocAQn8Xbegyxo--

