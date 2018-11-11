Received: from eggs.gnu.org ([2001:4830:134:3::10]:49145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwda-00018t-K3
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 15:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwdY-0008SC-7X
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 15:47:18 -0500
References: <cover.1541595424.git.berto@igalia.com>
	<770670edd5f78338a0a1c2fd040e41829a05b6e3.1541595424.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b2f2fbe9-4ab2-48a8-fb23-8017e648dab5@redhat.com>
Date: Sun, 11 Nov 2018 21:47:06 +0100
MIME-Version: 1.0
In-Reply-To: <770670edd5f78338a0a1c2fd040e41829a05b6e3.1541595424.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qd82ffbCDM7Il1i4cXJRWxXqhUaCgoPWZ"
Subject: Re: [Qemu-devel] [PATCH v4 13/15] block: Stop passing flags to
 bdrv_reopen_queue_child()
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
--Qd82ffbCDM7Il1i4cXJRWxXqhUaCgoPWZ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b2f2fbe9-4ab2-48a8-fb23-8017e648dab5@redhat.com>
Subject: Re: [PATCH v4 13/15] block: Stop passing flags to
 bdrv_reopen_queue_child()
References: <cover.1541595424.git.berto@igalia.com>
 <770670edd5f78338a0a1c2fd040e41829a05b6e3.1541595424.git.berto@igalia.com>
In-Reply-To: <770670edd5f78338a0a1c2fd040e41829a05b6e3.1541595424.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.11.18 13:59, Alberto Garcia wrote:
> Now that all callers are passing the new options using the QDict we no
> longer need the 'flags' parameter.
>=20
> This patch makes the following changes:
>=20
>    1) The update_options_from_flags() call is no longer necessary
>       so it can be removed.
>=20
>    2) The update_flags_from_options() call is now used in all cases,
>       and is moved down a few lines so it happens after the options
>       QDict contains the final set of values.
>=20
>    3) The flags parameter is removed. Now the flags are initialized
>       using the current value (for the top-level node) or the parent
>       flags (after inherit_options()). In both cases the initial
>       values are updated to reflect the new options in the QDict. This
>       happens in bdrv_reopen_queue_child() (as explained above) and in
>       bdrv_reopen_prepare().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 48 +++++++++++++++++++-----------------------------
>  1 file changed, 19 insertions(+), 29 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Qd82ffbCDM7Il1i4cXJRWxXqhUaCgoPWZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvolUoACgkQ9AfbAGHV
z0BPswgAqraG6THZVUHfzWuhbKSGx98vO1NCuU8pDk/4nGPjY2NSrQBiiAX4pqfl
ybowuzuMZ023dEj4atuIauFmDfq8bPBScXk1oMjCbZ1S41sIKA2c8cDUP1wkTRtZ
lrUB/7POjELfwfbcgDQAQG7bj8dIJNmHaf+KTcabDYTUK0MfcPzrCO8yTX6tQnbo
qjxCB9RmJHSvDi4H1stuJ2qQbS6kjh0NLP5ymHmVKGRvZoNUGLVU0f+iVJnUalu0
3G98bvMMi8IjQSv3GBnEBcjJvYwVwJ7rwPpvL9mE/twgJg59JEk+pYlN11kdjim7
Jq1iYEGMjI+iRHkNvcWXKxOvfXRKwA==
=xngl
-----END PGP SIGNATURE-----

--Qd82ffbCDM7Il1i4cXJRWxXqhUaCgoPWZ--
