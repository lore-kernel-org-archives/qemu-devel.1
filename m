Received: from eggs.gnu.org ([2001:4830:134:3::10]:52175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7QiS-0007O2-6m
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7QiP-000719-3U
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:15:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170507113540.8687-1-krzk@kernel.org>
	<20170507113540.8687-3-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b672980d-c714-2e11-636a-331f566e9bb6@amsat.org>
Date: Sun, 7 May 2017 15:15:24 -0300
MIME-Version: 1.0
In-Reply-To: <20170507113540.8687-3-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/3] hw/intc/exynos: Constify
 array of combiner interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 05/07/2017 08:35 AM, Krzysztof Kozlowski wrote:
> The static array of interrupt combiner mappings is not modified so it
> can be made const for code safeness.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/exynos4210_gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
> index 222cfd6c6387..636dc6dbc1f9 100644
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -116,7 +116,7 @@ enum ExtInt {
>   * which is INTG16 in Internal Interrupt Combiner.
>   */
>
> -static uint32_t
> +static const uint32_t
>  combiner_grp_to_gic_id[64-EXYNOS4210_MAX_EXT_COMBINER_OUT_IRQ][8] = {
>      /* int combiner groups 16-19 */
>      { }, { }, { }, { },
>
