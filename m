Received: from eggs.gnu.org ([2001:4830:134:3::10]:54040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSCX0-0002eO-53
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSCWy-0007yb-Qn
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:26:06 -0400
Date: Mon, 11 Jun 2018 12:16:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180611021642.GE2737@umbus.fritz.box>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <20180611011501.10235-7-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v4 06/40] hw: Directly use "qemu/units.h"
 instead of "qemu/cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Alexander Graf <agraf@suse.de>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2018 at 10:14:27PM -0300, Philippe Mathieu-Daud=E9 wrote:
> These files don't use anything exposed by "qemu/cutils.h",
> simplify preprocessing including directly "qemu/units.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/arm/msf2-soc.c  | 2 +-
>  hw/arm/msf2-som.c  | 2 +-
>  hw/core/machine.c  | 2 +-
>  hw/display/sm501.c | 2 +-
>  hw/mips/boston.c   | 2 +-
>  hw/ppc/pnv.c       | 2 +-
>  hw/ppc/ppc440_uc.c | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 530e461c42..edb3ba824f 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -23,13 +23,13 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "hw/arm/arm.h"
>  #include "exec/address-spaces.h"
>  #include "hw/char/serial.h"
>  #include "hw/boards.h"
> -#include "qemu/cutils.h"
>  #include "hw/arm/msf2-soc.h"
>  #include "hw/misc/unimp.h"
> =20
> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
> index ed533bbde1..2432b5e935 100644
> --- a/hw/arm/msf2-som.c
> +++ b/hw/arm/msf2-som.c
> @@ -23,12 +23,12 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/boards.h"
>  #include "hw/arm/arm.h"
>  #include "exec/address-spaces.h"
> -#include "qemu/cutils.h"
>  #include "hw/arm/msf2-soc.h"
>  #include "cpu.h"
> =20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ccf3a4b9c7..2077328bcc 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -11,6 +11,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-common.h"
> @@ -19,7 +20,6 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "qemu/error-report.h"
> -#include "qemu/cutils.h"
>  #include "sysemu/qtest.h"
> =20
>  static char *machine_get_accel(Object *obj, Error **errp)
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 1c6c9445c5..bbb9274886 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -24,7 +24,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -#include "qemu/cutils.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 512c60c03e..b7bfeccf4c 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -18,6 +18,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu-common.h"
> =20
>  #include "exec/address-spaces.h"
> @@ -32,7 +33,6 @@
>  #include "hw/mips/cpudevs.h"
>  #include "hw/pci-host/xilinx-pcie.h"
>  #include "qapi/error.h"
> -#include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "chardev/char.h"
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index bdb6f63d2c..0df4a4fd74 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -18,6 +18,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
> @@ -31,7 +32,6 @@
>  #include "hw/ppc/pnv_core.h"
>  #include "hw/loader.h"
>  #include "exec/address-spaces.h"
> -#include "qemu/cutils.h"
>  #include "qapi/visitor.h"
>  #include "monitor/monitor.h"
>  #include "hw/intc/intc.h"
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index b5b31b4b9b..1ab2235f20 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -9,8 +9,8 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu-common.h"
> -#include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "cpu.h"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsd24oACgkQbDjKyiDZ
s5Ln1g//Y2NqOI+6mFTH/jXIvbRZ8BQI3ijwEd/4LOI55DqKcmxv9kOJOZ2SYu0A
NtpG1sIpfBBZAD53gYbp/1hcnVjNDTc7MnqosQcNNeJaAM8nAIpP82rGqFrHaVgu
RQpu4B+H57NoC4veqQy6gVZjscRLBAPNNo7QwvPRSE5rgnrPahRf6ADeFsodKgOS
rmdpbKY4aL3uwU8jFIg32D6NeAWk/+/JcLKrVoeveOHZjm2qWWgtuCvyuy0ag96s
p1rjoJV+eb+ySG2fbLwOtvmCLAKzohByVLKNEK7Lmc5l9d+F5mQnk1DfXBlp/og6
w/XayDbtiNic9+mpRsGxTH3GQf9NTDIwD2e9OcrDeb7kNDa3w7P5q1qSJVe1GgEZ
aY1KbS4GEMOCndLX3YcAD94BLJMMzyl+vmmF6ibag0kKSvgNLvK2ht61S61IqpmT
9Y9IPXduQKBa7iwT+PHnljmHgHt/nkb6v66bRqxZFQFNodEx9+yW62BE2CUjMZlW
yISo9VKfxV/5h+mOrj3X3JRt2hmtYrvnr54YvUr+QGawCfbcJu3ir2huxEjahM8Z
9gxffm63KHn7zN6acf4GqGaV8jQ++s4Z0eem5BqA+F+Zl5jPw1s6r+nv1D7dcMK/
oTQtNUenrAtG/2P8PeylEzPn3YmjY6PPGySH5cYlnnpHFTOLxqI=
=GKJu
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
