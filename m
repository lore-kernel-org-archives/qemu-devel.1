Received: from eggs.gnu.org ([2001:4830:134:3::10]:48555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDoM8-000404-Tu
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDoM4-0008Ox-Il
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:47:24 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDoM3-0008OE-Qb
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:47:20 -0400
Received: by mail-wm0-x242.google.com with SMTP id a67so14046265wmf.3
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 02:47:19 -0700 (PDT)
References: <20180501180455.11214-1-richard.henderson@linaro.org>
	<20180501180455.11214-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180501180455.11214-3-richard.henderson@linaro.org>
Date: Wed, 02 May 2018 10:47:17 +0100
Message-ID: <878t929yoq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] target/arm: Tidy condition
 in disas_simd_two_reg_misc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Path analysis shows that size =3D=3D 3 && !is_q has been eliminated.
>
> Fixes: Coverity CID1385853
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 97950dce1a..6d49f30b4a 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11473,7 +11473,11 @@ static void disas_simd_two_reg_misc(DisasContext=
 *s, uint32_t insn)
>          /* All 64-bit element operations can be shared with scalar 2misc=
 */
>          int pass;
>
> -        for (pass =3D 0; pass < (is_q ? 2 : 1); pass++) {
> +        /* Coverity claims (size =3D=3D 3 && !is_q) has been eliminated
> +         * from all paths leading to here.
> +         */
> +        tcg_debug_assert(is_q);
> +        for (pass =3D 0; pass < 2; pass++) {
>              TCGv_i64 tcg_op =3D tcg_temp_new_i64();
>              TCGv_i64 tcg_res =3D tcg_temp_new_i64();


--
Alex Benn=C3=A9e
