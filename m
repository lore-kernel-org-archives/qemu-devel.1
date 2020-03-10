Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC6CC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF562071B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 23:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eW2okyL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF562071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBo7H-0007ne-4d
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 19:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBo5k-0006F8-0B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBo5i-00064E-F8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 19:15:15 -0400
Received: from ozlabs.org ([203.11.71.1]:57827)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBo5h-0005tb-P5; Tue, 10 Mar 2020 19:15:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48cWCK0HyTz9sPk; Wed, 11 Mar 2020 10:15:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583882109;
 bh=+5ZSE5+oReUCDVKDLDaanWx3ukO2jjZcBW7+csQ5vls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eW2okyL2cOu1D51d0v5ZAm3daiqWcXYQwyVbbgBlbQgBK+fnVq2TOjEuRgbALLi22
 9mKDjgwFKKJBj8xW7ZSGwvsQJj7HEwS17KNMEr+fYxeB9Yw3GTh4p5U0z7wyIme/SL
 mnGidcHzRExDoxYnRojWRVObGXpXWhGkxKSz/dsc=
Date: Wed, 11 Mar 2020 10:15:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH] target/ppc: Fix rlwinm on ppc64
Message-ID: <20200310231503.GR660117@umbus.fritz.box>
References: <20200309204557.14836-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eyYj78xbwv+yMvU1"
Content-Disposition: inline
In-Reply-To: <20200309204557.14836-1-vt@altlinux.org>
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
Cc: qemu-stable@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eyYj78xbwv+yMvU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 11:45:57PM +0300, Vitaly Chikunov wrote:
> rlwinm cannot just AND with Mask if shift value is zero on ppc64 when
> Mask Begin is greater than Mask End and high bits are set to 1.
>=20
> Note that PowerISA 3.0B says that for `rlwinm' ROTL32 is used, and
> ROTL32 is defined (in 3.3.14) so that rotated value should have two
> copies of lower word of the source value.
>=20
> This seems to be another incarnation of the fix from 820724d170
> ("target-ppc: Fix rlwimi, rlwinm, rlwnm again"), except I leave
> optimization when Mask value is less than 32 bits.
>=20
> Fixes: 7b4d326f47 ("target-ppc: Use the new deposit and extract ops")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Applied to ppc-for-5.0.

> ---
>  target/ppc/translate.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 36fa27367c..127c82a24e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1938,15 +1938,17 @@ static void gen_rlwinm(DisasContext *ctx)
>          me +=3D 32;
>  #endif
>          mask =3D MASK(mb, me);
> -        if (sh =3D=3D 0) {
> -            tcg_gen_andi_tl(t_ra, t_rs, mask);
> -        } else if (mask <=3D 0xffffffffu) {
> -            TCGv_i32 t0 =3D tcg_temp_new_i32();
> -            tcg_gen_trunc_tl_i32(t0, t_rs);
> -            tcg_gen_rotli_i32(t0, t0, sh);
> -            tcg_gen_andi_i32(t0, t0, mask);
> -            tcg_gen_extu_i32_tl(t_ra, t0);
> -            tcg_temp_free_i32(t0);
> +        if (mask <=3D 0xffffffffu) {
> +            if (sh =3D=3D 0) {
> +                tcg_gen_andi_tl(t_ra, t_rs, mask);
> +            } else {
> +                TCGv_i32 t0 =3D tcg_temp_new_i32();
> +                tcg_gen_trunc_tl_i32(t0, t_rs);
> +                tcg_gen_rotli_i32(t0, t0, sh);
> +                tcg_gen_andi_i32(t0, t0, mask);
> +                tcg_gen_extu_i32_tl(t_ra, t0);
> +                tcg_temp_free_i32(t0);
> +            }
>          } else {
>  #if defined(TARGET_PPC64)
>              tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eyYj78xbwv+yMvU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5oH3YACgkQbDjKyiDZ
s5K5Jw//bsI21ymx6GqnVNtZZP5aoFx2Vrbn8VE1aW4LoL3Ma+3jfts5kziJbMMw
J+BH7rLWuOQ9IOOAPvmCW/Q52NINVUf5cQTnLgPWjsCD5Mm5N21kU/5X6JE3o0yV
0OG3GMoOikh2SbNeC5kzM6M7t48NsaD5PJLpnDVlVcdVsDr4+q1zmZhK/pOUs1GF
vyw7dNBHTvACes74hBfjSYXfZ90IWmhp1ejUE9TxjKLGoz336LERehOYApLoKMni
2jQYSnB1AYTGhEJU1tpW39pjZVVkQKt9nS6vITnVmwZKQt5khHowMgJmWh1P3Cmo
JG7urDF5IXvx9R6IBx7s8/cosyh8Hb2OfTyA/kex2KlBlfP4rNhhDILC+KFfFRH8
dSXuZrHc45eyFFo5RpONMieaZUz7Nz6221WEdisR/K9G8Lzix+z5VK5ryIptmYIx
IAVjuCg7QddAgsWKcs4Gc8OFQ12XIHrtU9QQCWdLFKE1m0ZFTWRO/sedoB8zxntE
sNFOjxZv5Mm4zs/ct7zWhiThJUM6LnhtVEIZNutHDTAw8EBWcFN+qFrTpj4PTP3K
iAMmr/Ke+lI+4yJjXhrxXz0cBGCuitL47Cug+G7Jnfl1Gt/O4C86aBAgBjAwkyq+
3T02/rqxl1NNakRZlt2+An895VtxR/jqI4sZmSxcHU2X+qnIprA=
=unZC
-----END PGP SIGNATURE-----

--eyYj78xbwv+yMvU1--

