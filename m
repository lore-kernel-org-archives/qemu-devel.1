Received: from eggs.gnu.org ([2001:4830:134:3::10]:48700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgr8f-0005lM-MA
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgr8c-0008Uc-J9
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:00:45 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgr8c-0008UA-DD
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:00:42 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so2086446wmd.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 03:00:42 -0800 (PST)
Date: Thu, 23 Feb 2017 11:00:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223110039.GB30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760157489.31154.11695946385006642137.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <148760157489.31154.11695946385006642137.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 02/29] 9pfs: remove side-effects in
 local_init()
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


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:39:34PM +0100, Greg Kurz wrote:
> If this function fails, it should not modify *ctx.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 7de07e1ba67f..55903e5d7745 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1168,9 +1168,25 @@ static int local_ioc_getversion(FsContext *ctx, V9=
fsPath *path,
> =20
>  static int local_init(FsContext *ctx)
>  {
> -    int err =3D 0;
>      struct statfs stbuf;
> =20
> +#ifdef FS_IOC_GETVERSION
> +    /*
> +     * use ioc_getversion only if the iocl is definied

s/iocl/ioctl/

Otherwise:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrsDXAAoJEJykq7OBq3PIhsQH/0TeN1cTO0D4IZv/0/IpAMZ5
CAGu9DEsla2MrEDayBT6FDLrMRj+QiA3QDoJYsd75hLW3Osw+3nKcRPmMUcl3mWA
oSnf8s3lU6V6HgMY31FhrtOariyO+CMZ55vWYOmJTaiYhW4mwdP7HYxurLBpQb6A
N/B1DhDpzvLF4r7orqFQJcy/U4bT9vsSntIYMFIdzvNPIDPwgadK+r56SPOlIq/L
qtPFNZWB35KHVFDagj2avlnVRX7y5ao08Ne8AZ14uGSK/DO7ysDdCXk2yXXxEVMt
tBZLJDPWHtKgq8MxDqseEYsX4PdcVY9iLtCCQ9J+bh5+1U1or4WpyHnFvv46Tgc=
=n6bV
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
