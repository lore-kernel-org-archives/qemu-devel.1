Received: from eggs.gnu.org ([2001:4830:134:3::10]:49098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fk6hG-00007H-5a
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fk6hD-0005LR-4L
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:50:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2403 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1fk6hC-0005IJ-LW
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:50:39 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Mon, 30 Jul 2018 11:50:19 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473B71C04E@DGGEMM528-MBX.china.huawei.com>
References: <20180730085121.12523-1-pbonzini@redhat.com>
In-Reply-To: <20180730085121.12523-1-pbonzini@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cryptodev: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>

Hi Paolo,

I've posted a patch before, pls see
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg05215.html

which reviewed by Stefan
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg01549.html

It seems that it hasn't been merged. Could you pick it up pls?

Regards,
Jay

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+jianjay.zhou=3Dhuawei.com@nongnu.org] On Behalf Of Paolo Bonzini
> Sent: Monday, July 30, 2018 4:51 PM
> To: qemu-devel@nongnu.org
> Subject: [Qemu-devel] [PATCH] cryptodev: remove dead code
>=20
> Reported by Coverity as CID 1390600.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  backends/cryptodev-vhost-user.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-
> user.c index d52daccfcd..d539f14d59 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -157,7 +157,6 @@ static void cryptodev_vhost_user_event(void *opaque, =
int
> event)  {
>      CryptoDevBackendVhostUser *s =3D opaque;
>      CryptoDevBackend *b =3D CRYPTODEV_BACKEND(s);
> -    Error *err =3D NULL;
>      int queues =3D b->conf.peers.queues;
>=20
>      assert(queues < MAX_CRYPTO_QUEUE_NUM); @@ -174,10 +173,6 @@ static v=
oid
> cryptodev_vhost_user_event(void *opaque, int event)
>          cryptodev_vhost_user_stop(queues, s);
>          break;
>      }
> -
> -    if (err) {
> -        error_report_err(err);
> -    }
>  }
>=20
>  static void cryptodev_vhost_user_init(
> --
> 2.17.1
>=20
