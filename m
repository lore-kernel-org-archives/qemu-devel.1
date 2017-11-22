Received: from eggs.gnu.org ([2001:4830:134:3::10]:53603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOn-0002ha-U5
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOm-0002XI-PZ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:33 -0500
Date: Wed, 22 Nov 2017 15:08:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122040817.GM2380@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-9-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vdqwC0msT4ilQ2it"
Content-Disposition: inline
In-Reply-To: <20171120032420.9134-9-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 08/12] e500: add mpc8540 i2c controller to
 ccsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:24:16PM -0600, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

You're adding what seems to be a fairly specific device to the general
e500 init - this again suggests that it should be split, putting
creation of devices under control of individual machines.

> ---
>  hw/ppc/e500.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 6f77844303..bef7d313d4 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -861,6 +861,14 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>      qdev_init_nofail(dev);
>      ccsr_addr_space =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> =20
> +    dev =3D qdev_create(NULL, "mpc8540-i2c");
> +    object_property_add_child(qdev_get_machine(), "i2c[*]",
> +                              OBJECT(dev), NULL);
> +    qdev_init_nofail(dev);
> +    s =3D SYS_BUS_DEVICE(dev);
> +    memory_region_add_subregion(ccsr_addr_space, 0x3000,
> +                                sysbus_mmio_get_region(s, 0));
> +
>      mpicdev =3D ppce500_init_mpic(machine, params, ccsr_addr_space, irqs=
);
> =20
>      /* Serial */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU+DEACgkQbDjKyiDZ
s5KUZw//c70E4PZ5WIdeVWE089N4qLgsCqUNK1SY16tUPd4SIJ3v6i5hkX+l5nmh
G2cu74KjIVx34rFAEdxjpltjofHHUFW1qmL67Hi8RSKMwk+HlO0OFPtlAGhm5aKH
WhSXrvTuXdeetkxc+SNv0eiXGbU+APxzCZd9oBHI4bnxbQhhrTOg8sSXGLbxpoqf
t4qiUTLpOCZhr1Wr4XF+/9/PHY2YqeGszJWyRXawggDp0GdI0537+h9zWpWH0sVh
rWJL6YNI+Q1UDkCOHFVifE4wtqv5r0/SR+HhyEKNfjgeUVl3usGcM6K28LRX9NMv
tDFosUXoNDiI2n1/VvDM/11d3mpr/AjMJd4kI7joPO9dmyzAGc40OlzOX82ISwj0
FDE8QGkrW7EjtiEmxe7MXfvnBfuzISVG5AsEhPVBxKoojjTkohyiXNMR2ZseckKq
AI06kIhSB350O9g+BulRgg+DjCkfKVe90I4QT2b4pX7dU3qdy8ZWW3fFAu5cyMTv
vUQNd5kfAG038mO2nghteZGWPiReBITDRmAPRqY1MHniOoQgx6Xf0ndU5acDBg8G
Vh+td9YMNboFpyicLHZjJz8bMRDnlwi3yuKJ/erdo5XhDpEw55vhRayK4/+5tPf2
Kl6l0K7i74Qys+ACPWr+Ok+zwALfO8qaLOBvCKVFtah2YwxyiQQ=
=N2dS
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--
