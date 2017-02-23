Received: from eggs.gnu.org ([2001:4830:134:3::10]:41624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgupY-0005hw-Kq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgupT-0007pt-O5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:57:16 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgupT-0007pk-Hi
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:57:11 -0500
Received: by mail-wm0-x244.google.com with SMTP id m70so283494wma.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:57:11 -0800 (PST)
Date: Thu, 23 Feb 2017 14:57:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223145708.GS30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760170950.31154.10269855132369692301.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/U0GMd1Pus0mbMSS"
Content-Disposition: inline
In-Reply-To: <148760170950.31154.10269855132369692301.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 19/29] 9pfs: local: renameat: don't follow
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


--/U0GMd1Pus0mbMSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:41:49PM +0100, Greg Kurz wrote:
> The local_renameat() callback is currently a wrapper around local_rename()
> which is vulnerable to symlink attacks.
>=20
> This patch rewrites local_renameat() to have its own implementation, based
> on local_opendir_nofollow() and renameat().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 63 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/U0GMd1Pus0mbMSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvhEAAoJEJykq7OBq3PIBCQH/2wHTFhzzRrrI73mydP+M2t5
+FyGLyfwNSvb6t5AvWghptWXjE4nzseU0NVShXmAl1CucUis9z5zB2QSLoHAtB7K
II+NW4SePcQN7wWRIkJjHCMjdSWIMFTx353IIPPBOlKoi05aqA5+FBvGU1eulP8y
ip5T3w/zNT35Zp/AZJArEJNohTY0/62cWzoIgvlSHeCUKbFLRkj8DIk1QMTENUMf
lrNKM+7V2EuxTsLajf7qwHImXRSw4Vzhuhuc/fI2u8GznioKYXMx+G3itYEeCeWJ
StbodjndIaLbX4sY3ZmpyKknlcMMjP1xMZ1nhIU6Xcb+/dlbTDoJfwujucPvM34=
=vSKu
-----END PGP SIGNATURE-----

--/U0GMd1Pus0mbMSS--
