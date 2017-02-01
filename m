Received: from eggs.gnu.org ([2001:4830:134:3::10]:46650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmdH-0004RN-2u
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmdE-0006xp-0I
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:34:59 -0500
Date: Wed, 1 Feb 2017 15:29:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201042924.GR30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-13-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cYG5ZC/RuVsIq1ir"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-13-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 12/17] target/ppc/POWER9: Add POWER9
 pa-features definition
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


--cYG5ZC/RuVsIq1ir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:18PM +1100, Suraj Jitindar Singh wrote:
> Add a pa-features definition which includes all of the new fields which
> have been added, note we don't claim support for any of these new features
> at this stage.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 45bd2de..35799da 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -357,6 +357,20 @@ static void spapr_populate_pa_features(CPUPPCState *=
env, void *fdt, int offset)
>          0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
>          0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
>          0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
> +    /* Currently we don't advertise any of the "new" ISAv3.00 functional=
ity */
> +    uint8_t pa_features_300[] =3D { 64, 0,
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /*  0 -  5 */
> +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /*  6 - 11 */
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 24 - 29 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 30 - 35 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 36 - 41 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 42 - 47 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 48 - 53 */
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 54 - 59 */
> +        0x00, 0x00, 0x00, 0x00           }; /* 60 - 63 */
> +
>      uint8_t *pa_features;
>      size_t pa_size;
> =20
> @@ -371,6 +385,10 @@ static void spapr_populate_pa_features(CPUPPCState *=
env, void *fdt, int offset)
>          pa_features =3D pa_features_207;
>          pa_size =3D sizeof(pa_features_207);
>          break;
> +    case POWERPC_MMU_3_00:
> +        pa_features =3D pa_features_300;
> +        pa_size =3D sizeof(pa_features_300);
> +        break;
>      default:
>          return;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cYG5ZC/RuVsIq1ir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkWQkAAoJEGw4ysog2bOSESkP/2zq+xRizRJ32y2WM8FJuGu5
Uo33O75bW7Fxg8ct8GZt8RLcrX/OTwdBq+XtCoMCloJUWg/NvQsf/1ZUY3KpoF3F
DHgADKofuRvRdmn8HZXJrHihDf9LIIUW6dqi33xR2V1WyeiMhRC0ReuMtjitBBCa
v/jIl7fkUOsviT0QQb8OxfZ4GVEaN5KYu+lcDtSvqPF+Nad9ND1ai+qASpYTEUD2
ZReH2n2rYWofcw5OazcBsRjehcHJkgt2nlUTNEHUlYhpmaXn2LeZGdPWauibDkOa
Cf7Cckr4bY/vUiiUsub4wGOErriK9pUlYXR+1jf5hBFzsV+YIpSMPoYJewCKaO3C
ec/reAKoF8na2rExtgEpZEuH+Ky86Bn6nZsR66mjstNvSOUEgYSbc8XBQWVxsPOD
oOC6WANWW7HRb9PpB4htgZuZXd30S15+9AJaItdFoaHAH5PpARthHhAbi3Ysby/D
eVpE2+R8KEqhJmyd7FkiopPSlBBWoun7TI8ie8EV7My346WotCkO0gDr4yYJeNKe
RaW9iVoTdjafbMHprdmTwnAfQAn2e4fUaOhjt1+5YVYuufD1O6i29FnLYrhL1riv
RCl/J1eaNl0hNAotv/pk6lTONcqF5NpWngCCT8RIF/9Lwf10Qx2ReVB2K6qG2P0H
tTNaY9X8eKYQDXEpIi2X
=KVEh
-----END PGP SIGNATURE-----

--cYG5ZC/RuVsIq1ir--
