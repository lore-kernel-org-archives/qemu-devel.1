Received: from eggs.gnu.org ([2001:4830:134:3::10]:46504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHqm-0005og-E6
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHql-0007Bf-HY
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:25:48 -0500
References: <20180223192549.26666-1-kwolf@redhat.com>
	<20180223192549.26666-25-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d8e38b05-0879-6fda-c642-4d9eae7b2fa1@redhat.com>
Date: Mon, 26 Feb 2018 13:25:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180223192549.26666-25-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JIeqgdNO06EMmXfnMVSGr9fjMdPLQhMYY"
Subject: Re: [Qemu-devel] [PATCH v3 24/36] rbd: Use qemu_rbd_connect() in
 qemu_rbd_do_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JIeqgdNO06EMmXfnMVSGr9fjMdPLQhMYY
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <d8e38b05-0879-6fda-c642-4d9eae7b2fa1@redhat.com>
Subject: Re: [PATCH v3 24/36] rbd: Use qemu_rbd_connect() in
 qemu_rbd_do_create()
References: <20180223192549.26666-1-kwolf@redhat.com>
 <20180223192549.26666-25-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-25-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-23 20:25, Kevin Wolf wrote:
> This is almost exactly the same code. The differences are that
> qemu_rbd_connect() supports BlockdevOptionsRbd.server and that the cach=
e
> mode is set explicitly.
>=20
> Supporting 'server' is a welcome new feature for image creation.
> Caching is disabled by default, so leave it that way.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 54 ++++++++++-------------------------------------------=
-
>  1 file changed, 10 insertions(+), 44 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--JIeqgdNO06EMmXfnMVSGr9fjMdPLQhMYY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqT/MUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AP2kH/RM0rjbR0joeUUvV2e4afAUhFtdr5h04
O8TueCe6JU7O4Blm1M7jLX5RqlQlN+xMe1v/nMHBAWs3irno5mGP4r3CJf21tUTQ
FpP8KkMxV3u7xywM8qjdRy735B3Hm6GMNIXahkCM0ekNC4M104a7wWa9x+rzhl/f
PLEHUfv8LiYgrkVlSvnhS6V3F1jlCiN44NH7OeDHUHOmXJsosA1xA4OMxauwS58w
6r8P4Q3Ea6d2jV+nEYKWq6+vo0v6zMBqWud+cYfQgIRHVsI3a0iawEhXZk2Aco+k
4iIMlsYA6w5fUn9HDLi9S2qkiY/CC77U5FCo4i6RCADexlt1gCv5Oqg=
=/Ujw
-----END PGP SIGNATURE-----

--JIeqgdNO06EMmXfnMVSGr9fjMdPLQhMYY--
