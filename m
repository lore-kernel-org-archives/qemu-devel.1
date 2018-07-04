Received: from eggs.gnu.org ([2001:4830:134:3::10]:52057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fahZB-0002yW-CB
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fahZA-0004IP-9K
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:11:29 -0400
Date: Wed, 4 Jul 2018 14:11:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180704131120.GH32267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180704125802.26394-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180704125802.26394-1-kwolf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/crypto: Fix memory leak in create
 error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On Wed, Jul 04, 2018 at 02:58:02PM +0200, Kevin Wolf wrote:
> Fixes: Coverity CID 1393782
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 994172a3de..146d81c90a 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -551,7 +551,7 @@ static int coroutine_fn block_crypto_co_create_opts=
_luks(const char *filename,
>      /* Create protocol layer */
>      ret =3D bdrv_create_file(filename, opts, errp);
>      if (ret < 0) {
> -        return ret;
> +        goto fail;
>      }
> =20
>      bs =3D bdrv_open(filename, NULL, NULL,

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
