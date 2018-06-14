Received: from eggs.gnu.org ([2001:4830:134:3::10]:38691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTISX-0000VG-0J
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTIST-0004Uq-4O
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:01 -0400
Date: Thu, 14 Jun 2018 11:35:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614013532.GE3042@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<a9d502cce05cfa57895c415164efd288f4926fb6.1528935420.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline
In-Reply-To: <a9d502cce05cfa57895c415164efd288f4926fb6.1528935420.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 8/9] sm501: Perform a full update after
 palette change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Sebastian Bauer <mail@sebastianbauer.info>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> From: Sebastian Bauer <mail@sebastianbauer.info>
>=20
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Commit message.  Why is this necessary?

> ---
>  hw/display/sm501.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 0625cf5..a2ee6e3 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -479,6 +479,7 @@ typedef struct SM501State {
>      MemoryRegion twoD_engine_region;
>      uint32_t last_width;
>      uint32_t last_height;
> +    uint32_t do_full_update; /* perform a full update next time */
>      I2CBus *i2c_bus;
> =20
>      /* mmio registers */
> @@ -1032,6 +1033,7 @@ static void sm501_palette_write(void *opaque, hwadd=
r addr,
> =20
>      assert(range_covers_byte(0, 0x400 * 3, addr));
>      *(uint32_t *)&s->dc_palette[addr] =3D value;
> +    s->do_full_update =3D 1;
>  }
> =20
>  static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
> @@ -1620,6 +1622,12 @@ static void sm501_update_display(void *opaque)
>          full_update =3D 1;
>      }
> =20
> +    /* someone else requested a full update */
> +    if (s->do_full_update) {
> +        s->do_full_update =3D 0;
> +        full_update =3D 1;
> +    }
> +
>      /* draw each line according to conditions */
>      snap =3D memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
>                offset, width * height * src_bpp, DIRTY_MEMORY_VGA);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshxmQACgkQbDjKyiDZ
s5JMqxAAiyM/zse7rdgs6Dm/vvzl8r6mgUeq4mrRpBBd5c5uZd2IPS8/cU6GZ2pE
MLCOV+zz/wadcxxTGGFWK3oeHhT0LJTqH/Hf9J03x+jOL/mX6ZPcw/4PMk6n58+T
OL4wNT2zbeA/LwkBZElyNPC1LmQdj8fizIU4F6az/txHsTtORlX6L6F8ow/AF8YT
0KkljrlMoZMJCP2zUdLu6EF3JQLfBNe4RJaSHcJ8WGiDGm3a2VVNSAlWUFcfMh21
gb8Msqi2V3BDrCEjZJVxA5bW+QC0jcNWLYk1tBJNM3g6MtlVs74LJ//F1HsBgIbC
ZSjfZmCOf78f/ayWlRFBNCIfZGGEHhYl2uh9UOHyzfj8CR6BcxQEb8KBRQVV6AtE
+kCjLgivYbfFqWhl4Z+u66L8jTjMV+JuEppkUbSxihQYl/PJim2c82eMgKRjD5xI
nJ+n7HiL85oCe8sub695GrFNbj0xUELxYEg4lORl04n52Ox62CHArxz+2DCjYUr2
VRXodCgyUCyXN5OCXQwh9Yb//9EhGJuRaEOnK8UA+gOWwMO0Vk7thW6KvBMR1/9Z
XeoaAo2Y6stn832YcDFdFJEHlK3+zH4KANgLJyhoX2irColxuCGH6P2+Tc15L2HV
wOA+cYhjZcS5NdEjEjCv4aTpZOdEBCjYyDlc3CM261eSt5l1NSo=
=fcEk
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
