Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54922C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2487D206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Oo0mVmdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2487D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskv7-0006nL-EI
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jskuX-000662-7P; Tue, 07 Jul 2020 06:33:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jskuT-0005Ej-UN; Tue, 07 Jul 2020 06:33:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B1Jg23Gmgz9sSn; Tue,  7 Jul 2020 20:33:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594117982;
 bh=0nWyI6Q7TzYCWTKZ2pJzafaZWBVpXezfmTUc1Ry/gFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Oo0mVmdSqvn0fDeCtoHld9viy+gJnkWjdGKikpseR8FwnVEVXzAJ3LCUc2ajqhIr3
 WffRAuA7T7vVLFnnLX5MPn8/J0ltEtNO45uu2EzFw6B4reC2swjzfSAZNLSLqYHQ5V
 c0iOLVEsYRDYC4b7/JIgddyd0lrQcvme/2EmqJbs=
Date: Tue, 7 Jul 2020 20:30:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lijun Pan <ljp@linux.ibm.com>
Subject: Re: [PATCH v4 03/11] target/ppc: add byte-reverse br[dwh] instructions
Message-ID: <20200707103046.GE18595@umbus.fritz.box>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200701234344.91843-4-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <20200701234344.91843-4-ljp@linux.ibm.com>
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
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 06:43:38PM -0500, Lijun Pan wrote:
> POWER ISA 3.1 introduces following byte-reverse instructions:
> brd: Byte-Reverse Doubleword X-form
> brw: Byte-Reverse Word X-form
> brh: Byte-Reverse Halfword X-form
>=20
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>

Applied to ppc-for-5.2.

> ---
> v4: make it compile on all targets
> v3: fix the store issue in br[dwh]
>     simplify brw implementation
>     add "if defined(TARGET_PPC64)"
> v2: fix coding style
>     use Power ISA 3.1 flag
>=20
>  target/ppc/translate.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4ce3d664b5..590c3e3bc7 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6971,7 +6971,47 @@ static void gen_dform3D(DisasContext *ctx)
>      return gen_invalid(ctx);
>  }
> =20
> +#if defined(TARGET_PPC64)
> +/* brd */
> +static void gen_brd(DisasContext *ctx)
> +{
> +    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode=
)]);
> +}
> +
> +/* brw */
> +static void gen_brw(DisasContext *ctx)
> +{
> +    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode=
)]);
> +    tcg_gen_rotli_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]=
, 32);
> +
> +}
> +
> +/* brh */
> +static void gen_brh(DisasContext *ctx)
> +{
> +    TCGv_i64 t0 =3D tcg_temp_new_i64();
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +
> +    tcg_gen_movi_i64(t0, 0x00ff00ff00ff00ffull);
> +    tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
> +    tcg_gen_and_i64(t2, t1, t0);
> +    tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], t0);
> +    tcg_gen_shli_i64(t1, t1, 8);
> +    tcg_gen_or_i64(cpu_gpr[rA(ctx->opcode)], t1, t2);
> +
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +#endif
> +
>  static opcode_t opcodes[] =3D {
> +#if defined(TARGET_PPC64)
> +GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
> +GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
> +GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
> +#endif
>  GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
>  GEN_HANDLER(cmp, 0x1F, 0x00, 0x00, 0x00400000, PPC_INTEGER),
>  GEN_HANDLER(cmpi, 0x0B, 0xFF, 0xFF, 0x00400000, PPC_INTEGER),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8ETtMACgkQbDjKyiDZ
s5IbeA/+MjxSUp/9t3fxClkn+ZajSDAA3mcrHrFOc2AIhfTwedGbms2FH2fipmhv
Zz/Rs0VT9l3ot0D+IRPuHgFnYVRAwU/oMbwc2gTigBxHWSyjTU/8sVhYNB1JZ1Cq
WPVZOnOoMGgMiwFg+bbPNSU5RurKgvWkYdd4/6FGm9Aa7hyVnlEOWpqEQd1gAhWr
+Q2ScCrFA94hsxiGnMrRTOU2wq3YWf+ILTsEl44XLlB0GUdNoYFnLrxhHTM5TpcL
7b91bOjcoTfOdW0AG4ro1i+8cEAI2NR/zvx+fboWCdSuTnqlrpCzAAWs9zlEetOk
iahnOn3C9OkNvVj7eQ2KyMksNRrpwZAr45+PE9E8ckw/onmWr6gBMTjFSf5z1r1b
+CeZ9lZiELDrb6m6xZireAET2utW5Cx1uxPQdf1bPuA2v+VVWJFDK7GhFmO/JMZk
jiBfOO5wzA46RIGGTCserilEBozuT3WgEy06fxsjggMpnBxBbrcnhuQGm2HgmD8W
rZ5eiBALlCr3B8a7gzM03D98rlgFYcipcZiVWcbEzoS80WnWAQz+o31UFrn3puuB
pIiOJy+8/QL374R1WD78IpSZN3xaM0YuCxxTnhukUS0r6trrlK4m0xFlYoPMKW6h
/Ov089ZYg4m/T2hwt4nnSERUF47K1tvgZo7VH4SA6RXDArlCClA=
=EqSX
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--

