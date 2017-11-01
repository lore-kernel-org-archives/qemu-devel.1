Received: from eggs.gnu.org ([2001:4830:134:3::10]:43178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e9xTl-0001eu-8i
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e9xTk-0001gp-Cz
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:11:05 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:45675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e9xTk-0001fm-8d
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:11:04 -0400
Received: by mail-ua0-x244.google.com with SMTP id l40so2158753uah.2
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 11:11:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171101142526.1006-4-ross.lagerwall@citrix.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
	<20171101142526.1006-4-ross.lagerwall@citrix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 1 Nov 2017 19:11:01 +0100
Message-ID: <CAJ+F1C+PzaA1wVkNbb0eV2wY-9M6f-s3MmxCP6i_kuvAemtwCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] io: Don't call close multiple times
 in QIOChannelFile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Wed, Nov 1, 2017 at 3:25 PM, Ross Lagerwall
<ross.lagerwall@citrix.com> wrote:
> If the file descriptor underlying QIOChannelFile is closed in the
> io_close() method, don't close it again in the finalize() method since
> the file descriptor number may have been reused in the meantime.
>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> New in v2.
>
>  io/channel-file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 16bf7ed..1f2f710 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -178,6 +178,7 @@ static int qio_channel_file_close(QIOChannel *ioc,
>                           "Unable to close file");
>          return -1;
>      }
> +    fioc->fd =3D -1;
>      return 0;
>  }
>
> --
> 2.9.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
