Received: from eggs.gnu.org ([2001:4830:134:3::10]:42037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3LOq-0007sh-D0
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3LOk-0000Xh-Ux
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:50:56 -0400
Date: Tue, 3 Apr 2018 13:50:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180403125047.GE4467@stefanha-x1.localdomain>
References: <20180323164254.26487-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20180323164254.26487-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: remove
 bdrv_dirty_bitmap_make_anon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 05:42:53PM +0100, Paolo Bonzini wrote:
> All this function is doing will be repeated by
> bdrv_do_release_matching_dirty_bitmap_locked, except
> resetting bm->persistent.  But even that does not matter
> because the bitmap will be freed.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/dirty-bitmap.c         | 9 ---------
>  blockdev.c                   | 1 -
>  include/block/dirty-bitmap.h | 1 -
>  3 files changed, 11 deletions(-)

CCing Fam and John, who maintain block/dirty-bitmap.c.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaw3inAAoJEJykq7OBq3PIwTQIAJt6+aM3h1fZrAyk2vK5SW+O
cIOtdiPYOWSWiwHL9z5lvG3OhcPJqCNFFmMOUjiwdK2XKnK7CO+IqKSJB3FugdV6
Du8BWh41ySJqifhoyqCf4CmaISV+JVhiy8B9WWNqvWqilvivmUOLNZstlu5FzcPc
Yv+wSmqM4ollXihvTt6v1IjOpdPolN1Uf46h0wPLRPa4nuN8ZRaO3H0fwSBZNkyJ
zTPUkQEmu4lbk2QiJ1aPBvrzC3z/Ae5FVBEncz/g1pFayU621RHSD+SV11BxbBAI
pDm3f8GYKfxs+b2tsZJt14sgJk8iCz262+i7FLenzxVZtXHnUeJeUC3DAHeC/S4=
=m1ts
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
