Received: from eggs.gnu.org ([2001:4830:134:3::10]:42739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciL49-0000As-M5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciL44-0007oh-QC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:10:13 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciL44-0007oI-Iy
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:10:08 -0500
Received: by mail-wm0-x244.google.com with SMTP id u63so13349540wmu.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:10:08 -0800 (PST)
Date: Mon, 27 Feb 2017 13:10:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227131005.GK28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814896326.28146.5441448723230448401.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xsn3knLL3qrmRbVI"
Content-Disposition: inline
In-Reply-To: <148814896326.28146.5441448723230448401.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 09/28] 9pfs: local: lsetxattr: don't
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


--Xsn3knLL3qrmRbVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:42:43PM +0100, Greg Kurz wrote:
> The local_lsetxattr() callback is vulnerable to symlink attacks because
> it calls lsetxattr() which follows symbolic links in all path elements but
> the rightmost one.
>=20
> This patch introduces a helper to emulate the non-existing fsetxattrat()
> function: it is implemented with /proc/self/fd which provides a trusted
> path that can be safely passed to lsetxattr().
>=20
> local_lsetxattr() is converted to use this helper and opendir_nofollow().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - introduce /proc based fsetxattrat_nofollow()
> ---
>  hw/9pfs/9p-posix-acl.c  |   18 ++++--------------
>  hw/9pfs/9p-util.h       |    2 ++
>  hw/9pfs/9p-xattr-user.c |    8 +-------
>  hw/9pfs/9p-xattr.c      |   39 +++++++++++++++++++++++++++++++++------
>  hw/9pfs/9p-xattr.h      |    3 +++
>  5 files changed, 43 insertions(+), 27 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Xsn3knLL3qrmRbVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCUtAAoJEJykq7OBq3PIL3wH/1tGET7IHazEX1zH6VC6EfMy
0LmdGrVI8T/pTJcgrQ9DHHOzJFN7Q58SCUKkBP+boN6E3Gu57MYQxMvZjx2BaEeY
r+JSxpRDV9UYOU+6BY2a8K+77C/VovmPjcdg5t/PH+BKG4koEArNV47Yddo/BQoi
0N7zyuCn873wEW1MakHFVViMd2XoeyzmI4mIc5MetQtRs0HxDRDPANrVdnvi7JDs
Ey7y95afkIowUHG/nIAGfsnNzYEAvRRPYW7p6xJNOQjhhLo+6+lkCk3w9Eut2hlP
51WWzjm65qearQg2uBwBx8bR43LMgOH6jVbagGyVfY1KsuwPsCJbPrCKsrtJu2c=
=mKvL
-----END PGP SIGNATURE-----

--Xsn3knLL3qrmRbVI--
