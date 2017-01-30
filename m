Received: from eggs.gnu.org ([2001:4830:134:3::10]:46508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYEP4-0001X8-Ax
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYEP1-0006Lq-Ar
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:02:02 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYEP1-0006LJ-4L
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:01:59 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so6637986wmd.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 08:01:58 -0800 (PST)
Date: Mon, 30 Jan 2017 16:01:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130160155.GQ2118@stefanha-x1.localdomain>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kPJUzav3owWaKxsz"
Content-Disposition: inline
In-Reply-To: <20170120164322.21851-12-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/17] block: explicitly acquire aiocontext
 in timers that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com


--kPJUzav3owWaKxsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 05:43:16PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c                |  2 ++
>  block/io.c                  |  5 +++++
>  block/iscsi.c               |  8 ++++++--
>  block/null.c                |  4 ++++
>  block/qed.c                 | 12 ++++++++++++
>  block/qed.h                 |  3 +++
>  block/throttle-groups.c     |  2 ++
>  util/aio-posix.c            |  2 --
>  util/aio-win32.c            |  2 --
>  util/qemu-coroutine-sleep.c |  2 +-
>  10 files changed, 35 insertions(+), 7 deletions(-)
>=20
>         v1->v2: document restrictions in bdrv_aio_cancel due to qemu_aio_=
ref
> 	[Stefan]

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kPJUzav3owWaKxsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj2NzAAoJEJykq7OBq3PIHJIIAIDgPK+gPFktLiJPujOCGsIq
+YTAv/5o82FE/IEMUDp9cPGe8tXNYRNsXTtLcNBSP2pucsBIalr779l4N+Ydo3ay
6nS2wCNs0IxHCkj3yECgY/3WVOcxor45nQkypfqkwBRvAZU873NEymtMk+JzNjUE
aJlkIrHD/zHwFBu4QRSQrNyZHCbNxSe4K6Cr8O95PKmKPx/QZLzHoVMXvLJie2oQ
JFq8+dRmoGlcGjiL+qhqmam0b4mtOUy53Cl68Rd15PwT+LQQllFDj+GpmRiSLGi+
NJnfQLrcZrxlpCvAKhjECZ7oyyx2eZyE7kHyp/Mw3IcrrdfK49N61nxXWRzj/lc=
=QUav
-----END PGP SIGNATURE-----

--kPJUzav3owWaKxsz--
