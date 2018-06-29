Received: from eggs.gnu.org ([2001:4830:134:3::10]:51278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYi4j-0004nB-Ec
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYi4f-0007lt-3v
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:19:49 -0400
Date: Fri, 29 Jun 2018 11:16:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629011655.GI23134@umbus.fritz.box>
References: <20180628121417.1980-1-david@redhat.com>
	<20180628121417.1980-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline
In-Reply-To: <20180628121417.1980-4-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] pc: drop memory region alignment
 check for 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 02:14:16PM +0200, David Hildenbrand wrote:
> All applicable memory regions always have an alignment > 0. All memory
> backends result in file_ram_alloc() or qemu_anon_ram_alloc() getting
> called, setting the alignment to > 0.
>=20
> So a PCDIMM memory region always has an alignment > 0. NVDIMM copy the
> alignment of the original memory memory region into the handcrafted memory
> region that will be used at this place.
>=20
> So the check for 0 can be dropped and we can reduce the special
> handling.
>=20
> Dropping this check makes factoring out of alignment handling easier as
> compat handling only has to look at pcmc->enforce_aligned_dimm and not
> care about the alignment of the memory region.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bf986baf91..934b7155b1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1712,7 +1712,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_=
dev,
>      uint64_t align =3D TARGET_PAGE_SIZE;
>      bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> =20
> -    if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
> +    if (pcmc->enforce_aligned_dimm) {
>          align =3D memory_region_get_alignment(mr);
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1iIcACgkQbDjKyiDZ
s5L/FA/+JGntXq+Hz1bVucMPjWyhgi0OTODfaQpXbTIV/ST+W7SF7ooDp3d5ajQY
rzXcyDqwejfYWN6HBI0j/rm+04rkxupfCWNcHMt32jBOiLYrYoacL80jrEdKiB7O
xKrzsU5JxPaxXP7Hcjg2sD8C5QGG7S38stDTWfJq4QhJsi+wrqiXOn1fWZxZVlKP
cEVAtJ3XFveYz6VPjv92YAujh3aKE4NVsw5H1uYHaBzl947bcmCx29p57g022UVX
ycFHTayAF2hE8Yu7s5+dQFnur2/vegH1FOJa1lCwFBjQip3ShV2pDhiPa94uXmur
mi0VwM/dhamnjmOy8VpLyAzDPZP4qqFVk9B8OSG8lZJDSxgk7iVSfC+txXg052tn
SrucKYTzhIYU69V2uVDommBU2X8vwU9I2qGcE9DUBqjWY7r3k5DGTI3+psZ4b6j/
Q3xM02Sf4HPCfYu0V0AX0q1cnQcdqftcIkrOYjzw7dCxoJAI7H6GCjEZ/AeWqM1n
2WRbxl+CtfESNyd4lEfE4syAn0aIA22dW+c2rvlT3SjPVaesDHRz3+cyKomq1j/f
J0YybEOS2hgUA4hvN/3ValFqog+1r3dL/kMWrfcCZF99Rxy87K6tXmfhA/a5jHi0
6n5W+SfSANTbOw4hRhs0Rq1K8dTqug/fka7VIxfKyb1F7mve9no=
=yFnn
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--
