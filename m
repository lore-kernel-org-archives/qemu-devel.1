Received: from eggs.gnu.org ([2001:4830:134:3::10]:40439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxVK7-0005nE-H8
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 06:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxVK6-00011a-Sz
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 06:46:11 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-11-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a9e20c86-4ecf-e05f-d102-df35ed2c877f@redhat.com>
Date: Wed, 5 Sep 2018 12:45:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180904170930.28619-11-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="89joxP59gFbMNLbhYv9YiG6PUT2cdkiyR"
Subject: Re: [Qemu-devel] [PATCH v4 10/15] tests/test-blockjob-txn: move
 .exit to .clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--89joxP59gFbMNLbhYv9YiG6PUT2cdkiyR
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>
Message-ID: <a9e20c86-4ecf-e05f-d102-df35ed2c877f@redhat.com>
Subject: Re: [PATCH v4 10/15] tests/test-blockjob-txn: move .exit to .clean
References: <20180904170930.28619-1-jsnow@redhat.com>
 <20180904170930.28619-11-jsnow@redhat.com>
In-Reply-To: <20180904170930.28619-11-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-04 19:09, John Snow wrote:
> The exit callback in this test actually only performs cleanup.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/test-blockjob-txn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--89joxP59gFbMNLbhYv9YiG6PUT2cdkiyR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluPs+YACgkQ9AfbAGHV
z0DYDQgAw2iT7qmLLTdgl04iqWJmtnPh9F2zCoYqwjcyZLw7jo5KnRjH0gFqHop+
RCbfiSTU0b5Kv9pn/Gfw+ZQRYM4XMFsdVE64/kdyPgfPQFc+aTGIJ4T7EefQF/CQ
kfH6/qTaKPGJTFFK6o19NqD0G6eNiAiFfWUXyXm46mI/C5yAs1uyFr8gEbfQmOv+
lhJKUFbUfsdfNwe0vhzg+A+CJH5zO8FNSTZIYaFGYGKqCgzEZ+11T4OrqUUL4f0P
vNOCpFx8Es7ue9mJuIEq9HfcMt7wjdCmIkDLvOdN37I3jlHDy4hq6E2y+G9nCUJx
CjCudxoUznlTPk4YFMEALRmOzzELmA==
=8cNI
-----END PGP SIGNATURE-----

--89joxP59gFbMNLbhYv9YiG6PUT2cdkiyR--
