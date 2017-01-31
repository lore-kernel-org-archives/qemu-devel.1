Received: from eggs.gnu.org ([2001:4830:134:3::10]:50128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnp-0000O0-QJ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYXnp-0001Vc-0L
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:44:53 -0500
Date: Tue, 31 Jan 2017 10:25:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131102500.GB18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-2-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-2-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 01/21] backup: move from done_bitmap to
 copy_bitmap
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


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:44PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Use HBitmap copy_bitmap instead of done_bitmap. This is needed to unify
> backup loop for full/incremental modes in future patches.
>=20
> We reset bit of the copy_bitmap immediately after checking it in
> backup_do_cow(). It is safe, because all other intersecting requests
> will wait for our request finish anyway.
>=20
> The other difference is that in case of error we will have zeroed bit in
> copy_bitmap, when in done_bitmap we have not set bit.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkGX8AAoJEJykq7OBq3PI6FUH/Ruu+C4gxrjqOLBCj7HHfOpZ
HCtLQh0+FTiM9DMt2XorjFIimsKDYYFUmfP5+O3edesb+PZRDhjSX4Zp6avtH1p4
V6PxMt24WoFfXmCLHaCn+VLPQURjriBjhCJa2pFCQrpoy0nWyTPSYCUCV2r8EnQc
NkJYrsx6N43y8saNgRy2f+Zcyoql6WTNxtAtmoyu3TpiwnAskkZuBqzYtHp9br/V
Knf0bZ4NumHnfQPcdPXT7wDzLKUAgMA7HS2B4AVlOp6bFokFqDNYSFJ5RwibDTv2
9qf4hAak2dpAqtiJyX0l00ho4ddiOhQT/L5UmOEI+4ROdODNtXt2jFFBF3kYTZ4=
=qERi
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
