Received: from eggs.gnu.org ([2001:4830:134:3::10]:50191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnw-0000T4-E5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnv-0001YB-P5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:45:00 -0500
Date: Tue, 31 Jan 2017 11:01:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131110114.GE18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-5-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-5-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 04/21] backup: use copy_bitmap in
 incremental backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:47PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> We can use copy_bitmap instead of sync_bitmap. copy_bitmap is
> initialized from sync_bitmap and it is more informative: we will not try
> to process data, that is already in progress (by write notifier).
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 58 +++++++++++++++++++---------------------------------=
------
>  1 file changed, 19 insertions(+), 39 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkG56AAoJEJykq7OBq3PI2bcH/0/hcaEUiiKIaHg01r7+INP3
Akkg8xYwUIpR1RboTJRPDVzsO6UclrVq6371CBOnz3nJjRWZDhVEq/7GupTi0Ol3
ILr+Vq5fsDh44ToPs+onz53Oxk/ivIkJFOXq3MQIGRBwb/FNt9P2NBMA9oiUy6FO
eGmhQt4QqASXwp2LGPHPyD0eY7zvUcKpb0AfuigjUBZnqaQwsQXFnQ588xqwe5U/
MZFhqLCMwFtU9QKjCTXU3EIkPZSRJkLwG6pwpluCnK0ltlGbVNPYdwBhXhK2gdv+
m0zr1T3Om/xkHnwKTSsrhe89DxWV4nIiM+RFEXZmfm2lQbgibkr4+EoOdiHLkgM=
=r1lO
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
