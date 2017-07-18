Received: from eggs.gnu.org ([2001:4830:134:3::10]:53649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXJLB-0008IZ-AE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXJL7-0007hO-I9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:38:29 -0400
Date: Tue, 18 Jul 2017 13:33:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170718033301.GA2756@umbus.fritz.box>
References: <20170718020033.8819-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20170718020033.8819-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] spapr_pci: Fix obsolete comment about
 MSIX encoding in addr/data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 12:00:33PM +1000, Alexey Kardashevskiy wrote:
> f1c2dc7c866a "spapr-pci: rework MSI/MSIX" (07/2013) changed MSIX encoding
> but forgot to change the comment so this changes it.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-2.10, thanks.

> ---
>  hw/ppc/spapr_pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index a52dcf8ec0..4b895c5a2a 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -723,9 +723,7 @@ static PCIINTxRoute spapr_route_intx_pin_to_irq(void =
*opaque, int pin)
>  /*
>   * MSI/MSIX memory region implementation.
>   * The handler handles both MSI and MSIX.
> - * For MSI-X, the vector number is encoded as a part of the address,
> - * data is set to 0.
> - * For MSI, the vector number is encoded in least bits in data.
> + * The vector number is encoded in least bits in data.
>   */
>  static void spapr_msi_write(void *opaque, hwaddr addr,
>                              uint64_t data, unsigned size)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlltgWsACgkQbDjKyiDZ
s5I6zw/9HCcwN7xvBGKwYke0SEpAJAqmwWF25MfTjXcaQEjTqnpklmW5nGAzkhfw
8B4vI6oZNpnFWXmvlkbUbYMfuiMAEXi7x9D3V7HGtLWskfEYVD1J5Him7FyTwDzK
A9pV4eRwNpkehy37lMbrlzO/bZXRlakt1te8EN9UxevAgMvvBddfRwXrPOKJ8MiE
+0yt0hKVDV/wuQ+tgAGHeTL/JP/HH0oUKvWjdH2b4BJj9hMU4QCeziSfT/ocrLkO
/SG5ozDBcId+vv26dDJW/yQC5akEOSUeIJ63RadruIDTkbq7rAGlDGBvCu1ATuSO
7DVhuBaQTRyGsK2pQmzZEja/OG4preVMZ7G7hX8KTvTaTe1KKu/emeB/UWKTIbJ8
Hv+HMH8fr15HhpDyq0LqaJnsZ40SAOm49g9DATShNtTLtvrVMOKy+CMlc7svi14W
phgzw9aOmt9dNJxsJFcDqtl3BOl1WxPuWG9xh4r1Z+4j+AFUgixdkSM+nYtJ3F1J
4SL4v4AjaGTeimhscPbtSqxYmHQm4LdpgXWjBNJhtop1TuoupJEc8yvwWWwGIrbV
eJxEKeVcYaePoXMytJfdGJDdljM4Xr8pY42EET4LsGu0Pb5TQieI2KVhpfu7LDGy
Zc7Ryqylqt2NooZs41uI73mhzuBE+tLA9XekpJ16xKO2mUcPSsc=
=L6oF
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
