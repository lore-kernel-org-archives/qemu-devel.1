Received: from eggs.gnu.org ([2001:4830:134:3::10]:40237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOs-0002lU-Cj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOr-0002O0-5l
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:10 -0400
Date: Tue, 12 Jun 2018 11:29:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612012905.GR2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PY8tzLeNxmyMVNR3"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-10-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 09/11] pc-dimm: remove
 pc_dimm_get_vmstate_memory_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>


--PY8tzLeNxmyMVNR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:53PM +0200, David Hildenbrand wrote:
> We can reuse pc_dimm_get_memory_region() now, as both functions are
> (besides the assert which is also correct), equal.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/pc-dimm.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 9a0da5d441..bc79dd04d8 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -219,11 +219,6 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIM=
MDevice *dimm)
>      return host_memory_backend_get_memory(dimm->hostmem);
>  }
> =20
> -static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dim=
m)
> -{
> -    return host_memory_backend_get_memory(dimm->hostmem);
> -}
> -
>  static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
>  {
>      const PCDIMMDevice *dimm =3D PC_DIMM(md);
> @@ -282,7 +277,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void =
*data)
>      dc->desc =3D "DIMM memory module";
> =20
>      ddc->get_memory_region =3D pc_dimm_get_memory_region;
> -    ddc->get_vmstate_memory_region =3D pc_dimm_get_vmstate_memory_region;
> +    ddc->get_vmstate_memory_region =3D pc_dimm_get_memory_region;
> =20
>      mdc->get_addr =3D pc_dimm_md_get_addr;
>      /* for a dimm plugged_size =3D=3D region_size */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PY8tzLeNxmyMVNR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfId8ACgkQbDjKyiDZ
s5LEHA/+OahJ4tN/LrCE7Bix7C4QSmVhyNF6aE1gz6mbv80ZcZGms2RDDLYg6DW2
bkc9xMzW8rqqAmQjrmUVK7fQziTkvNWTCCzZ7OHjMRBBZdKIz8Z+PNG+8DjvnVQU
qxr+MH9JTcUdGdirJpDjmE+4WJfF8HTIWRVq5G6n+pP4lU3bQBzcyqEWekLhgxgO
rikH7n6t44C8Ti3awUKbHCRQxOeg1TRHwcTLKJq9VHcne3lA2YVyH+hocAcGDdjh
Ur0z3kjAQBCZMRMc0iThvjODX9s6qRmlOApLjlWqYFoC2njPI6LNq0uJ+eD9ql+V
QMgLICNqWQ1DaY2QK1xRnvL3UeTRZoK8LPTLM44IM0eWdsJuXWQDBc+TE1lOHass
ro3GpF+HhzLtc/g8X2jtut6egh9doeb+aadscFJyfpaBQhzZIoZgIqFISdPf2uqk
2KUNFrxr4dmgB3QrmbsX6taKr32cxiiGPKF8nCNITjW6liPAk5XOiIGqTF5blLHN
ty3JB9jC32eAAXcHVXDy59Fke6V87KzMnIm6cixHwHGuMGFVocTMDbaQPbv8nHjx
XpfVO101ssWSleEYGVtg51YUB2Rkg22+NVy2QIXrxQXNbVB3BG71gXST+MvZvyJw
8mFNTaI4zaGK23oGlaOULEHK92ea58eVKMJ9b4FHCyPa9d39oF0=
=eQPo
-----END PGP SIGNATURE-----

--PY8tzLeNxmyMVNR3--
