Received: from eggs.gnu.org ([2001:4830:134:3::10]:34371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilY-000270-3Y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilU-0006WX-U9
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:52 -0400
Date: Mon, 4 Jun 2018 12:43:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604024340.GK4251@umbus>
References: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
In-Reply-To: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] prep: fix keyboard for the 40p machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org, f4bug@amsat.org


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 06:39:58AM +0100, Mark Cave-Ayland wrote:
> Commit 72d3d8f052 "hw/isa/superio: Add a keyboard/mouse controller (8042)"
> added an 8042 keyboard device to the PC87312 superio device to replace th=
at
> being used by the prep machine.
>=20
> Unfortunately this commit didn't do the same for the 40p machine which br=
oke
> the keyboard by registering two 8042 keyboard devices at the same address.
>=20
> Resolve this by similarly removing the 8042 keyboard from the 40p machine=
 as
> done for the prep machine in commit 72d3d8f052.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.0.

> ---
>  hw/ppc/prep.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index a1e7219db6..be4db6a687 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -770,7 +770,6 @@ static void ibm_40p_init(MachineState *machine)
> =20
>      /* add some more devices */
>      if (defaults_enabled()) {
> -        isa_create_simple(isa_bus, TYPE_I8042);
>          m48t59 =3D NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
> =20
>          dev =3D DEVICE(isa_create(isa_bus, "cs4231a"));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUp1wACgkQbDjKyiDZ
s5JytxAAufeYzgqPCUjzARsDQwVot+Ym6Kl+vehpyft3rAZ2YaPEH/bNS2jhdURx
YBAf8fnPgwK5aTRd5AyDXeQ77Jt1TxKCSNe629h/aGF53NbQCIY3DudPHpGex/Hi
hJT/9UewkQcPhJ58Wju2fH6pajSzksTUelrNITPo2f8dr+K6K5l0Ljxdtwm8gXwq
1GBWP0v7NcgHV+jdWS7iItCxt6KvQcIbyrwPmMXbknIr8JnmPRhbDnqpz08HTAPr
GE6vaQyxDofPUskA25dLPGLeSWlkyI61dnJmBoQRhinq3/J7S3B+yulmdSpi6c+z
IAeD0dYWuJtdbylZd9o/RoUSs/6ko5sWniWCWszPGB+8DE6TCVzXkc3f/GhNKPfs
KIytIBWJNTJVLGrPOkHLno/3+P65Q5eWO5LJbpeB0glrDm6e5jRQKmhNKxj7q3Sa
E0/MDh1I9MnA6B4mY6N5XkghnHr9q5ipuU1QeqJ3OKKRtD0QDB6y9JJ953W1VkJe
QEFVS02cHioENUqysHB9ZcMLlkk8xC/wtSZ7HOzDSHl5TFP40ze/dqY7w4NPrUa4
Eq3HCmP7/mmLGAhyIr23KXAuyXWbi9ut0LcakA37/NK/3mPdP7U3ZYriEFLR8OaW
VDA3wvmSiBv5Wr0hkqCL1M0ud8yQ1QcihgDjKZCY3e+gbtzaR44=
=zyZk
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
