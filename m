Received: from eggs.gnu.org ([2001:4830:134:3::10]:37233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhc-0007C3-PB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybf-0006ow-Un
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:37 -0400
Date: Tue, 23 Oct 2018 16:09:05 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023150905.GE12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-7-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-7-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 06/45] hw/timer/sun4v-rtc: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:43PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> Message-Id: <20181002212522.23303-3-f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
> @@ -41,14 +34,14 @@ static uint64_t sun4v_rtc_read(void *opaque, hwaddr a=
ddr,
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
> -    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, addr);
> +    trace_sun4v_rtc_read(addr, val);

This should be trace_sun4v_rtc_write(), no?

>  }
> =20
>  static const MemoryRegionOps sun4v_rtc_ops =3D {
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index ca9ad6321a..75bd3b1042 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -66,5 +66,9 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data=
, unsigned size) "CMSDK A
>  cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size)=
 "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %=
u"
>  cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
> =20
> +# hw/timer/sun4v-rtc.c
> +sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " =
value 0x%" PRIx64
> +sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 =
" value 0x%" PRIx64
> +
>  # hw/timer/xlnx-zynqmp-rtc.c
>  xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min,=
 int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPOZEACgkQbDjKyiDZ
s5JW6BAA5cO+mOufqVr94/AU4aapvcEuhvl0KzNkXy09uJhjLZZn6zG4Aj9BJHB7
8KiDX+Y2Tgsw8ze8o45xMCx5N/vfi0YYFidrs7PwLC9+F9E/Vf8XQ5aUlSm52Xt9
TWqBQ+I40EHOuw0+h00mrVqVOo/FPX2gAg8WFTlKDZ59T/v4PV0irc/wwBKrVX1R
lu18qVzlAilZzvpihWr8Rn7M4qhiuYzOJ+S6HvAtM0mZcHnEfbzicdr0pQw7HR1V
YxiUDfmFN4BYiNzB/+OJACZgz/vsmKyAFQzGP9+pzx8skbMqEOxK7MuBtDX/5VtX
olTNBRpoBAD0LHMhPZo1UA6tHl8BjdGdJ8BCDo70Fag1cI6TuSa+opuzdtC+V42C
n5JIZI629GgJhhXSvqXVZ3UbqZoZNvZ4KjkjCY0TRZ0BlDWZBx4eqHjBIkNfCfm/
1BIdVKeMXt3FUcpSJNHMpAJSLEDkbO2K8we3IMC5zf81fWF2a2IQ5iT7rTizJA1b
xG4FgKViPPAZ2ytZsq9Y60sFjYHyv7cpWMRpE7qYisAQ7l3YeVuU/c9QqXsFQSO5
gZYwI0S588JZxFURVCg0hVmvD99VfxBqetebsuB47RrVLEcNN5dkAfQ607S3ZEiz
g1c8ZGry6xzZIzZN8gwCzdDwha08xWIOtcb9JGmR5LfQdKCIPBg=
=sDxs
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
