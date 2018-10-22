Received: from eggs.gnu.org ([2001:4830:134:3::10]:47997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gEZrX-0005Tv-CI
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gEZrS-0003Zo-7D
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:03:15 -0400
Received: from mail-bn3nam01on0124.outbound.protection.outlook.com
	([104.47.33.124]:61216
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gEZrR-0003ZR-W4
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 09:03:10 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 22 Oct 2018 13:03:07 +0000
Message-ID: <BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1540134918.git.noring@nocrew.org>
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?Windows-1252?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Subject: [PATCH v8 00/38] target/mips: Limited support for the R5900
>=20

Hi, Fredrik.

The series looks good.

I added ASE_MMI flag along with INSN_R5900, I think this fits better in the=
 overall MIPS for QEMU design.

I made a couple of other minor changes.

I experienced some build errors (see the end of this mail), so I had to exc=
lude some patches, but all others are fine, and had my "Reviewed-by". 32 pa=
tches will be included in the next MIPS queue.

Thanks for all efforts!

Aleksandar


/home/rtrk/Build/qemu-pull-request-oct-22/target/mips/translate.c: In funct=
ion =91gen_mul_txx9=92:
/home/rtrk/Build/qemu-pull-request-oct-22/target/mips/translate.c:4888:38: =
error: passing argument 3 of =91tcg_gen_add2_i32=92 from incompatible point=
er type [-Werror=3Dincompatible-pointer-types]
             tcg_gen_add2_i32(t2, t3, cpu_LO[acc], cpu_HI[acc], t2, t3);
                                      ^~~~~~
In file included from /home/rtrk/Build/qemu-pull-request-oct-22/target/mips=
/translate.c:29:0:
/home/rtrk/Build/qemu-pull-request-oct-22/tcg/tcg-op.h:314:6: note: expecte=
d =91TCGv_i32 {aka struct TCGv_i32_d *}=92 but argument is of type =91TCGv_=
i64 {aka struct TCGv_i64_d *}=92
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
      ^~~~~~~~~~~~~~~~
/home/rtrk/Build/qemu-pull-request-oct-22/target/mips/translate.c:4888:51: =
error: passing argument 4 of =91tcg_gen_add2_i32=92 from incompatible point=
er type [-Werror=3Dincompatible-pointer-types]
             tcg_gen_add2_i32(t2, t3, cpu_LO[acc], cpu_HI[acc], t2, t3);
                                                   ^~~~~~
In file included from /home/rtrk/Build/qemu-pull-request-oct-22/target/mips=
/translate.c:29:0:
/home/rtrk/Build/qemu-pull-request-oct-22/tcg/tcg-op.h:314:6: note: expecte=
d =91TCGv_i32 {aka struct TCGv_i32_d *}=92 but argument is of type =91TCGv_=
i64 {aka struct TCGv_i64_d *}=92
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
      ^~~~~~~~~~~~~~~~
/home/rtrk/Build/qemu-pull-request-oct-22/target/mips/translate.c:4908:38: =
error: passing argument 3 of =91tcg_gen_add2_i32=92 from incompatible point=
er type [-Werror=3Dincompatible-pointer-types]
             tcg_gen_add2_i32(t2, t3, cpu_LO[acc], cpu_HI[acc], t2, t3);
                                      ^~~~~~
In file included from /home/rtrk/Build/qemu-pull-request-oct-22/target/mips=
/translate.c:29:0:
/home/rtrk/Build/qemu-pull-request-oct-22/tcg/tcg-op.h:314:6: note: expecte=
d =91TCGv_i32 {aka struct TCGv_i32_d *}=92 but argument is of type =91TCGv_=
i64 {aka struct TCGv_i64_d *}=92
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
      ^~~~~~~~~~~~~~~~
/home/rtrk/Build/qemu-pull-request-oct-22/target/mips/translate.c:4908:51: =
error: passing argument 4 of =91tcg_gen_add2_i32=92 from incompatible point=
er type [-Werror=3Dincompatible-pointer-types]
             tcg_gen_add2_i32(t2, t3, cpu_LO[acc], cpu_HI[acc], t2, t3);
                                                   ^~~~~~
In file included from /home/rtrk/Build/qemu-pull-request-oct-22/target/mips=
/translate.c:29:0:
/home/rtrk/Build/qemu-pull-request-oct-22/tcg/tcg-op.h:314:6: note: expecte=
d =91TCGv_i32 {aka struct TCGv_i32_d *}=92 but argument is of type =91TCGv_=
i64 {aka struct TCGv_i64_d *}=92
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
      ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
/home/rtrk/Build/qemu-pull-request-oct-22/rules.mak:69: recipe for target '=
target/mips/translate.o' failed
make[1]: *** [target/mips/translate.o] Error 1
Makefile:483: recipe for target 'subdir-mips64-softmmu' failed
make: *** [subdir-mips64-softmmu] Error 2
