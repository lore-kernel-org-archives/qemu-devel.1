Received: from eggs.gnu.org ([2001:4830:134:3::10]:43744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8txX-00060L-Nz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8txS-0003FB-Ra
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:41:11 -0400
Date: Thu, 11 May 2017 15:41:00 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511194100.GI24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 06/16] backup: Request
 BLK_PERM_AIO_CONTEXT_CHANGE on target
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


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:46PM +0800, Fam Zheng wrote:
> What's done in the source's context change notifier is moving the
> target's context to follow the new one, so we request this permission
> here.

It's true that the backup block job must be able to set target's
AioContext, but does this change also allow other users to set target's
AioContext while the backup job is running?  If yes, then we need to
handle that.

> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/backup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index a4fb288..546c5c5 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -636,7 +636,7 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
>      }
> =20
>      /* The target must match the source in size, so no resize here eithe=
r */
> -    job->target =3D blk_new(BLK_PERM_WRITE,
> +    job->target =3D blk_new(BLK_PERM_WRITE | BLK_PERM_AIO_CONTEXT_CHANGE,
>                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
>                            BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD);
>      ret =3D blk_insert_bs(job->target, target, errp);
> --=20
> 2.9.3
>=20
>=20

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFL5MAAoJEJykq7OBq3PIf04H/1DK456AX8NgisSfHHyzhw0C
9im2FKjyr22seXo6bWAklRZ95QdbQV9AuHSY/kNykfByaNHKn7ubX6WVxjK8xzMJ
Ond+fk+tV9QbcS6G++yjkOYuGIW/iXjeLdDRN9/HBu0DxBurHSFBzUt7JpCsvV7g
PikKv5PhGkLM4Cab/rV00T7OKZ0BDhiwUGb1Un8ZNUxSyhv82HO0DLvW3ye14o2g
2wZ1IiauvqoGAj0RD1/bTMX6vzinvANfx63cX2y5vCQDzbRji0gG9fsAzzw1WjA3
e/xSwWbXl/AKxjSrhOBbDt7QqlO+FNn/E7FkM31orzz0oUUddtdNgUEfAlNb7Ws=
=JZ6+
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
