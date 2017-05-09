Received: from eggs.gnu.org ([2001:4830:134:3::10]:48387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d86Jj-0004lZ-2B
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d86Ji-0005If-5u
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:40:47 -0400
Date: Tue, 9 May 2017 10:40:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170509144036.GC16825@stefanha-x1.localdomain>
References: <20170504173745.27414-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20170504173745.27414-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Simplify BDRV_BLOCK_RAW recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 12:37:45PM -0500, Eric Blake wrote:
> Since we are already in coroutine context during the body of
> bdrv_co_get_block_status(), we can shave off a few layers of
> wrappers when recursing to query the protocol when a format driver
> returned BDRV_BLOCK_RAW.
>=20
> Note that we are already using the correct recursion later on in
> the same function, when probing whether the protocol layer is sparse
> in order to find out if we can add BDRV_BLOCK_ZERO to an existing
> BDRV_BLOCK_DATA|BDRV_BLOCK_OFFSET_VALID.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEdTkAAoJEJykq7OBq3PIgVYH/jQsBu1HbeEWrl7J5eFYbtuN
6KxblzQKYjQhq6gg5godsARMmAgNa7LRNSZ16eT+4VE4KD/KzW0oy6cV+oBkgWYw
bMji7LtneAQStFNV90RSbYFl7krwznt8E4xrlwbM1oG0CvEJ/9ZmOgvi6+R6M8Po
7igqKok4ot0DD3GuFSmH0gM7fSpR15uqYSrVxKybzLKtRKXxQ+7ewyNMnbuY71fY
YLIoqmpeatUo+QCNixpDd/jC0xfRwU7Hz7w6K+0CRrjUKiiMwpmANK7abqvievdk
AY9s2CyxSOZpVlQDHMNUkSFiqSpcOfO5hpaSov9oMpwkgrGszExoSdg/yTVZZxo=
=ektx
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
