Received: from eggs.gnu.org ([2001:4830:134:3::10]:40822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOGoZ-0002jd-Br
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 23:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOGoW-0002QH-8P
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 23:35:11 -0500
Date: Tue, 3 Jan 2017 14:51:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170103035144.GN12761@umbus.fritz.box>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<1483049536-21548-4-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mkHYMT4O8DyWoHkb"
Content-Disposition: inline
In-Reply-To: <1483049536-21548-4-git-send-email-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH 3/6] prep: do not use global variable to
 access nvram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>


--mkHYMT4O8DyWoHkb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 29, 2016 at 11:12:13PM +0100, Herv=E9 Poussineau wrote:
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>

This makes sense on its own, so I've applied it to ppc-for-2.9.

> ---
>  hw/ppc/prep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 054af1e..9fb89d3 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -339,13 +339,13 @@ static PortioList prep_port_list;
>  /* NVRAM helpers */
>  static inline uint32_t nvram_read(Nvram *nvram, uint32_t addr)
>  {
> -    NvramClass *k =3D NVRAM_GET_CLASS(sysctrl->nvram);
> +    NvramClass *k =3D NVRAM_GET_CLASS(nvram);
>      return (k->read)(nvram, addr);
>  }
> =20
>  static inline void nvram_write(Nvram *nvram, uint32_t addr, uint32_t val)
>  {
> -    NvramClass *k =3D NVRAM_GET_CLASS(sysctrl->nvram);
> +    NvramClass *k =3D NVRAM_GET_CLASS(nvram);
>      (k->write)(nvram, addr, val);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mkHYMT4O8DyWoHkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYax/OAAoJEGw4ysog2bOSdHEP/A6ivv2WzMRyErZiDbw7keBI
uManZMeqiwGtR6sneHw641dmpck1gd7kxKmda7W0bMCuZKpGL5b89aRyl58JutGr
f8s+yXnGk5qYVrip7Xaabq+sysMYgRe2owAqY9bmD+yh58oeajuFmXoL7GWGal5s
0xhsTYlyRFQ6EwrE5Hs/YSqpW9MiM/hHNQBvYp/cVWWcTCFa4MA1QD7Ec3aTlOxp
HCVgwb+7PWiY4PJOduuMXbvuGKGTbg8uJFv4Z5GJb9GYI+evOB8JtDmKdAyCzm9R
hXbuOOMF4npkGMLfahPewodoVdaLJZFd5W51j4zXwReABAWrl+FpTshdUrzoZ2UU
KbsoFG7HQNb9OZ2h8mJjY/zNMDuVRIVeih1JSLSZRU4tkiNIEt1FALtI2o5dJ9Ev
PBpfwEMyr+g/wPBKlQ6tkoif/IOqHQB/A2lEnMlAObdGWRASnLelyUGrwTNEB86P
4/eokjz8Di9//Ccw/t97/AzxmQK3FpcZw8uObJ63/lKbCMbQylqvGWUmQ8/M/Uai
jkFjFVqqCmn3z7Nov5np3ApM0Cr4Iz2zpCARO8/5fzcooeSpwKWy+qAR/Q5qHRqe
znBBUSiQZAbXKcTxoezP3T6pEjB5OhKULz2HR2aMpCWcURD3mzknN9Z7X7k84ZV0
O17TfLysER4PXqWILnTj
=rU4n
-----END PGP SIGNATURE-----

--mkHYMT4O8DyWoHkb--
