Received: from eggs.gnu.org ([2001:4830:134:3::10]:50635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHAq-0008Vq-Vg
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHAn-0005RH-1d
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:00:13 -0500
Date: Mon, 13 Feb 2017 14:00:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213140005.GD10361@stefanha-x1.localdomain>
References: <20170203170729.12399-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <20170203170729.12399-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] test-vmstate: remove
 yield_until_fd_readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2017 at 09:07:29AM -0800, Paolo Bonzini wrote:
> The function is not needed anymore now that migration is built on
> top of QIOChannel.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/test-vmstate.c | 11 -----------
>  1 file changed, 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYobvkAAoJEJykq7OBq3PI9i0H/iBkcR5s4f8p/82Y1Uk0Segg
U62m4Z8stdohGEBSYbkbRxshGp74elESlEX4jZ0NX6+MIfHFrcyfmF2L1XzRtsDM
GvOvQM1tis18bwGbbrYJzahyrVWvGKUIrDSvFl+VitkCCxgEIRMz40lODiKs+3iO
knlKWpFjgHALYKt/R6dFcSUkWssVHcGWAMRaA1nW3a+8pILiWWyUkQ5eU+LcMIjQ
BLJYFnQMBRIkGCn4OR8S0NYz/Li1K4e+shtjwFD3lqX8jlLF8x5lgS6rZxI+bkop
4ibtOc9saErYHiOzgCe8JXaUySTGDOjHPjLFjhwxqqn8kWco7jMyXBlhloo5Xzk=
=tu2Q
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
