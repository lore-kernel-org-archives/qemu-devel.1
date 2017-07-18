Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQFZ-00050T-L7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQFY-0002J7-VP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:01:09 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-26-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-26-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 04:00:59 -0700
Message-ID: <CAJ+F1CKZRQ_0bVFhj+hmtkRD0f_NrxzXTfYY0Qq0pkmhsKp9Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 25/29] libqos: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu trival <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 11:10 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
> No entry in MAINTAINERS for tests/libqos/* does it deserve it's own entry=
?
>

It would, do you want to candidate? :)

>  tests/libqos/libqos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index 6226546c28..0edb7e99ba 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -258,7 +258,7 @@ void generate_pattern(void *buffer, size_t len, size_=
t cycle_len)
>      p =3D rand() % 256;
>      for (i =3D 0; i < len; i++) {
>          tx[i] =3D p++ % 256;
> -        if (i % cycle_len =3D=3D 0) {
> +        if (QEMU_IS_ALIGNED(i, cycle_len)) {
>              p =3D rand() % 256;
>          }
>      }
> --
> 2.13.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
