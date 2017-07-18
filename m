Received: from eggs.gnu.org ([2001:4830:134:3::10]:51048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWfB-0007Bl-JX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWf8-0003E9-I6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:52:01 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-11-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53a83027-dde9-9728-90ab-b90a92484445@redhat.com>
Date: Tue, 18 Jul 2017 12:51:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-11-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CM9t1M1VfFXhBtVqgWMjdV2wBqgBxI6Uv"
Subject: Re: [Qemu-devel] [PATCH 10/29] net/rocker: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CM9t1M1VfFXhBtVqgWMjdV2wBqgBxI6Uv
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, Jiri Pirko <jiri@resnulli.us>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <53a83027-dde9-9728-90ab-b90a92484445@redhat.com>
Subject: Re: [PATCH 10/29] net/rocker: use QEMU_IS_ALIGNED macro
References: <20170718061005.29518-1-f4bug@amsat.org>
 <20170718061005.29518-11-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 01:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osde=
p.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/net/rocker/rocker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 4f0f6d71e5..55228f2f52 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1419,7 +1419,7 @@ static int pci_rocker_init(PCIDevice *dev)
>              desc_ring_set_consume(ring, cmd_consume, ROCKER_MSIX_VEC_C=
MD);
>          } else if (i =3D=3D ROCKER_RING_EVENT) {
>              desc_ring_set_consume(ring, NULL, ROCKER_MSIX_VEC_EVENT);
> -        } else if (i % 2 =3D=3D 0) {
> +        } else if (QEMU_IS_ALIGNED(i, 2)) {
>              desc_ring_set_consume(ring, tx_consume,
>                                    ROCKER_MSIX_VEC_TX((i - 2) / 2));
>          } else if (i % 2 =3D=3D 1) {
>=20

Given the if chain, I think you don't want this one.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CM9t1M1VfFXhBtVqgWMjdV2wBqgBxI6Uv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluSrsACgkQp6FrSiUn
Q2pGTAgAqomevxNLRzvDQs6shE+VwqMTWgiwNjEdSLqdSaGCinByVPrcfex2zRR6
5vGJhFYJRF3lPXcSDiv5S5hdSGwfz+2GR2VLDhUH1fZRN0nk4Hz5LesER4pJ7GP1
Lb8iTFKSfoduuBZwPbfMZRbvMAfEGtvwmb2XcFJKsir69Ew+a3jV0GNblNCLyBUT
uzjv8GbXKCeVhOp3Llovo1EesMw4eDzF5wNPXoqWJt5OtyQZbW1VW2JWkH8iQUVF
WKml0xlk8U95EVYgz0WF1XrF6uEiDUhV7FL9akIVWC3BkTl43t0TSnccoaFYnW0w
7nvfmNEsP4vXB5gxC2XRLc8abWKWMQ==
=XfeF
-----END PGP SIGNATURE-----

--CM9t1M1VfFXhBtVqgWMjdV2wBqgBxI6Uv--
