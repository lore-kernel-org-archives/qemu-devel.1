Received: from eggs.gnu.org ([2001:4830:134:3::10]:50848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCncW-0003yF-4I
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCncQ-0007nC-7P
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:15:52 -0500
References: <20171109013804.14488-1-mreitz@redhat.com>
	<20171109013804.14488-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <099b72f4-fbc6-b7e4-5196-b4154aea9adb@redhat.com>
Date: Thu, 9 Nov 2017 08:15:32 -0600
MIME-Version: 1.0
In-Reply-To: <20171109013804.14488-6-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X3trWHvBOKoNQ2PGafi2tgmp6QehEt59r"
Subject: Re: [Qemu-devel] [PATCH 5/5] iotests: Make 136 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X3trWHvBOKoNQ2PGafi2tgmp6QehEt59r
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <099b72f4-fbc6-b7e4-5196-b4154aea9adb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] iotests: Make 136 less flaky
References: <20171109013804.14488-1-mreitz@redhat.com>
 <20171109013804.14488-6-mreitz@redhat.com>
In-Reply-To: <20171109013804.14488-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 07:38 PM, Max Reitz wrote:
> 136 executes some AIO requests without a final aio_flush; then it
> advances the virtual clock and thus expects the last access time of the=

> device to be less than the current time when queried (i.e. idle_time_ns=

> to be greater than 0).  However, without the aio_flush, some requests
> may be settled after the clock_step invocation.  In that case,
> idle_time_ns would be 0 and the test fails.
>=20
> Fix this by adding an aio_flush if any AIO request but some other

s/but/other than/

> aio_flush has been executed.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/136 | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--X3trWHvBOKoNQ2PGafi2tgmp6QehEt59r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEYwQACgkQp6FrSiUn
Q2pS4gf/Z7Q8j2IeVWf4ZINDX+MajRpTGi5kdGTINT67naVmybB6zz0CXbBaJWjH
jB4RjkQJKspcgafO+FdIUIhpcexEnbwDYz8pBOEbGnhV079sFrGmS3x+NnDW7gbJ
Bsnpl+C6n3S/dGm1HNAEkGVYHGvldtiDWbGhRYkC/nab8zs/Duzpm4UDQcMNJgLd
cPHL8xYq5tGGLQXMkT3CR0NF8LF9qwH7NclLEOr9lFJprPZTShxEMxPxJA8xTIy9
sEV69FOIdRT4CX4JduUON9tq1PN8SBCLKcVLm8mAUroC8ldmzlfxj85woTnvHcaL
OncOLQQzZJEyTdc5Xe7GeUGbRP+9Pg==
=XhGM
-----END PGP SIGNATURE-----

--X3trWHvBOKoNQ2PGafi2tgmp6QehEt59r--
