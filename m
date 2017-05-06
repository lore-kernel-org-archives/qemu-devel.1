Received: from eggs.gnu.org ([2001:4830:134:3::10]:43318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72EH-0005TW-Lz
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72ED-0002U7-My
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:06:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170506152414.8704-1-krzk@kernel.org>
	<20170506152414.8704-3-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ab971cd6-51c6-7cb3-4f5e-0520538caffd@amsat.org>
Date: Sat, 6 May 2017 13:06:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170506152414.8704-3-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/exynos: Declare local variables
 in some order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Aesthetic.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

On 05/06/2017 12:24 PM, Krzysztof Kozlowski wrote:
> Bring some more readability by declaring local function variables, first
> initialized ones and then the rest (with reversed-christmas-tree order).
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  hw/arm/exynos4210.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 0da877f8db0a..27a7bf28a5a9 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -162,12 +162,12 @@ static uint64_t exynos4210_calc_affinity(int cpu)
>
>  Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
>  {
> -    int i, n;
>      Exynos4210State *s = g_new(Exynos4210State, 1);
>      qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
> -    DeviceState *dev;
>      SysBusDevice *busdev;
>      ObjectClass *cpu_oc;
> +    DeviceState *dev;
> +    int i, n;
>
>      cpu_oc = cpu_class_by_name(TYPE_ARM_CPU, "cortex-a9");
>      assert(cpu_oc);
>
