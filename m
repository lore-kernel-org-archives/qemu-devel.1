Received: from eggs.gnu.org ([2001:4830:134:3::10]:36730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZQ7E-0001zJ-3x
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZQ7A-0007j5-WC
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 17:44:32 -0500
Date: Fri, 3 Feb 2017 09:44:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170202224420.GA7754@umbus.fritz.box>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
	<148602129908.33.4236801111127079549@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <148602129908.33.4236801111127079549@eba24e3a0d7f>
Subject: Re: [Qemu-devel] [PULL 000/107] ppc-for-2.9 queue 20170202
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, qemu-ppc@nongnu.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 11:41:40PM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> Your series seems to have some coding style problems. See output below for
> more information:
>=20
> Type: series
> Subject: [Qemu-devel] [PULL 000/107] ppc-for-2.9 queue 20170202
> Message-id: 20170202051445.5735-1-david@gibson.dropbear.id.au
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>=20
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>=20
> # Useful git options
> git config --local diff.renamelimit 0
> git config --local diff.renames True
>=20
> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
>     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailbac=
k -; then
>         failed=3D1
>         echo
>     fi
>     n=3D$((n+1))
> done
>=20
> exit $failed
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20170202051445.5735-1-david@gibson.dropbear.=
id.au -> patchew/20170202051445.5735-1-david@gibson.dropbear.id.au
> Switched to a new branch 'test'
[snip]
> Checking PATCH 46/107: target-ppc: Add xxextractuw instruction...
> ERROR: Macros with complex values should be enclosed in parenthesis
> #110: FILE: target/ppc/translate/vsx-ops.inc.c:52:
> +#define GEN_XX2FORM_EXT(name, opc2, opc3, fl2)                          \
> +GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0, opc3, 0x00100000, PPC_NONE, =
fl2), \
> +GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0x00100000, PPC_NONE, =
fl2)
>=20
> total: 1 errors, 0 warnings, 92 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

This one is a standard false positive due to checkpatch being confused
by the ugly macros in this file.

[snip]
> Checking PATCH 93/107: target/ppc: Add pcr_supported to POWER9 cpu class =
definition...
> ERROR: spaces required around that '-' (ctx:VxV)
> #22: FILE: target/ppc/cpu.h:2293:
> +    PCR_COMPAT_3_00     =3D 1ull << (63-59),
>                                       ^
>=20
> total: 1 errors, 0 warnings, 15 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

This one's matching the surrounding code which is already not quite in
style, best to fix those together sometime later.

[snip]
> Checking PATCH 100/107: target-ppc: Add xvtstdc[sp, dp] instructions...
> ERROR: Macros with complex values should be enclosed in parenthesis
> #126: FILE: target/ppc/translate/vsx-ops.inc.c:137:
> +#define GEN_XX2FORM_DCMX(name, opc2, opc3, fl2) \
> +GEN_XX3FORM(name, opc2, opc3 | 0, fl2),         \
> +GEN_XX3FORM(name, opc2, opc3 | 1, fl2)
>=20
> total: 1 errors, 0 warnings, 96 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

This one's the false positive again.

[snip]
> Checking PATCH 103/107: tcg/POWER9: NOOP the cp_abort instruction...
> ERROR: do not use C99 // comments
> #28: FILE: target/ppc/translate.c:6025:
> +    // Do Nothing
>=20
> total: 1 errors, 0 warnings, 17 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

But this one was me being sloppy.  Do we care enough to re-do the
pullreq?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYk7ZBAAoJEGw4ysog2bOSTo4P+QGIkzbs8/ypJQ5Yu/Z6hMua
QEb35SvkWubLiEF2BIbBj6IHXv/tTYDQIYcKeCQ0Bf26uxN/Mgz+3QxxPK1e4xli
U8I2ElFGGi2RYXUZnNGsPU2qbnNPWx+7QocbJO9IZV/vnW+zTGr1LJqYno7iYZ7w
OTIov1WrfgbdRp122ah9phoa1xgqVofC940xr3Biyfrzc9Q+3DW3Aj/9wNNIcQcR
WZF8XCHSWO8gKD8N4CHhZQo4IK+zz3a+Z/+2/Lb1dVNiy4AjsonjNUObLgP+7KHJ
SIVypO+GdZOXac3iILQSLCR5GionNK73o/NeX1ua3nQ+KsDONRPBgjFBE5FPZnCt
2hMG2tUZA/7hzHKBqrtGTZwBg3r0bRt2eYEpJeC9KKC7kzsqxjH5lPUpQZ2f66hN
n3sBjcD0HuWtdtqjkoo7eLnm8I2EkU3tUr/lRNVVEuBooWvhpuWyti/xwk8M+prK
XrMd7rhxpQ5dvTX05u5ann59+eS2SOG5tVO0RE7DLg5whcNA7tZI7pHY2rC7lGRj
mBd5i59DI2+pBkVkV+LIU6deOdNobxInU5sZZQpbJjt+JE1VQQlhFS9nr4/8g/O1
XhsaZw0J4TEsMQs/nWqYOzzEysaz9OfUo2RVvVq5LhjxggVZTtbkTlObL5q6jNtu
CbN/DqQyX+ODTXNQ5tmg
=QQd9
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
