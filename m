Received: from eggs.gnu.org ([209.51.188.92]:46512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnh-0003wg-Tz
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnT-0005Dv-Ls
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:55:50 -0500
Date: Thu, 28 Feb 2019 11:56:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190228005647.GC7734@umbus.fritz.box>
References: <20190227085149.38596-1-aik@ozlabs.ru>
	<20190227085149.38596-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20190227085149.38596-2-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3 1/6] pci: Move NVIDIA vendor id to
 the rest of ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 07:51:44PM +1100, Alexey Kardashevskiy wrote:
> sPAPR code will use it too so move it from VFIO to the common code.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Not technically my purview, but since it's to enable the rest of this
series, I've applied it to ppc-for-4.0.

> ---
>  include/hw/pci/pci_ids.h | 2 ++
>  hw/vfio/pci-quirks.c     | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index eeb3301..0abe27a 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -271,4 +271,6 @@
> =20
>  #define PCI_VENDOR_ID_SYNOPSYS           0x16C3
> =20
> +#define PCI_VENDOR_ID_NVIDIA             0x10de
> +
>  #endif
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index eae31c7..40a1200 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -526,8 +526,6 @@ static void vfio_probe_ati_bar2_quirk(VFIOPCIDevice *=
vdev, int nr)
>   * note it for future reference.
>   */
> =20
> -#define PCI_VENDOR_ID_NVIDIA                    0x10de
> -
>  /*
>   * Nvidia has several different methods to get to config space, the
>   * nouveu project has several of these documented here:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3Mc0ACgkQbDjKyiDZ
s5IGOxAAy/fNMrBjoU6kFkgEvztr7wd4A9geYVlLfPcsFYxtMHjAVKexWSSfOhNL
bi/RC4ob+765lwfqkbR2ZIdYNaHoTIQksXCqPWx0yY0GQCOE714F4usnTx9UzjDM
yW5+/M5jlb8ySl2mvCfLDAErRV8dSJZ7wuNI2UAbyCEIKVEBEjy4K2NSEsj+c7ph
NnbYVPZTJOYNS01UHev7nGs2/h/iZnH6ZOiVlRDKwLiolUMY4IhYNPQxlsKcQ8UM
kSJ32HfFaevi8IMVZ6mqjG+/pm3SkI6vVgu/fPD5vUhMG/8l4YYya2R2dRaPhRf5
n4J0pIr69qNz9D6sgkZCQu+28N5SwmjWwmjfu8im2bq9emdHoofwObfUtzjhCHaM
O2NWOIYNJ13hLbKRPIp+kp+smTa2iZG959DQfz6dEeQTtCA0ShUMjCYxCs0pB7v4
oEEXcrcRUWsyM6z+N5ts8QRHue7GznYtJB9fcTEuQgbAqgmM0pX9+uWnbKpIjx5C
KxPUfGVGkD5OBqh/nZZLlzKxkQmIxiCOZ1XDr9+DPrR1QseFT7nd5iT10/BLWnpX
Mv0cndlmMEA4mXJRA0txuaBr636FjMRPp+Y9qY6cRHjG5EUtOsnEGVZNcEZea6Ou
9r15ALnGF7rBc2TvuGBDv/C85/uO3ORATmbt2JT0o2t4LTWdVoI=
=s2qV
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
