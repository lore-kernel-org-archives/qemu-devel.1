Received: from eggs.gnu.org ([2001:4830:134:3::10]:57432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEY7-0003UI-7c
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEY6-0000fE-Fw
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:22:35 -0400
Date: Fri, 25 May 2018 16:22:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180525152226.GC21895@stefanha-x1.localdomain>
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180425183223.580566-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <20180425183223.580566-9-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] block: Removed unused sector-based
 vectored I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 01:32:23PM -0500, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Now that all callers of vectored I/O have been converted
> to use our preferred byte-based bdrv_co_p{read,write}v(), we can
> delete the unused bdrv_co_{read,write}v().
>=20
> Furthermore, this gets rid of the signature difference between
> the public bdrv_co_writev and the callback .bdrv_co_writev.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/block.h |  4 ----
>  block/io.c            | 36 ------------------------------------
>  2 files changed, 40 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbCCoyAAoJEJykq7OBq3PIYi0IALShppSOINR51/wYFY2jsxTy
xs3KLYcveQF2rrkp6u/4cKgxosZh+dOPB1+ppcw590X7kc6OZcj2ZMN4kfkNcd3N
HxiK0EnsFEQ5m+Ue4meMVov/tzcyBeqj2l2kN1gi7VqGMMATyQL2lwUa6ew0LNQZ
wEuQpHJ//dvGo5Q89CqxgCgiCbn8oAjmsURn4BFzhyvd97wKoOS+rTA7m1kPMFOA
7yL0EKznyS2xy6yQ7vZS21Y3qpIOsysUkfpmTlUqzV7hq4bTNIf1p94aO5jbEcOY
B3MaSbdS6B4UYFa3P5ssAn3+3DOgWh6FvuekVgPwLKDCJdWqWdsud6q8/wKi6xs=
=KZs2
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
