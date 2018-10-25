Received: from eggs.gnu.org ([2001:4830:134:3::10]:59609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFh5V-00034O-6s
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gFgus-0007sz-KD
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:20 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gFgur-0007hi-EN
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:18 -0400
Date: Thu, 25 Oct 2018 15:44:37 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181025144436.GE2697@umbus.hotspot.internet-for-guests.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <20181023152306.3123-7-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] memory-device: avoid overflows on
 very huge devices
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


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 05:23:05PM +0200, David Hildenbrand wrote:
> Should not be a problem right now, but it could theoretically happen
> in the future.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/memory-device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 996ad1490f..8be63c8032 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -85,7 +85,8 @@ static void memory_device_check_addable(MachineState *m=
s, uint64_t size,
> =20
>      /* will we exceed the total amount of memory specified */
>      memory_device_used_region_size(OBJECT(ms), &used_region_size);
> -    if (used_region_size + size > ms->maxram_size - ms->ram_size) {
> +    if (used_region_size + size < used_region_size ||
> +        used_region_size + size > ms->maxram_size - ms->ram_size) {
>          error_setg(errp, "not enough space, currently 0x%" PRIx64
>                     " in use of total space for memory devices 0x" RAM_AD=
DR_FMT,
>                     used_region_size, ms->maxram_size - ms->ram_size);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvR1tQACgkQbDjKyiDZ
s5JqoA//V9fKXSheOiVCXfZg2rMFZSQiOT2CSiPgCiDqQifym9Gu0xxT5V/ny+zr
FlPIcu0SNNYR0r0YyL6rbnxT9xxfWTITbXWJnvBDXxGYVA9f5+3CbnYBzSh6rSwB
nHjUruw10ba7M/ExRJmFOeB6o+YVpRmOALsTka4yhi/IKFYteDP8Jg/eC2+3sH8E
VxvERKUUgQRWbHlWx70vmsoSeedxkx0BzA9odXE5sKQbPyEq2RSgBUhPlZo/i5gd
FbdxZv+ob5MKIzwbGAi+Im7z8KMRKoke0GhOLVlbJRBv5MUnzVcnCUgiXlMCbefF
BO75UObQ0TV2e2eii19ncVNPwNH5ulfT21TpX1hV9GWZRBXX1jMyEvsvXdDMJAfg
c0av1hiY9cFiTImP4OYR3k7b5P4nj9E9xu367Q0k+O09ryWEQj7KzHD4X0o98ogD
c8u+w1l6cGu9SqRTkgJ8dia8Oi1dNnSPpbQ16YLe7wyrC8Zh/pl7QzDG4r+cJdch
aMRFCzZrQHDYFnvF1EpXeA2Cwcpf79BZsRGD6mcoBobcIjqHLkS06E/k0OYkJmM0
eghqp0u/3XD29mC1AZrQetlnRjIC/uZf3rOzP/z7vrik0hSh76Byk4So/DXNbt5U
JYPa3/u6B69XVuItau/hHU2rYGLWiG4kVnG8tz56sph7J5FWqrw=
=nRgD
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
