Received: from eggs.gnu.org ([2001:4830:134:3::10]:34040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNc1I-0006RB-Hp
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNc1H-0002l9-Py
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:38:24 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-2-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <57c0dd5d-f988-814b-1b27-65dfbbfe2d62@redhat.com>
Date: Tue, 29 May 2018 12:38:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZuStlgyZTb3hm31vYwO8s3jZXgg4lPWII"
Subject: Re: [Qemu-devel] [PATCH 01/14] vdi: Fix vdi_co_do_create() return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZuStlgyZTb3hm31vYwO8s3jZXgg4lPWII
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <57c0dd5d-f988-814b-1b27-65dfbbfe2d62@redhat.com>
Subject: Re: [PATCH 01/14] vdi: Fix vdi_co_do_create() return value
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-2-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> .bdrv_co_create() is supposed to return 0 on success, but vdi could
> return a positive value instead. Fix this.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vdi.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ZuStlgyZTb3hm31vYwO8s3jZXgg4lPWII
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNLZYACgkQ9AfbAGHV
z0AsDwf+Nj5sBNPPfXOp7/hsklI29k9g+SQKmNArb+hWBqWJ4JqyTaIrj/bjbQOw
bn+pNgsuvgRsK6l/rSb+iVBYtBNFeqlT7YcgIJt6gegh9mJkDE3FEhX6bMNoUsMp
V9yexFwAkRZYQloeXC85+fomEPz53F49usrl/LMeeDDha+66nJR9qY816vRJ2xFA
UKEeTiuOwiMOwY2ipOZXWtORHUKxNuPRPtIxV61kVEnkI67sAL78doizqE8TNfS/
dL6rskAoLwYud1nibAPSPGFjDXJ3iZA5lEhFvcgB19e8oS9WvAsb3LCgJtxBrlIJ
R/Sbz7y2XHOFHNFKTUQbmZTp9+WQ5Q==
=h5Kb
-----END PGP SIGNATURE-----

--ZuStlgyZTb3hm31vYwO8s3jZXgg4lPWII--
