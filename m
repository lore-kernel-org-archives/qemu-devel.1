Received: from eggs.gnu.org ([2001:4830:134:3::10]:46743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRz3-0001y5-VK
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRz2-0001ob-Vo
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:44:38 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-10-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b70145b2-5c24-d525-b23a-aaeb7ab960c5@redhat.com>
Date: Fri, 22 Jun 2018 21:44:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/14] hw/arm/omap: Use
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

On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/omap.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index 39abba753d..3867687b8c 100644
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
> @@ -962,8 +963,8 @@ void omap_mpu_wakeup(void *opaque, int irq, int req=
);
>          fprintf(stderr, "%s: Bad register " OMAP_FMT_plx "\n",	\
>                          __func__, paddr)

What about that fprintf above?

>  # define OMAP_RO_REG(paddr)		\
> -        fprintf(stderr, "%s: Read-only register " OMAP_FMT_plx "\n",	\
> -                        __func__, paddr)
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Read-only register " OMAP_=
FMT_plx \
> +                      "\n", __func__, paddr)
> =20
>  /* OMAP-specific Linux bootloader tags for the ATAG_BOARD area
>     (Board-specifc tags are not here)  */
>=20

 Thomas
