Received: from eggs.gnu.org ([2001:4830:134:3::10]:41900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgxh-0006j3-7s
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgxf-0004YW-TD
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:25:33 -0400
Date: Fri, 2 Jun 2017 17:23:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602072318.GO13397@umbus.fritz.box>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
	<149637571900.4027.16202778059216626774@f98a8425f76e>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O3WNCzIuUImKerqE"
Content-Disposition: inline
In-Reply-To: <149637571900.4027.16202778059216626774@f98a8425f76e>
Subject: Re: [Qemu-devel] [PATCHv5 0/4] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, groug@kaod.org, clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, abologna@redhat.com, sbobroff@redhat.com


--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 08:55:19PM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Type: series
> Message-id: 20170602031507.29881-1-david@gibson.dropbear.id.au
> Subject: [Qemu-devel] [PATCHv5 0/4] Clean up compatibility mode handling
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>=20
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>=20
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
> Switched to a new branch 'test'
> 6ccf47f ppc: Rework CPU compatibility testing across migration
> 2b75df3 pseries: Reset CPU compatibility mode
> 282a89c pseries: Move CPU compatibility property to machine
> 8741a73 qapi: add explicit null to string input and output visitors
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/4: qapi: add explicit null to string input and output vi=
sitors...
> Checking PATCH 2/4: pseries: Move CPU compatibility property to machine...
> Checking PATCH 3/4: pseries: Reset CPU compatibility mode...
> Checking PATCH 4/4: ppc: Rework CPU compatibility testing across migratio=
n...
> ERROR: braces {} are necessary for all arms of this statement
> #94: FILE: target/ppc/machine.c:236:
> +    if (cpu->compat_pvr) {
> [...]
> +    } else
> [...]
>=20
> total: 1 errors, 0 warnings, 100 lines checked

This is a false positive triggered by an #ifdef intersecting the
if/else.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O3WNCzIuUImKerqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMRJjAAoJEGw4ysog2bOSOYMQAMzOjjxL554Qa054Pj57d3oM
Z5mVgavSIf1HE+edKG1k+LBCAZThl2wcyal60CgSHfNVOCZVpsri2erABxHtxJdR
wRfiqF1Mf5Zx4lsxGwgyTtdfC8GnctBybHPsumggmM7u9XuN8gjk9wZVmeuX0AXY
bcXbUGt3ya345iIcBnLBgOdBmbJpIx1l0gWR4uplGAyTBWV8CyOddhmOYOiCZj/q
V04PgOJdKPNMv2/Yc+2HMxAAdwADBaW0iiiorLmc1sxqhzzktxE9uGMkzT9+TI2p
6XUdeLlhMReajWFCWWBSIukX3m0BaWUp5GAXP3klTcZPCJ38XfKUZHGpBiKad+3M
UcE4itoW7OLwRjvvlJRpDzdy4aKDlYfBNDMM2BM+KAoyhlUWwmd0ohuifLUlMvgG
wg0gmwBGaux6orEiZZbi6AzwxjKHJgj0tQnJavJlf/pDNqxtkBMbkqAphYWHYCqX
bPA1YtptY6lg9Jmp3txRk1PwPIA6bjYqcKdGz7rKZnn7d2uTivMRGJT+wx98PRPg
fJpxirtmq7MjrvokFI17Ts8T/Fi7WrxQBGlj1HQqRzV88paRTo96zzJsw0Pu0tel
Mi+toq2n5HxjX0clBnB5TQfpAS7L9oDp1Jd6GGOQwTi+WorOdc7EKhKdso+G5ViC
5G6t6lt7map/nG2PgrhB
=d4ou
-----END PGP SIGNATURE-----

--O3WNCzIuUImKerqE--
