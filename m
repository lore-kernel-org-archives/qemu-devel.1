Received: from eggs.gnu.org ([2001:4830:134:3::10]:48673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epE0C-00077v-UE
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epE07-0004FT-7c
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:07:08 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:42663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epE07-0004ES-0q
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:07:03 -0500
Received: by mail-pf0-x244.google.com with SMTP id t15so3546353pfh.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:07:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-24-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 14:06:41 +0000
Message-ID: <CAFEAcA_Qwx55g-rkcw8M_CUCDjtkwH1iOscxEt9a78y5GckQUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 23/67] target/arm: Implement SVE Element
 Count Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  11 ++
>  target/arm/sve_helper.c    | 136 ++++++++++++++++++++++
>  target/arm/translate-sve.c | 274 ++++++++++++++++++++++++++++++++++++++++++++-
>  target/arm/sve.decode      |  30 ++++-
>  4 files changed, 448 insertions(+), 3 deletions(-)
>

> @@ -127,7 +132,9 @@ static void do_vector3_z(DisasContext *s, GVecGen3Fn *gvec_fn,
>  /* Invoke a vector move on two Zregs.  */
>  static void do_mov_z(DisasContext *s, int rd, int rn)
>  {
> -    do_vector2_z(s, tcg_gen_gvec_mov, 0, rd, rn);
> +    if (rd != rn) {
> +        do_vector2_z(s, tcg_gen_gvec_mov, 0, rd, rn);
> +    }
>  }
>
>  /* Initialize a Zreg with replications of a 64-bit immediate.  */
> @@ -168,7 +175,9 @@ static void do_vecop4_p(DisasContext *s, const GVecGen4 *gvec_op,
>  /* Invoke a vector move on two Pregs.  */
>  static void do_mov_p(DisasContext *s, int rd, int rn)
>  {
> -    do_vector2_p(s, tcg_gen_gvec_mov, 0, rd, rn);
> +    if (rd != rn) {
> +        do_vector2_p(s, tcg_gen_gvec_mov, 0, rd, rn);
> +    }
>  }

These should probably be squashed into an earlier patch.


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
