Received: from eggs.gnu.org ([2001:4830:134:3::10]:39906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9K0n-0007ns-8C
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Jpv-00020y-3v
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 20:55:51 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<23f88429b3135b18abdc8643fb5cc35a6dd5d912.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <85df98a2-f7d8-57d2-ae5a-53492a1ea180@redhat.com>
Date: Mon, 8 Oct 2018 02:55:41 +0200
MIME-Version: 1.0
In-Reply-To: <23f88429b3135b18abdc8643fb5cc35a6dd5d912.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7B9GLDDxKsAaBVxQ7NIy7Kbp7vA1yTReL"
Subject: Re: [Qemu-devel] [PATCH 02/14] block: Add
 bdrv_reopen_set_read_only()
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
--7B9GLDDxKsAaBVxQ7NIy7Kbp7vA1yTReL
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <85df98a2-f7d8-57d2-ae5a-53492a1ea180@redhat.com>
Subject: Re: [PATCH 02/14] block: Add bdrv_reopen_set_read_only()
References: <cover.1537367701.git.berto@igalia.com>
 <23f88429b3135b18abdc8643fb5cc35a6dd5d912.1537367701.git.berto@igalia.com>
In-Reply-To: <23f88429b3135b18abdc8643fb5cc35a6dd5d912.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> Most callers of bdrv_reopen() only use it to switch a BlockDriverState
> between read-only and read-write, so this patch adds a new function
> that does just that.
>=20
> We also want to get rid of the flags parameter in the bdrv_reopen()
> API, so this function sets the "read-only" option and passes the
> original flags (which will then be updated in bdrv_reopen_prepare()).
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c               | 17 +++++++++++++++++
>  include/block/block.h |  2 ++
>  2 files changed, 19 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--7B9GLDDxKsAaBVxQ7NIy7Kbp7vA1yTReL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6qw0ACgkQ9AfbAGHV
z0ALFAgAqF4uaAJg4j6+5p70CcfHddN6m51gm4UzNoD5b8SfzgLYTT84wTbkXfPQ
6Z9VL+1l81MACrOA12hIdMhNqcw4FnDaDiYr/Y6eW2mkwEc61Cb30iZrkEtrIxJS
X05/9UKG7tcQEkOR6oFdTBjcHfgoOJiDfkX538kj+iOAvoCPtRhqEcWYDntvxPj5
aENiU3imfPsqQOddO0bvxTojx9YZvW+1k8+tpCDmCogHFdVxXAyoNvlAp6UClwPr
W84sdsvnyzy5e/lP/cXpnyDx9eK+wkaXSZp0zAQAUiLQNNUq17xBgBDKh/iJ90C8
Vi2jFXPAcYyre+qeYl6YfyakyVZ/EQ==
=/ELH
-----END PGP SIGNATURE-----

--7B9GLDDxKsAaBVxQ7NIy7Kbp7vA1yTReL--
