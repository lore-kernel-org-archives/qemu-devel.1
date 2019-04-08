Received: from eggs.gnu.org ([209.51.188.92]:39589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hDQXV-0001o1-V8
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hDQSe-0003rh-Hj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:21:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hDQSe-0003rF-3P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:21:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so7522871qkc.0
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-4-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-4-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 8 Apr 2019 11:20:52 +0200
Message-ID: <CAMxuvayc+RnpmFpUVFaLW2Uh8y6bZo2N4o6wu6YVyE1XRHtdWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/15] char-pty: Drop "char device
 redirected to" message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Mon, Apr 8, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> char_pty_open() prints a "char device redirected to PTY_NAME (label
> LABEL)" message to the current monitor or else to stderr.  No other
> ChardevClass::open() prints anything on success.  Drop the message.
>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  chardev/char-pty.c | 2 --
>  1 file changed, 2 deletions(-)
>

I guess that was printed for convenience.

Allocated pty can be read from "info chardev", so I suppose we can
make qemu more silent. Fine with me:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index b034332edd..a48d3e5d20 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -211,8 +211,6 @@ static void char_pty_open(Chardev *chr,
>      qemu_set_nonblock(master_fd);
>
>      chr->filename =3D g_strdup_printf("pty:%s", pty_name);
> -    error_printf("char device redirected to %s (label %s)\n",
> -                 pty_name, chr->label);
>
>      s =3D PTY_CHARDEV(chr);
>      s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
> --
> 2.17.2
>
