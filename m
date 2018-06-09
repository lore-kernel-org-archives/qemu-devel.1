Received: from eggs.gnu.org ([2001:4830:134:3::10]:58113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fRawI-0004Wv-Bd
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 06:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fRawH-0007gj-24
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 06:17:42 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fRawG-0007gL-Qd
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 06:17:40 -0400
Received: by mail-wm0-x243.google.com with SMTP id l15-v6so5073001wmc.1
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 03:17:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528530764-21376-2-git-send-email-dimastep@yandex-team.ru>
References: <1528530764-21376-1-git-send-email-dimastep@yandex-team.ru>
	<1528530764-21376-2-git-send-email-dimastep@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Jun 2018 12:17:39 +0200
Message-ID: <CAJ+F1CLxXJVYxNEXPsZMTLcDCQjLnOYMNdYb0sx0eb8bHK-ASQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/3] memfd: fix possible usage of the
 uninitialized file descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>
Cc: QEMU <qemu-devel@nongnu.org>, wrfsh@yandex-team.ru

On Sat, Jun 9, 2018 at 9:52 AM, Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
> The qemu_memfd_alloc_check() routine allocates the fd variable on stack.
> This variable is initialized inside the qemu_memfd_alloc() function.
> There are several cases when *fd will be left unintialized which can
> lead to the unexpected close() in the qemu_memfd_free() call.
>
> Set file descriptor to -1 before calling the qemu_memfd_alloc routine.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  util/memfd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/memfd.c b/util/memfd.c
> index d248a53..6287946 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -187,6 +187,7 @@ bool qemu_memfd_alloc_check(void)
>          int fd;
>          void *ptr;
>
> +        fd =3D -1;
>          ptr =3D qemu_memfd_alloc("test", 4096, 0, &fd, NULL);
>          memfd_check =3D ptr ? MEMFD_OK : MEMFD_KO;
>          qemu_memfd_free(ptr, 4096, fd);
> --
> 2.7.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
