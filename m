Received: from eggs.gnu.org ([2001:4830:134:3::10]:49581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBon6-00084W-Il
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBon1-0003Cq-PM
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:23:16 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBon1-0003Cj-Kq
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 18:23:11 -0400
Received: by mail-yw1-f66.google.com with SMTP id 135-v6so6870366ywo.8
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 15:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539362376-12010-23-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-23-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 15 Oct 2018 00:22:59 +0200
Message-ID: <CAAdtpL5LjcdaF2jMaafKP5b39Ns=45w-d5+7fJETZjBOH24FNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 22/28] target/mips: Add CP0 Config2 to
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, Oct 12, 2018 at 6:58 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Add field corresponding to CP0 Config2 to DisasContext. This is
> needed for availability control via Config2 bits.
>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/mips/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index e7bc3d4..9e4aae5 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1449,6 +1449,7 @@ typedef struct DisasContext {
>      uint32_t opcode;
>      int insn_flags;
>      int32_t CP0_Config1;
> +    int32_t CP0_Config2;
>      int32_t CP0_Config3;
>      int32_t CP0_Config5;
>      /* Routine used to access memory */
> @@ -25517,6 +25518,7 @@ static void mips_tr_init_disas_context(DisasConte=
xtBase *dcbase, CPUState *cs)
>      ctx->saved_pc =3D -1;
>      ctx->insn_flags =3D env->insn_flags;
>      ctx->CP0_Config1 =3D env->CP0_Config1;
> +    ctx->CP0_Config2 =3D env->CP0_Config2;
>      ctx->CP0_Config3 =3D env->CP0_Config3;
>      ctx->CP0_Config5 =3D env->CP0_Config5;
>      ctx->btarget =3D 0;
> --
> 2.7.4
>
>
