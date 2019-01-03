Received: from eggs.gnu.org ([208.118.235.92]:38377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZn-0002h4-1h
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZf-00056v-F0
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:37 -0500
Date: Thu, 3 Jan 2019 13:07:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103020748.GL10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535261366.862554.2330587135163596442.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6CXocAQn8Xbegyxo"
Content-Disposition: inline
In-Reply-To: <154535261366.862554.2330587135163596442.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 07/15] spapr_pci: Define SPAPR_MAX_PHBS in
 hw/pci-host/spapr.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>


--6CXocAQn8Xbegyxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 01:36:53AM +0100, Greg Kurz wrote:
> PHB hotplug will bring more users for it. Let's define it along with
> the PHB defines from which it is derived for simplicity.
>=20
> While here fix a misleading comment about manual placement, which was
> abandoned with 30b3bc5aa9f4.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.0, thanks.

> ---
>  hw/ppc/spapr.c              |    2 --
>  include/hw/pci-host/spapr.h |    6 ++++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 621006eaa862..fe3f9829ae6c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3838,8 +3838,6 @@ static void spapr_phb_placement(sPAPRMachineState *=
spapr, uint32_t index,
>       * 1TiB 64-bit MMIO windows for each PHB.
>       */
>      const uint64_t base_buid =3D 0x800000020000000ULL;
> -#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
> -                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
>      int i;
> =20
>      /* Sanity check natural alignments */
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 9d2ec1a410e8..83d5075a6ef3 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -94,11 +94,13 @@ struct sPAPRPHBState {
>      ((1ULL << 32) - SPAPR_PCI_MEM_WIN_BUS_OFFSET)
>  #define SPAPR_PCI_MEM64_WIN_SIZE     0x10000000000ULL /* 1 TiB */
> =20
> -/* Without manual configuration, all PCI outbound windows will be
> - * within this range */
> +/* All PCI outbound windows will be within this range */
>  #define SPAPR_PCI_BASE               (1ULL << 45) /* 32 TiB */
>  #define SPAPR_PCI_LIMIT              (1ULL << 46) /* 64 TiB */
> =20
> +#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
> +                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
> +
>  #define SPAPR_PCI_2_7_MMIO_WIN_SIZE  0xf80000000
>  #define SPAPR_PCI_IO_WIN_SIZE        0x10000
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6CXocAQn8Xbegyxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtbnQACgkQbDjKyiDZ
s5IfERAAyP0lL2zQVe/WJJRWfkO05sRId2vGzmNOP0oDqfT00rgLSXlSYFFv65q9
Lwe3cRxqIblN3OPjLmWZEK1nohSuQnVkCpwBqDRt6l5C1MuOgeLcSl2r8cGU8Z1M
P/pfqFVSsZlSsVs0n51Kfbg3VmZbLugdnffMqo3+VcAWgpIBy5LJ9vVPrhT5IBPE
87pNlr1TQCFrOPLHlMFjuKv07kh35AesEgpyX9ZVEo2ovX/aEK8AZgGVcn1FzLeo
9Mw5Hj9ySixtAyQioxeIXEL6q6pI0jhUutuOJmbuAWLWYBtWHtRsV4y8vYGsK/fN
XtAuUO7JTnzM0hK2hiJqChnibrvQx6m/74xS4PUYcFDzglQPzLwn2tB0HBa6Vh8/
AqwpviI839GBD6YlHipQVpBQeT/vZhEJVz/hf6nx4Ad1Zajt0nxZUnKPAb6zXbDd
Tc1O7ubokgAI3KwJDHqy7FD1EOugIkIQnY1bQinse7b9svCDmmtISmt4h0xpwx9K
gJ2u7GjTYwDN4rm/AGc53BeFkq/YWkIyvpoKzmx53gvKg/tM2kHL9AgEn5grqUjw
EL/gtZWAKLiqE1p6iYbr2+Oj8kPr5+Zjy38C4gd8lgmRfIRfthNxa7MQfEVNI8dn
XEtaRJ1QD6HvXuYtJ4VnAk9F5YJQ7NWDaMoOooo0wBuzQwP7hUg=
=rfOf
-----END PGP SIGNATURE-----

--6CXocAQn8Xbegyxo--
