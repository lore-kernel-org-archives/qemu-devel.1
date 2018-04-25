Received: from eggs.gnu.org ([2001:4830:134:3::10]:60426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBLUN-00069f-66
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBLUJ-0006uz-3G
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:33:43 -0400
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
Date: Wed, 25 Apr 2018 09:33:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180421132929.21610-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tFqHU2nJzlardaQ1Cl1JwAfZiNaj2f6cX"
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: Add BDRV_REQ_WRITE_UNCHANGED
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tFqHU2nJzlardaQ1Cl1JwAfZiNaj2f6cX
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: Add BDRV_REQ_WRITE_UNCHANGED
 flag
References: <20180421132929.21610-1-mreitz@redhat.com>
 <20180421132929.21610-4-mreitz@redhat.com>
In-Reply-To: <20180421132929.21610-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/21/2018 08:29 AM, Max Reitz wrote:
> This flag signifies that a write request will not change the visible
> disk content.  With this flag set, it is sufficient to have the
> BLK_PERM_WRITE_UNCHANGED permission instead of BLK_PERM_WRITE.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  include/block/block.h | 6 +++++-
>  block/io.c            | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)

Since patch 5 adds an instance of a driver setting supported_write_flags
=3D BDRV_REQ_WRITE_UNCHANGED, I think this patch should tweak the
documentation of supported_write_flags (and supported_zero_flags?) in
block_int.h to mention that drivers can opt-in to supporting this
particular flag (rather than it being handled completely at the block
layer).

Also, that does raise the question of whether you have more work to
support write-zero requests with WRITE_UNCHANGED (which indeed sounds
like something plausible to support).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tFqHU2nJzlardaQ1Cl1JwAfZiNaj2f6cX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrgkbQACgkQp6FrSiUn
Q2p82gf/eF6PyH3han2nYxER+So8z2NQ2vTqzRTokyMiSoIEPNzRR0bLMK8tdB1O
nuMyKEAf1Itzd5BmXCMRYbKnyrLX/0tSomDm7aaCK8AwvKKT0nEaZNioQ+v5CPxR
sBmXYS+kkxxpijQJ1V4y1bzxRPUi3cAe6AeoV0rxazeymCItg88TwVl7dxs3+b1A
m4jAzzVM7sxSuAckAcTiWazsozjYWtGj8yNgPZ+t6P37iF3vu3WWTJBvs1Tfic8V
eHRmI5cbZSKEPaFwWU084MDm2mLcigInkG7EkvTtPRj36mO59qhMtMqom6fqd6TB
sXnhsJ9kaTKtLeaCAa/YE1v5yVQGqQ==
=AHWO
-----END PGP SIGNATURE-----

--tFqHU2nJzlardaQ1Cl1JwAfZiNaj2f6cX--
