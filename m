Received: from eggs.gnu.org ([2001:4830:134:3::10]:46991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckjuu-0004Ps-US
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckjur-0003VK-Nt
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:06:36 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170305214857.9510-1-krzk@kernel.org>
	<20170305214857.9510-3-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2130c1b2-0f81-13f6-a1f8-c0a2e294e3f0@amsat.org>
Date: Mon, 6 Mar 2017 01:06:29 -0300
MIME-Version: 1.0
In-Reply-To: <20170305214857.9510-3-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/3] hw/misc/exynos4210_pmu:
 Reorder local variables for readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Krzysztof,

On 03/05/2017 06:48 PM, Krzysztof Kozlowski wrote:
> Short declaration of 'i' was in the middle of declarations with
> assignments.  Make it a little bit more readable.  No functional change.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  hw/misc/exynos4210_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
> index cbdfa0614600..60d1545c0baa 100644
> --- a/hw/misc/exynos4210_pmu.c
> +++ b/hw/misc/exynos4210_pmu.c
> @@ -401,8 +401,8 @@ static uint64_t exynos4210_pmu_read(void *opaque, hwaddr offset,
>                                      unsigned size)
>  {
>      const Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
> -    unsigned i;
>      const Exynos4210PmuReg *reg_p = exynos4210_pmu_regs;
> +    unsigned i;

your change seems OK but while you are here, 'unsigned' is considered 
harmful since more than a decade. why not use 'size_t i' since 
PMU_NUM_OF_REGISTERS is indeed an ARRAY_SIZE()?

>
>      for (i = 0; i < PMU_NUM_OF_REGISTERS; i++) {
>          if (reg_p->offset == offset) {
> @@ -420,8 +420,8 @@ static void exynos4210_pmu_write(void *opaque, hwaddr offset,
>                                   uint64_t val, unsigned size)
>  {
>      Exynos4210PmuState *s = (Exynos4210PmuState *)opaque;
> -    unsigned i;
>      const Exynos4210PmuReg *reg_p = exynos4210_pmu_regs;
> +    unsigned i;
>
>      for (i = 0; i < PMU_NUM_OF_REGISTERS; i++) {
>          if (reg_p->offset == offset) {
>
