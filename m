Received: from eggs.gnu.org ([2001:4830:134:3::10]:42687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXQFD-0008Ve-Oi
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXQFC-0007Kw-FL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:05:19 -0400
References: <20180624040609.17572-1-f4bug@amsat.org>
	<20180624040609.17572-10-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e8083908-85c8-6d86-3f53-ed22e0dd934e@redhat.com>
Date: Mon, 25 Jun 2018 14:05:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180624040609.17572-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/16] hw/arm/omap: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

On 24.06.2018 06:06, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/omap.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index 39abba753d..e7fbd340f3 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -21,6 +21,7 @@
>  # define hw_omap_h		"omap.h"
>  #include "hw/irq.h"
>  #include "target/arm/cpu-qom.h"
> +#include "qemu/log.h"
> =20
>  # define OMAP_EMIFS_BASE	0x00000000
>  # define OMAP2_Q0_BASE		0x00000000
> @@ -944,8 +945,6 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRe=
gion *sysmem,
>                  unsigned long sdram_size,
>                  const char *core);
> =20
> -#define OMAP_FMT_plx "%#08" HWADDR_PRIx
> -
>  uint32_t omap_badwidth_read8(void *opaque, hwaddr addr);
>  void omap_badwidth_write8(void *opaque, hwaddr addr,
>                  uint32_t value);
> @@ -959,11 +958,12 @@ void omap_badwidth_write32(void *opaque, hwaddr a=
ddr,
>  void omap_mpu_wakeup(void *opaque, int irq, int req);
> =20
>  # define OMAP_BAD_REG(paddr)		\
> -        fprintf(stderr, "%s: Bad register " OMAP_FMT_plx "\n",	\
> -                        __func__, paddr)
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad register %#08"HWADDR_P=
RIx"\n", \
> +                      __func__, paddr)
>  # define OMAP_RO_REG(paddr)		\
> -        fprintf(stderr, "%s: Read-only register " OMAP_FMT_plx "\n",	\
> -                        __func__, paddr)
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Read-only register %#08" \
> +                                       HWADDR_PRIx "\n", \
> +                      __func__, paddr)
> =20
>  /* OMAP-specific Linux bootloader tags for the ATAG_BOARD area
>     (Board-specifc tags are not here)  */
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
