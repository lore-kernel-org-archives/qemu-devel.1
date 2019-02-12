Received: from eggs.gnu.org ([209.51.188.92]:55412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtdai-0003Up-47
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtdaZ-0000hx-9M
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:19:30 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-5-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1482c45-ff59-4c50-d7e2-97fb4bf73305@redhat.com>
Date: Tue, 12 Feb 2019 13:18:44 -0600
MIME-Version: 1.0
In-Reply-To: <20190212010248.11056-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0RJP2feqlMiYLLOxiLYCDi8BC6AvtZvsd"
Subject: Re: [Qemu-devel] [PATCH 4/5] block/dirty-bitmap: explicitly lock
 bitmaps with successors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0RJP2feqlMiYLLOxiLYCDi8BC6AvtZvsd
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <d1482c45-ff59-4c50-d7e2-97fb4bf73305@redhat.com>
Subject: Re: [PATCH 4/5] block/dirty-bitmap: explicitly lock bitmaps with
 successors
References: <20190212010248.11056-1-jsnow@redhat.com>
 <20190212010248.11056-5-jsnow@redhat.com>
In-Reply-To: <20190212010248.11056-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 7:02 PM, John Snow wrote:
> Instead of implying a locked status, make it explicit.
> Now, bitmaps in use by migration, NBD or backup operations
> are all treated the same way with the same code paths.
> ---
>  block/dirty-bitmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--0RJP2feqlMiYLLOxiLYCDi8BC6AvtZvsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjHBQACgkQp6FrSiUn
Q2qKtggAgaybzMVbFtEiggaOZcRcaHxfDKfqCIKUMaOEjLc2AwHJgAM6SFzzfozJ
9B8GeJIzGvQFVJfD9zvUDtZ/nGjCjWx/eB0S6LTFqw8oHFFbUywgKyNBSlA0Ho6X
covuBSRGgCRRADDozfz+izZeE+BsaWVY/ptpdfcOj2cjGIQesS3em5yGaoLM8qeI
LTtkhLbRh4vid/NOTp8o7SDaElfq/noS19lKHPOe/IQLi3+7SycVh6M5TGXusmTE
/c/jZXrO8xdS1DMK0Ka1PP9J10SBXEv2375lC/mEpOJyDaUIlybr0sI+wBIBlf+Z
STeScPkuuRqTuUqUHFDtNRkVZKDgbw==
=rcKe
-----END PGP SIGNATURE-----

--0RJP2feqlMiYLLOxiLYCDi8BC6AvtZvsd--
