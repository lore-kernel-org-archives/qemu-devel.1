Received: from eggs.gnu.org ([2001:4830:134:3::10]:48946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQ8M-0006Dq-1B
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQ8L-0006uf-AY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:53:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-29-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-29-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 03:53:37 -0700
Message-ID: <CAJ+F1CJM0ueL1n39CxPvmL6EbW5TBP1XEruNMTT6JkzB4hGhEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 28/29] tests/qapi: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu trival <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 11:10 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/test-qobject-output-visitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
> index 749c54065f..121ee181a0 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -558,7 +558,7 @@ static void init_native_list(UserDefNativeListUnion *=
cvalue)
>          boolList **list =3D &cvalue->u.boolean.data;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(boolList, 1);
> -            (*list)->value =3D (i % 3 =3D=3D 0);
> +            (*list)->value =3D QEMU_IS_ALIGNED(i, 3);
>              (*list)->next =3D NULL;
>              list =3D &(*list)->next;
>          }
> --
> 2.13.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
