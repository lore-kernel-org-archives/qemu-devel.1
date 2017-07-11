Received: from eggs.gnu.org ([2001:4830:134:3::10]:34088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUzm0-0007md-EB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUzlz-0007yh-Hf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:20:36 -0400
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-4-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a647abd-dfa0-4ef4-bfba-613e4f1392bd@redhat.com>
Date: Tue, 11 Jul 2017 13:20:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170711163748.17817-4-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cT6FsUGRsqNnhIwxJ3fllp8w8ULFNgVEW"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] block: remove bdrv_truncate
 callback in blkdebug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cT6FsUGRsqNnhIwxJ3fllp8w8ULFNgVEW
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block <qemu-block@nongnu.org>
Message-ID: <6a647abd-dfa0-4ef4-bfba-613e4f1392bd@redhat.com>
Subject: Re: [PATCH v4 3/4] block: remove bdrv_truncate callback in blkdebug
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
 <20170711163748.17817-4-el13635@mail.ntua.gr>
In-Reply-To: <20170711163748.17817-4-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2017 11:37 AM, Manos Pitsidianakis wrote:
> Now that bdrv_truncate is passed to bs->file by default, remove the
> callback from block/blkdebug.c and set is_filter to true.

This also automatically gives blkdebug access to

bdrv_probe_blocksizes
bdrv_probe_geometry
bdrv_has_zero_init
bdrv_get_info

all of which make sense to me.

>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/blkdebug.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cT6FsUGRsqNnhIwxJ3fllp8w8ULFNgVEW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZRboAAoJEKeha0olJ0NqDM8H/3E/s27DsUezKLLLcwMI7+n3
geAEk+uAlWEDz21GGUzW5RAvJPKD4FFotixdlwFg3qWLua5pmyGLMFpN01uULRXA
pGYpJxSsH+awAZEMBRkw+KUQC6PgjAhTxfAaeE5WE5F3RhFsrGP8g8ZDDjJHI0b3
rpIgxMZnazeZVrQHhYVD+EGMb6MqlzTJaZPpOMz7dGkKrQxs7SsP8hngPkiBhZAH
lgKyGvaWHQTAAEXuIkZElj69wyxOERt+nrPuNFKO8q0fliHYCJbgTqnxmwZetHcB
vpFzEJaWuZzk5ZoeKzDtFJI3avWNltQwAKbXaWUIYgsWbLLf8T2PcBtmVvAKEPY=
=ViIm
-----END PGP SIGNATURE-----

--cT6FsUGRsqNnhIwxJ3fllp8w8ULFNgVEW--
