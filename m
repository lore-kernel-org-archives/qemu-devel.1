Received: from eggs.gnu.org ([2001:4830:134:3::10]:54204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fngze-0001wU-Dy
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fngzb-0004Mz-7A
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:12:30 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fngza-0004M7-VJ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:12:27 -0400
Received: by mail-wm0-x242.google.com with SMTP id r24-v6so1776670wmh.0
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 02:12:26 -0700 (PDT)
References: <20180809034033.10579-1-richard.henderson@linaro.org>
	<20180809034033.10579-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180809034033.10579-3-richard.henderson@linaro.org>
Date: Thu, 09 Aug 2018 10:12:24 +0100
Message-ID: <87o9ebq4xz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/11] target/arm: Fix typo in
 do_sat_addsub_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-stable@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Used the wrong temporary in the computation of subtractive overflow.
>
> Cc: qemu-stable@nongnu.org (3.0.1)
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-sve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 374051cd20..9dd4c38bab 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -1625,7 +1625,7 @@ static void do_sat_addsub_64(TCGv_i64 reg, TCGv_i64=
 val, bool u, bool d)
>              /* Detect signed overflow for subtraction.  */
>              tcg_gen_xor_i64(t0, reg, val);
>              tcg_gen_sub_i64(t1, reg, val);
> -            tcg_gen_xor_i64(reg, reg, t0);
> +            tcg_gen_xor_i64(reg, reg, t1);
>              tcg_gen_and_i64(t0, t0, reg);
>
>              /* Bound the result.  */


--
Alex Benn=C3=A9e
