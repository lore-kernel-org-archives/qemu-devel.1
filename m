Received: from eggs.gnu.org ([2001:4830:134:3::10]:48010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgr5f-0003x4-Ir
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgr5c-0007T3-HZ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:57:39 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgr5c-0007ST-AX
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:57:36 -0500
Received: by mail-wm0-x243.google.com with SMTP id m70so2068113wma.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 02:57:36 -0800 (PST)
Date: Thu, 23 Feb 2017 10:57:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223105733.GA30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760156667.31154.17134759490866240142.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <148760156667.31154.17134759490866240142.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 01/29] 9pfs: local: move xattr security ops
 to 9p-xattr.c
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


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:39:26PM +0100, Greg Kurz wrote:
> These functions are always called indirectly. It really doesn't make sense
> for them to sit in a header file.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-xattr.c |   61 ++++++++++++++++++++++++++++++++++++++++
>  hw/9pfs/9p-xattr.h |   80 +++++++++-------------------------------------=
------
>  2 files changed, 75 insertions(+), 66 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrsAdAAoJEJykq7OBq3PIRdIIAIhCq+8PU/W/rVqfeVZ9hbvg
Kk9rOjhAeiuYjtXrcpnDvaXcsigy0hMYUMrD10tloPnw4ZvXYqi7L8w8Fc1irJIw
ZF7+UdM8rdhiPPY1EGTNjqJv0IURdVeKcbpN8qkl796LWtgteCVVHBrXe3Nuga34
xeWOsxWHDAeDoe6xpzlOwoEfpei+vwqiY0/Pbdwrap/z5tccwQ2637A5xnd1gGS3
hUZ4vjiPPb3gKSTZXX/qn/4Q7JK+hUA79QaLx9/MH6YCvkbO7GdPRykVocxPU7P3
/2197Y7C6KaI9uEMYgmrmVdxx8E4d0Ioo8OQJ9AMMVwim5eJtYxB4fCidUyuT/I=
=w8tY
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
