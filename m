Received: from eggs.gnu.org ([2001:4830:134:3::10]:49206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1ecVbT-0007yS-3f
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1ecVbS-0007XU-7y
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:17:03 -0500
References: <20180119114444.7590-1-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <d3d62aeb-435b-86eb-15a6-fa96f6e28d4c@tuxfamily.org>
Date: Fri, 19 Jan 2018 13:16:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180119114444.7590-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: fix TCG variable double free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On 19.01.2018 12:44, Laurent Vivier wrote:
> t64 is also unconditionally freed after the switch () { ... }
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index f0e86a73d4..ea18df940a 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -969,7 +969,6 @@ static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
>      case OS_DOUBLE:
>          tcg_gen_qemu_ld64(t64, addr, index);
>          gen_helper_extf64(cpu_env, fp, t64);
> -        tcg_temp_free_i64(t64);
>          break;
>      case OS_EXTENDED:
>          if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
> 

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
