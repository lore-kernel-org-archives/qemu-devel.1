Received: from eggs.gnu.org ([2001:4830:134:3::10]:38397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDVS-00065f-QH
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDVP-0001HE-KY
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:17:06 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:42525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWDVP-0001H6-DJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:17:03 -0400
Received: by mail-qk0-x243.google.com with SMTP id u62-v6so507865qkf.9
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 21:17:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-23-yongbok.kim@mips.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7eb9338c-75df-840a-c53c-5c65314a711c@amsat.org>
Date: Fri, 22 Jun 2018 01:16:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-23-yongbok.kim@mips.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="eKd2bCRWoDiPqJl8L46vgRPDbCLE2pP9R"
Subject: Re: [Qemu-devel] [PATCH 22/35] target/mips: Fix data type for offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eKd2bCRWoDiPqJl8L46vgRPDbCLE2pP9R
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com,
 Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Message-ID: <7eb9338c-75df-840a-c53c-5c65314a711c@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 22/35] target/mips: Fix data type for offset
References: <20180620120620.12806-1-yongbok.kim@mips.com>
 <20180620120620.12806-23-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-23-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/20/2018 09:06 AM, Yongbok Kim wrote:
> From: Yongbok Kim <yongbok.kim@imgtec.com>
>=20
> Offset can be larger than 16 bit from nanoMIPS,
> and immediate field can be larger than 16 bits as well.
>=20
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/mips/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 9e29dd7..8c20ba3 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -2114,7 +2114,7 @@ OP_ST_ATOMIC(scd,st64,ld64,0x7);
>  #undef OP_ST_ATOMIC
> =20
>  static void gen_base_offset_addr (DisasContext *ctx, TCGv addr,
> -                                  int base, int16_t offset)
> +                                  int base, int offset)
>  {
>      if (base =3D=3D 0) {
>          tcg_gen_movi_tl(addr, offset);
> @@ -2142,7 +2142,7 @@ static target_ulong pc_relative_pc (DisasContext =
*ctx)
> =20
>  /* Load */
>  static void gen_ld(DisasContext *ctx, uint32_t opc,
> -                   int rt, int base, int16_t offset)
> +                   int rt, int base, int offset)
>  {
>      TCGv t0, t1, t2;
>      int mem_idx =3D ctx->mem_idx;
> @@ -2377,7 +2377,7 @@ static void gen_llwp(DisasContext *ctx, uint32_t =
base, int16_t offset,
> =20
>  /* Store */
>  static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
> -                    int base, int16_t offset)
> +                    int base, int offset)
>  {
>      TCGv t0 =3D tcg_temp_new();
>      TCGv t1 =3D tcg_temp_new();
> @@ -2602,7 +2602,7 @@ static void gen_cop1_ldst(DisasContext *ctx, uint=
32_t op, int rt,
> =20
>  /* Arithmetic with immediate operand */
>  static void gen_arith_imm(DisasContext *ctx, uint32_t opc,
> -                          int rt, int rs, int16_t imm)
> +                          int rt, int rs, int imm)
>  {
>      target_ulong uimm =3D (target_long)imm; /* Sign extend to 32/64 bi=
ts */
> =20
>=20


--eKd2bCRWoDiPqJl8L46vgRPDbCLE2pP9R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsseDUACgkQ4+MsLN6t
wN4Q+A/+ITa9aAGbIX/SIz12s5zGfYkr1DX5UAHyJ9OjV/6R26yNRM7QFrlMm+hJ
7hSLAyIZuDc99XeES+kmfgRthQ0FSe/J430BPocW4fAIlymV0/ezWZVR5CNS9Vmv
QACy4F/6Y9EYca6JLrWZrQuVCceTK7FCAnsXoWWH1Mwc1RIsv18VVQ8N0nhApncc
Zt3b2ufcXcfZRK6167a8GNjYl7QrGpGaW2qGnztIGZlv9Y0g61a5ezsBAr2XplHX
9XJDz+Ej5NjILdD5ruTVV3U+hVuzXAyIxnN6GJg8Zx5izTVKwQOckWmSyGIWMv6E
JMAXIMw4Dif9ZpkJ66shBT3Y5JbIHVrr1E+XLAK++7DQ2tQSgMERM8kRbFyfD7Vh
zKzvWo2VfFyxP6ntPpHb7juLR+N1bTmdIjNi8h18nM3RlBNbHGF8FVtsl8PpcXqx
EVXDXVt93xWJ2Y44lJRtZB7TH02zFwXVKXKAJ4xqkBwQCMmyneBz9CCn2Px1JRSX
CmnAfD3UbV3thpabd5nMbg4uDRUGGn4mx17vCb9UVjKBMBf2V9q5HlGzKhWoEcXh
KB46cMnk94Qedd8IFI+iD84anze4L2wphWFbVyNlBU0qNJm/zckaYhK2e4sdxWJF
RFGUm2g24XoGADpPjpBTravNsWEjts+Cc5Pf5sxZ6dcDCV+Vi1M=
=c/86
-----END PGP SIGNATURE-----

--eKd2bCRWoDiPqJl8L46vgRPDbCLE2pP9R--
