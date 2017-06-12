Received: from eggs.gnu.org ([2001:4830:134:3::10]:49587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKQG3-0004J2-UR
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKQG0-0006AB-Nz
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:23:55 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKQG0-000699-Gd
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:23:52 -0400
Received: by mail-wr0-x244.google.com with SMTP id v104so22314453wrb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 07:23:52 -0700 (PDT)
Date: Mon, 12 Jun 2017 15:23:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170612142339.GE17075@stefanha-x1.localdomain>
References: <20170609101808.13506-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <20170609101808.13506-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3] block: change variable names in
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 01:18:08PM +0300, Manos Pitsidianakis wrote:
> Change the 'int count' parameter in *pwrite_zeros, *pdiscard related
> functions (and some others) to 'int bytes', as they both refer to bytes.
> This helps with code legibility.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---

Please include a changelog beneath '---' in future patches.  For
example:

v3:
 * Drop ide change which operated on sectors, not bytes [Stefan]

>  block/blkdebug.c               | 36 +++++++++++++++----------------
>  block/blkreplay.c              |  8 +++----
>  block/block-backend.c          | 22 +++++++++----------
>  block/file-posix.c             | 34 +++++++++++++++---------------
>  block/io.c                     | 48 +++++++++++++++++++++---------------=
------
>  block/iscsi.c                  | 20 +++++++++---------
>  block/mirror.c                 |  8 +++----
>  block/nbd-client.c             |  8 +++----
>  block/nbd-client.h             |  4 ++--
>  block/qcow2.c                  | 28 ++++++++++++------------
>  block/qed.c                    |  8 +++----
>  block/raw-format.c             |  8 +++----
>  block/rbd.c                    |  4 ++--
>  block/sheepdog.c               |  6 +++---
>  include/block/block.h          |  8 +++----
>  include/block/block_int.h      |  6 +++---
>  include/sysemu/block-backend.h | 20 +++++++++---------
>  qemu-io-cmds.c                 | 46 ++++++++++++++++++++----------------=
----
>  18 files changed, 161 insertions(+), 161 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZPqPrAAoJEJykq7OBq3PIMsIIAK1PRG5J30QGAdhNCZooS3KN
ZGjmI9QQtaqCWzEINMPsKFqHNzrOS7dWTUmryQqFpy0VHNkyCnwLpKihaCCW//BG
8KemfZBa+ID0fWNk1Ow0zpVR2SzS2UlMEnAjOlMG2uferit2AgyBQ+XnTxJParKu
ijq5EkLsITxHDLy+NxtKZqoRtm1W4XtFeS0EWtiNlSlMiiaPr6Ukwps2JupdRsLy
eZlCCUeqXt70c1Ba+mlteZfNGlBUhQYOroFq90QZ+fzfSXoEyVEddKimyRiLUcwI
0Oa8tCK9qUJrUh6unoKgNZAJ34ilnC6HuT2zhdYV4A9W8riHx2LmdGJAcu+iBSs=
=CTtp
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
