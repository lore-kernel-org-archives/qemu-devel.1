Received: from eggs.gnu.org ([2001:4830:134:3::10]:49168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQ97-0006q2-VF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQ97-0007XJ-Dk
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:54:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-24-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-24-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 03:54:23 -0700
Message-ID: <CAJ+F1CKM++cYHT2KL6LJeUFeYbDQsNS9b1D3hT=+NMSw7yhv-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 23/29] async: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu trival <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, QEMU <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 11:09 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  util/aio-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 2d51239ec6..e89fd7024a 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -119,7 +119,7 @@ static int aio_epoll(AioContext *ctx, GPollFD *pfds,
>      }
>      if (timeout <=3D 0 || ret > 0) {
>          ret =3D epoll_wait(ctx->epollfd, events,
> -                         sizeof(events) / sizeof(events[0]),
> +                         ARRAY_SIZE(events),
>                           timeout);
>          if (ret <=3D 0) {
>              goto out;
> --
> 2.13.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
