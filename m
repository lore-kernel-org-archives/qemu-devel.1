Received: from eggs.gnu.org ([2001:4830:134:3::10]:58646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYww-0001yq-Ek
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebYwv-0002E8-MB
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:39:18 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<3c5596196fac576592433452622c3fb8ce45979c.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7800cd3-a6f7-b94b-d8a1-393f8c0fce22@redhat.com>
Date: Tue, 16 Jan 2018 15:39:02 -0600
MIME-Version: 1.0
In-Reply-To: <3c5596196fac576592433452622c3fb8ce45979c.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mrzQwUNha6HCz531axWneCFJsYbeRIrwl"
Subject: Re: [Qemu-devel] [PATCH v2 06/32] qcow2: Remove BDS parameter from
 qcow2_cache_entry_mark_dirty()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mrzQwUNha6HCz531axWneCFJsYbeRIrwl
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <a7800cd3-a6f7-b94b-d8a1-393f8c0fce22@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/32] qcow2: Remove BDS parameter from
 qcow2_cache_entry_mark_dirty()
References: <cover.1513342045.git.berto@igalia.com>
 <3c5596196fac576592433452622c3fb8ce45979c.1513342045.git.berto@igalia.com>
In-Reply-To: <3c5596196fac576592433452622c3fb8ce45979c.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_get_table_idx(). This is no longer necessary so this
> parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c    |  3 +--
>  block/qcow2-cluster.c  | 12 ++++++------
>  block/qcow2-refcount.c | 14 ++++++--------
>  block/qcow2.h          |  3 +--
>  4 files changed, 14 insertions(+), 18 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mrzQwUNha6HCz531axWneCFJsYbeRIrwl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpecPYACgkQp6FrSiUn
Q2qApAf8Dw4s/KZhIbSxIUHeZVR+UFZxH0s7R32qVO0WD+pfemEGT3nS9vt7Xb8/
XbkKWTqJ+xXGjAms38mPK+brijAVoCKgxpBsVpiecwmJhs+6tp2ZjZzk8nlO5et5
dHB7IsYBk9QdDVIVRCaVoZnWFOXNt5FDYdKDQDrPZTkYrqxBe+cfsBrx5h8/AVa7
Cl1YG4YPwQEsR5YJ/Fny+b4c+M8Xos1Mv3NGmG8LGgmqBiBPb2in4BbaxEUQrRF5
aCbpL72UKIEXI2W6xY2WOcx/vW58XSgNnhx5tQK3qfV2sQjsKqnbOZB0l5Jj1ztx
4SWIwIWTv8b6N4da5fsgq5eGS7bhIQ==
=G0aL
-----END PGP SIGNATURE-----

--mrzQwUNha6HCz531axWneCFJsYbeRIrwl--
