Received: from eggs.gnu.org ([2001:4830:134:3::10]:54100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQLw-0002jp-9N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQLv-0005Zk-C2
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:07:44 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-20-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-20-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 04:07:34 -0700
Message-ID: <CAJ+F1CJL8krrmFwCgqx6qZepkNZbcvTJrkOEVcsWiHurCBcUZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/29] disas: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu trival <qemu-trivial@nongnu.org>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Jul 17, 2017 at 11:09 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>
> There is no entry for this file in MAINTAINERS, should it go under TCG/Ov=
erall?

That would make sense to me.

>
>  disas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/disas.c b/disas.c
> index d335c55bbf..8b59448286 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -151,7 +151,7 @@ static int print_insn_objdump(bfd_vma pc, disassemble=
_info *info,
>      info->read_memory_func(pc, buf, n, info);
>
>      for (i =3D 0; i < n; ++i) {
> -        if (i % 32 =3D=3D 0) {
> +        if (QEMU_IS_ALIGNED(i, 32)) {
>              info->fprintf_func(info->stream, "\n%s: ", prefix);
>          }
>          info->fprintf_func(info->stream, "%02x", buf[i]);
> --
> 2.13.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
