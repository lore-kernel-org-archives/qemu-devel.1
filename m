Received: from eggs.gnu.org ([2001:4830:134:3::10]:55935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPVgI-0005x4-0d
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPVgD-0002Fy-Ue
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:12:01 -0400
Date: Mon, 26 Jun 2017 16:11:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626151154.GG29664@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-7-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-7-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 6/8] block: add options
 parameter to bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 03:46:58PM +0300, Manos Pitsidianakis wrote:
> diff --git a/block.c b/block.c
> index 694396281b..c7d9f8959a 100644
> --- a/block.c
> +++ b/block.c
> @@ -1150,20 +1150,25 @@ free_and_fail:
>  }
> =20
>  BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *nod=
e_name,
> -                                       int flags, Error **errp)
> +                                       int flags, QDict *options, Error =
**errp)

Please add a doc comment that explains the QDict ownership when options
!=3D NULL.  Users need to understand whether the options QDict still
belongs to them after the call or bdrv_new_open_driver() takes over
ownership.

See bdrv_open_inherit() for an example.

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUSQ5AAoJEJykq7OBq3PIcPgIAMQuZcN9lpwV1GTlk7OgGlyF
WgPAPbsAs0t16m4qCYsgwosGM0E8rSGVCEy+0LJHa6yYkkaxSfjvo9X8SS+nJiqk
qQDUbILGuYfAsOQZ7fXkS21VchD3RRqmKE50xMfsy4i6cURvbsNmoUR26lXNo6jU
oUwoNVAW6qgUVAsIIcbrMuK87i6tT1POOsT9Pq2oNlm645rnhaS5EqeadRXCa45w
PwGbOmWjEREoJb4bcp+/ETeSHku7dhXFP/me2j+9dzSRk6Ovkv9vegSklynWdhDR
rve8BAzV8DG7gHYqk+s1VIuNDloHNDk7Bloc9zG3XxiZosFXMT/O3aZFsoEiyxw=
=Uh3f
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--
