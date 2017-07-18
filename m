Received: from eggs.gnu.org ([2001:4830:134:3::10]:49752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQBP-00016w-VX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQBP-0008PI-3h
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:56:52 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-27-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-27-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 03:56:47 -0700
Message-ID: <CAJ+F1C+WsdUp3Vtx+-FZ9g7URSAQuJWb6h7-w6yJXM+4TKQNjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 26/29] tests/tcg: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu trival <qemu-trivial@nongnu.org>, Richard Henderson <rth@twiddle.net>, QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Jul 17, 2017 at 11:10 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/tcg/alpha/test-cond.c | 2 +-
>  tests/tcg/alpha/test-ovf.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

I think those do not include osdep.h

(sigh, tests/tcg would need some love ;)

> diff --git a/tests/tcg/alpha/test-cond.c b/tests/tcg/alpha/test-cond.c
> index 74adffaa69..e5596f10b8 100644
> --- a/tests/tcg/alpha/test-cond.c
> +++ b/tests/tcg/alpha/test-cond.c
> @@ -77,7 +77,7 @@ int main (void)
>  {
>    int i;
>
> -  for (i =3D 0; i < sizeof (vectors)/sizeof(vectors[0]); i++)
> +  for (i =3D 0; i < ARRAY_SIZE(vectors); i++)
>      if ((*vectors[i].func)(vectors[i].v) !=3D vectors[i].r) {
>        write(1, "Failed\n", 7);
>        return 1;
> diff --git a/tests/tcg/alpha/test-ovf.c b/tests/tcg/alpha/test-ovf.c
> index 01c80e7525..43fc6ebb2e 100644
> --- a/tests/tcg/alpha/test-ovf.c
> +++ b/tests/tcg/alpha/test-ovf.c
> @@ -20,7 +20,7 @@ int main (void)
>  {
>    int i;
>
> -  for (i =3D 0; i < sizeof (vectors)/sizeof(vectors[0]); i++)
> +  for (i =3D 0; i < ARRAY_SIZE(vectors); i++)
>      if ((*vectors[i].func)(vectors[i].a, vectors[i].b) !=3D vectors[i].r=
) {
>        write(1, "Failed\n", 7);
>      }
> --
> 2.13.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
