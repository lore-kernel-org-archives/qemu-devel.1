Received: from eggs.gnu.org ([2001:4830:134:3::10]:52277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN41h-0005j9-Vx
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN41h-0008P6-5T
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:48:18 -0500
References: <20171206144550.22295-1-stefanha@redhat.com>
	<20171206144550.22295-7-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d65742f2-4974-31e5-46f0-04b9ebe5194c@redhat.com>
Date: Thu, 7 Dec 2017 15:47:50 -0600
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-7-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nQqUHTCUB6PoERWB6Wo3Uo62AVUbGBPUP"
Subject: Re: [Qemu-devel] [PATCH v2 6/9] block: drop unused
 BlockDirtyBitmapState->aio_context field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nQqUHTCUB6PoERWB6Wo3Uo62AVUbGBPUP
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <d65742f2-4974-31e5-46f0-04b9ebe5194c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/9] block: drop unused
 BlockDirtyBitmapState->aio_context field
References: <20171206144550.22295-1-stefanha@redhat.com>
 <20171206144550.22295-7-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-7-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:45 AM, Stefan Hajnoczi wrote:
> The dirty bitmap actions in qmp_transaction have not used AioContext
> since the dirty bitmap locking discipline was introduced in commit
> 2119882c7eb7e2c612b24fc0c8d86f5887d6f1c3 ("block: introduce
> dirty_bitmap_mutex").  Remove the unused field.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  blockdev.c | 13 -------------
>  1 file changed, 13 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nQqUHTCUB6PoERWB6Wo3Uo62AVUbGBPUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloptwYACgkQp6FrSiUn
Q2pWDgf+O/DlkSDxdForh+tZEKqGIc0vNiMVtgFQYQSPjAzeFAKTgix3CbzKU3H1
5R44CwtyWtlY2qjlZzbfEJ2C39qs5NIsWUG8Xy5s6xZJK+7zUGaVLb2PYtcJ6t3k
PgFTGY0+vgqcRUG3bQaydLYabaIsBQdpAbtsHsAGE0RdJ94FvO2V4iy/+0hCPoHG
2MZ0//SFfHmF5Goqzln0V2Kb00dTcdM2ewz+wMHB2bwjLsKWxH9pkhAVoP9vxHN1
XzkdDMHYvYL/QrV8yWOQezAw/Ch90uVHsS/X3GJ+wTtGS405Rcc+6aotnyk7434u
V7qZpA562cAZ+xvPm4JubTZ6ZrRugQ==
=MKzl
-----END PGP SIGNATURE-----

--nQqUHTCUB6PoERWB6Wo3Uo62AVUbGBPUP--
