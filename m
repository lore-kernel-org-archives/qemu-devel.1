Received: from eggs.gnu.org ([2001:4830:134:3::10]:39898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gZHMZ-0004oL-Ln
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gZHMW-0000Vl-Cw
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:32:51 -0500
Date: Tue, 18 Dec 2018 15:32:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181218153207.GG18767@stefanha-x1.localdomain>
References: <20181217164847.24411-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline
In-Reply-To: <20181217164847.24411-1-remy.noel@blade-group.com>
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v3] aio-posix: Fix concurrent
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 05:48:47PM +0100, remy.noel@blade-group.com wrote:
> From: Remy Noel <remy.noel@blade-group.com>
>=20
> It is possible for an io_poll callback to be concurrently executed along
> with an aio_set_fd_handlers. This can cause all sorts of problems, like
> a NULL callback or a bad opaque pointer.
>=20
> This changes set_fd_handlers so that it no longer modify existing handlers
> entries and instead, always insert those after having proper initialisati=
on.
>=20
> Also, we do not call aio_epoll_update for deleted handlers as this has
> no impact whatsoever.
>=20
> Signed-off-by: Remy Noel <remy.noel@blade-group.com>

Tested-by: Stefan Hajnoczi <stefanha@redhat.com>

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcGRL3AAoJEJykq7OBq3PIXzYIAJKVJb/cxL28tBsgNRgNARdN
R030eCI6p0vLcGWHS1mnyBuNZQE1manAGnXdFUqWmayvWR2F13G4fM3AeCOM/NVP
UfNU77ee90716J3kOXXHczlfadxaYpzJawpleng+mtTiu/tctifblSP4+TOOO6rr
kcQ+nhIgCGG8NYNnDLg441ScH4Y8OF46Yj52rhJ5xjjsxv08mqXBb9n4njh4tOHc
60SCju3YadUIenfmFGo6NIyk0NUrEmeywHhqw3xQh6Jry6HCfFxwFvPylQCANf1v
Rotqee6rqDy8LvkNynJRST40nuxVo0owbYapE/QgmIaQLqggQNV7Gss5UxMDcUE=
=/1Gb
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
