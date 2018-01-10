Received: from eggs.gnu.org ([2001:4830:134:3::10]:56279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ5cN-0003SJ-U8
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 20:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ5cM-0006T0-Oe
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 20:55:51 -0500
Date: Wed, 10 Jan 2018 12:55:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180110015506.GO2131@umbus.fritz.box>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/d7X7C0hV/blnKmH"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: surajjs@au1.ibm.com, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


--/d7X7C0hV/blnKmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2018 at 03:15:25PM +0000, Peter Maydell wrote:
> On 9 January 2018 at 12:16, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
> > Thanks.  Even if you can identify which patch it is and we can
> > postpone that one would be a bug help.
>=20
> Bisection blames this one:
>=20
> pbonzini@redhat.com (1):
>       target-ppc: optimize cmp translation

Aha!  Ok, I'll pull that one out until we find a fix.

[snip]
> (This is a build for arm32, running in a chroot on an aarch64
> box, non-debug build.)

Ah.. but since it's a chroot, still an aarch64 cpu behind it all.  I
think the machines I managed to borrow were all much older slower
really truly arm32 machines, which I guess didn't show the problem.

Oh.. and probably a debug (default) build as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/d7X7C0hV/blnKmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpVcngACgkQbDjKyiDZ
s5Iy7A//ZJg7ysVkiNFVbPbfWryo4cKe1o+58vu58SG0K3jF557LKZVtMigLQHAP
5S/IrzWqBVzhAjH/Jy7kCEcC3fXxgWNSxyRpWeVbicXCIzXiksD7SlCAk8R86IHk
0phsu2NF8GgWxYAm4erCr/gNc7QQ+FxKe9GcQjGuJdxZScpPM7L3nloyjkCvLwrv
a5zai5DQQLUuBEczq5/i6vHRVcg7Nq1XCDT3OXY8c0oqEkMxEg9aWCOHNOsADbKu
1/q2H30gqOlEt17RkdQr8zr4adNIYSy4lUwBZzJ7mnVFceh4D6j0excRYUc5CZ52
vat0VFfKzDEQNA3HL+pIBfDdP5pKZTjzzcvI9aEMUBzX8tC63XU2UU7gxB/NcyXx
UepfWwiCw3knuvxG8bgiKj/LG4vPg/sifVLNiq23idYad1fwZCqEMEZ2vLbZXbNa
mSynmetEzpyAOWBbWii56e4dMZ3ZsLFvKWK1kN1DUNnmjr9GMvIHgmtRu6g1TxI/
aKB5bGYSas0N4QzvpxsWwlw8NGURgaWlt8LL/seOxJtvPYjcbDIdH50egyPU7eOu
QcEJ147J2HIBxnlOyX3d37Q+eRJAP2KyOB+2mmiJsn0w0PN5+Ww2+y44IDLwnnbg
ESqOB2K2c2wnRulBHsCpU6ZpuxFEezhtj7WYEswPUQCJ7kDcBxQ=
=hSeb
-----END PGP SIGNATURE-----

--/d7X7C0hV/blnKmH--
