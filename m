Received: from eggs.gnu.org ([2001:4830:134:3::10]:59733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cSytm-0006m8-BL
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 23:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cSytl-0001ff-Af
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 23:28:02 -0500
Date: Mon, 16 Jan 2017 13:16:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170116021603.GB15853@umbus>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-2-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-2-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 01/17] powerpc/cpu-models: rename
 ISAv3.00 logical PVR definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:07PM +1100, Suraj Jitindar Singh wrote:
> This logical PVR value now corresponds to ISA version 3.00 so rename it
> accordingly.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This one stands on its own, so I've applied it to ppc-for-2.9 already.

> ---
>  target/ppc/cpu-models.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index aafbbd7..d587e69 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -601,7 +601,7 @@ enum {
>      CPU_POWERPC_LOGICAL_2_06       =3D 0x0F000003,
>      CPU_POWERPC_LOGICAL_2_06_PLUS  =3D 0x0F100003,
>      CPU_POWERPC_LOGICAL_2_07       =3D 0x0F000004,
> -    CPU_POWERPC_LOGICAL_2_08       =3D 0x0F000005,
> +    CPU_POWERPC_LOGICAL_3_00       =3D 0x0F000005,
>  };
> =20
>  /* System version register (used on MPC 8xxx)                           =
     */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYfCzhAAoJEGw4ysog2bOS7kMQAM2EN3pcRgd+8CJ5CxNHzIsI
daWTtDwT3Z9TfgAYvWXsfQfcbD3I8c8eBS4H8KriIwG2+CKFvVt+XUOk8JjZ8JuI
NrgbS1++PqNBNc9TUaoHfEWaxYFy8/VK715tXikFk8Vxg2VSjlIk29JLi+jMZH4/
6P0N0U3RBD5kjCAx0kRF1SZ9txcmrgNXY/N9eX3eu5C63DuiNFtJagU1/22tXmZ7
jwuUS/QItd3CK9LrCx/nc+r/8LaraQXuoWaim35lcowuCoqcQ9SoPL8xmNZM0M5t
bZB6lWNzq/Cyce6HncJb4PcnmDFtUkkJiRkkPACOLeaFJvOfc8l2SDRqnARnmCYi
KZJPKZCBUbzcqV7XYaQuQKSeI/9nd+FOwuTPoW2yNerAcdhG4+at1THjkMUpPmjF
SNFX91GufcgFxofgqw1OcGJeYwFaU/zqk4eMC0te/2PIwOCn9b37IjkSq+TAVHjl
B2xKLrL70oidExTBApFjs8q73c6KZVUDMyWQVIvJlhOGfGYoGDqr5bABRjCk/z0w
qcQmb07zUmxGJYyka5Wd6+xR6XItVgIA8rV2dmj3vS/D/O6za63U9+ZlgYsfYpOI
qIYtP8PhBlyWvTMNJK8GISR0r0+itZTFx8EeDhqTocjj9idISg4+Wy5m6C+4G4mu
ewYzhtMSyWl++Ii3X/lG
=zgA9
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
