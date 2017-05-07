Received: from eggs.gnu.org ([2001:4830:134:3::10]:52247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7Qj7-0007iR-Jc
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7Qj4-00078V-Fo
	for qemu-devel@nongnu.org; Sun, 07 May 2017 14:16:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170507113540.8687-1-krzk@kernel.org>
	<20170507113540.8687-2-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49ff1573-a503-e9f8-d1be-c346290f1eb9@amsat.org>
Date: Sun, 7 May 2017 15:16:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170507113540.8687-2-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] hw/arm/exynos: Use type
 define instead of hard-coded a9mpcore_priv string
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
> Use a define for a9mpcore_priv device type name instead of hard-coded
> string.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/exynos4210.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 034fc8be9d76..a9e221c5b7fe 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -26,6 +26,7 @@
>  #include "qemu-common.h"
>  #include "qemu/log.h"
>  #include "cpu.h"
> +#include "hw/cpu/a9mpcore.h"
>  #include "hw/boards.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/sysbus.h"
> @@ -212,7 +213,7 @@ static void exynos4210_init(Object *obj)
>      }
>
>      /* Private memory region and Internal GIC */
> -    dev = qdev_create(NULL, "a9mpcore_priv");
> +    dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
>      qdev_prop_set_uint32(dev, "num-cpu", EXYNOS4210_NCPUS);
>      qdev_init_nofail(dev);
>      busdev = SYS_BUS_DEVICE(dev);
>
