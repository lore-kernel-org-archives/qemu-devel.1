Received: from eggs.gnu.org ([2001:4830:134:3::10]:49374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uFr-0005Aa-Ky
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uFo-00063I-JM
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:00:07 -0400
Date: Thu, 11 May 2017 16:00:01 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511200001.GJ24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-8-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-8-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 07/16] backup: Do initial
 aio context move of target via BB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:47PM +0800, Fam Zheng wrote:
> The old aio context check is hacky because when it was added we didn't
> have the permission system to enforce a general rule. It only checks if
> the target BDS has a BB, which is in fact insufficient because there may
> be other BBs in the graph that cannot handle the aio context change.
>=20
> Do this through blk_set_aio_context interface, in backup_job_create()
> which is a central place for both drive-backup and blockdev-backup, to
> take care of the compatibility check.
>=20
> Also the bdrv_set_aio_context in do_drive_backup could have been
> conditional, to save a recursion when possible.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/backup.c |  9 +++++++++
>  blockdev.c     | 14 --------------
>  2 files changed, 9 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMLBAAoJEJykq7OBq3PIT88H/1DX3dlxhAofu1iSQbmxjvwo
njujYOBBhR1mFyWa0kxD8Hed+kujwcK6uAOKlvSvCYKykOvs0FAPILx5UogScRyS
ZFAtcx8DSrzdy5yj2TuhHB+UjM/lkeoypPkJ0gkpMfkxAO7YNdyONzVcs/ICnDkV
zWWr/7KMoc7cVtkPnxlpp+g9G3ErwkjlSozIlw8SVo+2lQdFFKXdzvagK7x0j9fh
bUJZx9aSdi/2GsHsdgfacTIdtoZrJj5X8gaJABkvkrB0QqEYT5q5Hk9PXQ3Wu8cP
L0HS1oRkWRKBjSpuiwYxn7xwvuwgd4zmBYW7ns/FBx75n4KAsuF4cqJV0841u1Q=
=u2yk
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
