Received: from eggs.gnu.org ([2001:4830:134:3::10]:50808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2l0J-0004Pg-BZ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2l0I-0000mb-BL
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:26:55 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5bd65154-58f3-bd56-7327-09025406e286@redhat.com>
Date: Thu, 12 Oct 2017 16:26:45 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a0mqMkbI4vseGt1qXFcSE7iSlnFO7XcfD"
Subject: Re: [Qemu-devel] [PATCH v3 03/13] nbd: rename some simple-request
 related objects to be _simple_
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a0mqMkbI4vseGt1qXFcSE7iSlnFO7XcfD
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <5bd65154-58f3-bd56-7327-09025406e286@redhat.com>
Subject: Re: [PATCH v3 03/13] nbd: rename some simple-request related objects
 to be _simple_
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> To be consistent when their _structured_analogs will be introduced.

space before analogs

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/nbd-internal.h                       |  2 +-
>  nbd/client.c                             |  4 ++--
>  nbd/server.c                             | 12 ++++++------
>  nbd/trace-events                         |  2 +-
>  tests/qemu-iotests/nbd-fault-injector.py |  4 ++--
>  5 files changed, 12 insertions(+), 12 deletions(-)
>=20

> +++ b/nbd/trace-events
> @@ -54,7 +54,7 @@ nbd_receive_request(uint32_t magic, uint16_t flags, u=
int16_t type, uint64_t from
>  nbd_send_reply(int32_t error, uint64_t handle) "Sending response to cl=
ient: { .error =3D %" PRId32 ", handle =3D %" PRIu64 " }"
>  nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attachin=
g clients to AIO context %p\n"
>  nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching =
clients from AIO context %p\n"
> -nbd_co_send_reply(uint64_t handle, uint32_t error, int len) "Send repl=
y: handle =3D %" PRIu64 ", error =3D %" PRIu32 ", len =3D %d"
> +nbd_co_send_simple_reply(uint64_t handle, uint32_t error, int len) "Se=
nd reply: handle =3D %" PRIu64 ", error =3D %" PRIu32 ", len =3D %d"

I'd also insert 'simple' in the log message.

Interesting that we trace when the server sends a simple message, but
the client does not (yet) trace which type of message it receives; but
that can be for later patches (I haven't checked if you already added it
later in this series)

Changes are small enough that I can make them as part of queueing them
on my NBD list, with:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--a0mqMkbI4vseGt1qXFcSE7iSlnFO7XcfD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf3hUACgkQp6FrSiUn
Q2oX+Af/Zf6Pw9Wa2p0Idco7uw1NSHYE/JYu2afyb2IgViGhrKySzl4syAeAbhpq
sLW+xSbYZVYwrJJ01heU8Hk3anBJLIt3VftfTn/C9GsVaQkMi5idlMlbURTXdVGh
Ue28aWC1WUb0OXz3lDVf+z4OGEHTdqO7Jw6xS2ril6Nc3S0NNx2uEeLtxiqb3mZH
T+xJFNFW5xw1QeFOfgsxITtNVbqPYJ5Xro400MdV5aDA6bsnNJdIb2pqpSZ5EWU+
ES7QeF7BUqhmx5VndAarQgHDyRsKDPtswHXUySjGRTQfLJBfBdnm1sdo0BBHpBYj
eyQccdkY4r+bkHJR0UFZAKdk0fHU6g==
=PhbP
-----END PGP SIGNATURE-----

--a0mqMkbI4vseGt1qXFcSE7iSlnFO7XcfD--
