Received: from eggs.gnu.org ([2001:4830:134:3::10]:33265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWMPH-00033W-TV
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWMPE-0006Vb-02
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:47:20 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@mips.com>)
	id 1fWMPD-0006UM-Q3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:47:15 -0400
From: Aleksandar Markovic <Aleksandar.Markovic@mips.com>
Date: Fri, 22 Jun 2018 13:47:03 +0000
Message-ID: <96f2606a9d054aa9bd26d48be5256322@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>,
	<20180620120620.12806-23-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-23-yongbok.kim@mips.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/35] target/mips: Fix data type for offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <Yongbok.Kim@mips.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, James Hogan <James.Hogan@mips.com>, Paul Burton <Paul.Burton@mips.com>, Matthew Fortune <Matthew.Fortune@mips.com>, Stefan Markovic <Stefan.Markovic@mips.com>

> From: Yongbok Kim <yongbok.kim@imgtec.com>
>
> Offset can be larger than 16 bit from nanoMIPS,
> and immediate field can be larger than 16 bits as well.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>

Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

> ---
>  target/mips/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 9e29dd7..8c20ba3 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -2114,7 +2114,7 @@ OP_ST_ATOMIC(scd,st64,ld64,0x7);
>  #undef OP_ST_ATOMIC
>
>  static void gen_base_offset_addr (DisasContext *ctx, TCGv addr,
> -                                  int base, int16_t offset)
> +                                  int base, int offset)
>  {
>      if (base =3D=3D 0) {
>          tcg_gen_movi_tl(addr, offset);
> @@ -2142,7 +2142,7 @@ static target_ulong pc_relative_pc (DisasContext *c=
tx)
>
>  /* Load */
>  static void gen_ld(DisasContext *ctx, uint32_t opc,
> -                   int rt, int base, int16_t offset)
> +                   int rt, int base, int offset)
>  {
>      TCGv t0, t1, t2;
>      int mem_idx =3D ctx->mem_idx;
> @@ -2377,7 +2377,7 @@ static void gen_llwp(DisasContext *ctx, uint32_t ba=
se, int16_t offset,
>
>  /* Store */
>  static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
> -                    int base, int16_t offset)
> +                    int base, int offset)
>  {
>      TCGv t0 =3D tcg_temp_new();
>      TCGv t1 =3D tcg_temp_new();
> @@ -2602,7 +2602,7 @@ static void gen_cop1_ldst(DisasContext *ctx, uint32=
_t op, int rt,
>
>  /* Arithmetic with immediate operand */
>  static void gen_arith_imm(DisasContext *ctx, uint32_t opc,
> -                          int rt, int rs, int16_t imm)
> +                          int rt, int rs, int imm)
>  {
>      target_ulong uimm =3D (target_long)imm; /* Sign extend to 32/64 bits=
 */
>
> --
> 1.9.1
