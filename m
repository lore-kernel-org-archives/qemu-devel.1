Received: from eggs.gnu.org ([2001:4830:134:3::10]:50546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBhR7-0003Er-DG
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBhR4-00085L-8w
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:32:05 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBhR4-000857-4X
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:32:02 -0400
Received: by mail-yw1-f65.google.com with SMTP id l79-v6so6646869ywc.7
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 07:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539428198.git.noring@nocrew.org>
	<c33bd47dc5382728314e200f0e9fd713898540d9.1539428198.git.noring@nocrew.org>
In-Reply-To: <c33bd47dc5382728314e200f0e9fd713898540d9.1539428198.git.noring@nocrew.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 14 Oct 2018 16:31:50 +0200
Message-ID: <CAAdtpL7acK7xsvk-OzBaciuW-Lv3Rde7K+_AOa8ad-od-a86_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 1/7] target/mips: Define R5900
 instructions and CPU preprocessor constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Sat, Oct 13, 2018 at 1:10 PM Fredrik Noring <noring@nocrew.org> wrote:
>
> The R5900 implements the 64-bit MIPS III instruction set except DMULT,
> DMULTU, DDIV, DDIVU, LL, SC, LLD and SCD. The MIPS IV instructions MOVN,
> MOVZ and PREF are implemented. It has the R5900 specific three-operand
> instructions MADD, MADDU, MULT and MULTU as well as pipeline 1 versions
> MULT1, MULTU1, DIV1, DIVU1, MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and
> MTLO1. A set of 93 128-bit multimedia instructions specific to the
> R5900 is also implemented.
>
> The Toshiba TX System RISC TX79 Core Architecture manual
>
> http://www.lukasz.dk/files/tx79architecture.pdf

Also available on https://wiki.qemu.org/File:C790.pdf

>
> describes the C790 processor that is a follow-up to the R5900. There
> are a few notable differences in that the R5900 FPU
>
> - is not IEEE 754-1985 compliant,
> - does not implement double format, and
> - its machine code is nonstandard.
>
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/mips/mips-defs.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index c8e99791ad..76550de2da 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -53,6 +53,7 @@
>  #define   ASE_MSA       0x01000000
>
>  /* Chip specific instructions. */
> +#define         INSN_R5900       0x10000000
>  #define                INSN_LOONGSON2E  0x20000000
>  #define                INSN_LOONGSON2F  0x40000000
>  #define                INSN_VR54XX     0x80000000
> @@ -63,6 +64,7 @@
>  #define                CPU_MIPS3       (CPU_MIPS2 | ISA_MIPS3)
>  #define                CPU_MIPS4       (CPU_MIPS3 | ISA_MIPS4)
>  #define                CPU_VR54XX      (CPU_MIPS4 | INSN_VR54XX)
> +#define         CPU_R5900       (CPU_MIPS3 | INSN_R5900)
>  #define                CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
>  #define                CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
>
> --
> 2.16.4
>
