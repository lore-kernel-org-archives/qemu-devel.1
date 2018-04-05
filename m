Received: from eggs.gnu.org ([2001:4830:134:3::10]:47525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3v9C-0004DJ-6t
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3v99-0002PC-5F
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:01:10 -0400
Date: Thu, 5 Apr 2018 13:00:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180405030012.GH20851@umbus.fritz.box>
References: <20180405022002.17809-1-david@gibson.dropbear.id.au>
	<152289571648.1698.14222443168217841096@71c20359a636>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
In-Reply-To: <152289571648.1698.14222443168217841096@71c20359a636>
Subject: Re: [Qemu-devel] [PATCHv2 for-2.13 0/2] Helpers to obtain host page
 sizes for guest RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 07:35:17PM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Type: series
> Message-id: 20180405022002.17809-1-david@gibson.dropbear.id.au
> Subject: [Qemu-devel] [PATCHv2 for-2.13 0/2] Helpers to obtain host page =
sizes for guest RAM
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
> git config --local diff.algorithm histogram
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
>  * [new tag]               patchew/20180405022002.17809-1-david@gibson.dr=
opbear.id.au -> patchew/20180405022002.17809-1-david@gibson.dropbear.id.au
> Switched to a new branch 'test'
> 3a2019a8ad Add host_memory_backend_pagesize() helper
> d70b1b2b92 Make qemu_mempath_getpagesize() accept NULL
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/2: Make qemu_mempath_getpagesize() accept NULL...
> ERROR: braces {} are necessary for all arms of this statement
> #96: FILE: util/mmap-alloc.c:56:
> +        } while (ret !=3D 0 && errno =3D=3D EINTR);
> [...]

AFAICT this is a false positive where checkpatch is mistaking a do {}
while for a plain while loop.

> total: 1 errors, 0 warnings, 82 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 2/2: Add host_memory_backend_pagesize() helper...
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrFkTkACgkQbDjKyiDZ
s5KYmw//VeG8iePkl0KcLL/nHL4vXlS+9aPj28CpA5g0b7DOybS7uuIxM0llJHU7
UaYSa7ZXSBClbRxKoHfIk892fPID9W5ffCafjVwnp4P1gF6je1Ny8yQ+hNwnNsPq
TOg252Xyq4GQ30UqVhFNz5CaUIA2U4fR+b3ikrQ1hv0ixid0O32Ehy2e9oY1PyFl
irKy9zluCenD3luJSpLm37n+dxUZCr9G1rF/QwSN8wMeVu3SVK/uwO40Xq3UuVtq
2lkldPktHhA36ujzqC/9GNQ1dsVxD82Qrr0kcV+s5emYcw0augCwLncZtf9cBCXy
Z3/Taa975jDawAvmJMTp0Eu0I2U+Aq6/wRpEEPmzx15x9oDcbtTJN561a3Ou+HUv
SZUhG/8VhGmAMRAeCpjIE0ZTDZurqBZxP1G6X2tSUPwXHktpV2+VxaOddwh4JFm5
8t+m/AFeAZDo9EzBlIrpWqP6rT1XIolfjr1IsTnMagd2+sd3pgIGtUbWaDTHjMe1
GXT67OoNKv8KTHOu7kGCGJMZx328PTGI0DHuYRe44Hh8WEbIW/dpRhu8IUYV5keG
Suvq4HXG8+7jgyHsLih5NzI7Cxx1ZF9j2Be5NNY0325ZOGqJtA8j1g7k9wiHRker
0WaCTWa5g7w4/jFlptLEmDkwcKPSazDqCNoya4+/9EFrgqNvK4Q=
=TEaf
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
