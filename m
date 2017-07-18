Received: from eggs.gnu.org ([2001:4830:134:3::10]:48443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQ70-0004yQ-Ui
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQ70-0006Gg-82
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:19 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-30-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-30-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 03:52:13 -0700
Message-ID: <CAJ+F1CLMxo1x8w_eiP7XKk1KXGnBN0z1ZTqMc2L7BmkSpE+N8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 29/29] tests/qapi: use ARRAY_SIZE macro
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
>  tests/test-string-output-visitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/test-string-output-visitor.c b/tests/test-string-outpu=
t-visitor.c
> index e736db3af8..f0902dd49e 100644
> --- a/tests/test-string-output-visitor.c
> +++ b/tests/test-string-output-visitor.c
> @@ -97,7 +97,7 @@ static void test_visitor_out_intList(TestOutputVisitorD=
ata *data,
>      Error *err =3D NULL;
>      char *str;
>
> -    for (i =3D 0; i < sizeof(value) / sizeof(value[0]); i++) {
> +    for (i =3D 0; i < ARRAY_SIZE(value); i++) {
>          *tmp =3D g_malloc0(sizeof(**tmp));
>          (*tmp)->value =3D value[i];
>          tmp =3D &(*tmp)->next;
> --
> 2.13.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
