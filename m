Received: from eggs.gnu.org ([2001:4830:134:3::10]:39432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguiv-0006sI-0s
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguiq-0005ZA-3J
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:50:25 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cguip-0005Z2-RZ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:50:20 -0500
Received: by mail-wr0-x241.google.com with SMTP id s27so4190157wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:50:19 -0800 (PST)
Date: Thu, 23 Feb 2017 14:50:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223145016.GP30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760168489.31154.7921066936280376884.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9pS2hy4/DrI8BQlq"
Content-Disposition: inline
In-Reply-To: <148760168489.31154.7921066936280376884.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 16/29] 9pfs: local: truncate: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--9pS2hy4/DrI8BQlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:41:24PM +0100, Greg Kurz wrote:
> The local_truncate() callback is vulnerable to symlink attacks because
> it calls truncate() which follows symbolic links in all path elements.
>=20
> This patch converts local_truncate() to rely on open_nofollow() and
> ftruncate() instead.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9pS2hy4/DrI8BQlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvaoAAoJEJykq7OBq3PIM/MH/26aOlNyrk4sMkuAeZ1hTi4B
iu2DwM0p+/3Ko9x0qULaU5ZIj6JUylqX82HOOUPHKldUsqK4HzgDJafbpea0ILIJ
H43Z/G5VxImHdITCGKv9jRnN9P7GT9QjngZ2bu3rDoQpx9Nvzy2awcWL8u/XPbrT
sTHqDz9QxMSi7LJHiLpamMCYuYT/ag0zifkn/RLvgCmaxGxQ02LsUh1WIvMECD1o
cN0CcPYjbuU5qDI3xVkqO1eWrChZZmvhF3yWVayYFNy45V8AiQkWc3n0heSLEAOB
hrVG6bB4VOJrnWtHo1Q7OJ+fkg1bxyx/Y9TTOJM/50Z0dWd6YSTT6KDqNKbi43g=
=EN+U
-----END PGP SIGNATURE-----

--9pS2hy4/DrI8BQlq--
