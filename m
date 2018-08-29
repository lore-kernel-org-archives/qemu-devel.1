Received: from eggs.gnu.org ([2001:4830:134:3::10]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuzLQ-0003bi-1g
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuzAB-0006ri-Qu
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:01:37 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<c3e00bed732f1a08edff79aee79669f3572352b8.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <92551863-bd02-8dab-ea8f-be02b0277146@redhat.com>
Date: Wed, 29 Aug 2018 14:01:27 +0200
MIME-Version: 1.0
In-Reply-To: <c3e00bed732f1a08edff79aee79669f3572352b8.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ezJy5SpZIUFWz7tt09qeGZx3uZtppAYvB"
Subject: Re: [Qemu-devel] [PATCH 9/9] block: Allow changing 'force-share' on
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ezJy5SpZIUFWz7tt09qeGZx3uZtppAYvB
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <92551863-bd02-8dab-ea8f-be02b0277146@redhat.com>
Subject: Re: [PATCH 9/9] block: Allow changing 'force-share' on reopen
References: <cover.1535291602.git.berto@igalia.com>
 <c3e00bed732f1a08edff79aee79669f3572352b8.1535291602.git.berto@igalia.com>
In-Reply-To: <c3e00bed732f1a08edff79aee79669f3572352b8.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> 'force-share' is one of the basic BlockdevOptions available for all
> drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
> the user cannot change it and doesn't get an error explaining that it
> can't be changed.
>=20
> One example of how this option is being ignored is that on a
> read-write image this should produce an error:
>=20
>    (qemu) qemu-io virtio0 "reopen -o force-share=3Don"
>    force-share=3Don can only be used with read-only images
>=20
> Since there's no reason why we shouldn't allow changing it and the
> implementation is simple let's just do it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c               | 30 ++++++++++++++++++++++++------
>  include/block/block.h |  1 +
>  2 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ezJy5SpZIUFWz7tt09qeGZx3uZtppAYvB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGixcACgkQ9AfbAGHV
z0DZgQf/Y8KcwgHsNmCJZ4jJ37AN/7RjZmINZ1XN4mYCfyNW1jD9XHvDRGUhJvkB
7HiOVbpgcJqrBIY7AHLU+qbWzTVEKLjg25PmNoDIhcyj8j0KtY8HL6/lzxTcGpFN
tmeWEKwlxJfa5qbzClqiPykxfg0TDJqVlTRZIPk/5e9tVKckxoomgZPoLZ2ydhXd
F/Kox20nDGb9G+2pZGN8TSnOcsJg6lLw6MNUudwsG6t7e8JxHaOZHMsTkEFrLytE
RFDgpwQu2Xy2f88vmzdVYWr3DW2GoZeVELBH6ag5A3J9WErptHvSJRgALyjSaNKL
stwsabsQi3WrX9RgnC4sHN/AejnScA==
=wy/Q
-----END PGP SIGNATURE-----

--ezJy5SpZIUFWz7tt09qeGZx3uZtppAYvB--
