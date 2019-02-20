Received: from eggs.gnu.org ([209.51.188.92]:40500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwI2B-0000wr-OA
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 21:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwI26-0005tQ-Su
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 21:54:53 -0500
Date: Wed, 20 Feb 2019 12:39:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220013905.GD9345@umbus.fritz.box>
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-16-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a6YTfLRor63AaheO"
Content-Disposition: inline
In-Reply-To: <20190220010232.18731-16-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 15/25] spapr-vty: Let vty_putchars() use
 size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>


--a6YTfLRor63AaheO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 02:02:22AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Both callers (h_put_term_char and rtas_display_character) use
> an unsigned value.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/char/spapr_vty.c        | 2 +-
>  include/hw/ppc/spapr_vio.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> index 6748334ded..92b8c40410 100644
> --- a/hw/char/spapr_vty.c
> +++ b/hw/char/spapr_vty.c
> @@ -83,7 +83,7 @@ static int vty_getchars(VIOsPAPRDevice *sdev, uint8_t *=
buf, int max)
>      return n;
>  }
> =20
> -void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, int len)
> +void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, size_t len)
>  {
>      VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
> =20
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index e8b006d18f..ed79d2f380 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -126,7 +126,7 @@ static inline int spapr_vio_dma_set(VIOsPAPRDevice *d=
ev, uint64_t taddr,
>  int spapr_vio_send_crq(VIOsPAPRDevice *dev, uint8_t *crq);
> =20
>  VIOsPAPRDevice *vty_lookup(sPAPRMachineState *spapr, target_ulong reg);
> -void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, int len);
> +void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, size_t len);
>  void spapr_vty_create(VIOsPAPRBus *bus, Chardev *chardev);
>  void spapr_vlan_create(VIOsPAPRBus *bus, NICInfo *nd);
>  void spapr_vscsi_create(VIOsPAPRBus *bus);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a6YTfLRor63AaheO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsr7cACgkQbDjKyiDZ
s5I+TRAAoUYSiy2dnSWUa835NZsmTwIjbjhGgX+dyP2VcxD6eCzsxu3Ar+t+fsT9
bGMvCegj+errJ2Z9yKpYdMkTzLOkRkHzTx1c5yRNU6f11EhKu6lpTXJh+M2PPgw9
lezN1rbx88MfHcRtJDrvJRpWLCcEyw0n5z74Vln8p9yY2ZMipHLGvMmx7wlAIaG5
IeH2hdSWqT0UV1QAlMTdcUNkr5tdGy7wjI4g3WzuzEnZDPW6qNHig60gC7gjnjM6
Y+PIjrvjeZ2DPWuksWiSB8XGvpKf2rO4qSsoXQSNsZfNTl0IC8DtFaAmdXOp5kcy
gSZfm9a9moDZNZKOp53tvQ216y0A1aNx/Y8Y1dzuR0cC93Db26d3k0rEytpjzpum
ZXvTbU+ggLtgDb0iHUNisNUGnmyTZd1j0c1wkT9nBPXgD+nH1oIiWgW6RfnXB4hZ
fzyy1S5JQYYvoVw+VC0BTskCBAQ5nRDUz+iGoaJz9uPFGQBXOZPEnQmjynoCGY+N
c11l+vaiSJsVauKMiJCbvVAUNvXv9szG4665ocwdN+K+8YuIuIKZqE1LsfuyM0CO
eEHyhVroXx9nOh8mZUbwWKiq1AhQ2kyxGk/vrEEtJyABaxdA8aAzd8JrEfsU+1I5
Dfmu0IPkm6cKrHLUvkyYtnZ8HY8HnDJlyarzVQsa7fzxZ/OsZzc=
=s4B1
-----END PGP SIGNATURE-----

--a6YTfLRor63AaheO--
