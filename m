Received: from eggs.gnu.org ([209.51.188.92]:43517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggf4I-00080V-IY
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggf4H-00082n-CU
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:16:30 -0500
Date: Tue, 8 Jan 2019 11:07:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190108000749.GG13339@umbus.fritz.box>
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Content-Disposition: inline
In-Reply-To: <20190107193020.21744-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr: Eliminate
 SPAPR_PCI_2_7_MMIO_WIN_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 05:30:18PM -0200, Eduardo Habkost wrote:
> The macro is only used in one place, where the purpose of the
> value is obvious.  Eliminate the macro so we don't need to rely
> on stringify().
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/pci-host/spapr.h | 1 -
>  hw/ppc/spapr.c              | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 7c66c3872f..a85a995b6c 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -99,7 +99,6 @@ struct sPAPRPHBState {
>  #define SPAPR_PCI_BASE               (1ULL << 45) /* 32 TiB */
>  #define SPAPR_PCI_LIMIT              (1ULL << 46) /* 64 TiB */
> =20
> -#define SPAPR_PCI_2_7_MMIO_WIN_SIZE  0xf80000000
>  #define SPAPR_PCI_IO_WIN_SIZE        0x10000
> =20
>  #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5671608cea..bff42f0adb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4225,7 +4225,7 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
>          {
>              .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
>              .property =3D "mem_win_size",
> -            .value    =3D stringify(SPAPR_PCI_2_7_MMIO_WIN_SIZE),
> +            .value    =3D "0xf80000000",
>          },
>          {
>              .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwz6dAACgkQbDjKyiDZ
s5KxthAAmMSt+mzO7gBNqkfCRsvhE9RQs+CbWqXU+qb6Wgb5QkfCCsMrfWWe0UGo
HPs6teVCyt9K31XT7W9ZGde5YtMEO7wpEHcr3EkZT4KyMUUwOjUaL3ut5npQSCWL
2SG6wtePDIPTLmsODoLJVCoCRhcuFF2ZN+d91DlANwr3purOP/B9KEVu1GUOlA8r
JdPMXRNN9VaRm7VaUvUVOb8NCSqaFt5IiHlgRUGGD3ZnH5a0Hjvu9NaLL0oFuGCK
r3D8eyrivhxRxGeWX8kGu5rAbpYZx2LKWRZ+TXsZIJ7KKXTVPU3hVZERR+ApjBMz
soDywiID/1HTrPvKtxaqiRigZCvNOUWMbSNzFKFX/FC7Z2w19dbXKV238olN+k7p
ryNRPXkC85Lcu6WWnNk4QusdxWYw52r4u+2sAhgh1z5CIRCGRsqCFenXxFOyIMYA
pQiJrzjaxoLB6K+jAVyzB23Pw1CCaIDPUgfmCCBu4imO5ib55JGL+JYvmBXsGfCw
ak+dOo4EBYuq3XtqYNFGoKRJ+CIyGpNQFBFkq5O1GV79eicDkyyTQWcs99+8XBse
V2pvvlcWsvns+qpJyFF5+JKMuSoz8umf6P/VXDmB2Gw92v2gGKKrd8tAxyO6Kvq8
9kqQ543+SyML7/ddyLH8O4SjlzScXrRS2uACOtpHjH4OgqupC1A=
=89iK
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--
