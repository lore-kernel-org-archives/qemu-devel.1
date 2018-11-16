Received: from eggs.gnu.org ([2001:4830:134:3::10]:59338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gNf7W-00067q-Co
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gNf7V-0006rM-K9
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:29:18 -0500
Date: Fri, 16 Nov 2018 14:29:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181116142903.GB9742@stefanha-x1.localdomain>
References: <20181016132018.5054-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20181016132018.5054-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: fix Coverity
 CID1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, peter.maydell@linaro.org, den@openvz.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 04:20:18PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Theoretically possible that we finish the skipping loop with bs =3D NULL
> and the following code will crash trying to dereference it. Fix that.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  migration/block-dirty-bitmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
> index 477826330c..6de808f95f 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -288,6 +288,10 @@ static int init_dirty_bitmap_migration(void)
>              bs =3D backing_bs(bs);
>          }
> =20
> +        if (!bs || bs->implicit) {

Why is it necessary to check bs->implicit?

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb7tQvAAoJEJykq7OBq3PIyrUH/jc8mcRqs29AcohcfNxkEwBo
NRIlntn3Nu96+uaoWo/3/ezf5DgXP2+fTi6YiG9OGm7S4nELbRLckMZzFmKgMeno
xke8ybpHFIPjIb/7FDvkeO91I/YXvUJ2TislchvQCrseuMnQKJlNzUtjXQFZ/TNq
MwHlR0vf9KAdVLOLUaeyPVVxFsR8dDxXDXrvggKArvuQMg7e/xFtO6IhdXq8oHI+
AKFVzdiGOdQ0wzNC9uVhn8jFCv6Bz7M8Pr4syPrdLCwecPmUJMbDhDq58eRIzrxx
xRpj1wzoBbm7kvR71KBCCqPyVhXFPCJwOihtzloHVLuB5+QhrK9ho0MN5gkRJSg=
=no+w
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
