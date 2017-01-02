Received: from eggs.gnu.org ([2001:4830:134:3::10]:35620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCEd-0004sE-TZ
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 18:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCEc-0006JE-6S
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 18:41:47 -0500
Date: Tue, 3 Jan 2017 10:02:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170102230212.GF12761@umbus.fritz.box>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<1483049536-21548-3-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <1483049536-21548-3-git-send-email-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH 2/6] vga: increase priority of 0xa0000
 memory region
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


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 29, 2016 at 11:12:12PM +0100, Herv=E9 Poussineau wrote:
> VGA device registers vram as BAR 0. If this BAR is activated as a very lo=
w address which
> crosses 0xa0000-0xbffff, low memory region is not accessible anymore.
>=20
> This fixes display on PReP machine if we enable PCI mapping at
> address 0.

This commit message needs more information.  What exactly is the VGA
BAR colliding with?  Why does the other thing have higher priority?
Why is it safe for the VGA BAR to override the other thing?  Why is
this safe on all platforms?

> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> ---
>  hw/display/vga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 2a88b3c..c573f35 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -2265,7 +2265,7 @@ void vga_init(VGACommonState *s, Object *obj, Memor=
yRegion *address_space,
>      memory_region_add_subregion_overlap(address_space,
>                                          0x000a0000,
>                                          vga_io_memory,
> -                                        1);
> +                                        2);
>      memory_region_set_coalescing(vga_io_memory);
>      if (init_vga_ports) {
>          portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYatv0AAoJEGw4ysog2bOSwo4QALvFJoK7oJtSjhIPeq9uQvvj
XG4VyD+IRE3L494glHU6LmW0/GOEvIu5274KD53LScBvGhs5hCQbKqNGtlW/sGQz
VM6X669B/y2PEbrx37kybLZKR6HaPhpjEXHn3uKQwMTvgJKOpVsiglzq5Y4p/0Ml
nI1Eud1rKc7nOvfTVdPvZGoY3t+Sk44bWYPOC0ufurjNOMYO5YxRjqua6u/VrhVp
hZoBalknH+naNDjRuBPsRDvqQ43RcAhkUeO8KTSrCAUlU5KdmvdC+Nh0bfML2zuC
MMS42p/Pgus1V/iHDGLbKj6EnEnnpJoztrJW2qynSTsHX6bLP15RYcOiB6WdEF9z
EC3RwI3ScmLBoL856Sq5Wa+E/sNC8x+WjWgBlzP8tiifLx/1T2HWjJaexcjFD7rb
2cruXGA9/X4iAZB8fpbyMsuO+6rc/3pdVMfxgTiH0oRkUgcz8bIj6kmBmqTmvg0+
D1ZFqTSSG6PETtPHrxtr7DUrFZFiMHs1xTMVf6VStNpdvrZrHsTn507BP7Vyl5Kf
mLZXw6WjHvst9iErvxvum88vCPIQVk9eO3rZitTHpxsf7Gg7UObXGhwMgvlrnt2o
wuwfMr9vlyonYbIbbLCX1J8oETz1Pg1QAHCROPmildZTQMNdEhbWu/DkqzyjCcXq
lKbciAFmwoEwkxnueIcZ
=+GUW
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
