Received: from eggs.gnu.org ([2001:4830:134:3::10]:46075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHAL-00006b-3r
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHAK-0000EW-0t
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:11:33 -0400
References: <20180621180224.8312-1-f4bug@amsat.org>
	<20180621180224.8312-4-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3b263d94-b684-3c59-1c34-62f075ea1c9f@redhat.com>
Date: Fri, 22 Jun 2018 10:11:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180621180224.8312-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/dma/omap_dma: Use
 qemu_log_mask(UNIMP) instead of printf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 21.06.2018 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/dma/omap_dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
> index abd18c67ea..ab3a1b0451 100644
> --- a/hw/dma/omap_dma.c
> +++ b/hw/dma/omap_dma.c
> @@ -18,6 +18,7 @@
>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "qemu-common.h"
>  #include "qemu/timer.h"
>  #include "hw/arm/omap.h"
> @@ -1439,8 +1440,9 @@ static int omap_dma_sys_read(struct omap_dma_s *s=
, int offset,
>      case 0x480:	/* DMA_PCh0_SR */
>      case 0x482:	/* DMA_PCh1_SR */
>      case 0x4c0:	/* DMA_PChD_SR_0 */
> -        printf("%s: Physical Channel Status Registers not implemented.=
\n",
> -               __func__);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Physical Channel Status Registers not imple=
mented\n",
> +                      __func__);
>          *ret =3D 0xff;
>          break;

Reviewed-by: Thomas Huth <thuth@redhat.com>
