Received: from eggs.gnu.org ([209.51.188.92]:54797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsqaU-0004mu-I0
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 10:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gsqaT-0007FR-Q3
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 10:00:06 -0500
References: <20190210145736.1486-1-mreitz@redhat.com>
	<20190210145736.1486-11-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <673c5958-ebec-cf0b-2e88-f2af421d8ea2@redhat.com>
Date: Sun, 10 Feb 2019 15:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190210145736.1486-11-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Tx9u0zetFpgqrKDefeSWHqw6JEma4vvzE"
Subject: Re: [Qemu-devel] [PATCH v3 10/10] iotests.py: s/_/-/g on keys in
 qmp_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tx9u0zetFpgqrKDefeSWHqw6JEma4vvzE
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <673c5958-ebec-cf0b-2e88-f2af421d8ea2@redhat.com>
Subject: Re: [PATCH v3 10/10] iotests.py: s/_/-/g on keys in qmp_log()
References: <20190210145736.1486-1-mreitz@redhat.com>
 <20190210145736.1486-11-mreitz@redhat.com>
In-Reply-To: <20190210145736.1486-11-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.02.19 15:57, Max Reitz wrote:
> This follows what qmp() does, so the output will correspond to the
> actual QMP command.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Dang it, sorry, I forgot to drop this R-b tag while rebasing.  It
shouldn't be here. :-/

Max

> ---
>  tests/qemu-iotests/206.out    | 56 +++++++++++++++++------------------=

>  tests/qemu-iotests/207.out    | 18 +++++------
>  tests/qemu-iotests/210.out    | 28 +++++++++---------
>  tests/qemu-iotests/211.out    | 26 ++++++++--------
>  tests/qemu-iotests/212.out    | 44 +++++++++++++--------------
>  tests/qemu-iotests/213.out    | 46 ++++++++++++++--------------
>  tests/qemu-iotests/237.out    | 54 ++++++++++++++++-----------------
>  tests/qemu-iotests/iotests.py |  6 ++--
>  8 files changed, 140 insertions(+), 138 deletions(-)


--Tx9u0zetFpgqrKDefeSWHqw6JEma4vvzE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxgPGsACgkQ9AfbAGHV
z0A40wf/eYp05kOpG2VoFQES1iDlc8swyImICjhBoZfNSlUv+8XUvXfcNrMDxLsR
SNNRQMWG/DCt+ghHx8W3MtDErccZZXVpi+X9DaIDjn67+ZICVt3hXCLHWRPmoBV7
33l18ZxzpnEmmE6/rPWTEqR1CYYv4zYbX6orAHvy/gdn7/SbOMGksJfhbBkU9ynn
viQHoY8a7MaaaSaCk1Vw6Ls9AneoECepC2D4o+gtWAua4k3aZSOmOvqvHvgekT4D
dHXEx0IVrzizqgy40i45T/CVBjlMLJT6MyIWSOrHFtUCd8/wMk4LyOTdScrInVXV
zbd7Fp00v+eOK25VXuT5ByW18YR7Og==
=fJmW
-----END PGP SIGNATURE-----

--Tx9u0zetFpgqrKDefeSWHqw6JEma4vvzE--
