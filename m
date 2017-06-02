Received: from eggs.gnu.org ([2001:4830:134:3::10]:35010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrQc-00037C-Mp
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrQb-0004DR-JY
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:36:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170602162857.6065-1-krzk@kernel.org>
	<20170602163618.6369-1-krzk@kernel.org>
	<20170602163618.6369-2-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <33f0d254-c1a9-9b8e-8dbf-745d87e31c0e@amsat.org>
Date: Fri, 2 Jun 2017 15:36:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170602163618.6369-2-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/9] hw/timer/exynos4210_mct: Fix
 checkpatch style errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/02/2017 01:36 PM, Krzysztof Kozlowski wrote:
> Fix checkpatch errors:
> 1. ERROR: spaces required around that '+' (ctx:VxV)
> 2. ERROR: spaces required around that '&' (ctx:VxV)
>
> No functional changes.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/timer/exynos4210_mct.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index a2ec3920f82e..2404fb737ac4 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -937,7 +937,7 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
>  {
>      uint32_t freq = s->freq;
>      s->freq = 24000000 /
> -            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg)+1) *
> +            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg) + 1) *
>                      MCT_CFG_GET_DIVIDER(s->reg_mct_cfg));
>
>      if (freq != s->freq) {
> @@ -1162,7 +1162,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>
>      DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
>
> -    if (offset&0x4) {
> +    if (offset & 0x4) {
>          s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
>      } else {
>          s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
>
