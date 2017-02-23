Received: from eggs.gnu.org ([2001:4830:134:3::10]:38636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgugn-0004qU-F6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgugi-0004l1-HK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:48:13 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgugi-0004kN-AX
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:48:08 -0500
Received: by mail-wm0-x244.google.com with SMTP id v77so249230wmv.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:48:08 -0800 (PST)
Date: Thu, 23 Feb 2017 14:48:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223144805.GN30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760166871.31154.9803071784073980223.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3rMDlCEgcaHQQFB+"
Content-Disposition: inline
In-Reply-To: <148760166871.31154.9803071784073980223.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 14/29] 9pfs: local: utimensat: don't follow
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


--3rMDlCEgcaHQQFB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:41:08PM +0100, Greg Kurz wrote:
> The local_utimensat() callback is vulnerable to symlink attacks because it
> calls qemu_utimens()->utimensat(AT_SYMLINK_NOFOLLOW) which follows symbol=
ic
> links in all path elements but the rightmost one or qemu_utimens()->utime=
s()
> which follows symbolic links for all path elements.
>=20
> This patch converts local_utimensat() to rely on opendir_nofollow() and
> utimensat(AT_SYMLINK_NOFOLLOW) directly instead of using qemu_utimens().
> It is hence assumed that the OS supports utimensat(), i.e. has glibc 2.6
> or higher and linux 2.6.22 or higher, which seems reasonable nowadays.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3rMDlCEgcaHQQFB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvYkAAoJEJykq7OBq3PIW/YH/0vdSh4Oj56Oe+gkArlhF+V2
MGkP3rqmK3Iv11fxuqTgHyvK+PO1v/DetEAdZD5UAOYeFbfqfjmPFR+tgHDZqO/p
VSmjvpR64ozHUg6qMzJ1tVe41tTkp2CCZCWeK1tuFj8Fna6DzfVaVsdA6kQwOmFt
Y1FfnISd6wV0JqLY50fsjy0zeMKKNwTFEo8yZPxs64iax2vmETyLz8CTECruqVvc
iIztm4YRc6WdlHTNPe5i2Wy3zUdDf2+Mifng/Ozr6IDD+O0p9BXUycl3dPvCv61f
nPEfpo8YKRhU+G0I+qPb9dWcxm4PfoRC+ENxZ9dYlpkJfwkOSI+KAjaekvBEP98=
=l0oe
-----END PGP SIGNATURE-----

--3rMDlCEgcaHQQFB+--
