Received: from eggs.gnu.org ([2001:4830:134:3::10]:43407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkrCa-0002CG-4D
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkrCU-00068H-Hy
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:30:08 -0400
MIME-Version: 1.0
In-Reply-To: <20180801123111.3595-3-richard.henderson@linaro.org>
References: <20180801123111.3595-1-richard.henderson@linaro.org>
	<20180801123111.3595-3-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 1 Aug 2018 15:30:01 +0200
Message-ID: <CABoDooMKtkuvvgrF9T63-9dMJaCPFX9=P7mCa6zGZk2JXEw2Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/4] target/arm: Fix typo in
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, Aug 1, 2018 at 2:31 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Used the wrong temporary in the computation of subtractive overflow.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>


Laurent

> ---
>  target/arm/translate-sve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 374051cd20..9dd4c38bab 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -1625,7 +1625,7 @@ static void do_sat_addsub_64(TCGv_i64 reg, TCGv_i64 val, bool u, bool d)
>              /* Detect signed overflow for subtraction.  */
>              tcg_gen_xor_i64(t0, reg, val);
>              tcg_gen_sub_i64(t1, reg, val);
> -            tcg_gen_xor_i64(reg, reg, t0);
> +            tcg_gen_xor_i64(reg, reg, t1);
>              tcg_gen_and_i64(t0, t0, reg);
>
>              /* Bound the result.  */
> --
> 2.17.1
>
