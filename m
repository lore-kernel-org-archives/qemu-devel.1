Received: from eggs.gnu.org ([2001:4830:134:3::10]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgrV1-000193-EO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgrUw-0005yU-HT
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:23:51 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgrUw-0005yP-9u
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:23:46 -0500
Received: by mail-wm0-x241.google.com with SMTP id r18so2194275wmd.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 03:23:46 -0800 (PST)
Date: Thu, 23 Feb 2017 11:23:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223112342.GE30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760159920.31154.1371018412446175087.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <148760159920.31154.1371018412446175087.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 05/29] 9pfs: local: keep a file descriptor
 on the shared folder
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


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:39:59PM +0100, Greg Kurz wrote:
> This patch opens the shared folder and caches the file descriptor, so that
> it can be used to do symlink-safe path walk.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index c2239bfafce4..8aee7f2516ed 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -14,6 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "9p.h"
>  #include "9p-xattr.h"
> +#include "9p-util.h"
>  #include "fsdev/qemu-fsdev.h"   /* local_ops */
>  #include <arpa/inet.h>
>  #include <pwd.h>
> @@ -43,6 +44,10 @@
>  #define BTRFS_SUPER_MAGIC 0x9123683E
>  #endif
> =20
> +struct local_data {

QEMU coding style would requires:

  typedef struct {
      int mountfd;
  } LocalData;

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrsY+AAoJEJykq7OBq3PIiawH/33i5ftgFEn4eJoNQsmmNNgU
Rqe1aC7t/Xi9TCGMVr/KcE/Ksnbi+h3+MC3NW6QemzP+LAJQ/rugSI++u8Yz+8hB
Rqi9GyGfagGAr+bJ2+uSxBEKJYUGd9kmQGSfc0pcF6bY2QV5DY+hwAtooL/Yt+Lw
0HXNJ2wuiADmiFaQDqEBkyUw2wv5tgEBkqzJAv5EWnGO6piUU4fMSps7LmcnvrQW
Bjr/eS2oFlaiZIUcJl4bKataOUydVVnMQbOEXH0WGwCHHdmxHRAXpfeyfPSvC6IG
QhEFTU7yBODv3PjMtbs8joL5KCaSpKYu8skeRej6a0egvp/ZJE4aFZC2Eo058Tg=
=jbTM
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
