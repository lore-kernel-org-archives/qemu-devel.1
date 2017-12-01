Received: from eggs.gnu.org ([2001:4830:134:3::10]:47312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrsa-0000MP-N2
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrsZ-00010L-IP
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:25:48 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-4-crosa@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7819fc24-60cd-fe5b-130a-d5dd0dbe664d@redhat.com>
Date: Fri, 1 Dec 2017 21:25:40 +0100
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-4-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iC1J5GnBKPvL3Se7xOaLtI98dVvnTsRMm"
Subject: Re: [Qemu-devel] [PATCH 03/10] qemu-iotests: be strict with
 expected output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iC1J5GnBKPvL3Se7xOaLtI98dVvnTsRMm
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <7819fc24-60cd-fe5b-130a-d5dd0dbe664d@redhat.com>
Subject: Re: [PATCH 03/10] qemu-iotests: be strict with expected output
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-4-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-16 18:38, Cleber Rosa wrote:
> The contract between runner (check) and test is one that accepts some
> minor differences in the expcted output, as the comparison method
> employed is a "diff -w".
>=20
> This is an exception to a clearer and more straightforward rule of
> just requiring the generated output to be *equal* (and not similar) to
> the recorded expected output.
>=20
> Let's drop this exception and make things more predictable.

But this has been a conscious choice, as your very patch shows.
checkpatch yields 48 trailing whitespace errors, which is exactly what
the -w is for.

Also, I can't apply it because the 061.out hunks have been line-wrapped
by the \r for some reason.

Max

>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/026.out | 92 +++++++++++++++++++++++---------------=
--------
>  tests/qemu-iotests/049.out |  4 +-
>  tests/qemu-iotests/061.out |  4 +-
>  tests/qemu-iotests/104.out |  2 +-
>  tests/qemu-iotests/109.out | 44 +++++++++++-----------
>  tests/qemu-iotests/175.out |  2 +-
>  tests/qemu-iotests/check   |  4 +-
>  7 files changed, 76 insertions(+), 76 deletions(-)


--iC1J5GnBKPvL3Se7xOaLtI98dVvnTsRMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohusQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzsMIAJjUkc2t+Ly8MXh1iRICYfZaaHPqc7nD
L2dbgSwbI9LtcTmx15Gj0JSXs4aArVpkShA++AWcyCjyTAOCHJRwLpl+yTJzu5QI
mvrsZ87YcRAGm2KzKNjPgihMfMk/cZ25pwhnH0lnWcE+p6xeyVco+0107K0/T9gP
Nb8dz/C9Vpg7cWboi7dMrG4LzYZkZcILGCzkGFDGcVepCkYI+Dv/jD2rgU5qJdyf
ww0GmVTrXXGMIlI3QKCpSB1FphgZWKIHlqM/buA5bltvD+8BL7+wv4aP/X//E8wk
IJ6ciYnvZCCVA1W+hj9pUbKsSbWScLDVIRY6sFbfQIeqFMuQZRuX57w=
=u/rA
-----END PGP SIGNATURE-----

--iC1J5GnBKPvL3Se7xOaLtI98dVvnTsRMm--
