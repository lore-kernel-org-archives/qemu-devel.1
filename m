Received: from eggs.gnu.org ([2001:4830:134:3::10]:52587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cyVgm-0002RC-MJ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 23:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cyVgl-0005vq-O0
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 23:44:56 -0400
Date: Thu, 13 Apr 2017 12:54:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170413025422.GA14531@umbus.fritz.box>
References: <1491984907-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <1491984907-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr-cpu-core: Release ICPState object
 during CPU unrealization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 01:45:07PM +0530, Bharata B Rao wrote:
> Recent commits that re-organized ICPState object missed to destroy
> the object when CPU is unrealized. Fix this so that CPU unplug
> doesn't abort QEMU.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Applied to ppc-for-2.10, thanks.

> ---
>  hw/ppc/spapr_cpu_core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 2e689b5..4389ef4 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -127,6 +127,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *d=
ev, Error **errp)
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
>          spapr_cpu_destroy(cpu);
> +        object_unparent(cpu->intc);
>          cpu_remove_sync(cs);
>          object_unparent(obj);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7uhaAAoJEGw4ysog2bOS6UEP/0KBtIIY5y1VoYBpJAzB9X1I
HhuUe+DqJqQSy1Xcn/YfCqFC0eTRgMMW+Jwl7uVlHEfHyYgGxaQ1P9HG/OvsSo5Q
XaLaO60A8/AeBmM8jEZ2nJNvKf/LNP+KAFewttGhVmPrAlzQBtKBa+ZtJ11+4PP/
xuLnw3NUNr5owZ3bv2azDZbV4U27+JgicWyOssa3UIwd/d4MSd/zdMrh/hoUXBn/
/yISjOly7wV4P49kjv5EibZa4saNIxaxk15YI4mbyT0oG7mVwEkvBss6u7LNSR5B
59kvq6PvG272+jiTWDn/FfXfWHRHg3ZFphK4GfKE/j0N9EhvanjnFvbySHi5u9e4
LJqMUULOsXgSos754IeGlSklcrWBKNzRgi5zVox/NYyeexTqrYoTQ8bmbgJPRbsX
tp2PcITMNT8xCMS7zMuEKMG4GMmYLwuTpGHMtGMR5R3vmFAinm5o1N96X2Ozf1BB
Z8ieTNVZTkeeBHD3swKcTiwyLEuZtrnELgGpDLoeV+pF1tJF16iWtRVr3DK6MHi6
si0IFHAoU1MGXBYRZEhlCRdPiCUSz88ZyRZGkG+S/HFEDldREXOUrZSL1inQ2C95
HdBeIoiWC7VgaxYBLcXCIWELzdlZ9L9420SKCIVVy46/MJFLg5+6PyDOFfIKQuWe
UzCdGaA+lNMqhjAbp/r3
=pkdK
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
