Received: from eggs.gnu.org ([2001:4830:134:3::10]:56228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fOKC4-0003ny-FI
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fOKC3-0002Wy-M1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:48:28 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fOKC3-0002W0-DL
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:48:27 -0400
Received: by mail-wr0-x244.google.com with SMTP id f16-v6so17021232wrm.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 02:48:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531074601.10647-3-slp@redhat.com>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-3-slp@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 31 May 2018 11:48:25 +0200
Message-ID: <CAJ+F1C+1-n0K=qF2HuNGYmgMZEU_91A2i-1kJ-tbZ+jrHuGKQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] chardev: On QIO_CHANNEL_ERR_BROKEN set
 errno to EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Thu, May 31, 2018 at 9:46 AM, Sergio Lopez <slp@redhat.com> wrote:
> This allows callers to identify this potentially unrecoverable error.

(missing signed-off)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-io.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index f810524..f934eb9 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -168,6 +168,9 @@ int io_channel_send_full(QIOChannel *ioc,
>
>              errno =3D EAGAIN;
>              return -1;
> +        } else if (ret =3D=3D QIO_CHANNEL_ERR_BROKEN) {
> +            errno =3D EPIPE;
> +            return -1;
>          } else if (ret < 0) {
>              errno =3D EINVAL;
>              return -1;
> --
> 1.8.3.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
