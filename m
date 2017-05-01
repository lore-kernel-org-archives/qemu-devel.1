Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d558d-000273-RX
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d558Z-0004qi-Ov
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:48:51 -0400
Date: Mon, 1 May 2017 16:13:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501061337.GO13773@umbus.fritz.box>
References: <cover.1493274659.git.sam.bobroff@au1.ibm.com>
	<20170427063153.GB11487@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QRo3kt64Wi40AlcO"
Content-Disposition: inline
In-Reply-To: <20170427063153.GB11487@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] ppc/xics: Fix stale irq->status bits
 after get
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--QRo3kt64Wi40AlcO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 04:31:53PM +1000, Sam Bobroff wrote:
> ics_get_kvm_state() "or"s set bits into irq->status but does not mask
> out clear bits.
>=20
> Correct this by initializing the IRQ status to zero before adding bits
> to it.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

This definitely looks like a bugfix, applied to ppc-for-2.10.

> ---
>  hw/intc/xics_kvm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 42e0e0ef84..03c1fc77cb 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -213,6 +213,7 @@ static void ics_get_kvm_state(ICSState *ics)
>              irq->priority =3D irq->saved_priority;
>          }
> =20
> +        irq->status =3D 0;
>          if (state & KVM_XICS_PENDING) {
>              if (state & KVM_XICS_LEVEL_SENSITIVE) {
>                  irq->status |=3D XICS_STATUS_ASSERTED;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QRo3kt64Wi40AlcO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBtIQAAoJEGw4ysog2bOSSYoQAL3AOujNioOiZTXeLjDAFLZX
TMotxqEeYyP75Zfe30NJpr4A5fMySWj7bPf+KnV7tn37WEu6owtTQxAtN892N7HF
uzSyF6x0UJVDGqUlB+oBwav6hNmg//XB6/7f/X8ColVcXR6WRsK6xnN9dultm43J
lE8HIaAsE25w+DavXlsfYmKDn/NOFQxSN2lJCAROQm9CvKRVGZMmYsVV5/WeMJYF
yI/yGFxgciLEvg1rO8iPfHccbnZ87PNP8XAAEj8H80p++s0d2yUhTqlEkkZfxxo/
YM453JgZxSGC/6mXxB7F49l9Yj1R8S/7FMQqm/qqDAQAmaA6OV8TGIkDCH7kyog7
LeBL7ipUrLigcPU6FDFhkXhdoEPlqKYzErH+NZYj2x/TTvqieLt7eGesuwUEIoTM
ZlW4yZdU1PBSY/4LsXJgapdDlCL1M4bPMkVSc0IaLPAa/RmpYRWkxvVVduIFnFdp
PzZPOVBOIw0A9UJU9huCsdPBIVdjPUTQQa/kYH1Y5hgtv7nU92JUQy/3+YK2MwtD
D3RLtpjs4txxq9R3E1zKXhsuV1eW0zc1Qvzyi3d48+h/xRAAU5vIvQevoqFbN+Pc
zR7/Copf9Hhe8xv2M2bmDr7xaWXNgXuSUnl4hFsKCnnUEnGFtte7pmOMpkGbUfWU
mXTVAD32ST60YOecxEy5
=9qAt
-----END PGP SIGNATURE-----

--QRo3kt64Wi40AlcO--
