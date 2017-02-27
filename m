Received: from eggs.gnu.org ([2001:4830:134:3::10]:38931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciKtD-0007T9-KG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciKtA-0004Dt-H4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:58:55 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciKtA-0004Dc-9q
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:58:52 -0500
Received: by mail-wm0-x244.google.com with SMTP id v77so13324087wmv.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 04:58:52 -0800 (PST)
Date: Mon, 27 Feb 2017 12:58:48 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227125848.GI28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814894608.28146.6510271749788030194.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N8NGGaQn1mzfvaPg"
Content-Disposition: inline
In-Reply-To: <148814894608.28146.6510271749788030194.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 07/28] 9pfs: local: lgetxattr: don't
 follow symlinks
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


--N8NGGaQn1mzfvaPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:42:26PM +0100, Greg Kurz wrote:
> The local_lgetxattr() callback is vulnerable to symlink attacks because
> it calls lgetxattr() which follows symbolic links in all path elements but
> the rightmost one.
>=20
> This patch introduces a helper to emulate the non-existing fgetxattrat()
> function: it is implemented with /proc/self/fd which provides a trusted
> path that can be safely passed to lgetxattr().
>=20
> local_lgetxattr() is converted to use this helper and opendir_nofollow().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - introduce /proc based fgetxattrat_nofollow()
> ---
>  hw/9pfs/9p-posix-acl.c  |   16 ++--------------
>  hw/9pfs/9p-util.c       |   12 ++++++++++++
>  hw/9pfs/9p-util.h       |    2 ++
>  hw/9pfs/9p-xattr-user.c |    8 +-------
>  hw/9pfs/9p-xattr.c      |   31 ++++++++++++++++++++++++-------
>  hw/9pfs/9p-xattr.h      |    2 ++
>  6 files changed, 43 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--N8NGGaQn1mzfvaPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCKIAAoJEJykq7OBq3PI2ZUH/021gsRdSBGuieT84XP3jjPH
APw8p6u0sX90HvpKyc3W5T193sOzsmb35T6t7LA0X1SNmemo6AuHXSrjrscH97sA
ZQL8TF4zAw+MIB20v+ffigYyO8GiTrmebCupQGTXcfd5DDleNfkmYrBsgBIgLIOX
bGbagg6wqeZ7kLjRAmCMdiFmZFR1lf1XR8gIHEnFa+BpKa0K18ebB9qzMMcJt8fL
NKsgBnRo24yHA5fEtpZDWsPI9lJFegvAIBCUhkC6BrhBhVn+4bd2LyM3mC/xT6Bw
bnqYIsPqA12n6R9VPWEkCK5BDJaUh5wWxwivS6PuhFEcO3njxqrmdSJfXQL4+SA=
=rLNh
-----END PGP SIGNATURE-----

--N8NGGaQn1mzfvaPg--
