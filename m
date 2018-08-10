Received: from eggs.gnu.org ([2001:4830:134:3::10]:54503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fnvt8-0005nf-02
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 21:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fnvt7-0004aP-0v
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 21:06:45 -0400
Date: Fri, 10 Aug 2018 11:04:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180810010439.GC4079@umbus>
References: <20180809204010.3579-1-hpoussin@reactos.org>
	<20180809204010.3579-2-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20180809204010.3579-2-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/ppc: on 40p machine,
 change default firmware to OpenBIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 10:40:09PM +0200, Herv=E9 Poussineau wrote:
> OpenBIOS gained 40p support in 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff
> Use it, instead of relying on the presence of a proprietary
> firmware.

Uh..  openhackware might be, well, a hack, but I don't think it's
propietary.  Replacing it with openbios might well be a good idea, but
we want an accurrate reason for doing so.

> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> ---
>  hw/ppc/prep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 3401570d98..1558855247 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -736,7 +736,7 @@ static void ibm_40p_init(MachineState *machine)
>      /* PCI host */
>      dev =3D qdev_create(NULL, "raven-pcihost");
>      if (!bios_name) {
> -        bios_name =3D BIOS_FILENAME;
> +        bios_name =3D "openbios-ppc";
>      }
>      qdev_prop_set_string(dev, "bios-name", bios_name);
>      qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlts5KcACgkQbDjKyiDZ
s5IuZhAAltOIYj5A7rAXQ7Kl4DlTw2SMKR68aYK3naVdZvXGt/JvH5zh4tWmB43t
qlDOI7/j0Vh8bFHVCtHfDxJMY799nsZQaed+om3P2L3IZW1s41Dxo8u7TiLT+zY2
dado2k2SmMowiAMXhdj6rFuJbnGKqAIvoeuZCegC9e/F04RVbWBEdSseZetsviGT
bb5e8WnSxq+BI2LrIGX2DhLrD20o9xyOjhOPtgq2Bucc4LUtiO9zPnaIT8ZHbZEo
S5Pzrcb95uKv6jlOBtz1l4Xc1d9NqagUg8pK/uWwc0AkLuaZ2WsWB9Eb+N2p6Kc5
jjlDAHG8LloW0eRA+aF4Yzh1j71eI8Gs7v+UxTSi5fI9GMjER+i/eY2cw+bBOn2E
bWv+p660LI2arOsXTXuVvcFIK34BetGMHec49hT9syYXl6zLRH8kaGKfXexvAO5l
fBMIfx+ZQVfjINl60MSSgQ0RSxbyxKzZf+CGsGwjVlJTMqWKijs6O3rj6yfbc9N/
3UfyYpz3W+fhz/Oky3qszks8QK6PhCNQo5YGd8TEiUulJ02fcWSMw0rnu7pfdOJV
PqfWECQjEGSXNFEp4mJZsLfvDGEJVsi0ZE8O6OGVfUkpBUWIzUWxiYBdgW6mRepj
shy1gq/A9VO0RfLrkOwLzywYnRDgQnGbMKZXpq5Gxz9oeS8p6Sc=
=TUO5
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
