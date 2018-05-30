Received: from eggs.gnu.org ([2001:4830:134:3::10]:57032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNzt6-0006fB-QZ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNzt6-0007Ps-22
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:07:32 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-3-rkagan@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <487a5f30-1398-21ad-1d00-e7f469247a05@redhat.com>
Date: Wed, 30 May 2018 14:07:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180426161958.2872-3-rkagan@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NHYpidK497Us6PYVREMel8RigWfRyRY3Q"
Subject: Re: [Qemu-devel] [PATCH 02/17] iotests: iotests.py: prevent
 deadlock in subprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NHYpidK497Us6PYVREMel8RigWfRyRY3Q
From: Max Reitz <mreitz@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <487a5f30-1398-21ad-1d00-e7f469247a05@redhat.com>
Subject: Re: [PATCH 02/17] iotests: iotests.py: prevent deadlock in subprocess
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
 <20180426161958.2872-3-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-3-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 18:19, Roman Kagan wrote:
> A subprocess whose std{out,err} is subprocess.PIPE may block writing it=
s
> output, so .wait() should not be called on it until the pipes are read
> completely on the caller's side.
>=20
> Subprocess.communicate takes care of this.
>=20
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  tests/qemu-iotests/iotests.py | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--NHYpidK497Us6PYVREMel8RigWfRyRY3Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsOk/kACgkQ9AfbAGHV
z0BxWQf7BcIgM8HKPJPKBrx7Xl0Z1DExA9e4XBMZS7G+gM3ZTk+BLuw7Qo31o2ER
AFDKYLvRrJYa5DuNtCSNrz80ERRVDf8ZZK75YmGUjaOORwRvnzr4I8SqenLiLJF8
B80C/027yY0bp9vsTrjFrmfwqS27nrDvfd7jax2PPbcVoGEe5YOaS6HxgKnUjMyW
ln0bxayUN8sVauAN5QrmbuaDmwgoFWTqUjNfjWXr4X+5iz+qacobzYFutS5FTBSm
eMhPLLLWv26bbhJ4+aTOk2oDvJr/7hNTIdIa+BIO92Uj3cwmWsYIuFKuOjltqStx
IZqHUuroYQngovVZFQO5Da3PzJqEYw==
=KB5v
-----END PGP SIGNATURE-----

--NHYpidK497Us6PYVREMel8RigWfRyRY3Q--
