Received: from eggs.gnu.org ([2001:4830:134:3::10]:59216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgu51-0002Gv-0q
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgu4w-000265-3L
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:09:11 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgu4v-00025w-Ss
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:09:06 -0500
Received: by mail-wr0-x244.google.com with SMTP id z61so4033476wrc.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:09:05 -0800 (PST)
Date: Thu, 23 Feb 2017 14:09:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223140902.GK30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760164565.31154.18106542980362196249.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Content-Disposition: inline
In-Reply-To: <148760164565.31154.18106542980362196249.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 11/29] 9pfs: local: lremovexattr: don't
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


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:40:45PM +0100, Greg Kurz wrote:
> The local_lremovexattr() callback is vulnerable to symlink attacks because
> it calls lremovexattr() which follows symbolic links in all path elements=
 but
> the rightmost one.
>=20
> This patch converts local_lremovexattr() to rely on opendir_nofollow() and
> fremovexattrat_nofollow() instead.
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-posix-acl.c  |   10 ++--------
>  hw/9pfs/9p-xattr-user.c |    8 +-------
>  hw/9pfs/9p-xattr.c      |    8 +-------
>  3 files changed, 4 insertions(+), 22 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYruz+AAoJEJykq7OBq3PIc18H/iuVQhFUThEw81iFE4h8Pfpg
TGZll9YyVn4zT659IKA1mXygs953LwqK9owx06RyKQOp8THGQ32fAGSXLwYSur0n
iZK48F6bhR16i4nptrIR9ZRS8XNcO6Zze9kdhBkb/z6x9rTEhu6KGp2oW0CFW4ji
XrqOAxqYXXNyKIAqCM1VOlvRll2prwr3L2uo83PjS8iyGsMWun0EXVjP8WUbvdzt
Po/EaxeAo0Wm3WfxGBA/AzWAeRAGpl5CxtNt+YKzTdLrX3ewUf82OCS+7RD+1/ML
ILlgU/FU51+Mn63nR0RkeqWTG+3YP7EOxda9cQm5YHWqjW4g965sFl7ZhhsVLCw=
=VlKC
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--
