Received: from eggs.gnu.org ([209.51.188.92]:53160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjlfT-0006xT-1n
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjlfS-0004XH-8d
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:55:42 -0500
Date: Wed, 16 Jan 2019 13:55:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190116135538.GB16898@stefanha-x1.localdomain>
References: <20190114133257.30299-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20190114133257.30299-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/2] throttle-groups: fix
 restart coroutine iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 01:32:55PM +0000, Stefan Hajnoczi wrote:
> v2:
>  * Added qemu-iotests test case [Kevin, Alberto]
>  * Use atomic operations instead of AioContext lock [Paolo]
>=20
> This patch series fixes a segfault upon device_del when virtio-scsi is us=
ed
> with iothreads.
>=20
> Stefan Hajnoczi (2):
>   throttle-groups: fix restart coroutine iothread race
>   iotests: add 238 for throttling tgm unregister iothread segfault
>=20
>  include/block/throttle-groups.h |  5 ++++
>  block/throttle-groups.c         |  9 +++++++
>  tests/qemu-iotests/238          | 47 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/238.out      |  6 +++++
>  tests/qemu-iotests/group        |  1 +
>  5 files changed, 68 insertions(+)
>  create mode 100755 tests/qemu-iotests/238
>  create mode 100644 tests/qemu-iotests/238.out
>=20
> --=20
> 2.20.1
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPzfaAAoJEJykq7OBq3PIQpwH/3nUcqHt47dKwL1iqh5kTnYb
mT/SVFLNo1vygxmV+1Wu97vQejoQeLXKkgreea1ywa0YRMkZmfuLNlzEds3SV4aC
qta+ep4W76Eco8C+J0lbi7iUHXIhlAJwGfunkoPtpIuXEp/g+njYjs/WrLRpYoOX
y01fIwUHGI35NrB16cSTX2HETH1LIu29KQIGHz5qO/X7YRvXFuBxbzXem8B4QGtD
TiByG1uGyOYVfrNEGREPphr49PDYFsehbsNZE4sq28nF4hNvuPLMKL1GFqdYNEjq
AblRhXhJWnK1kQQTZv6xgDcIS+iNT6/+0MEVdin6N6kG6qCJwuOA6ESB4ffKTc4=
=pdi+
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
