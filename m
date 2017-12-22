Received: from eggs.gnu.org ([2001:4830:134:3::10]:43841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNZw-0003lv-9L
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNZv-00084L-Kt
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:41:36 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSNZv-00083n-Ew
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:41:35 -0500
Received: by mail-wr0-x244.google.com with SMTP id g17so18735888wrd.13
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 05:41:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221212125.19075-2-maxime.coquelin@redhat.com>
References: <20171221212125.19075-1-maxime.coquelin@redhat.com>
	<20171221212125.19075-2-maxime.coquelin@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 14:41:33 +0100
Message-ID: <CAJ+F1CKJBhkyvSCEi3jncaM+eMWXgo4AY1GwBMmEL2HacXrUkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] vhost-user-test: fix features mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Dec 21, 2017 at 10:21 PM, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
> VIRTIO_NET_F_MAC is a bit position, not a bit mask.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/vhost-user-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index e2c89ed376..43c6528644 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -177,7 +177,7 @@ static void init_virtio_dev(TestServer *s)
>      qvirtio_set_driver(&dev->vdev);
>
>      features =3D qvirtio_get_features(&dev->vdev);
> -    features =3D features & VIRTIO_NET_F_MAC;
> +    features =3D features & (1u << VIRTIO_NET_F_MAC);
>      qvirtio_set_features(&dev->vdev, features);
>
>      qvirtio_set_driver_ok(&dev->vdev);
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
