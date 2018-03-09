Received: from eggs.gnu.org ([2001:4830:134:3::10]:54195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu6B9-0007kt-IA
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 19:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu6B8-000637-Az
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 19:46:35 -0500
Date: Fri, 9 Mar 2018 11:41:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180309004107.GT3083@umbus.fritz.box>
References: <20180308115036.23461-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u+FGODhbLwgAeSOU"
Content-Disposition: inline
In-Reply-To: <20180308115036.23461-1-david.engraf@sysgo.com>
Subject: Re: [Qemu-devel] [PATCH] PPC e500: Fix gap between u-boot and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Engraf <david.engraf@sysgo.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--u+FGODhbLwgAeSOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 12:50:36PM +0100, David Engraf wrote:
> This patch moves the gap between u-boot and kernel at the correct locatio=
n.
>=20
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

Applied, thanks.

> ---
>  hw/ppc/e500.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 43c15d18c4..bdef2bddc6 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1009,6 +1009,10 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
rams *params)
>      }
> =20
>      cur_base =3D loadaddr + payload_size;
> +    if (cur_base < (32 * 1024 * 1024)) {
> +        /* u-boot occupies memory up to 32MB, so load blobs above */
> +        cur_base =3D (32 * 1024 * 1024);
> +    }
> =20
>      /* Load bare kernel only if no bios/u-boot has been provided */
>      if (machine->kernel_filename && !kernel_as_payload) {
> @@ -1025,11 +1029,6 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
rams *params)
>          cur_base +=3D kernel_size;
>      }
> =20
> -    if (cur_base < (32 * 1024 * 1024)) {
> -        /* u-boot occupies memory up to 32MB, so load blobs above */
> -        cur_base =3D (32 * 1024 * 1024);
> -    }
> -
>      /* Load initrd. */
>      if (machine->initrd_filename) {
>          initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u+FGODhbLwgAeSOU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqh2CMACgkQbDjKyiDZ
s5K6lxAA3Bm6dnCDmKhPMW8H6q4IIEky1rIGpSf/P0wnJOov8gWG0cmJgga/0pvi
aGamXb2uKUrTSCTbG5zH6Q3MpGmFbHRo1Ze1sVupsk/RPk+3TJRUX6j+BvDDPB2B
XLf3mYhHay/Wjzy2V0bh0E3oxXhT4HrnwFP3URX6NrxE0oooTEQsB8mVtfhBD5mY
9DiZkMgYDKdSdn+FicjN4VTpZpCVESkU+Q9kn3TJG3+u1sXKdITQT2KKG7Xy3GqT
FawxO5VjZBEQ8fqwlOImb3OZwWKnP2HB2PNqnVBu3ShZFc1GsS/LxiZdIJIsxmFp
I8+GryF04N5Jh3wHjrBwCtw6GNDR39/390ldiXMfTNEneXbTofcWF6j6Cd/JASXu
1cdzmakoVEb9i2nID5X17K3BGSQO2t6jILn3f8B+WepHg9tbWO2AooJG6hWiOlwT
OPgiWLTX3UH8CiseWLm8F/YRsVdLNxw/p723yZb+eHIZ5pokq4p2FbL/jd1shdsG
u00wNcdklqUO7CNT3HhcS83A0EJYnqvIXqdBV4xEa86X1UhZbhTTs9GH5KKhMaWN
5pRaRzNNi0Rb+ENfDrIUBJ0sGnIGskLAtNH0Zz9jbw/OO4q8W8GdU9HqetW01KEX
9wkEOgl/js4x4FxNpCqqNAbe9cmMVsV0345cfQ6Ib2n591O/3MI=
=OUbN
-----END PGP SIGNATURE-----

--u+FGODhbLwgAeSOU--
