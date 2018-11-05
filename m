Received: from eggs.gnu.org ([2001:4830:134:3::10]:39044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJa2D-0005ZM-BH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJa2A-0006Im-0S
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:14:57 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gJa29-0006IN-R0
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:14:53 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so13255888qko.0
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 00:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20181019164929.18404-1-mreitz@redhat.com>
	<20181019164929.18404-3-mreitz@redhat.com>
In-Reply-To: <20181019164929.18404-3-mreitz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Nov 2018 12:14:41 +0400
Message-ID: <CAMxuvay+Dh3rqpbL87aRANyB+mTWCuJm63cA+28OZqJ7fYEfxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] chardev: Indent list of chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>, "Wolf, Kevin" <kwolf@redhat.com>

On Fri, Oct 19, 2018 at 8:49 PM Max Reitz <mreitz@redhat.com> wrote:
>
> Following the example of qemu_opts_print_help(), indent all entries in
> the list of character devices.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index e115166995..10d44aaefc 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -569,7 +569,7 @@ help_string_append(const char *name, void *opaque)
>  {
>      GString *str =3D opaque;
>
> -    g_string_append_printf(str, "\n%s", name);
> +    g_string_append_printf(str, "\n  %s", name);
>  }
>
>  static const char *chardev_alias_translate(const char *name)
> --
> 2.17.1
>
