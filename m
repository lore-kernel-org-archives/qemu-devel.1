Received: from eggs.gnu.org ([2001:4830:134:3::10]:41696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f9J6v-0000pF-NA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f9J6u-0005L8-A8
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:37:05 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f9J6u-0005Ki-3H
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 19:37:04 -0400
Received: by mail-ot0-x241.google.com with SMTP id d9-v6so7732728oth.10
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 16:37:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e2b58801-c13e-7a73-26ba-54ac7a5c7876@amsat.org>
References: <1524135103-30477-1-git-send-email-frederic.konrad@adacore.com>
	<a615d677-5c2f-831b-8b09-1b1abafa5159@adacore.com>
	<e2b58801-c13e-7a73-26ba-54ac7a5c7876@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 20 Apr 2018 11:37:02 +1200
Message-ID: <CAHNT7Nt=oxPnDr2n01eddJm-M+6oh90DyCMgOY4i9MrCp-6BfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] riscv: requires libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Fri, Apr 20, 2018 at 4:56 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> > On 04/19/2018 12:51 PM, KONRAD Frederic wrote:
> >> When compiling on a machine without libfdt installed the configure
> script
> >> should try to get libfdt from the git or should die because otherwise
> >> CONFIG_LIBFDT is not set and the build process end in an error in the
> >> link
> >> phase.. eg:
> >>
> >> hw/riscv/virt.o: In function `riscv_virt_board_init':
> >> qemu/src/hw/riscv/virt.c:317: undefined reference to
> >> `qemu_fdt_setprop_cell'
> >> qemu/src/hw/riscv/virt.c:319: undefined reference to
> >> `qemu_fdt_setprop_cell'
> >> qemu/src/hw/riscv/virt.c:345: undefined reference to `qemu_fdt_dumpdtb=
'
> >> collect2: error: ld returned 1 exit status
> >> make[1]: *** [qemu-system-riscv64] Error 1
> >> make: *** [subdir-riscv64-softmmu] Error 2
> >>
> >> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> >> ---
> >>   configure | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/configure b/configure
> >> index 0a19b03..1587f08 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -3732,7 +3732,7 @@ fi
> >>   fdt_required=3Dno
> >>   for target in $target_list; do
> >>     case $target in
> >> -
> >> aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-
> softmmu|mips64el-softmmu)
> >>
> >> +
> >> aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-
> softmmu|mips64el-softmmu|riscv64-softmmu)
> >>
> >
> > I just realized that riscv32 use it too so I'll correct with
> > riscv*-softmmu.
>
> Using "riscv*-softmmu":
>

Indeed.

We had this fix in our tree before one of the rebases against upstream:

https://github.com/riscv/riscv-qemu/commit/90cdfb86e81c54c1df42412b10b86fd8=
3a6dee82

It must have somehow got dropped when we forward ported to QEMU master in
December 2017. My apologies.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Reviewed-by: Michael Clark <mjc@sifive.com>

>>         fdt_required=3Dyes
> >>       ;;
> >>     esac
> >>
> >
>
