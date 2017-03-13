Received: from eggs.gnu.org ([2001:4830:134:3::10]:35984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cnVde-00024o-HE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cnVda-0005wc-GU
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:28:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170313184750.429-1-krzk@kernel.org>
	<20170313184750.429-4-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <65adff21-6f04-f27b-08bc-5a731da58604@amsat.org>
Date: Mon, 13 Mar 2017 16:28:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170313184750.429-4-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] hw/misc/exynos4210_pmu: Reorder
 local variables for readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 03/13/2017 03:47 PM, Krzysztof Kozlowski wrote:
> Short declaration of 'i' was in the middle of declarations with
> assignments.  Make it a little bit more readable.  Additionally switch
> from "unsigned" to "unsigned int" as this pattern is more widely used.
> No functional change.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/misc/exynos4210_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
> index e30dbc7d3d83..63a8ccd35559 100644
> --- a/hw/misc/exynos4210_pmu.c
> +++ b/hw/misc/exynos4210_pmu.c
> @@ -401,8 +401,8 @@ static uint64_t exynos4210_pmu_read(void *opaque, hwaddr offset,
>                                      unsigned size)
>  {
>      Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
> -    unsigned i;
>      const Exynos4210PmuReg *reg_p = exynos4210_pmu_regs;
> +    unsigned int i;
>
>      for (i = 0; i < PMU_NUM_OF_REGISTERS; i++) {
>          if (reg_p->offset == offset) {
> @@ -420,8 +420,8 @@ static void exynos4210_pmu_write(void *opaque, hwaddr offset,
>                                   uint64_t val, unsigned size)
>  {
>      Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
> -    unsigned i;
>      const Exynos4210PmuReg *reg_p = exynos4210_pmu_regs;
> +    unsigned int i;
>
>      for (i = 0; i < PMU_NUM_OF_REGISTERS; i++) {
>          if (reg_p->offset == offset) {
>
