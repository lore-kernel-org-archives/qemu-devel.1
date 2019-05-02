Received: from eggs.gnu.org ([209.51.188.92]:57450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hM2zd-0003oP-FY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hM2zY-0002Al-FG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:06:43 -0400
Date: Thu, 2 May 2019 14:04:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190502040459.GE13618@umbus.fritz.box>
References: <20190501223819.8584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20190501223819.8584-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for
 ppc64le
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2019 at 03:38:17PM -0700, Richard Henderson wrote:
> At present make check-tcg will produce errors like
>=20
>   RUN     tests for ppc64
>   TEST    test-mmap (default) on ppc64
> test-mmap: Invalid ELF image for this architecture
> make[2]: *** [run-test-mmap] Error 255
> make[1]: *** [run-guest-tests] Error 2
> make: *** [run-tcg-tests-ppc64-linux-user] Error 2
>=20
> which is caused by the use of the host ppc64le compiler
> in building guest ppc64(be) executables.

Thanks for looking at this.

I've staged this tentatively in ppc-for-4.1.  However while it removes
the "Invalid ELF image" message I still get:

  TEST    test-mmap (4096 byte pages) on ppc64le
test-mmap: Invalid argument
make[2]: *** [/home/dwg/qemu/tests/tcg/multiarch/Makefile.target:35: run-te=
st-mmap-4096] Error 255
make[2]: Target 'run' not remade because of errors.
make[1]: *** [/home/dwg/qemu/tests/tcg/Makefile.include:71: run-guest-tests=
] Error 2
make: *** [/home/dwg/qemu/tests/Makefile.include:1079: run-tcg-tests-ppc64l=
e-linux-user] Error 2

Running on a POWER9 host.  Do you see that as well?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzKbGgACgkQbDjKyiDZ
s5L24w//REl6xvTe5wVXIqtnzSHNRg5ICnV0AyZDD9M93o4Z6M0njqy6fEICrNTh
HOXJcExnDl9Mvn50zhYfeHghSYRyZi6PgbMfs3vVc2TBM7eOIJo9+m1suSA3V0WM
Q+yuCwaA+6+Ff2mvczd3sbFlXKPsOLieMcI9qup3ajhDp+wlHL6VtlysRh/z2P1r
JjL+Zu3M+VhUg28y1lUiAS8bnVXBjNW1YbFGm/rs0Znfr7eHYBrfpAuCA4CYd8EB
0qerJ6QuEw7AD9QTWgckXAfsSmSxPXXQ+s3he2otFg9txr9hbEpfYuXpuJlVemIv
U0kw9NkqkDEhRZlcWCj5S4nWjgnueoYreV02McPqH6NlC/bsWKz6DlCWOwVE8syB
fvHm1IT2coSTh9pQM1rgRg7VTSOAxJq8dYRqJX7hKhUP7/ddrkKUJi+gRBSpPvq3
/7daim5YQBgqoLatqY8ML1gFYlrG9LFdArew/y/Jv7RM+yE9B9m2nZx4l2ZGjiBp
z6oIupCb+P9wMCjtlpaiFotgcH0Ob8NoIK78f+6JeSi4f5oYWuF9EXwuYJVfoZkR
i2mqp05SE4ZbrYn7efQUGwttRkYr5dcA55kVnY3GuEmNbMq7JVvWTupB+9BNvtLe
jIxK5OngiFIqC0h76OZ20jh1pqVgbfjHDFH+xoVO1hKxx0cnugo=
=4hKQ
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
