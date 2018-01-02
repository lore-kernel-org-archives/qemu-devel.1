Received: from eggs.gnu.org ([2001:4830:134:3::10]:49101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWP1K-0003vu-2H
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWP1J-0006D8-Et
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:02:30 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWP1J-0006Cn-82
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:02:29 -0500
Received: by mail-wr0-x243.google.com with SMTP id w107so23116387wrb.9
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:02:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228072945.9573-2-peterx@redhat.com>
References: <20171228072945.9573-1-peterx@redhat.com>
	<20171228072945.9573-2-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2018 17:02:27 +0100
Message-ID: <CAJ+F1CJ8xGp8weCzvyv27pNhySd4hSHs0LCV3eiTLYS_fxU3HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] chardev: use backend chr context when
 watch for fe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Dec 28, 2017 at 8:29 AM, Peter Xu <peterx@redhat.com> wrote:
> In commit 6bbb6c0644 ("chardev: use per-dev context for
> io_add_watch_poll", 2017-09-22) all the chardev watches are converted to
> use per-chardev gcontext to support chardev to be run outside default
> main thread.  However that's still missing one call from the frontend
> code.  Touch that up.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/char-fe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index ee6d596100..c611b3fa3e 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -356,7 +356,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondi=
tion cond,
>      }
>
>      g_source_set_callback(src, (GSourceFunc)func, user_data, NULL);
> -    tag =3D g_source_attach(src, NULL);
> +    tag =3D g_source_attach(src, s->gcontext);
>      g_source_unref(src);
>
>      return tag;
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
