Received: from eggs.gnu.org ([2001:4830:134:3::10]:48520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgtI6-0001eq-PA
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgtI3-0004Af-FJ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:18:38 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgtI3-0004AK-7n
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:18:35 -0500
Received: by mail-wm0-x241.google.com with SMTP id v77so2718829wmv.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 05:18:35 -0800 (PST)
Date: Thu, 23 Feb 2017 13:18:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223131831.GF30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760160738.31154.14112432972227976652.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <148760160738.31154.14112432972227976652.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 06/29] 9pfs: local: open/opendir: don't
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


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:40:07PM +0100, Greg Kurz wrote:
> The local_open() and local_opendir() callbacks are vulnerable to symlink
> attacks because they call:
>=20
> (1) open(O_NOFOLLOW) which follows symbolic links in all path elements but
>     the rightmost one
> (2) opendir() which follows symbolic links in all path elements
>=20
> This patch converts both callbacks to use new helpers based on
> openat_nofollow() to only open files and directories if they are
> below the virtfs shared folder
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   31 +++++++++++++++++++++----------
>  hw/9pfs/9p-local.h |   20 ++++++++++++++++++++
>  2 files changed, 41 insertions(+), 10 deletions(-)
>  create mode 100644 hw/9pfs/9p-local.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYruEnAAoJEJykq7OBq3PI/lwH/2kVCqK4StoomRlqzpjZXgK3
8gGE7Ch239hqmZXq4ftrudbPHJavA1/6/7J6WZvCGqBiB/5L4FODGv3/JHym5kIl
NI0u0UsGdSuvt10fM6PVmbCJ6J8GHTDfsBN5HlfYpOLpvAIDvfs2qyONOc4UW7SD
SA+1brsOuBh4NtgTiGY0FNEb7h+b8/gFvlmWmwt37noMxs9lb9wxbVR74r6qtWUU
sTb65ErFZls7r1N0L068v61b2asxtvYP7dHvGPYcWCiwDaJL9ZSjSNsOfkd/s54Z
gU32XU8B8PAiasyanEI8FRRVs3SWn+wam2JEckUWSpAYOPcdAEGaHh43W2JeVao=
=Jvqr
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
