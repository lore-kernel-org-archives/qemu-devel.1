Received: from eggs.gnu.org ([2001:4830:134:3::10]:33260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw8tl-0007Nh-6n
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw8tk-0001Lu-9r
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:00:33 -0400
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73a0f01f-e3ef-3bb2-826c-1e338921b68d@redhat.com>
Date: Thu, 6 Apr 2017 10:00:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170406142527.25835-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ELhIkC6qeso7j2ncCGN0lUk5kK173b85n"
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] block: Quiesce old aio context
 during bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ELhIkC6qeso7j2ncCGN0lUk5kK173b85n
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73a0f01f-e3ef-3bb2-826c-1e338921b68d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] block: Quiesce old aio context
 during bdrv_set_aio_context
References: <20170406142527.25835-1-famz@redhat.com>
 <20170406142527.25835-4-famz@redhat.com>
In-Reply-To: <20170406142527.25835-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 09:25 AM, Fam Zheng wrote:
> The fact that the bs->aio_context is changing can confuse the dataplane=

> iothread, because of the now fine granularity aio context lock.
> bdrv_drain should rather be a bdrv_drained_begin/end pair, but since
> bs->aio_context is changing, we can just use aio_disable_external and
> block_job_pause.
>=20
> Reported-by: Ed Swierk <eswierk@skyportsystems.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ELhIkC6qeso7j2ncCGN0lUk5kK173b85n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5lgCAAoJEKeha0olJ0Nq/nQH/1F8a4ulrHkO/1fCM48Uyd3h
PR2mm3BNi5e7VccWZrKZSqhwUvoeShlrvnHr8nAYjdkW3T0xMX4+kDgGMJDWT0FH
z9FrEw29I9ddDaZ/18WcXtGXRIvKdYL35vDUGS5qoOcli4pZy8KIqMLG7fjQKc1k
JoK+d7Mq2osYhnlGJfk4wQ2MkQFkOq8PITbUiNXWpOWgaqnh3aLzgTuTs6dWsXex
GUx7Tvoqw0VXAduG7jswkzfv4vQyGyxfDyU/8jxff61DMqHCxfaegHV4fEZblEwp
BkZMaA3CZtgzz+9+3R4kOUeCfpN7HgonRN16d7NzEEZJn63N46JCIWGOxsuthJQ=
=5NAH
-----END PGP SIGNATURE-----

--ELhIkC6qeso7j2ncCGN0lUk5kK173b85n--
