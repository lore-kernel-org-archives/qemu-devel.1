Received: from eggs.gnu.org ([2001:4830:134:3::10]:52807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fo1BS-0001H5-WF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fo1BP-0002Y9-Lt
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:46:03 -0400
Date: Fri, 10 Aug 2018 16:41:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180810064154.GE4079@umbus>
References: <20180810053712.6587-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <20180810053712.6587-1-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: on 40p machine,
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


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 07:37:12AM +0200, Herv=E9 Poussineau wrote:
> OpenBIOS gained 40p support in 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff
> Use it, instead of relying on an unmaintained and very limited firmware.
>=20
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>

Applied to ppc-for-3.1, thanks.

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

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlttM7AACgkQbDjKyiDZ
s5IbjRAAh9/nEKTzE7BtIL3AwE/5CJXQem6KTYTZ+dGMbDB5WjNjxukgWIqgEpBS
HAddkzJX9mWcaViAd37Nd/e+yP4c3XgiWg6Tmrevmyx3S7xjzuiOmbVjWx4mUEfT
NQzbPxz260BVuQqrFX8SusO8WQh3gggVfEhltWPLdQXGHewb8XAXFrSBDa8Q+geb
bUjHVdR1dhV0I9TZd8jovAKIAXAaoWwbE+TcEKbATV3cWR6pXMT7WQGCdsPrgz8V
F2ffpzMMfGLVkaEl7S6x5W2cTFTBuVWZPEX2BAGejA+SAwovunAkek6y0u6BPOKj
EWCQSgXq/dj2nA0NcGd3jm6UGa15lXT9wzfBy4tcSCIqpboS4kjTWD9xs6jxHAML
i9pMdkE2mEakIQxuS/+BVW34RuDZWa9x4IjQ7wJerFkZ4HocqySdnjnqAM3GEOlx
C4tmjV1AHcjSjZzFVRwBmF7NNIvIlMjs1Aao4uetz9rfNMxL2jpjbmUuZUfoPq0j
WGiEm+JW8ZnLCtvLJ+IC9+fZUTJbQK56QXFOgTr7G0xgsrUZ4M8KJ/DXAU9Uei+R
WooaRwSd7mMqxncmDPSYiU2uM0FUx6OU1ggaDOoxd79YBbKFoH/YeAKH/LEqC2UN
UNep/SpQPr9Z5KM6TUv2R9BmqC9I/Gk73a6cr8jIwSek0vjV1pc=
=tH/m
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
