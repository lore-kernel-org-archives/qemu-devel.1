Received: from eggs.gnu.org ([209.51.188.92]:49400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlUi-0002i1-FW
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlUb-00015a-4l
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:21:36 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-14-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d5147c7-3081-f04d-ee50-f9fc3cf27b84@redhat.com>
Date: Thu, 7 Feb 2019 09:20:47 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-14-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uXYwKow5ctPr3qxOkthoB59hvJP8QigIS"
Subject: Re: [Qemu-devel] [PATCH v3 13/17] migration/block: use
 qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uXYwKow5ctPr3qxOkthoB59hvJP8QigIS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <8d5147c7-3081-f04d-ee50-f9fc3cf27b84@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 13/17] migration/block: use
 qemu_iovec_init_buf
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-14-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-14-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  migration/block.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--uXYwKow5ctPr3qxOkthoB59hvJP8QigIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcTM8ACgkQp6FrSiUn
Q2o90AgAkhtjj0Q1dKJFJhfCUgZZmLsT2eR9NAPHeFjK/ziWz/mT10QnSz3vV7ia
U+pbg96p7gH+edT1rLvAIX5gvo0vJbonZ4GcNtCkiu54mgozxoU04+FDpfi0dp87
Mr6efn58xmD1iOyjmkAVWyyUFTTxWtfe0R/FTkJXxSlMIJD6kUJd6sLjDg5x2vxB
m65cD5gqAGDlDKc1oUvnUqE2XkBW+jHO3jgD5Lfc0cqprkWh6pUHMb73TenQDKpm
Z4vlqNIFxurCqxYNpOEASnvUlgZC4RrjqBUEB8UeiXDAe6uIIF5shvIeUR+Fn8Qh
1Qc9t9TkWTPe8uFCtQG5kXHxnmtNQw==
=wU0W
-----END PGP SIGNATURE-----

--uXYwKow5ctPr3qxOkthoB59hvJP8QigIS--
