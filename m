Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGwPf-0003Eo-Uk
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGwPe-0003qe-Sw
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 19:27:43 -0500
Date: Tue, 21 Nov 2017 11:25:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171121002555.GP19214@umbus.fritz.box>
References: <20171120071423.11693-1-david@gibson.dropbear.id.au>
	<151116233520.519.2313246296341795954@bafd83ae6430>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qnK4RqISe3HuYx1/"
Content-Disposition: inline
In-Reply-To: <151116233520.519.2313246296341795954@bafd83ae6430>
Subject: Re: [Qemu-devel] [PATCH] spapr: Implement bug in spapr-vty device
 to be compatible with PowerVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, lvivier@redhat.com, paulus@samba.org, groug@kaod.org, qemu-ppc@nongnu.org


--qnK4RqISe3HuYx1/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 11:18:55PM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Subject: [Qemu-devel] [PATCH] spapr: Implement bug in spapr-vty device to=
 be compatible with PowerVM
> Type: series
> Message-id: 20171120071423.11693-1-david@gibson.dropbear.id.au
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
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/20171120071423.11693-1-david@gibson.dr=
opbear.id.au -> patchew/20171120071423.11693-1-david@gibson.dropbear.id.au
> Switched to a new branch 'test'
> 08e9d8fe82 spapr: Implement bug in spapr-vty device to be compatible with=
 PowerVM
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/1: spapr: Implement bug in spapr-vty device to be compat=
ible with PowerVM...
> ERROR: spaces required around that '-' (ctx:VxV)
> #40: FILE: hw/char/spapr_vty.c:68:
> +        if (buf[n-1] =3D=3D '\r') {

I've corrected this in my tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qnK4RqISe3HuYx1/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloTcpAACgkQbDjKyiDZ
s5IBDRAAxEf9MftrNPcwfS5sAYhZqwtrsrkkTLXdHtBba3M3u/rcmKhxI6B89vZM
5BmGVQ1bIMauWlj/9Hlb0imU628nGwFnYjeFCgewHeJ2WCiVot2sXM58p61+amQ8
LV7Ns/pvOWPI4zlb0k0U78GEGYYXBNwF/f2WW8q9dArnmocqnqwiwKnpvmOsHkyi
DzPV8rRTNeUnuzUfpK4kIcPKzyysH1eIQimQjRv8DC3Uax4gJ2ph3if9ZfNR6H+h
x2u+TqDAeGUpXcoYDVpRgfAPcLCkz8FEOlRAFB+9IoABSJ68XYh4UvMxJB66p7jL
onWi8BLeFIQX/LoLunmj24rs7hUYEbRmH860jnvjLmpgqa4vG7f/rhPkb6+2FEqr
LxTEabHvq1S6qJsvyybHySXTvybNyWQtJs2m1+f08CDQTiQtVl9B3BwKqjxxEok3
GdoTKMA3mVhuo28oij7rU+iQx9eDyj4jCy+zlXzvnc+Glice6y4IYslIAKHd0esW
tgZ77JtV+CU5kqcsrGu+ILCSrWFRWti9Xv5d+Vs5PFKbshNmjQrud2JLm6MBONb1
/YzcY8n1+vbViwOzPS0kB7imteNjNtK7rk3gILCmMYhFMRZPitkyCivTMwCm3Xff
lxW5BkQhZ4rXL8wd0ac5gX6tG4o8JBRTAj2+Ga9neRMrYZGfuts=
=q57C
-----END PGP SIGNATURE-----

--qnK4RqISe3HuYx1/--
