Received: from eggs.gnu.org ([2001:4830:134:3::10]:37010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foWgB-0007XW-6M
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foWgA-0000Mi-As
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:23:51 -0400
MIME-Version: 1.0
In-Reply-To: <20180810193129.1556-5-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
	<20180810193129.1556-5-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Sat, 11 Aug 2018 18:23:49 +0200
Message-ID: <CABoDooMuKcHSu4cp4nYPhJovzwSLVC+ydMy1pcBYE1+fLy2OaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/6] target/arm: Use FZ not FZ16 for SVE
 FCVT single-half and double-half
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable@nongnu.org

On Fri, Aug 10, 2018 at 9:31 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> We were using the wrong flush-to-zero bit for the non-half input.
>
> Fixes: 46d33d1e3c9
> Cc: qemu-stable@nongnu.org (3.0.1)
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Laurent

> ---
>  target/arm/translate-sve.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 05ba0518c8..fe7aebdc19 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -4093,7 +4093,7 @@ static bool do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
>
>  static bool trans_FCVT_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
>  {
> -    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_sh);
> +    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sh);
>  }
>
>  static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
> @@ -4103,7 +4103,7 @@ static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
>
>  static bool trans_FCVT_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
>  {
> -    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_dh);
> +    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_dh);
>  }
>
>  static bool trans_FCVT_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
> --
> 2.17.1
>
