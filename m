Received: from eggs.gnu.org ([2001:4830:134:3::10]:34135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9CJ-0004z1-OG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9CI-0005Gk-TY
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:22:23 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dG9CI-0005GV-LS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:22:22 -0400
Received: by mail-lf0-x242.google.com with SMTP id h4so2290937lfj.3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-7-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 19:22:10 +0000
Message-ID: <CAJ+F1CK562Kk7vq545R2r-rbOVr8KwQHVQe0JKxuGcS=7pFrsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/13] test-char: unref chardev-udp
 after test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com

On Tue, May 30, 2017 at 6:06 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> this is only not a problem if the test is last in a suite,
> otherwise it makes the following main_loop() calls to fail
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/test-char.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index f3b377f..d63d3d2 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -456,6 +456,8 @@ static void char_udp_test(void)
>
>      close(sock);
>      g_free(tmp);
> +    qemu_chr_fe_deinit(&be);
> +    object_unparent(OBJECT(chr));
>  }
>
>  static void char_file_test(void)
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
