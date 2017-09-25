Received: from eggs.gnu.org ([2001:4830:134:3::10]:42397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLnz-0001el-Lc
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLnw-00058K-Hy
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:19:43 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-19-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0793731d-fc49-cf85-f15d-3f1ae8bbe0d2@redhat.com>
Date: Mon, 25 Sep 2017 07:19:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-19-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/34] hw/unicore32: restrict hw addr
 defines to source file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 22.09.2017 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
> and drop unused #includes
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/unicore32/puv3.h | 10 ----------
>  hw/unicore32/puv3.c         | 16 ++++++++++------
>  2 files changed, 10 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
> index 5a4839f8df..f587a1f622 100644
> --- a/include/hw/unicore32/puv3.h
> +++ b/include/hw/unicore32/puv3.h
> @@ -14,16 +14,6 @@
> =20
>  #define PUV3_REGS_OFFSET        (0x1000) /* 4K is reasonable */
> =20
> -/* PKUnity System bus (AHB): 0xc0000000 - 0xedffffff (640MB) */
> -#define PUV3_DMA_BASE           (0xc0200000) /* AHB-4 */
> -
> -/* PKUnity Peripheral bus (APB): 0xee000000 - 0xefffffff (128MB) */
> -#define PUV3_GPIO_BASE          (0xee500000) /* APB-5 */
> -#define PUV3_INTC_BASE          (0xee600000) /* APB-6 */
> -#define PUV3_OST_BASE           (0xee800000) /* APB-8 */
> -#define PUV3_PM_BASE            (0xeea00000) /* APB-10 */
> -#define PUV3_PS2_BASE           (0xeeb00000) /* APB-11 */
> -
>  /* Hardware interrupts */
>  #define PUV3_IRQS_NR            (32)
> =20
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 504ea46211..6849bac59c 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -11,16 +11,10 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qemu-common.h"
>  #include "cpu.h"
>  #include "ui/console.h"
> -#include "elf.h"
> -#include "exec/address-spaces.h"
> -#include "hw/sysbus.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "hw/i386/pc.h"
> -#include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> =20
>  #undef DEBUG_PUV3
> @@ -29,6 +23,16 @@
>  #define KERNEL_LOAD_ADDR        0x03000000
>  #define KERNEL_MAX_SIZE         0x00800000 /* Just a guess */
> =20
> +/* PKUnity System bus (AHB): 0xc0000000 - 0xedffffff (640MB) */
> +#define PUV3_DMA_BASE           (0xc0200000) /* AHB-4 */
> +
> +/* PKUnity Peripheral bus (APB): 0xee000000 - 0xefffffff (128MB) */
> +#define PUV3_GPIO_BASE          (0xee500000) /* APB-5 */
> +#define PUV3_INTC_BASE          (0xee600000) /* APB-6 */
> +#define PUV3_OST_BASE           (0xee800000) /* APB-8 */
> +#define PUV3_PM_BASE            (0xeea00000) /* APB-10 */
> +#define PUV3_PS2_BASE           (0xeeb00000) /* APB-11 */
> +
>  static void puv3_intc_cpu_handler(void *opaque, int irq, int level)
>  {
>      UniCore32CPU *cpu =3D opaque;
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
