Received: from eggs.gnu.org ([2001:4830:134:3::10]:41200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dXQv2-0006NW-S5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dXQuz-0005rI-O7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:44:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 18 Jul 2017 13:42:17 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20170718061005.29518-17-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-17-f4bug@amsat.org>
Message-ID: <501136f163a5ab92df3d839360483774@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/29] lm32: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>

Am 2017-07-18 08:09, schrieb Philippe Mathieu-Daud=C3=A9:
> Applied using the Coccinelle semantic patch=20
> scripts/coccinelle/use_osdep.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

QEMU_IS_ALIGNED() sounds like it is used to check if a memory access is=20
aligned. Although it does the same, the line in question is used for=20
formatted output. I'm not sure if this macro should be used here.

-michael

> ---
>  target/lm32/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/lm32/translate.c b/target/lm32/translate.c
> index 692882f447..a9b159a6e3 100644
> --- a/target/lm32/translate.c
> +++ b/target/lm32/translate.c
> @@ -1185,7 +1185,7 @@ void lm32_cpu_dump_state(CPUState *cs, FILE *f,
> fprintf_function cpu_fprintf,
>=20
>      for (i =3D 0; i < 32; i++) {
>          cpu_fprintf(f, "r%2.2d=3D%8.8x ", i, env->regs[i]);
> -        if ((i + 1) % 4 =3D=3D 0) {
> +        if (QEMU_IS_ALIGNED(i + 1, 4)) {
>              cpu_fprintf(f, "\n");
>          }
>      }
