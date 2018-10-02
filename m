Received: from eggs.gnu.org ([2001:4830:134:3::10]:45815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvi-0004S4-HX
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvd-0007GE-Rb
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:46 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:39539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7Mvc-0007C4-Ew
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:40 -0400
Received: from player776.ha.ovh.net (unknown [10.109.146.53])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2CACF15DEF7
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:49:22 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-3-f4bug@amsat.org>
Message-ID: <12e2797a-f1fc-8a09-6176-2c8586c5cf20@kaod.org>
Date: Tue, 2 Oct 2018 17:49:16 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/15] hw/timer/sun4v-rtc: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On 10/2/18 12:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/timer/sun4v-rtc.c  | 13 +++----------
>  hw/timer/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
> index 310523225f..13be94f8da 100644
> --- a/hw/timer/sun4v-rtc.c
> +++ b/hw/timer/sun4v-rtc.c
> @@ -14,15 +14,8 @@
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "hw/timer/sun4v-rtc.h"
> +#include "trace.h"
> =20
> -//#define DEBUG_SUN4V_RTC
> -
> -#ifdef DEBUG_SUN4V_RTC
> -#define DPRINTF(fmt, ...)                                       \
> -    do { printf("sun4v_rtc: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while (0)
> -#endif
> =20
>  #define TYPE_SUN4V_RTC "sun4v_rtc"
>  #define SUN4V_RTC(obj) OBJECT_CHECK(Sun4vRtc, (obj), TYPE_SUN4V_RTC)
> @@ -41,14 +34,14 @@ static uint64_t sun4v_rtc_read(void *opaque, hwaddr=
 addr,
>          /* accessing the high 32 bits */
>          val >>=3D 32;
>      }
> -    DPRINTF("read from " TARGET_FMT_plx " val %lx\n", addr, val);
> +    trace_sun4v_rtc_read(addr, val);
>      return val;
>  }
> =20
>  static void sun4v_rtc_write(void *opaque, hwaddr addr,
>                               uint64_t val, unsigned size)
>  {
> -    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, addr)=
;
> +    trace_sun4v_rtc_read(addr, val);
>  }
> =20
>  static const MemoryRegionOps sun4v_rtc_ops =3D {
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index ca9ad6321a..75bd3b1042 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -66,5 +66,9 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t da=
ta, unsigned size) "CMSDK A
>  cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned siz=
e) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " si=
ze %u"
>  cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
> =20
> +# hw/timer/sun4v-rtc.c
> +sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 =
" value 0x%" PRIx64
> +sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx6=
4 " value 0x%" PRIx64
> +
>  # hw/timer/xlnx-zynqmp-rtc.c
>  xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int mi=
n, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
>=20
