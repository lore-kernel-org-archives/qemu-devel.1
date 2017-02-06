Received: from eggs.gnu.org ([2001:4830:134:3::10]:35325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHM-0004dF-40
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHI-00008A-14
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:40 -0500
Received: from ozlabs.org ([103.22.144.67]:45793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1caYHH-00007t-L6
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:35 -0500
Date: Mon, 6 Feb 2017 12:27:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170206012741.GC17644@umbus.fritz.box>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <1486110164-13797-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 01/18] vfio: trace map/unmap for notify
 as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2017 at 04:22:27PM +0800, Peter Xu wrote:
> We traces its range, but we don't know whether it's a MAP/UNMAP. Let's
> dump it as well.
>=20
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/vfio/common.c     | 3 ++-
>  hw/vfio/trace-events | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 801578b..174f351 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -305,7 +305,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, I=
OMMUTLBEntry *iotlb)
>      void *vaddr;
>      int ret;
> =20
> -    trace_vfio_iommu_map_notify(iova, iova + iotlb->addr_mask);
> +    trace_vfio_iommu_map_notify(iotlb->perm =3D=3D IOMMU_NONE ? "UNMAP" =
: "MAP",
> +                                iova, iova + iotlb->addr_mask);
> =20
>      if (iotlb->target_as !=3D &address_space_memory) {
>          error_report("Wrong target AS \"%s\", only system memory is allo=
wed",
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 8de8281..2561c6d 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -84,7 +84,7 @@ vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
>  # hw/vfio/common.c
>  vfio_region_write(const char *name, int index, uint64_t addr, uint64_t d=
ata, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>  vfio_region_read(char *name, int index, uint64_t addr, unsigned size, ui=
nt64_t data) " (%s:region%d+0x%"PRIx64", %d) =3D 0x%"PRIx64
> -vfio_iommu_map_notify(uint64_t iova_start, uint64_t iova_end) "iommu map=
 @ %"PRIx64" - %"PRIx64
> +vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova=
_end) "iommu %s @ %"PRIx64" - %"PRIx64
>  vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING re=
gion_add %"PRIx64" - %"PRIx64
>  vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add=
 [iommu] %"PRIx64" - %"PRIx64
>  vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, voi=
d *vaddr) "region_add [ram] %"PRIx64" - %"PRIx64" [%p]"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYl9ELAAoJEGw4ysog2bOS8HcQANZpZIKz80ejXAOZNUPHA+ae
Ea9r/K1/QuIDDkBzcG2ZPrlloweLFpw+zD+8lNQqfIg1EeIvrlkuEe0O+gqE2b+M
Sb3Zn/zdFqma0WWWHux3JQmtEEedzW+hnF2QNaO1N+pWouOdqzGoA+TAwNDExLip
BlYsfGZx3P75cyzE6W1/EC+Je8P3syslGwGas8nSFwmYrR9PBWLYw9H4eL1tb/uJ
cIu5Ep92P8wuZ4jqdctX2dpx2LFecjlfoFNDBmv3qcvBFYM6PjmSMLtasUUWCf8P
m6QJbC8JVzIJGxePRs5mecCKvedF6AthW4QtvkBZfCeHgf/9sqlxgAo9Rn6ap9o9
k6UyTZ6bK5cf6iu1tMQMoDqEFu+uhVDaB/vAYzbotCUuzEc5gxNWm3h1/Im9UoAu
sxZcSeruXGqig1+ha0S1XU3CpINusVi1Ai7+p0qTroskTBMslMvoxSpr33WQIdDK
SqtsbsDC691O8Ld5LzmOxxdSgfIrJtbrWw+16NCm2jijhCVacqZ++MpCxJxOXJGZ
4ksgOv+WHhIimdTIIFUy1LkfvDBG3CfAhlYdK5Hd+EGS//B5nO9u8TY91D3VClvY
IkZouLsu/xvrsRaX8lWorMzWQxfACw6gVaXHNjXOIJk4sE/3RaWEt1GVojyxNri5
3EhqlkatHwgwCRTq4aTC
=6KhO
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
