Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3426AC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 03:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EFA2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 03:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TH6fbT89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EFA2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQNN2-0004NK-1L
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 23:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34708 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jQNMJ-0003uh-MF
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 23:44:36 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jQNMI-0003oq-Sh
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 23:44:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33839 helo=ozlabs.org)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jQNMF-0003hB-Vw
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 23:44:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 495CHV4HTwz9sSd; Mon, 20 Apr 2020 13:44:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587354262;
 bh=sisyK/cGft+hFGDW970G+3NnEI1KbFw5yNKz1tKpZ3w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TH6fbT89ynaZg/VtciF5mZAr1QPKYk425Tg6rsW1mRkom8Ul2pR3fgddFjViMiAz1
 FLg/hY0oE7RXkboUb8ik4FpQJwSVmwtStXQEdas+w5V8bYYaGgY8VSCDrwNhaUv63B
 xXdRGQSrv7c+pM+RCqTu8xqWK8b3/NHGUtLAOErc=
Date: Mon, 20 Apr 2020 13:41:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/7] target/ppc: Use tcg_gen_gvec_dup_imm
Message-ID: <20200420034159.GB2220@umbus.fritz.box>
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20200418150411.1831-4-richard.henderson@linaro.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/19
 23:44:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: peter.maydell@linaro.org, zhiwei_liu@c-sky.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2020 at 08:04:07AM -0700, Richard Henderson wrote:
> We can now unify the implementation of the 3 VSPLTI instructions.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate/vmx-impl.inc.c | 32 ++++++++++++++++-------------
>  target/ppc/translate/vsx-impl.inc.c |  2 +-
>  2 files changed, 19 insertions(+), 15 deletions(-)
>=20
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 81d5a7a341..403ed3a01c 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -1035,21 +1035,25 @@ GEN_VXRFORM_DUAL(vcmpbfp, PPC_ALTIVEC, PPC_NONE, \
>  GEN_VXRFORM_DUAL(vcmpgtfp, PPC_ALTIVEC, PPC_NONE, \
>                   vcmpgtud, PPC_NONE, PPC2_ALTIVEC_207)
> =20
> -#define GEN_VXFORM_DUPI(name, tcg_op, opc2, opc3)                       \
> -static void glue(gen_, name)(DisasContext *ctx)                         \
> -    {                                                                   \
> -        int simm;                                                       \
> -        if (unlikely(!ctx->altivec_enabled)) {                          \
> -            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
> -            return;                                                     \
> -        }                                                               \
> -        simm =3D SIMM5(ctx->opcode);                                    =
  \
> -        tcg_op(avr_full_offset(rD(ctx->opcode)), 16, 16, simm);         \
> +static void gen_vsplti(DisasContext *ctx, int vece)
> +{
> +    int simm;
> +
> +    if (unlikely(!ctx->altivec_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_VPU);
> +        return;
>      }
> =20
> -GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
> -GEN_VXFORM_DUPI(vspltish, tcg_gen_gvec_dup16i, 6, 13);
> -GEN_VXFORM_DUPI(vspltisw, tcg_gen_gvec_dup32i, 6, 14);
> +    simm =3D SIMM5(ctx->opcode);
> +    tcg_gen_gvec_dup_imm(vece, avr_full_offset(rD(ctx->opcode)), 16, 16,=
 simm);
> +}
> +
> +#define GEN_VXFORM_VSPLTI(name, vece, opc2, opc3) \
> +static void glue(gen_, name)(DisasContext *ctx) { gen_vsplti(ctx, vece);=
 }
> +
> +GEN_VXFORM_VSPLTI(vspltisb, MO_8, 6, 12);
> +GEN_VXFORM_VSPLTI(vspltish, MO_16, 6, 13);
> +GEN_VXFORM_VSPLTI(vspltisw, MO_32, 6, 14);
> =20
>  #define GEN_VXFORM_NOA(name, opc2, opc3)                                \
>  static void glue(gen_, name)(DisasContext *ctx)                         \
> @@ -1559,7 +1563,7 @@ GEN_VXFORM_DUAL(vsldoi, PPC_ALTIVEC, PPC_NONE,
>  #undef GEN_VXRFORM_DUAL
>  #undef GEN_VXRFORM1
>  #undef GEN_VXRFORM
> -#undef GEN_VXFORM_DUPI
> +#undef GEN_VXFORM_VSPLTI
>  #undef GEN_VXFORM_NOA
>  #undef GEN_VXFORM_UIMM
>  #undef GEN_VAFORM_PAIRED
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 8287e272f5..b518de46db 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1579,7 +1579,7 @@ static void gen_xxspltib(DisasContext *ctx)
>              return;
>          }
>      }
> -    tcg_gen_gvec_dup8i(vsr_full_offset(rt), 16, 16, uim8);
> +    tcg_gen_gvec_dup_imm(MO_8, vsr_full_offset(rt), 16, 16, uim8);
>  }
> =20
>  static void gen_xxsldwi(DisasContext *ctx)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6dGgUACgkQbDjKyiDZ
s5Kz7xAAjW8yPYfmjwPCtmZjBa1McAWcRhHW05+pm3uMAtreYk6oO1Bh1Ca+oDb7
KT9Z82ZGsYhGTpUU7kOmcpWba7I1e8B231kaTk8ath3ZKbgFYKkde6qHfyiU6LWd
KSPfzvqr7YxblERtzCWJzp5wj7CGVTh+yE7tPdzFnNbx49JKIiELBZ15EhG7n4sk
KR4i6q9oluuTs3hlJDCqbt7kdasnKV7QDLXH47QmgAv/vPXv2mOeaOpvyPvjqsQw
lGRELFZtww+hiXCi/bhbAVeZqP4oPRBTiBJ95NDMm+DnjwBymTtlJllTtOOnZ5mO
tmhvsazSLIsO3n4WYOP8NaRNGCtfJx3d0L4xG0GLXCQtpn/TJL3UFHgiPrhemZbQ
hm3GwhkijTIQX2c8M7WNRuUME2ur1HPm8TUmEkoc4Qo9pntyehna1oV32dMLffvK
+Z9pQslTf4g0NgINPgbuMzsTtyr3XjhX2GIeHtYcgDJTIbZOIKqvrNrwMoQzufPU
O5E9JVKhdpNrBCodP79iFSVOWeMcPrK0kpxJcuUqoHZ13Uoidxdxtpna1xZVAv6e
fHJEdUegrcBsk7ypNGmVW1k2Xw7rJxMuDk4+67DDa9j+lpwh6iqX5SFWMV5nMyr5
BgbKLypQyuV4EHuQlX8DvaqNYYQ5LEiOpOO2qXDRL33SpBGMBro=
=o4zU
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

