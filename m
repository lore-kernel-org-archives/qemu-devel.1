Received: from eggs.gnu.org ([209.51.188.92]:37193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ggtfP-0002pn-Ll
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ggtfM-0001lJ-D0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:51:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ggtfM-0001ha-6v
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:51:44 -0500
Date: Tue, 8 Jan 2019 15:43:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190108154308.GB1506@stefanha-x1.localdomain>
References: <20181220152030.28035-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
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


--aVD9QWMuhilNxW9f
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

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNMUMAAoJEJykq7OBq3PIc3cH/17wgL90yUSJoEM61VhWihAk
71IH99cExaJ+Hywskyu/lOYcwq91x7DVViE8u+BUGYqPDmA0XNKE7Tsa+yQcPNFR
JLu8xyfFfoX4Sm83ltUVxatNsUVo9R3gRahMNuTlaPOubjoDWxD8JS7pN5Gr9czt
P9fXhN0LxyIVVqtpks5ENrPWHhpTiDx2ugHR1W3S41wH7mzcJvhNB67Tq77zDUvJ
/foDm9lE7KINqMdO8uP5T7jq0Bu3Rz7PYO39xs3D0OB1gpkcNKc3VA9e5kHBacag
1Ftt4pRFWxhYgPR7M473bGPfeOn/nwTfCM6TPeN7adoy1wFBbm/lh6HwgLQOk9w=
=d1E7
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
