Received: from eggs.gnu.org ([2001:4830:134:3::10]:58185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTmN-0001N0-NC
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTmM-0008IR-T8
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:40:35 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjTmM-0008Hw-MR
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:40:34 -0500
Received: by mail-wr0-x22e.google.com with SMTP id l37so56588424wrc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 08:40:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301182618.22395-5-krzk@kernel.org>
References: <20170301182618.22395-1-krzk@kernel.org>
	<20170301182618.22395-5-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 16:40:13 +0000
Message-ID: <CAFEAcA9B23Bvt0DrQxN2cQKgg-t8Mo+qMyzXShk2M=2BLYxheQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 4/5] hw/timer/exynos4210_mct: Fix
 checkpatch style errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>

On 1 March 2017 at 18:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Fix checkpatch errors:
> 1. ERROR: spaces required around that '+' (ctx:VxV)
> 2. ERROR: spaces required around that '&' (ctx:VxV)
>
> No functional changes.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  hw/timer/exynos4210_mct.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index 76634fb1b4fd..4dd3e441e2e6 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -936,7 +936,7 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
>  {
>      uint32_t freq = s->freq;
>      s->freq = 24000000 /
> -            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg)+1) *
> +            ((MCT_CFG_GET_PRESCALER(s->reg_mct_cfg) + 1) *
>                      MCT_CFG_GET_DIVIDER(s->reg_mct_cfg));
>
>      if (freq != s->freq) {
> @@ -1160,7 +1160,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>
>          DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
>
> -        if (offset&0x4) {
> +        if (offset & 0x4) {
>              s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
>          } else {
>              s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
> --
> 2.9.3

Wow, only 2 checkpatch errors in the whole file? :-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
