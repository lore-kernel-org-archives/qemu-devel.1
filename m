Received: from eggs.gnu.org ([2001:4830:134:3::10]:40293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOv-0002ns-Jk
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOu-0002QQ-DW
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:13 -0400
Date: Tue, 12 Jun 2018 11:12:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612011234.GQ2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wr1Q/2bz0MCWWNYv"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-9-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 08/11] pc-dimm: get_memory_region() will
 never return a NULL pointer
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


--wr1Q/2bz0MCWWNYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:52PM +0200, David Hildenbrand wrote:
> This is guaranteed by passing into host_memory_backend_get_memory() a
> value that is not NULL - which is what we always do.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/pc-dimm.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 7bb6ce509c..9a0da5d441 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -157,7 +157,6 @@ static void pc_dimm_get_size(Object *obj, Visitor *v,=
 const char *name,
>                               void *opaque, Error **errp)
>  {
>      uint64_t value;
> -    MemoryRegion *mr;
>      PCDIMMDevice *dimm =3D PC_DIMM(obj);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(obj);
> =20
> @@ -167,11 +166,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v=
, const char *name,
>          return;
>      }
> =20
> -    mr =3D ddc->get_memory_region(dimm);
> -    if (!mr) {
> -        return;
> -    }
> -    value =3D memory_region_size(mr);
> +    value =3D memory_region_size(ddc->get_memory_region(dimm));
> =20
>      visit_type_uint64(v, name, &value, errp);
>  }
> @@ -241,14 +236,8 @@ static uint64_t pc_dimm_md_get_region_size(const Mem=
oryDeviceState *md)
>      /* dropping const here is fine as we don't touch the memory region */
>      PCDIMMDevice *dimm =3D PC_DIMM(md);
>      const PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(md);
> -    MemoryRegion *mr;
> -
> -    mr =3D ddc->get_memory_region(dimm);
> -    if (!mr) {
> -        return 0;
> -    }
> =20
> -    return memory_region_size(mr);
> +    return memory_region_size(ddc->get_memory_region(dimm));
>  }
> =20
>  static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wr1Q/2bz0MCWWNYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfHgEACgkQbDjKyiDZ
s5KaFhAAqEYJrVqd6GKZU9JHivf0jUBbRMdkKu+vijIUd0EA6zGsceVd7zxR19oM
bw0XTM0Z56bVtJ58qWlkYBFJ3GWF/XY2A8rXlGvIhyvIx+vy6h+Yk78fkyFujSY1
GbyH3jgHSwG416PYlgF065+4XpK/mpUse66Yrg/q1/oXEZTc6YjBbHgURraAbghy
Mr9UiN0bMj0CQhAmX1aWxrr7IwPD7+a7yMFR6ICjLs/hecN1vuqNuRYd2pQsBGwT
xxgfifGwLLpZxVMIInPuZtAzlG/+rKwxukbgCAApJwixc23meGZTr2ynCFJOZgyG
wUD1xNNk5rHfk+fnwYdClmNPUivbS+wTJrATKWwKN0EV8XvEUIWBb09pxLNf+wRj
8EZoUchcRH8rGu+PBtJsHVtGi2C845zERSB3h5vOQ0NXxfDQPsIQw41q5jsEzuqL
/+9IphbK5VLWDwnKcGf2zYcGCMNVBzHCKgvuWK400uhCPsasXV3lHWepygACXJoX
9WN/l7Ar/U00qkQ2jaYD34d2m2w2+XEDxYg6ZZj0FE/OhTgVqO+b6lrGTiUta/jb
tIA5bUjdWKOvUMw33Y/10zsCO3i6dNQLT2jRP5kqSsmePfntyUCqZGZ9kRmd+2R7
2w3oUR8xF1HYJLDJQQyDLrgwnmrhAoRp+iOVo05KK9B2urmnJJQ=
=/viU
-----END PGP SIGNATURE-----

--wr1Q/2bz0MCWWNYv--
