Received: from eggs.gnu.org ([2001:4830:134:3::10]:33391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG39N-0000mc-0B
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG39M-0008TH-D7
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:54:57 -0400
Date: Wed, 31 May 2017 13:54:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531125448.GB16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-28-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1kVeyRzorzGcO9ta"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-28-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 27/29] qed: Simplify request handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--1kVeyRzorzGcO9ta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:08PM +0200, Kevin Wolf wrote:
> Now that we process a request in the same coroutine from beginning to
> end and don't drop out of it any more, we can look like a proper
> coroutine-based driver and simply call qed_aio_next_io() and get a
> return value from it instead of spawning an additional coroutine that
> reenters the parent when it's done.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 106 ++++++++++++++++--------------------------------------=
------
>  block/qed.h |   3 +-
>  2 files changed, 28 insertions(+), 81 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1kVeyRzorzGcO9ta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLr0YAAoJEJykq7OBq3PIosQH/3UkUjBDEkBnib5n7Ll3ohb/
0yWI+Dv/uumIAwqp9wZ7KQ7f+qVL8Eo6CH2u5C9XtGCNftWXQeg4T0KbJNmSVXBy
0rrdKEdpr7m+hyjFrPwbR/a7t7EjWjMtHbW23ay2wwzrajCKG8vljC9OjEHnWYdI
sUFQgbHIBCmrAbWAgacwT16yUFH1+4aDNoGtk6qew1m8bfOd9/0CU0lRlDDDYTRN
H31edkf26RdSx5wn4g3ppKfRfFIky3l68XJNU6P0E2RyvYBbqEAAU+/ieQwemPBw
B1GkOhdgj3+/l71U2HJWLYMw+ft0zO6X/ngJQLw0WTKJITnU+/M99Jd7NWGAwI0=
=Ap+l
-----END PGP SIGNATURE-----

--1kVeyRzorzGcO9ta--
