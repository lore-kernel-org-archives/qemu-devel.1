Received: from eggs.gnu.org ([2001:4830:134:3::10]:49418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFizT-0006C8-RS
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFizT-00024h-0p
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:55:39 -0500
References: <20171117154739.32565-1-kwolf@redhat.com>
	<20171117154739.32565-2-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3332fed1-d975-b5af-39f1-900702ecab0e@redhat.com>
Date: Fri, 17 Nov 2017 16:55:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171117154739.32565-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RbM7O7hG5BJKKXLhqQ8o2Js5uTWMG0gqO"
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/2] block: Fix permissions in
 image activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RbM7O7hG5BJKKXLhqQ8o2Js5uTWMG0gqO
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org,
 qemu-devel@nongnu.org
Message-ID: <3332fed1-d975-b5af-39f1-900702ecab0e@redhat.com>
Subject: Re: [PATCH for-2.11 1/2] block: Fix permissions in image activation
References: <20171117154739.32565-1-kwolf@redhat.com>
 <20171117154739.32565-2-kwolf@redhat.com>
In-Reply-To: <20171117154739.32565-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-17 16:47, Kevin Wolf wrote:
> Inactive images generally request less permissions for their image file=
s
> than they would if they were active (in particular, write permissions).=

> Activating the image involves extending the permissions, therefore.
>=20
> drv->bdrv_invalidate_cache() can already require write access to the
> image file, so we have to update the permissions earlier than that.
> The current code does it only later, so we have to move up this part.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--RbM7O7hG5BJKKXLhqQ8o2Js5uTWMG0gqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloPBnASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvZoH/3hmfowSeQA5dnRFhYrRTzxpXSyNyKT4
uqugg2/Edq/4FeVTQ8nsRdbelEvpyAbpmLvfGPgf7oI8e/xd5g0c2QgmyGWQEoeK
rj2nJej8/Q1abv2pBmeB2GP25TCsWXrexlHkmEMyRAX9ebxr+5ZEKBUgoQORmOrx
EQ+z/b4cN0kuNyUoPHApv0dwemTnbUXWl1aaAwc0qKZqK1nZ6O10HHcAS1g4qPwf
6Vz6sy+JZBq3dB3J9BNPvIU5weNv90HGlwdWqX3tOL8Zro64QCaiZ3hWl9oGwErO
4NLeWJBnmuCUD3OTmAHOjLyoMDV3mNYRrDR2XryByVQy6MG7cktjThk=
=gb46
-----END PGP SIGNATURE-----

--RbM7O7hG5BJKKXLhqQ8o2Js5uTWMG0gqO--
