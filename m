Received: from eggs.gnu.org ([2001:4830:134:3::10]:54399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQMS-0003E9-UD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXQMS-0005p5-0X
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:08:16 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-16-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-16-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 04:08:11 -0700
Message-ID: <CAJ+F1CJh-pX4rvuZKCzYiDE+8Spruan-w73qZk+=BWsLFG5OAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/29] microblaze: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu trival <qemu-trivial@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 11:09 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
> (also added braces to satisfy checkpatch)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  target/microblaze/op_helper.c | 3 ++-
>  target/microblaze/translate.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.=
c
> index 1e07e21c1c..41ab52fb7a 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -108,8 +108,9 @@ void helper_debug(CPUMBState *env)
>               (env->sregs[SR_MSR] & MSR_IE));
>      for (i =3D 0; i < 32; i++) {
>          qemu_log("r%2.2d=3D%8.8x ", i, env->regs[i]);
> -        if ((i + 1) % 4 =3D=3D 0)
> +        if (QEMU_IS_ALIGNED(i + 1, 4)) {
>              qemu_log("\n");
> +        }
>      }
>      qemu_log("\n\n");
>  }
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index cb65d1e129..ae7b3c71b0 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1839,9 +1839,10 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
>
>      for (i =3D 0; i < 32; i++) {
>          cpu_fprintf(f, "r%2.2d=3D%8.8x ", i, env->regs[i]);
> -        if ((i + 1) % 4 =3D=3D 0)
> +        if (QEMU_IS_ALIGNED(i + 1, 4)) {
>              cpu_fprintf(f, "\n");
>          }
> +    }
>      cpu_fprintf(f, "\n\n");
>  }
>
> --
> 2.13.2
>
>



--=20
Marc-Andr=C3=A9 Lureau
