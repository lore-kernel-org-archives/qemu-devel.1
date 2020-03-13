Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5ADC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945B22074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945B22074E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsH7-0007cO-R4
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCsGL-0006wq-5d
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCsGJ-0004ey-3L
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:54:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52365)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jCsGE-00043G-EM; Fri, 13 Mar 2020 17:54:30 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2wCg-1j9aSX1QB2-003Qbb; Fri, 13 Mar 2020 22:53:49 +0100
Subject: Re: [PATCH v4 00/21] linux-user: generate syscall_nr.sh
To: qemu-devel@nongnu.org
References: <20200310103403.3284090-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9cd132f9-d60b-5102-c56e-d6ccaa82c82d@vivier.eu>
Date: Fri, 13 Mar 2020 22:53:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310103403.3284090-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Fd8pGYGm++++Ao154BFe1jq+D1lMMqrp0uKrcP2osvmYcmBZsJq
 jlRoFAKMRghpyb3fySGfKre+eeJHyCm3ee/rJLw3/FapiQD+RkX7uMyobCi+4hJvY8q7U2j
 3lzEok7HvzxsGeogt56lPiCka7EFX4Strl1vRAXtnRDjqZk2m/9a6iKa+vYqh3zpPxAV/Cl
 TZ8nA0GXjRd1KLYBrF2BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gvDN4/qCOEg=:tGzrsbK+8IX8fg/HKFt2Fu
 urxji1JrvyOpHxqk0w1gC2M1EqBg8kT3wDRIYpSYzcOXuRpN68huplp8V3M4uS0b9S+oNb75O
 lAL9s1g7JuYKNIhQZFlxk9ABjkKv9tb4IWCI2Sb4wTUqc4CPVRTk6QiJeJLL5aq+eFgQAm9TK
 2cO+qaiJEFcvC4lkQaAtEswfmlnsLAiyieUxS+3PDjNJ6cMTn36aAj8E1UUM81fOBhvzaCn+i
 JWKl+aXb1X5VUPIW1LFvUBaxxlwLEYIqtPSAXE8Men/InGniIaUJfyjHSOJWuu42mccNWuxHs
 QjjP9rzwsnsOkEth+iErqszZt5pJZvKlKVSFSM/9xVBdB/oPyMnLxNbaY7tQLXxqgU0D12/EE
 jcAHPRhCHqR7nJ2TdJK0CwwRW4qR0OQ4GoTXHsLgLKwNIGQ0PA2nRx01NIjm70jbm8aAzM3m9
 h2AmDwthB7UQ7NiW+Fg3LBilkack1ZeqsKHb5/hhFPXezCaFPcVJc8u/+UGCqv6Ro2Jw5h77w
 6WJmENukX+6DNiwYPqiFQIL0YQ1J72NNDwvJ0DAnpQqe9pT04V3+8+PYJgQl8CWj9jjvP4Fop
 IUD73Fosnz1qDLZZlM8wWN3EOafQfjZsESrTwYS3hAxr6cBFcGAeK/dGRhZ0Nb/Zfo6SWMzs7
 HH0a9Et2CHs1PfN2p3L6C1p0tKh+YBkKUk1Oh9VJ8locIaD/H91NqxIgajLcvuSL2h+fQSpGx
 xJ/NQvsqlzGxoB81jjQ8/aBEP8NixkTtDo1aM4Pr7NKlAOlsJpqJtDT9/pa0/qqqWacYdOfZJ
 neVr0/3bNxuK4sX5KmOazY8YQ8Enz+M3fBGlj9/4iLiiJinh8mhOHF6zJo/fKPuwcG9wz93
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/03/2020 à 11:33, Laurent Vivier a écrit :
> This series copies the files syscall.tbl from linux v5.5 and generates
> the file syscall_nr.h from them.
> 
> This is done for all the QEMU targets that have a syscall.tbl
> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
> 
> tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)
> 
> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux and files
> are generated manually with the help of a script from the asm-generic/unistd.h
> 
> Define do_arch_prctl() with -TARGET_ENOSYS for i386 as the syscall number
> is defined now.
> 
> I have also removed all syscalls in s390x/syscall_nr.h defined for
> !defined(TARGET_S390X).
> 
> I have added a script to copy all these files from linux and updated
> them at the end of the series with their latest version for today.
> 
> Two patches manage the special case for mips O32 that needs
> to know the number of arguments. We find them in strace sources.
> 
> v4:
>     generate syscall_nr.h for hppa32, not 64
> 
> v3:
>    Add a patch to define do_arch_prctl() for i386
> 
> v2:
>     fix a typo (double comma) in $(call quiet-command)
>     add a script to remove dependencies to syscall_nr.h in source directory
> 
> ppc, mips64:
> 
>         we don't need to split syscall_nr.h as it is generated
>         according TARGET_SYSTBL_ABI to TARGET_ABI_DIR
>         and generated values are incorrect according to the file name.
> 
> arm:
> 
>         manage TARGET_NR_arm_sync_file_range
> 
> Once the syscall_nr.h are built in the build directory, the following script
> allows to compare them with the original one (first argument is the path
> to build directory), it must be run from the source directory:
> 
> cat > check_syscall_nr.sh <<EOF
> BUILD="$1"
> 
> ARCHS="i386 alpha arm hppa i386 m68k microblaze s390x sh4 sparc sparc64 xtensa ppc"
> 
> syscall_nr_diff()
> {
>         arch=$1
>         target=$2
>         syscall_nr=linux-user/$arch/syscall_nr.h
>         offset=$3
>         REFERENCE=$(git log -1 --format=format:%h -- $syscall_nr)^
>         if [ "$offset" = "" ] ; then
>                 git show $REFERENCE:$syscall_nr | \
>                         sed 's/[[:blank:]]\/\*[^*]*\*\///' | \
>                         sed 's/(\([^)]*\))/\1/'  > /tmp/old
>         else
>                 git show $REFERENCE:$syscall_nr | \
>                         sed 's/[[:blank:]]\/\*[^*]*\*\///' | \
>                         sed "s/TARGET_NR_Linux/$offset/" > /tmp/old
>         fi
>         diff -wu --color=always /tmp/old \
>                                 $BUILD/$target/$syscall_nr | less -R
> }
> 
> for arch in $ARCHS ; do
>         syscall_nr_diff $arch $arch-linux-user
> done
> 
> syscall_nr_diff ppc    ppc64-linux-user
> 
> syscall_nr_diff mips   mips-linux-user    4000
> syscall_nr_diff mips64 mips64-linux-user  5000
> syscall_nr_diff mips64 mipsn32-linux-user 6000
> EOF
> 
> Laurent Vivier (21):
>   linux-user: introduce parameters to generate syscall_nr.h
>   linux-user,alpha: add syscall table generation support
>   linux-user,hppa: add syscall table generation support
>   linux-user,m68k: add syscall table generation support
>   linux-user,xtensa: add syscall table generation support
>   linux-user,sh4: add syscall table generation support
>   linux-user,microblaze: add syscall table generation support
>   linux-user,arm: add syscall table generation support
>   linux-user,ppc: add syscall table generation support
>   linux-user,s390x: remove syscall definitions for !TARGET_S390X
>   linux-user,s390x: add syscall table generation support
>   linux-user,sparc,sparc64: add syscall table generation support
>   linux-user,x86_64,i386: cleanup TARGET_NR_arch_prctl
>   linux-user,i386: add syscall table generation support
>   linux-user,x86_64: add syscall table generation support
>   linux-user,mips: add syscall table generation support
>   linux-user,mips64: add syscall table generation support
>   linux-user,scripts: add a script to update syscall.tbl
>   linux-user: update syscall.tbl from linux 0bf999f9c5e7
>   linux-user,mips: move content of mips_syscall_args
>   linux-user,mips: update syscall-args-o32.c.inc
> 
>  MAINTAINERS                            |   1 +
>  Makefile.target                        |   3 +-
>  configure                              |  35 ++
>  linux-user/Makefile.objs               |  19 +-
>  linux-user/alpha/Makefile.objs         |   5 +
>  linux-user/alpha/syscall.tbl           | 479 ++++++++++++++++
>  linux-user/alpha/syscall_nr.h          | 492 -----------------
>  linux-user/alpha/syscallhdr.sh         |  32 ++
>  linux-user/arm/Makefile.objs           |   8 +
>  linux-user/arm/syscall.tbl             | 453 +++++++++++++++
>  linux-user/arm/syscall_nr.h            | 447 ---------------
>  linux-user/arm/syscallhdr.sh           |  31 ++
>  linux-user/hppa/Makefile.objs          |   5 +
>  linux-user/hppa/syscall.tbl            | 437 +++++++++++++++
>  linux-user/hppa/syscall_nr.h           | 358 ------------
>  linux-user/hppa/syscallhdr.sh          |  32 ++
>  linux-user/i386/Makefile.objs          |   5 +
>  linux-user/i386/syscall_32.tbl         | 444 +++++++++++++++
>  linux-user/i386/syscall_nr.h           | 387 -------------
>  linux-user/i386/syscallhdr.sh          |  28 +
>  linux-user/i386/target_cpu.h           |   4 +-
>  linux-user/m68k/Makefile.objs          |   5 +
>  linux-user/m68k/syscall.tbl            | 439 +++++++++++++++
>  linux-user/m68k/syscall_nr.h           | 434 ---------------
>  linux-user/m68k/syscallhdr.sh          |  32 ++
>  linux-user/microblaze/Makefile.objs    |   5 +
>  linux-user/microblaze/syscall.tbl      | 445 +++++++++++++++
>  linux-user/microblaze/syscall_nr.h     | 442 ---------------
>  linux-user/microblaze/syscallhdr.sh    |  32 ++
>  linux-user/mips/Makefile.objs          |   5 +
>  linux-user/mips/cpu_loop.c             | 440 +--------------
>  linux-user/mips/syscall-args-o32.c.inc | 436 +++++++++++++++
>  linux-user/mips/syscall_nr.h           | 425 ---------------
>  linux-user/mips/syscall_o32.tbl        | 427 +++++++++++++++
>  linux-user/mips/syscallhdr.sh          |  36 ++
>  linux-user/mips64/Makefile.objs        |  12 +
>  linux-user/mips64/syscall_n32.tbl      | 378 +++++++++++++
>  linux-user/mips64/syscall_n64.tbl      | 354 ++++++++++++
>  linux-user/mips64/syscall_nr.h         | 725 -------------------------
>  linux-user/mips64/syscallhdr.sh        |  33 ++
>  linux-user/ppc/Makefile.objs           |   6 +
>  linux-user/ppc/signal.c                |   2 +-
>  linux-user/ppc/syscall.tbl             | 521 ++++++++++++++++++
>  linux-user/ppc/syscall_nr.h            | 402 --------------
>  linux-user/ppc/syscallhdr.sh           |  34 ++
>  linux-user/s390x/Makefile.objs         |   5 +
>  linux-user/s390x/syscall.tbl           | 442 +++++++++++++++
>  linux-user/s390x/syscall_nr.h          | 398 --------------
>  linux-user/s390x/syscallhdr.sh         |  32 ++
>  linux-user/sh4/Makefile.objs           |   5 +
>  linux-user/sh4/syscall.tbl             | 442 +++++++++++++++
>  linux-user/sh4/syscall_nr.h            | 441 ---------------
>  linux-user/sh4/syscallhdr.sh           |  32 ++
>  linux-user/sparc/Makefile.objs         |   5 +
>  linux-user/sparc/syscall.tbl           | 485 +++++++++++++++++
>  linux-user/sparc/syscall_nr.h          | 363 -------------
>  linux-user/sparc/syscallhdr.sh         |  32 ++
>  linux-user/sparc64/Makefile.objs       |   5 +
>  linux-user/sparc64/syscall.tbl         | 485 +++++++++++++++++
>  linux-user/sparc64/syscall_nr.h        | 366 -------------
>  linux-user/sparc64/syscallhdr.sh       |  32 ++
>  linux-user/syscall.c                   |  25 +-
>  linux-user/x86_64/Makefile.objs        |   5 +
>  linux-user/x86_64/syscall_64.tbl       | 404 ++++++++++++++
>  linux-user/x86_64/syscall_nr.h         | 356 ------------
>  linux-user/x86_64/syscallhdr.sh        |  28 +
>  linux-user/xtensa/Makefile.objs        |   5 +
>  linux-user/xtensa/syscall.tbl          | 410 ++++++++++++++
>  linux-user/xtensa/syscall_nr.h         | 469 ----------------
>  linux-user/xtensa/syscallhdr.sh        |  32 ++
>  scripts/update-mips-syscall-args.sh    |  57 ++
>  scripts/update-syscalltbl.sh           |  49 ++
>  72 files changed, 8227 insertions(+), 6958 deletions(-)
>  create mode 100644 linux-user/alpha/Makefile.objs
>  create mode 100644 linux-user/alpha/syscall.tbl
>  delete mode 100644 linux-user/alpha/syscall_nr.h
>  create mode 100644 linux-user/alpha/syscallhdr.sh
>  create mode 100644 linux-user/arm/Makefile.objs
>  create mode 100644 linux-user/arm/syscall.tbl
>  delete mode 100644 linux-user/arm/syscall_nr.h
>  create mode 100644 linux-user/arm/syscallhdr.sh
>  create mode 100644 linux-user/hppa/Makefile.objs
>  create mode 100644 linux-user/hppa/syscall.tbl
>  delete mode 100644 linux-user/hppa/syscall_nr.h
>  create mode 100644 linux-user/hppa/syscallhdr.sh
>  create mode 100644 linux-user/i386/Makefile.objs
>  create mode 100644 linux-user/i386/syscall_32.tbl
>  delete mode 100644 linux-user/i386/syscall_nr.h
>  create mode 100644 linux-user/i386/syscallhdr.sh
>  create mode 100644 linux-user/m68k/Makefile.objs
>  create mode 100644 linux-user/m68k/syscall.tbl
>  delete mode 100644 linux-user/m68k/syscall_nr.h
>  create mode 100644 linux-user/m68k/syscallhdr.sh
>  create mode 100644 linux-user/microblaze/Makefile.objs
>  create mode 100644 linux-user/microblaze/syscall.tbl
>  delete mode 100644 linux-user/microblaze/syscall_nr.h
>  create mode 100644 linux-user/microblaze/syscallhdr.sh
>  create mode 100644 linux-user/mips/Makefile.objs
>  create mode 100644 linux-user/mips/syscall-args-o32.c.inc
>  delete mode 100644 linux-user/mips/syscall_nr.h
>  create mode 100644 linux-user/mips/syscall_o32.tbl
>  create mode 100644 linux-user/mips/syscallhdr.sh
>  create mode 100644 linux-user/mips64/Makefile.objs
>  create mode 100644 linux-user/mips64/syscall_n32.tbl
>  create mode 100644 linux-user/mips64/syscall_n64.tbl
>  delete mode 100644 linux-user/mips64/syscall_nr.h
>  create mode 100644 linux-user/mips64/syscallhdr.sh
>  create mode 100644 linux-user/ppc/Makefile.objs
>  create mode 100644 linux-user/ppc/syscall.tbl
>  delete mode 100644 linux-user/ppc/syscall_nr.h
>  create mode 100644 linux-user/ppc/syscallhdr.sh
>  create mode 100644 linux-user/s390x/Makefile.objs
>  create mode 100644 linux-user/s390x/syscall.tbl
>  delete mode 100644 linux-user/s390x/syscall_nr.h
>  create mode 100755 linux-user/s390x/syscallhdr.sh
>  create mode 100644 linux-user/sh4/Makefile.objs
>  create mode 100644 linux-user/sh4/syscall.tbl
>  delete mode 100644 linux-user/sh4/syscall_nr.h
>  create mode 100644 linux-user/sh4/syscallhdr.sh
>  create mode 100644 linux-user/sparc/Makefile.objs
>  create mode 100644 linux-user/sparc/syscall.tbl
>  delete mode 100644 linux-user/sparc/syscall_nr.h
>  create mode 100644 linux-user/sparc/syscallhdr.sh
>  create mode 100644 linux-user/sparc64/Makefile.objs
>  create mode 100644 linux-user/sparc64/syscall.tbl
>  delete mode 100644 linux-user/sparc64/syscall_nr.h
>  create mode 100644 linux-user/sparc64/syscallhdr.sh
>  create mode 100644 linux-user/x86_64/Makefile.objs
>  create mode 100644 linux-user/x86_64/syscall_64.tbl
>  delete mode 100644 linux-user/x86_64/syscall_nr.h
>  create mode 100644 linux-user/x86_64/syscallhdr.sh
>  create mode 100644 linux-user/xtensa/Makefile.objs
>  create mode 100644 linux-user/xtensa/syscall.tbl
>  delete mode 100644 linux-user/xtensa/syscall_nr.h
>  create mode 100644 linux-user/xtensa/syscallhdr.sh
>  create mode 100755 scripts/update-mips-syscall-args.sh
>  create mode 100755 scripts/update-syscalltbl.sh
> 

Applied the whole series to my linux-user branch.

Thanks,
Laurent


