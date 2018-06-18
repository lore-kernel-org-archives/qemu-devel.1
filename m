Received: from eggs.gnu.org ([2001:4830:134:3::10]:58346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV42E-0001PQ-H6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 19:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV42D-00037v-N6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 19:58:10 -0400
Date: Tue, 19 Jun 2018 09:55:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618235557.GB25461@umbus.fritz.box>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XeHo0rFSNt4mQX/E"
Content-Disposition: inline
In-Reply-To: <20180618215601.8974-1-mail@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org


--XeHo0rFSNt4mQX/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 11:56:01PM +0200, Sebastian Bauer wrote:
> Drivers for this card exists on PPC-based AmigaOS guests so it is useful =
to
> allow users to emulate the graphics card for PPC machines.
>=20
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>

Have you checked the Cirrus VGA actually works on a ppc machine?

> ---
>  default-configs/ppc-softmmu.mak | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index 860de80a27..218b14779c 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -29,6 +29,7 @@ CONFIG_IDE_SII3112=3Dy
>  CONFIG_I2C=3Dy
>  CONFIG_BITBANG_I2C=3Dy
>  CONFIG_M41T80=3Dy
> +CONFIG_VGA_CIRRUS=3Dy
> =20
>  # For Macs
>  CONFIG_MAC=3Dy

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XeHo0rFSNt4mQX/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoRoUACgkQbDjKyiDZ
s5KLAg//QmJUnmwHTJqHeHWUBD/aKhxXJw8jokANhKefN3SeLQ165vOG5k8Zunc4
VC4Rk93V9r/jWIX45fGv0PcKIRoSYLpC1PEsFvhhKYL4a9tLmWJTc10+utLya08y
tr1rZv+NZyXRQy/XyH9iPDHUU0Ee/n6ZGYNW6xe+Kt6j+4tAvBOFSK9N7jy+AXTI
JhFIzNTBVFMCo90sYQeS+953zM5g9agzHmFcrzCR8J14naQO7LlUYV8ttSxDHvtL
iqeV6V8fpL8w2DPAO11PJODbbIv94d2vBLzYngUYDSYcAWAlzfxoIHs2tIQ4hC8P
B1wcP49k/cWCl+KaUfBhYzf6Yc5HTIfIiVYC6zm8BkS5q9GZYfd2QQJJJwTu65ns
0J6e/IC/uDAg6UHBcHc8OW3xcLXNJx3dwluokHapRogD9ET6W4dhhAlY/7X47qzj
inwGqMnoko6YaG8PdzKiy1py5y52kVew0ax0Ozglee/my4B5e3Nft20eDttncMRZ
8+LFp3PVTzMwv8SL1sgVCu3ZwmElmOeWV6onEQauE79mN/fCfW7e8nlQalpm6j4q
NnKP/OQux/P8it1NA5bz0iTtRPexgxATYp/JvwXqd3SQZbPb3T09ZkJ5Q/Cix9l6
2NQ+TakHblD+L+oqljGm4XJrjfDd4iR2kN5cCWF7ny8ZnBhzlmY=
=rdKR
-----END PGP SIGNATURE-----

--XeHo0rFSNt4mQX/E--
