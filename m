Received: from eggs.gnu.org ([2001:4830:134:3::10]:34085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpG-0005va-1r
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpF-0002Fh-4J
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:14 -0500
Date: Mon, 19 Nov 2018 12:46:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181119014615.GD23503@umbus>
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <20181113083104.2692-4-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu RFC 3/7] pci: Move NVIDIA vendor id to
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:31:00PM +1100, Alexey Kardashevskiy wrote:
> sPAPR code will use it too so move it from VFIO to the common code.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

This looks correct to me independent of the rest of the series.

> ---
>  include/hw/pci/pci_ids.h | 2 ++
>  hw/vfio/pci-quirks.c     | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 63acc72..3ed7d10 100644
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

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyFecACgkQbDjKyiDZ
s5IggBAAon/uqD+QUzh+foJZvLSxvyccPSVatPO/WVqSG+5/joLTz/lXlG8Qtt2c
61ky+AAb9/BO5hWlzBOqMjBB/pJfaR6Di+aDUGQgS+KcZxAwBf6qDUur9nR9J7LP
AciImPBa1ufAgrTwk0jWfq39IZeNXuVkiW0zI7F+rlLhQdt90GWzQQf7i0DTKA+p
+0XHSLj9A+4hgizDn3ETyISt7Kmtpdl4ZFZrONAg5a6JWFU2JxfWGSnBACnWUaBo
SC8UDdI+ZdJaUOfs/O5ukeC34oWFzzgtgQ0cH5FH+ExNhXtD1scfeQFvsS83vBVn
OHlhpm+kVcg2Q/bBCksHezYS2KSdmYiINgkPHiTzZVWFMBOOUx1fv2CFpTT9HZIc
QzvA9cG3qw+7l3BxHSd7NZZzgs6AhtsBF/wBKcRcLAC0zfppQmMU1cyizUGKt7CV
k/hspbrNh9o4m7R0EmrnfYXBLmvPcb3dk9z5lyWVAwcvJYoolpduEQ0zl38mALbS
irCrkQ832POcWbFZU70iYAQTsXkdVsCHMmHw41nDV1UmWa/U6MC3VTnE2dFshWWu
h2HaNqwCmU2RlXR6NM0VJzSATtkaSpQhFp9YdFIUNym1iQHlUfPey5TKJ3UakwIZ
SyLLrS2HuSe+/61cMyCLkNkyWpG9TQVeLNynIIuA2Gr/MkfagWw=
=s10G
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
