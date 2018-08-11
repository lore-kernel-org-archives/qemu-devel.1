Received: from eggs.gnu.org ([2001:4830:134:3::10]:36948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foWfq-0007GG-53
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foWfp-0000AS-A8
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:23:30 -0400
MIME-Version: 1.0
In-Reply-To: <20180810193129.1556-4-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
	<20180810193129.1556-4-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Sat, 11 Aug 2018 18:23:28 +0200
Message-ID: <CABoDooPs76xu7tsQR_cjJm3A48YZARiTh-z8uct8Q6qMayogvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/6] target/arm: Use fp_status_fp16 for
 do_fmpa_zpzzz_h
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
> This makes float16_muladd correctly use FZ16 not FZ.
>
> Fixes: 6ceabaad110
> Cc: qemu-stable@nongnu.org (3.0.1)
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Laurent

> ---
>  target/arm/sve_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 5bae600d17..f8434e68f2 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -3398,7 +3398,7 @@ static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
>                  e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
>                  e2 = *(uint16_t *)(vm + H1_2(i));
>                  e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
> -                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
> +                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status_f16);
>                  *(uint16_t *)(vd + H1_2(i)) = r;
>              }
>          } while (i & 63);
> --
> 2.17.1
>
