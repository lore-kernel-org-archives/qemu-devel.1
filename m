Received: from eggs.gnu.org ([2001:4830:134:3::10]:51676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQejA-0007fb-Nx
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQej9-0008QR-Jx
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 16:08:16 -0400
References: <1528288551-31641-1-git-send-email-thuth@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6117a0e0-0ef7-4edd-cf95-77f08b0f1b55@redhat.com>
Date: Wed, 6 Jun 2018 22:08:08 +0200
MIME-Version: 1.0
In-Reply-To: <1528288551-31641-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4VrW370WwnoN3QLvXHcKtyszaGM0b9DCP"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Remove deprecated -s
 snapshot_id_or_name option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4VrW370WwnoN3QLvXHcKtyszaGM0b9DCP
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <6117a0e0-0ef7-4edd-cf95-77f08b0f1b55@redhat.com>
Subject: Re: [PATCH] qemu-img: Remove deprecated -s snapshot_id_or_name option
References: <1528288551-31641-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1528288551-31641-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 14:35, Thomas Huth wrote:
> It has been marked as deprecated since QEMU v2.0 already, so it
> is time now to finally remove it.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi          | 7 -------
>  qemu-img-cmds.hx       | 4 ++--
>  qemu-img.c             | 7 +------
>  qemu-img.texi          | 7 ++-----
>  tests/qemu-iotests/029 | 2 +-
>  tests/qemu-iotests/080 | 4 ++--
>  6 files changed, 8 insertions(+), 23 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--4VrW370WwnoN3QLvXHcKtyszaGM0b9DCP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYPygACgkQ9AfbAGHV
z0BlIAf/Um3KO3FH/rDWdcqHY6B7MWem929dDEFX/yk7abQAn0BBlefsuIufvzxI
7wKdvhJHh76y6HG1d6yvQtNi5ZcevFZNgXkp327ljT+9fv/hHVHJeeIqxLDfxiom
SiX8n91g/JT3IKHE56ArBp9KcJYhL/sawY8pIyEP/f8RARD8HgwUI+pycen+FJwO
MWhZwWSB3BBTrokAJa4yWlSkBx0Dd4sBfEVvvSWJFeHg0qEqVRpUrwwWeSm7oYuH
tUvRaIYK3ZjQ50AoOVbnyz9qbVEy33fIwzAAlrP9LxdSfCtoZ16/eGHqLE5frOcH
QUllWVeoSmIjRo+LZcc5+7IpoQBdzQ==
=tw5C
-----END PGP SIGNATURE-----

--4VrW370WwnoN3QLvXHcKtyszaGM0b9DCP--
