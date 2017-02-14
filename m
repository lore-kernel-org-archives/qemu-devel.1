Received: from eggs.gnu.org ([2001:4830:134:3::10]:49076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdmX7-0001Cg-T3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdmX4-0006JU-Og
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:29:17 -0500
Received: from ozlabs.org ([103.22.144.67]:43215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cdmX3-0006IN-W6
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:29:14 -0500
Date: Wed, 15 Feb 2017 09:55:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170214225530.GA12369@umbus.fritz.box>
References: <20170214133331.28997-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20170214133331.28997-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vmstate-static-checker: update white list
 with spapr_pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 02:33:31PM +0100, Laurent Vivier wrote:
> To fix migration between 2.7 and 2.8, some fields have
> been renamed and managed with the help of a PHB property
> (pre_2_8_migration):
>=20
>     5c4537b spapr: Fix 2.7<->2.8 migration of PCI host bridge
>=20
> So we need to add them to the white list:
>=20
>     dma_liobn[0],
>     mem_win_addr, mem_win_size,
>     io_win_addr, io_win_size
>=20
> become
>=20
>     mig_liobn,
>     mig_mem_win_addr, mig_mem_win_size,
>     mig_io_win_addr, mig_io_win_size
>=20
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Greg Kurz <groug@kaod.org>
> CC: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  scripts/vmstate-static-checker.py | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-c=
hecker.py
> index 14a27e7..bcef7ee 100755
> --- a/scripts/vmstate-static-checker.py
> +++ b/scripts/vmstate-static-checker.py
> @@ -85,6 +85,11 @@ def check_fields_match(name, s_field, d_field):
>          'xio3130-express-upstream-port': ['br.dev', 'parent_obj.parent_o=
bj',
>                                            'br.dev.exp.aer_log',
>                                            'parent_obj.parent_obj.exp.aer=
_log'],
> +        'spapr_pci': ['dma_liobn[0]', 'mig_liobn',
> +                      'mem_win_addr', 'mig_mem_win_addr',
> +                      'mem_win_size', 'mig_mem_win_size',
> +                      'io_win_addr', 'mig_io_win_addr',
> +                      'io_win_size', 'mig_io_win_size'],
>      }
> =20
>      if not name in changed_names:

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYo4riAAoJEGw4ysog2bOSjywQANtAr3X1dLtawJn0FRyL6FTP
Xb6pmBKwaqu9vblldgzpVdPN/jqBscQ7GpIeIv9We0foXd6t3KGMzh12dkOVGrME
asJRgYLC9A1NvqfFaK9kFW9uqcVU9Ac9Ws1Ha2YyO5xoiIOBQcJseHxqzyFVryeB
l2V3MgllU0kY2WVUzpurnoPfiKDZtfU1fDa7tvgh66yrbCaz50lJi//HK5ltsXyX
xtCV0cltVLHH3pTEyvZ/IkLaIOYDT641ykpDfvysfMbYwM/KNh2+IJNFIGxguJQq
p4wT3dq4UxRVdWsoKExXwhJZNFglfsBIYTzqs+HjVUdx4GAHEKPfjabeIqFeNoe+
SPXqxD71Uj/GQiSEH8yvyeIcjelPmjSNBL9fFcKE9It+gcOlQI98uc4is7dFeAoW
Xj46oGJ6RD0opphJYGmHi4eCWEzTkH6Yp1Pet+Ann3yWBOEXAWRIra7n8q0nA7Rp
WMLa37jLJSCozO3L6gABicS7+Xa47j+FFuOA90TgzFyRt1nDIy4vYRoJfCzIlLbO
EhbnAzjmc4S9cWv3HxE0NZ8Ejhj9IEVpdn/95FFJkkLpUoYbZR6wqJnE2gQJJ9Pg
HpXHxNvC9KudMpP4Ii9LN/7eIrN2wH2KKBMM1POpKvcD4SGUEOlXtZvNUI3UA6+i
IXp8LnG6wUla36kLN8ii
=T3QX
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
