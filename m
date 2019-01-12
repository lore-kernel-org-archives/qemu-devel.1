Received: from eggs.gnu.org ([209.51.188.92]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1giEgL-00068c-U2
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 03:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1giEgK-0007Kx-Vi
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 03:30:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1giEgK-0007K3-KK
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 03:30:16 -0500
Date: Sat, 12 Jan 2019 08:30:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190112083008.GA20193@stefanha-x1.localdomain>
References: <20181220152030.28035-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20181220152030.28035-1-remy.noel@blade-group.com>
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v4 0/2] Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: remy.noel@blade-group.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2018 at 04:20:28PM +0100, remy.noel@blade-group.com wrote:
> From: Remy Noel <remy.noel@blade-group.com>
>=20
> It is possible for an io_poll/read/write callback to be concurrently exec=
uted along
> with an aio_set_fd_handlers. This can cause all sorts of problems, like
> a NULL callback or a bad opaque pointer.
>=20
> V2:
>     * Do not use RCU anymore as it inccurs a performance loss
> V3:
>     * Don't drop revents when a handler is modified [Stefan]
> V4:
>     * Unregister fd from ctx epoll when removing fd_handler [Paolo]
>=20
> Remy Noel (2):
>   aio-posix: Unregister fd from ctx epoll when removing fd_handler.
>   aio-posix: Fix concurrent aio_poll/set_fd_handler.
>=20
>  util/aio-posix.c | 90 +++++++++++++++++++++++++++++-------------------
>  util/aio-win32.c | 67 ++++++++++++++++-------------------
>  2 files changed, 84 insertions(+), 73 deletions(-)
>=20
> --=20
> 2.19.2
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcOaWQAAoJEJykq7OBq3PI4P0H/2ODLDPlC9YKBO39rlwBK+EC
8vz2Bf7UYbYZ1YCPjGZ0Kp9FbUfww5jmxWqnUIP17S7kuP3dwwIGVnUdFdTmz5i8
XvRh+vkRP0CetgZWJnMkhXatjMa0ezb/LO8LZQKuYCOxJBlj6Zqin36ioX2J4gya
r2IM4mbauUNo6F34TfOP5LYdBAnyzPUaeep48Egd1Xv/8/9hZNhU5nlOOKuAIfhF
1AAakdTihlsxykeOBVmrkIP6sWLVV/fcrZSkuICOdV5PcIAulAXmKdbtfc4X0V+l
lxTp9sNyrlm+C14ip+0dmiVBeQ9/N9SxDRzs4Kemm7ond5RBMlRqR4fyBay9uu4=
=pdaJ
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
