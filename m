Received: from eggs.gnu.org ([2001:4830:134:3::10]:45653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRtB-000639-Pi
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRtA-0008FL-Mx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:38:33 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-8-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e98bac2c-ce0b-e226-3d96-004e46478f2f@redhat.com>
Date: Fri, 22 Jun 2018 21:38:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/14] hw/i2c/omap_i2c: Use
 qemu_log_mask(UNIMP) instead of fprintf
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
>  hw/i2c/omap_i2c.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
> index 26e3e5ebf6..690876e43e 100644
> --- a/hw/i2c/omap_i2c.c
> +++ b/hw/i2c/omap_i2c.c
> @@ -17,6 +17,7 @@
>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/arm/omap.h"
> @@ -339,14 +340,15 @@ static void omap_i2c_write(void *opaque, hwaddr a=
ddr,
>              }
>              break;
>          }
> -        if ((value & (1 << 15)) && !(value & (1 << 10))) {	/* MST */
> -            fprintf(stderr, "%s: I^2C slave mode not supported\n",
> -                            __func__);
> +        if ((value & (1 << 15)) && !(value & (1 << 10))) { /* MST */

Please keep the white spaces before the comment if you don't change
anything else.

> +            qemu_log_mask(LOG_UNIMP, "%s: I^2C slave mode not supporte=
d\n",
> +                          __func__);
>              break;
>          }
> -        if ((value & (1 << 15)) && value & (1 << 8)) {		/* XA */
> -            fprintf(stderr, "%s: 10-bit addressing mode not supported\=
n",
> -                            __func__);
> +        if ((value & (1 << 15)) && value & (1 << 8)) { /* XA */

dito.

> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: 10-bit addressing mode not supported\n"=
,
> +                          __func__);

Apart from the nits, looks fine to me, so once you've fixed that:

Reviewed-by: Thomas Huth <thuth@redhat.com>
