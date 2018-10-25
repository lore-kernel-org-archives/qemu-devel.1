Received: from eggs.gnu.org ([2001:4830:134:3::10]:59966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFh5S-0003lE-Oy
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFgus-0007t7-LF
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:21 -0400
Received: from ozlabs.org ([203.11.71.1]:52863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gFgur-0007hf-EJ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:18 -0400
Date: Thu, 25 Oct 2018 15:44:02 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181025144402.GD2697@umbus.hotspot.internet-for-guests.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20181023152306.3123-6-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] memory-device: use QEMU_IS_ALIGNED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 05:23:04PM +0200, David Hildenbrand wrote:
> Shorter and easier to read.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/memory-device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 7de1ccd497..996ad1490f 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -120,7 +120,7 @@ static uint64_t memory_device_get_free_addr(MachineSt=
ate *ms,
>      g_assert(address_space_end >=3D address_space_start);
> =20
>      /* address_space_start indicates the maximum alignment we expect */
> -    if (QEMU_ALIGN_UP(address_space_start, align) !=3D address_space_sta=
rt) {
> +    if (!QEMU_IS_ALIGNED(address_space_start, align)) {
>          error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported=
",
>                     align);
>          return 0;
> @@ -131,13 +131,13 @@ static uint64_t memory_device_get_free_addr(Machine=
State *ms,
>          return 0;
>      }
> =20
> -    if (hint && QEMU_ALIGN_UP(*hint, align) !=3D *hint) {
> +    if (hint && !QEMU_IS_ALIGNED(*hint, align)) {
>          error_setg(errp, "address must be aligned to 0x%" PRIx64 " bytes=
",
>                     align);
>          return 0;
>      }
> =20
> -    if (QEMU_ALIGN_UP(size, align) !=3D size) {
> +    if (!QEMU_IS_ALIGNED(size, align)) {
>          error_setg(errp, "backend memory size must be multiple of 0x%"
>                     PRIx64, align);
>          return 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvR1rIACgkQbDjKyiDZ
s5Jkiw/+Nys83qQDcAn43RhiHj9rZzthu+7ujI4w8aAAWLcY9stnXYhDQw1XkKCs
8/MBj3U9I4N2C8sHjvBK4am/KbmfNRw+v6uAqj6yC32ylhKKGdTRd+vcV1MRXXOp
jNl//S7ETteOLImEKESjZOQg8yFyKoLDXqmwt0wGsCNZ5rLJWfkOWmuOxgXbJafb
tH4UQPBS+RyjCa4K9VtayloK9q37XqO/7S4XIbDpk+VIl2id9LzpUV/WBYOOhStF
ZbhSUUPY7sUnusEMSlsKavtk2L9ZC8UmKaEUNz3lELIkxfhJVn8w8V8DayQRRz4c
sVzd3BQlzq/8oYyVrkd8tSwOZ3hvKQzpnKW8RezUmicDoJgZVWVnWM0NCG4geAAe
WGX6V3iCP+wnTl5nXJpO8JA67nIbEjsemlemaxOmwb3/Yrv66ILLYQRCaykYvo4T
IeUke2XBv+fzKafE3FgeuKaH4TDUamPcSUwGXIsHtdDiHN5ePrcOcAhXxey8k/Tt
0fustI8xDmGRAuC7atumFGtRoBfdN/3edCa8EbyvvH2xQYQUWZRqFr9YBR7PF5io
XN8EJtCBNeP0gBa5Z+ZSZgqsLoG54wLVAa5bO6/9l9N0P98mVNr5P/DsCo5AqP6c
NTTXprGoB6HAdJRm8ucjTXRT1KZ/BU1b8DK6Q7zlwwx6QlsXAGY=
=l5nl
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
