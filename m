Received: from eggs.gnu.org ([2001:4830:134:3::10]:59902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1ULB-000117-6q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1UL8-00050r-2s
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:27:13 -0400
Date: Mon, 9 Oct 2017 10:27:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171009092704.GC2954@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171007145609.16722-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171007145609.16722-1-sw@weilnetz.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] io: Add missing GCC_FMT_ATTR (fix
 -Werror=suggest-attribute=format)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Sat, Oct 07, 2017 at 04:56:09PM +0200, Stefan Weil wrote:
> This fixes a compiler warning:
>=20
> /qemu/io/channel-websock.c:163:5: error:
>  function might be possible candidate for =E2=80=98gnu_printf=E2=80=99 =
format attribute
>  [-Werror=3Dsuggest-attribute=3Dformat]
>=20
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  io/channel-websock.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Daniel P. Berrange <berrange@redhat.com>


>=20
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index d1d471f86e..7bf1340958 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -151,9 +151,10 @@ enum {
>      QIO_CHANNEL_WEBSOCK_OPCODE_PONG =3D 0xA
>  };
> =20
> -static void qio_channel_websock_handshake_send_res(QIOChannelWebsock *=
ioc,
> -                                                   const char *resmsg,
> -                                                   ...)
> +static void GCC_FMT_ATTR(2, 3)
> +qio_channel_websock_handshake_send_res(QIOChannelWebsock *ioc,
> +                                       const char *resmsg,
> +                                       ...)
>  {
>      va_list vargs;
>      char *response;

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
