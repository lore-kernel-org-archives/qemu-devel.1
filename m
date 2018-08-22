Received: from eggs.gnu.org ([2001:4830:134:3::10]:41987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOU9-0007dq-MK
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOU2-0002LK-3a
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:25 -0400
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-7-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <9088c265-475e-a10a-0e7f-ad68525d628b@greensocs.com>
Date: Wed, 22 Aug 2018 10:26:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180821132811.17675-7-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QoGn91AGytkeeo8pSL6cYLzF9KZOWsK9G"
Subject: Re: [Qemu-devel] [PATCH 6/9] hw/arm/fsl-imx6ul: Connect VIRQ and
 VFIQ
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
--QoGn91AGytkeeo8pSL6cYLzF9KZOWsK9G
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <9088c265-475e-a10a-0e7f-ad68525d628b@greensocs.com>
Subject: Re: [PATCH 6/9] hw/arm/fsl-imx6ul: Connect VIRQ and VFIQ
References: <20180821132811.17675-1-peter.maydell@linaro.org>
 <20180821132811.17675-7-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-7-peter.maydell@linaro.org>
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
>  hw/arm/fsl-imx7.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index d5e26855a55..7663ad68610 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -209,6 +209,10 @@ static void fsl_imx7_realize(DeviceState *dev, Err=
or **errp)
>          sysbus_connect_irq(sbd, i, irq);
>          irq =3D qdev_get_gpio_in(d, ARM_CPU_FIQ);
>          sysbus_connect_irq(sbd, i + smp_cpus, irq);
> +        irq =3D qdev_get_gpio_in(d, ARM_CPU_VIRQ);
> +        sysbus_connect_irq(sbd, i + 2 * smp_cpus, irq);
> +        irq =3D qdev_get_gpio_in(d, ARM_CPU_VFIQ);
> +        sysbus_connect_irq(sbd, i + 3 * smp_cpus, irq);
>      }
> =20
>      /*
>=20


--QoGn91AGytkeeo8pSL6cYLzF9KZOWsK9G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9Hk0ACgkQd8knW3Qn
Tr6Xzw/7BJWnXiK1IAwb1HZtMkkSjOvsjffWk15GXut7FsvioLBQAQiLvQQq6swn
Ng1gYP6mxesnOMuQiEgRXog+/+lUfg+jfd79jQ6MKIGi3KrO4RhZoLLJd7pprtYc
UBrhD9+rdGzp48Z33BAY3bf93ygIU40MUuv1IDexS3jlVRNOgv+5Mv4awVEhOPED
EmDvQMnucu79fvkX0tT/GACZ5n1U9swWfjtaugMUjNJreqMAIyRrGACTpmd/wAcK
xKDwlEKyDjLPGclVzuAGUvGJLHfhKixTtISlccg4p/7S9iC+SI87PP5vxaNaXtAW
by3dk2FWS0jElKi5p5W/i9p2AMy/rJrknPSC1aCkxybg4WJR0ZV5YaIrXvDV+dEG
i3WBwCzSJep7FqgLdAtHSAN68/VOGdcCWo0ohAXvo/9GoIorcimmPkyPmz5gR2nA
yesLaoTXaIOR/Cf22w8AEKYtK3S+KkjOiyBp2Jde6fXvh0pBca2sjS+xuD51U78O
1+F15TUQln3wDP4c/OLU6DOLTUxBQAn57RcKeoZV6kXfcHTe/P06cR1SQXYhW4tf
A5bMcHT2NspCGW6DkIWjbRndYqMKgGh2ufZTEkJDTkrG/fjtJkMnkfRMirNDo+2O
0MXATBfnb39VrgawW7V3Uf7Jy4fLH0yvBFJqba1whNHcNzQxjZQ=
=rtBk
-----END PGP SIGNATURE-----

--QoGn91AGytkeeo8pSL6cYLzF9KZOWsK9G--
