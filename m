Received: from eggs.gnu.org ([2001:4830:134:3::10]:41690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOTM-0006vE-4t
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOTK-0001wv-He
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:26:35 -0400
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-4-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <e31f0f76-888c-d2ed-9e2a-b00dff2f60b7@greensocs.com>
Date: Wed, 22 Aug 2018 10:26:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180821132811.17675-4-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lhKe1mfNMRmvFe62sUmPpklSqHXlBieuJ"
Subject: Re: [Qemu-devel] [PATCH 3/9] hw/arm/vexpress: Connect VIRQ and VFIQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lhKe1mfNMRmvFe62sUmPpklSqHXlBieuJ
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <e31f0f76-888c-d2ed-9e2a-b00dff2f60b7@greensocs.com>
Subject: Re: [PATCH 3/9] hw/arm/vexpress: Connect VIRQ and VFIQ
References: <20180821132811.17675-1-peter.maydell@linaro.org>
 <20180821132811.17675-4-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/21/18 3:28 PM, Peter Maydell wrote:
> Connect the VIRQ and VFIQ lines from the GIC to the CPU;
> these exist always for both CPU and GIC whether the
> virtualization extensions are enabled or not, so we
> can just unconditionally connect them.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/vexpress.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 5bfe2e43487..dc47ed84c20 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -251,6 +251,10 @@ static void init_cpus(const char *cpu_type, const =
char *privdev,
>          sysbus_connect_irq(busdev, n, qdev_get_gpio_in(cpudev, ARM_CPU=
_IRQ));
>          sysbus_connect_irq(busdev, n + smp_cpus,
>                             qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> +        sysbus_connect_irq(busdev, n + 2 * smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> +        sysbus_connect_irq(busdev, n + 3 * smp_cpus,
> +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
>      }
>  }
> =20
>=20


--lhKe1mfNMRmvFe62sUmPpklSqHXlBieuJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9HiwACgkQd8knW3Qn
Tr708w//bqlKb4V4zARkgA5EYV9FR61RfwEF2N2hCjoWEDyIfZfhyRGUZWZk2NHh
3aAVRuK6Yd2dzq2258AfOuJ0YLuLg1ZObpJF3KfYOCIctgY8IOJIpb601Q0bIJdG
o1zE5xmzWoyYJIssuTIqTfIqPvW2nHXt6mLf0OAaU/KdIehG/vYF+Pxv/Ix46bvl
9M5RxWOEUJ4B9w/PiOzmJm3d2Houq18THS0Lf6KjCtJgqsd9DQti7uR6ZQmaDFsJ
rfYWZIrm0IqunuRddhef4hhtPTeQ8ccGwJuyBXfCrdiY345sznSrEy28C+lFpIxG
ShISijkvpN4HbKv3RrBB1i+7rXEwf4PQ673LATIxZgKsnHoxstQCmnrLHtADojHM
sf1Y2c33p1d/uYl/NXRzD2xpR47ZdVqZRMJo9jIJ3rqfWMsSW2cDmEIeIQrFiZom
M2b7tXjzUqY6TYJhzTjZGtbzFO6xQ7XB6RL8S40IqKi5E4jk0UKpia6Kbp/uEWjj
QaTUKSBVqwrFriPChGTJH1AuUOkKU75DAThnCdFbFINL/p0cM88S7Wq6MdjWRcn6
AIhVGb/tbSuiJ3Zm1TK7uxwfU2T3peX/Fwxq//1xddL8Oc0kTd2AiOf5j7mswApl
PgLmTw8pVYmB9mLdsIXyOkCPoQg2KNld7fcrYKIjUVuPrmo4JEo=
=dLvx
-----END PGP SIGNATURE-----

--lhKe1mfNMRmvFe62sUmPpklSqHXlBieuJ--
