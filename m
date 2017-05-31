Received: from eggs.gnu.org ([2001:4830:134:3::10]:54950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2lc-0002cL-1v
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2lb-0008Bx-8y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:30:24 -0400
Date: Wed, 31 May 2017 13:30:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531123010.GJ16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-10-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3CAnR4CLEnEWqRMR"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-10-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/29] qed: Make
 qed_write_header() synchronous
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


--3CAnR4CLEnEWqRMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:50PM +0200, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 76 +++++++++++++++++++++++--------------------------------=
------
>  1 file changed, 29 insertions(+), 47 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3CAnR4CLEnEWqRMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrdSAAoJEJykq7OBq3PIsdgH/iHiZdcXejZTI5Bv8xRa7Ic1
/eySPKn44BYFHnM/3yGX4ltQkucQ5coTbp63PrL9rXyHjQmi4d8WAs6xnMHpQQ28
Z8CvG24dpaOQ94rJt9AoZoTcJf2rlIurD8tuIkmdwh937dmHcSBAuIfj+WOOm9qT
HrPRZbZDl7x6nUbg4nJHZmTyNW8/TC4USEXzSIp8zhnWir2Q/Qyn9/Lk9VOtO7jL
Pi/TTczk8y7fxjy/cSLVjXdAqvpjbh+dtmjVUDab++A5tlSh19PC4rfN4Rg2LZVi
4pvzyVev8yOK5uFGx821ga5a+mUsA8/HKly/2VlKsMaa+O6gL1r5hJjw1wv1n2w=
=1B2/
-----END PGP SIGNATURE-----

--3CAnR4CLEnEWqRMR--
