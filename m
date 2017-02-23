Received: from eggs.gnu.org ([2001:4830:134:3::10]:60549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguDW-0007HK-OC
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cguDS-0004Rr-QH
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:17:58 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cguDS-0004Qu-Ia
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:17:54 -0500
Received: by mail-wm0-x241.google.com with SMTP id u63so63827wmu.2
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:17:52 -0800 (PST)
Date: Thu, 23 Feb 2017 14:17:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223141749.GL30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760165308.31154.3129759292082239824.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Content-Disposition: inline
In-Reply-To: <148760165308.31154.3129759292082239824.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 12/29] 9pfs: local: unlinkat: don't follow
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


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:40:53PM +0100, Greg Kurz wrote:
> The local_unlinkat() callback is vulnerable to symlink attacks because it
> calls remove() which follows symbolic links in all path elements but the
> rightmost one.
>=20
> This patch converts local_unlinkat() to rely on opendir_nofollow() and
> unlinkat() instead.
>=20
> Most of the code is moved to a separate local_unlinkat_common() helper
> which will be reused in a subsequent patch to fix the same issue in
> local_remove().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |  100 ++++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 57 insertions(+), 43 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYru8NAAoJEJykq7OBq3PIRdkH/2D69T2NDBZbYq1K+ATttWA0
uyNOOS7i3UZXPtbTmUn2LV56zoeQCq6rP0hXxN2TVa5ZQThK43TP2EDFOnM1ZFZK
LSSKrCg5eYCJ7aTSVLBYGYAGmbQnaqFBr9KMcw+YXNvHrTOATjUfCg4Mzdadv4GF
+PcX+cVBhgVuZha5DWYNx0BrMX1PjZrWo78cdxuwp/vI3DYWJXxQz0olUmfXFwp/
9otXxhr/TjI/PC+YaF1v3iFhFb106aExwkbiSdEYAxQYbA4zMbyciKSfvYmIV0lp
/oVJjmpQWP9xzKfEMZy/rumDPJTu3OSVWT/sNOrThH1rL2S9W/GZEBp63+oAUTw=
=OYku
-----END PGP SIGNATURE-----

--Qgd2S+2VS1hsWwXW--
