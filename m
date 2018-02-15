Received: from eggs.gnu.org ([2001:4830:134:3::10]:35516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1emLe4-00040y-Vq
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1emLe3-0003Kw-S3
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:24 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:38468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1emLe3-0003Kj-HG
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:23 -0500
Received: by mail-wr0-x235.google.com with SMTP id n7so81770wrn.5
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 07:40:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-29-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-29-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 15 Feb 2018 16:40:21 +0100
Message-ID: <CAJ+F1CJnMqqFoDXV_qhamWfx8eq17MvWQ6xa2nmdXyCRaHDH4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 28/30] ivshmem: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU <qemu-devel@nongnu.org>

On Thu, Feb 15, 2018 at 5:28 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> It ease code review, unit is explicit.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/misc/ivshmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 16f03701b7..9b3ad96471 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -1302,7 +1302,7 @@ static void ivshmem_realize(PCIDevice *dev, Error *=
*errp)
>      }
>
>      if (s->sizearg =3D=3D NULL) {
> -        s->legacy_size =3D 4 << 20; /* 4 MB default */
> +        s->legacy_size =3D 4 * M_BYTE; /* 4 MB default */
>      } else {
>          int ret;
>          uint64_t size;
> --
> 2.16.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
