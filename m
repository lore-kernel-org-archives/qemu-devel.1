Received: from eggs.gnu.org ([2001:4830:134:3::10]:54455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSX9e-0006qb-Kd
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSX9d-0002qW-Qx
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:27:22 -0400
Date: Tue, 12 Jun 2018 10:22:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612002247.GK2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bX/mw5riLlTkt+Gv"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-3-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 02/11] nvdimm: no need to overwrite
 get_vmstate_memory_region()
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


--bX/mw5riLlTkt+Gv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:46PM +0200, David Hildenbrand wrote:
> Our parent class (PC_DIMM) provides exactly the same function.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/nvdimm.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 4087aca25e..f974accbdd 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -166,11 +166,6 @@ static void nvdimm_write_label_data(NVDIMMDevice *nv=
dimm, const void *buf,
>      memory_region_set_dirty(mr, backend_offset, size);
>  }
> =20
> -static MemoryRegion *nvdimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
> -{
> -    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
> -}
> -
>  static void nvdimm_class_init(ObjectClass *oc, void *data)
>  {
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_CLASS(oc);
> @@ -178,7 +173,6 @@ static void nvdimm_class_init(ObjectClass *oc, void *=
data)
> =20
>      ddc->realize =3D nvdimm_realize;
>      ddc->get_memory_region =3D nvdimm_get_memory_region;
> -    ddc->get_vmstate_memory_region =3D nvdimm_get_vmstate_memory_region;
> =20
>      nvc->read_label_data =3D nvdimm_read_label_data;
>      nvc->write_label_data =3D nvdimm_write_label_data;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bX/mw5riLlTkt+Gv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfElcACgkQbDjKyiDZ
s5JX4xAApkfGhWkR5DNhYaoHXnLXUMwHDfd2alBBPlT9ouKaAuvcPZDFaHbNeCbt
oLAqGdgubkCRCdUMtqae33o1YqDx1fO4UJK85UMTVqLz66F4tqx7SSRYlaIfzqsX
NR8oyc8nRJJqbjx4+nMX+I+Im7RzimETOPD4W7WyvmzUYN/8WnZePXgkPl2T02jU
z+4vsqEuUwxJZGylHa05Axwvt9FYJVpLMhCVCzQF++roY8EKSDJMCimYIUFA8hXj
G/RFDafUU4Rc0/QNmgPXyBuL880kjaH34/MFGCDev6WAOoKyQip8XPag/e/ZcVQ0
MHuDafrr5c4widoun5m7tnBqWMBS+2s23MMbfWHxa1DnStjbqm7fhtoJlxnuWM2R
5Phwym1lpBJbib32qjB6NlgmQmSupk7bWvHA6hXZE42kB7sA+zMYPf1WaTPWWPxe
dLPwrri0zrq8PtE80TNRZUi71pTfHnGGOFKdmX4GrXj3jlttvEhErDpHNjap2Cfb
QZ0pE7ARQC514s9UatY1NiOhrkJTyI5Fw8Pg7FKmj0AbkN7p3tB/ft+EArtgp4B3
BNRI5jHcTY9rAICfPlDosBRGw8wLkCQ8nxxrHptgVZwAqQqEmCa0HS4Zp/kGip1H
fxszjr2o0MPq+dcnrW9kTTjcNEC6FjeqpzmRtOPhrKAyjVa69i4=
=hFW1
-----END PGP SIGNATURE-----

--bX/mw5riLlTkt+Gv--
