Received: from eggs.gnu.org ([2001:4830:134:3::10]:37255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG4pi-0000B9-1S
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG4ph-0003wE-74
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:42:46 -0400
References: <20170524202842.26724-1-eblake@redhat.com>
	<20170524202842.26724-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <00ea23b3-dbda-00df-0bf2-f746a3043a3a@redhat.com>
Date: Wed, 31 May 2017 16:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170524202842.26724-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="knplxhwJFbRkMFERaUE9JAUDGHOfsbeWv"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] block: Guarantee that *file is set
 on bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--knplxhwJFbRkMFERaUE9JAUDGHOfsbeWv
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <00ea23b3-dbda-00df-0bf2-f746a3043a3a@redhat.com>
Subject: Re: [PATCH v2 2/5] block: Guarantee that *file is set on
 bdrv_get_block_status()
References: <20170524202842.26724-1-eblake@redhat.com>
 <20170524202842.26724-3-eblake@redhat.com>
In-Reply-To: <20170524202842.26724-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-24 22:28, Eric Blake wrote:
> We document that *file is valid if the return is not an error and
> includes BDRV_BLOCK_OFFSET_VALID, but forgot to obey this contract
> when a driver (such as blkdebug) lacks a callback.  Broken in
> commit 67a0fd2 (v2.6), when we added the file parameter.

Not sure if I'd call that "broken", as in the part participle of "break"
because there was never any breaking. It just didn't abide by the
contract from the start.

> Enhance qemu-iotest 177 to cover this, using a sequence that would
> print garbage or even SEGV, because it was dererefencing through
> uninitialized memory.  [The resulting test output shows that we
> have less-than-ideal block status from the blkdebug driver, but
> that's a separate fix coming up soon.]
>=20
> Setting *file on all paths that return BDRV_BLOCK_OFFSET_VALID is
> enough to fix the crash, but we can go one step further: always
> setting *file, even on error, means that a broken caller that
> blindly dereferences file without checking for error is now more
> likely to get a reliable SEGV instead of randomly acting on garbage,
> making it easier to diagnose such buggy callers.  Adding an
> assertion that file is set where expected doesn't hurt either.
>=20
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v2: drop redundant assignment
> ---
>  block/io.c                 | 5 +++--
>  tests/qemu-iotests/177     | 3 +++
>  tests/qemu-iotests/177.out | 2 ++
>  3 files changed, 8 insertions(+), 2 deletions(-)

Anyway,

Reviewed-by: Max Reitz <mreitz@redhat.com>


--knplxhwJFbRkMFERaUE9JAUDGHOfsbeWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLtZTEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKk4
B/9kUFE7pBXOnZuI8abYPHSKtcwCDCaFwdIMndkmYedo2A0/TiLw+RDPc81J6Id4
KBBWEFCXy23BCAmK5G56W+qbYt+InQ49HtpaZhjqxjExbZy77+T2Sl98bXm4OlQr
K98rwvgy6ZBTUUThczuDW2TnlhWNBs3sy40v+igcDcQZl9PpodWuJFx7Zt0oNE0J
f6tYldOD3fPOkLlosknh+vPGxhGDx+Gbi8ChIfsleNQWxFNz3BhvG5tuEW3Mr8/k
VH5av2seWDg6Qo1bxYOHN7+6vadQj1v8JfZg8RmPaSk06x7iME3neO9dpX8DXxPP
qEwWVDMqE81QdsLTXkUFihPy
=xP8G
-----END PGP SIGNATURE-----

--knplxhwJFbRkMFERaUE9JAUDGHOfsbeWv--
