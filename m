Received: from eggs.gnu.org ([2001:4830:134:3::10]:38267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnHhi-0005rr-IA
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnHhh-0006DI-PQ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:07:46 -0400
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3fae2ca1-90d0-b62a-d932-8c0d2cf2b62c@redhat.com>
Date: Thu, 31 Aug 2017 07:07:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170830215523.25278-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/17] MAINTAINERS: add missing ARM
 entries
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

On 30.08.2017 23:55, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ccee28b12d..b363e1b9c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -380,6 +380,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/char/pl011.c
> +F: include/hw/char/pl011.h
>  F: hw/display/pl110*
>  F: hw/dma/pl080.c
>  F: hw/dma/pl330.c
> @@ -403,13 +404,15 @@ F: hw/intc/gic_internal.h
>  F: hw/misc/a9scu.c
>  F: hw/misc/arm11scu.c
>  F: hw/timer/a9gtimer*
> -F: hw/timer/arm_*
> -F: include/hw/arm/arm.h
> +F: hw/timer/arm*
> +F: include/hw/arm/arm*.h
>  F: include/hw/intc/arm*
>  F: include/hw/misc/a9scu.h
>  F: include/hw/misc/arm11scu.h
>  F: include/hw/timer/a9gtimer.h
>  F: include/hw/timer/arm_mptimer.h
> +F: include/hw/timer/armv7m_systick.h
> +F: tests/test-arm-mptimer.c
> =20
>  Exynos
>  M: Igor Mitsyanko <i.mitsyanko@gmail.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
